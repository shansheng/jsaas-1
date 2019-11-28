package com.redxun.bpm.listener;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.core.context.HttpServletContext;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.PropertiesUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.util.SysUtil;

public class ListenerUtil {
	
	/**
	 * 
	 * @param instCc
	 * @param id
	 * @return
	 */
	public static BpmInstCp getInstCp(BpmInstCc instCc,String id){
		BpmInstCp instCp=new BpmInstCp();
		instCp.setId(IdUtil.getId());
		instCp.setCcId(instCc.getCcId());
		instCp.setUserId(id);
		instCp.setIsRead("NO");
		return instCp;
	}

	/**
	 * 发送抄送消息
	 * <pre>
	 * ${receiver}:你好
	 * ${sender}抄送给你一条流程实例信息:<a href="${serverUrl}/bpm/core/bpmInst/get.do?pkId=${instId}">${subject}</a>,请查收!
	 * </pre>
	 * @param userId
	 * @param instId
	 * @param subject
	 * @param noticeTypes
	 * @throws Exception 
	 */
	public static void sendCopyMsg(IUser osUser,String instId,String subject,String noticeTypes) {
		UserService userService=WebAppUtil.getBean(UserService.class);
		String template=MessageUtil.getFlowTemplateByAlias("copy");
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject("流程抄送");
		msgModel.setTemplateAlias(template);
		IUser sender=userService.getByUserId(ContextUtil.getCurrentUserId());
		String tenantId=ContextUtil.getCurrentTenantId();
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		receiverList.add(osUser);

		Map<String,Object> vars=msgModel.getVars();
		vars.put("tenantId", tenantId);
		vars.put("sender", sender.getFullname());
		vars.put("receiver", osUser.getFullname());
		vars.put("serverUrl", WebAppUtil.getInstallHost());
		vars.put("instId", instId);
		vars.put("type", "inst");
		vars.put("subject", subject);
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}
	
	
	public static void setCopyUsers(BpmInstCc instCc,Set<TaskExecutor>  identityInfos,String subject,String notifyType) {
		UserService osUserManager=WebAppUtil.getBean(UserService.class);
		
		Set<BpmInstCp> set= instCc.getBpmInstCps();
		
		Set<IUser> userSet=new HashSet<IUser>();
		
		for(Iterator<TaskExecutor> it=identityInfos.iterator();it.hasNext();){
			TaskExecutor idInfo=it.next();
			if (TaskExecutor.IDENTIFY_TYPE_USER.equals(idInfo.getType())) {
				IUser user=osUserManager.getByUserId(idInfo.getId());
				userSet.add(user);
				BpmInstCp instCp=ListenerUtil. getInstCp(instCc,idInfo.getId());
				set.add(instCp);
			}
			else{
				
				List<IUser> osUsers= osUserManager.getByGroupIdAndType(idInfo.getId(),"");
				for(IUser osUser:osUsers){
					BpmInstCp instCp=ListenerUtil. getInstCp(instCc,osUser.getUserId());
					set.add(instCp);
					userSet.add(osUser);
					set.add(instCp);
					userSet.add(osUser);
				}
			}
		}
		
		for(Iterator<IUser> it=userSet.iterator();it.hasNext();){
			IUser osuser=it.next();
			ListenerUtil.sendCopyMsg(osuser, instCc.getInstId(), subject, notifyType);
		}
		
		
	}
	
	/**
	 * 发送消息给 任务接收人
	 * @param taskEnt
	 * @param receiver
	 * @param noticeTypes
	 * @param templateType
	 */
	public static  void sendMsg(TaskEntity taskEnt ,String title, IUser receiver,String noticeTypes,String templateType,Map<String,Object> varMap){
		if(StringUtil.isEmpty(noticeTypes)) return;
		String userId=ContextUtil.getCurrentUserId();
		if(StringUtil.isEmpty(userId)) return;
		
		
		String subject=taskEnt.getDescription();
		
		UserService userService=WebAppUtil.getBean(UserService.class);
		String template=MessageUtil.getFlowTemplateByAlias(templateType);
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject(title);
		msgModel.setContent(subject);
		msgModel.setTemplateAlias(template);
		
		IUser sender= userService.getByUserId(userId);
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		receiverList.add(receiver);
		
		if(BeanUtil.isNotEmpty(varMap)){
			msgModel.setVars(varMap);
		}

		Map<String,Object> vars=msgModel.getVars();
	
		vars.put("sender", sender.getFullname());
		vars.put("receiver", receiver.getFullname());
		vars.put("serverUrl", WebAppUtil.getInstallHost());
		vars.put("taskId", taskEnt.getId());
		vars.put("subject", subject);
		//加入租户ID
		String ctxpath=PropertiesUtil.getProperty("ctxPath");
		vars.put("tenantId", taskEnt.getTenantId());
		vars.put("ctxPath", ctxpath);
		vars.put("type", "task");
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}
	
	
	
	/**
	 * 发送任务通知消息。
	 * @param taskEnt
	 * @param title
	 * @param receiver
	 * @param noticeTypes
	 * @param templateType
	 */
	public static  void sendMsg(BpmTask taskEnt ,String title, IUser receiver,String noticeTypes,String templateType,Map<String,Object> varMap){
		HttpServletRequest req=HttpServletContext.getRequest();
		
		String subject=taskEnt.getDescription();
		
		UserService userService=WebAppUtil.getBean(UserService.class);
		String template=MessageUtil.getFlowTemplateByAlias(templateType);
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject(title);
		msgModel.setTemplateAlias(template);
		IUser sender= userService.getByUserId(ContextUtil.getCurrentUserId());
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		receiverList.add(receiver);

		if(BeanUtil.isNotEmpty(varMap)){
			msgModel.setVars(varMap);
		}
		
		Map<String,Object> vars=msgModel.getVars();
	
		
		vars.put("sender", sender.getFullname());
		vars.put("receiver", receiver.getFullname());
		vars.put("serverUrl", WebAppUtil.getInstallHost());
		vars.put("taskId", taskEnt.getId());
		vars.put("subject", subject);
		//加入租户ID
		vars.put("tenantId", taskEnt.getTenantId());
		vars.put("ctxPath", req.getContextPath());
		vars.put("type", "task");
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}
	
	
	
}
