package com.redxun.bpm.listener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.IdentityLink;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.event.TaskCreateApplicationEvent;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.manager.BpmInstCcManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.context.HttpServletContext;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.util.SysUtil;

/**
 * 任务通知事件。
 * @author ray
 *
 */
@Service
public class TaskInformListener implements ApplicationListener<TaskCreateApplicationEvent>,Ordered{
	
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmInstCcManager bpmInstCcManager;
	@Resource
	UserService userService;
	

	@Override
	public int getOrder() {
		return 2;
	}

	@Override
	public void onApplicationEvent(TaskCreateApplicationEvent event) {
		TaskEntity taskEnt= (TaskEntity) event.getSource();
		UserTaskConfig config=event.getConfig();
		BpmInst bpmInst=event.getBpmInst();
		String notifyType =  config.getNotices();
		if(BeanUtil.isEmpty(notifyType)) {
			ProcessConfig procConfig=bpmNodeSetManager.getProcessConfig(taskEnt.getSolId(),taskEnt.getProcessDefinitionId()) ;
			notifyType=procConfig.getNotices();
		}
		
		//处理前台提交的抄送。
		handCopyTo( bpmInst,taskEnt,notifyType);
		
		String agentUser=taskEnt.getAgentUserId();
		if(StringUtil.isEmpty(agentUser)){
			sendMsg(taskEnt, notifyType);
		}
		//代理处理
		else{
			//发送代理接收人
			sendAgentToMsg(taskEnt,agentUser,notifyType);
			//发送代理人
			sendAgentMsg(taskEnt ,notifyType);
		}
	}
	
	/**
	 * 处理前台提交的抄送。
	 * @param bpmInst		流程实例	
	 * @param task			流程任务
	 * @param noteType		通知类型
	 */
	private void handCopyTo(BpmInst bpmInst,TaskEntity task,String noteType) {
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		if(!(cmd instanceof ProcessNextCmd)) return;
		
		ProcessNextCmd nextCmd=(ProcessNextCmd)cmd;
		String ccUserIds=nextCmd.getCcUserIds();
		
		if(StringUtil.isEmpty(ccUserIds)) return;
		
		IUser user=ContextUtil.getCurrentUser();
		
		Set<TaskExecutor>  identityInfos=new HashSet<TaskExecutor>();
		String[] aryUserId=ccUserIds.split(",");
		for(int i=0;i<aryUserId.length;i++){
			IUser tmpUser=userService.getByUserId(aryUserId[i]);
			identityInfos.add(TaskExecutor.getUserExecutor(tmpUser));
		}
		
		BpmInstCc instCc=new BpmInstCc();
		instCc.setCcId(IdUtil.getId());
		instCc.setSubject(bpmInst.getSubject());
		instCc.setNodeId(task.getTaskDefinitionKey());
		instCc.setNodeName(task.getName());
		instCc.setFromUserId(user.getUserId());
		instCc.setFromUser(user.getFullname());
		instCc.setSolId(bpmInst.getSolId());
		
		instCc.setInstId(bpmInst.getInstId());
		
		ListenerUtil.setCopyUsers(instCc,identityInfos,bpmInst.getSubject(),noteType);
		
		bpmInstCcManager.create(instCc);
		
	}

	
	private Set<IUser> getReceivers(TaskEntity taskEnt){
		Set<IUser> rtnSet=new HashSet<IUser>();
		UserService userManager=AppBeanUtil.getBean(UserService.class);
		String assignee=taskEnt.getAssignee();
		if(StringUtil.isNotEmpty(assignee)){
			IUser user=userManager.getByUserId(assignee);
			rtnSet.add(user);
		}
		else{
			Set<IdentityLink> set= taskEnt.getCandidates();
			for(Iterator<IdentityLink> it=set.iterator();it.hasNext();){
				IdentityLink link=it.next();
				//if(!"candidate".equals(link.getType())) continue;
				if(StringUtil.isNotEmpty(link.getUserId())){
					IUser user=userManager.getByUserId(link.getUserId());
					rtnSet.add(user);
				}
				if(StringUtil.isNotEmpty(link.getGroupId())){
					List<IUser> userList=userManager.getByGroupIdAndType(link.getGroupId(),link.getType());
					rtnSet.addAll(userList);
				}
			}
		}
		
		return rtnSet;
		
	}

	
	private void sendMsg(TaskEntity taskEnt ,String noticeTypes){
		Set<IUser> userSet= getReceivers(taskEnt);
		Map<String,Object> vars=new HashMap<>();
		if(BeanUtil.isEmpty(userSet)) return;
		for(IUser user:userSet){
			ListenerUtil. sendMsg( taskEnt ,"待办任务", user, noticeTypes,"approve",vars);
		}
	}
	
	
	
	/**
	 * 发送给代理人
	 * @param taskEnt
	 * @param receiver
	 * @param noticeTypes
	 */
	private  void sendAgentMsg(TaskEntity taskEnt ,String noticeTypes){
		
		String subject=taskEnt.getDescription();
		
		UserService userService=WebAppUtil.getBean(UserService.class);
		String template=MessageUtil.getFlowTemplateByAlias("agent");
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject("代理任务");
		msgModel.setTemplateAlias(template);
		IUser sender= userService.getByUserId(ContextUtil.getCurrentUserId());
		IUser receiver= userService.getByUserId(taskEnt.getAssignee());
		
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		receiverList.add(receiver);
	
		Map<String,Object> vars=msgModel.getVars();
		
		String installHost="";
		try {
			installHost=WebAppUtil.getInstallHost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vars.put("sender", sender.getFullname());
		vars.put("receiver", receiver.getFullname());
		vars.put("serverUrl", installHost);
		vars.put("taskId", taskEnt.getId());
		vars.put("subject", subject);
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}

	/**
	 * 发送给代理接收人
	 * @param taskEnt
	 * @param receiver
	 * @param noticeTypes
	 */
	private  void sendAgentToMsg(TaskEntity taskEnt ,String receiverId,String noticeTypes){
		
		String subject=taskEnt.getDescription();
		
		UserService userService=WebAppUtil.getBean(UserService.class);
		String template=MessageUtil.getFlowTemplateByAlias("agentTo");
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject("收到代理任务");
		msgModel.setTemplateAlias(template);
		IUser sender= userService.getByUserId(ContextUtil.getCurrentUserId());
		IUser receiver= userService.getByUserId(receiverId);
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		receiverList.add(receiver);
	
		Map<String,Object> vars=msgModel.getVars();
		
		String installHost="";
		try {
			installHost=WebAppUtil.getInstallHost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vars.put("sender", sender.getFullname());
		vars.put("receiver", receiver.getFullname());
		vars.put("serverUrl", installHost);
		vars.put("taskId", taskEnt.getId());
		vars.put("subject", subject);
		vars.put("agent", sender.getFullname());
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}

}
