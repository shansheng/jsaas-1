package com.redxun.bpm.listener;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.event.TaskCreateApplicationEvent;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmNodeJumpDao;
import com.redxun.bpm.core.dao.BpmRemindDefDao;
import com.redxun.bpm.core.dao.BpmRemindInstDao;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.bpm.core.entity.BpmRemindInst;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.service.ITimeLimitHandler;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.calendar.entity.CalSetting;
import com.redxun.oa.calendar.manager.CalSettingManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ICalendarService;
import com.sun.star.uno.RuntimeException;

/**
 * 催办实例产生监听器
 * @author redxun
 *
 */
@Service
public class ReminderListener implements ApplicationListener<TaskCreateApplicationEvent>,Ordered {

	@Override
	public int getOrder() {
		return 3;
	}
	
	@Resource
	BpmRemindDefDao bpmRemindDefDao;  
	@Resource
	BpmRemindInstDao bpmRemindInstDao;
	@Resource
	BpmNodeJumpDao bpmNodeJumpDao;
	
	@Resource
	GroovyEngine groovyEngine;
	@Autowired(required=false)
	ICalendarService calendarService ;
	@Resource
	CalSettingManager calSettingManager;
	

	@Override
	public void onApplicationEvent(TaskCreateApplicationEvent event) {
		TaskEntity taskEnt= (TaskEntity) event.getSource();
		String solId = (String) taskEnt.getVariable("solId");
		
		String nodeId=taskEnt.getTaskDefinitionKey();
		//获取催办定义。
		List<BpmRemindDef> remindList=getRemindDefList(solId,taskEnt.getProcessDefinitionId(), nodeId);
		
		if(BeanUtil.isEmpty(remindList)) return;
		//插入催办实例
		for(BpmRemindDef remindDef:remindList){
			String condition=remindDef.getCondition();
			if(condition==null) condition="";
			condition=condition.trim();
			//首先判断条件是否满足。
			if(StringUtil.isNotEmpty(condition)){
				Boolean rtn= (Boolean) groovyEngine.executeScripts(condition, taskEnt.getVariables());
				if(!rtn) continue;
			}
			addReminderInst(remindDef,taskEnt,solId);
		}
	}
	
	private List<BpmRemindDef>  getRemindDefList(String solId,String actDefId,String nodeId){
		List<BpmRemindDef> remindList=new ArrayList<BpmRemindDef>();
		List<BpmRemindDef> nodelList= bpmRemindDefDao.getBySolNode(solId, actDefId, nodeId);
		//获取节点配置
		if(BeanUtil.isNotEmpty(nodelList)){
			remindList.addAll(nodelList);
		}
		//节点配置为空的情况，则获取全局的配置。
		if(BeanUtil.isEmpty(nodelList)){
			List<BpmRemindDef> globalList= bpmRemindDefDao.getBySolNode(solId,actDefId, BpmRemindDef.GLOBAL_DEF_NAME);
			if(BeanUtil.isNotEmpty(globalList)){
				remindList.addAll(globalList);
			}
		}
		return remindList;
	}
	
	private void addReminderInst(BpmRemindDef remindDef,TaskEntity taskEnt,String solId){
		
		//获取催办处理的基础时间，到期时间需要根据这个进行计算。
		Date baseTime= getStartTime( remindDef, taskEnt);
		if(baseTime==null) return ;
		String nodeId=taskEnt.getTaskDefinitionKey();
		String instId= (String)taskEnt.getVariable("instId");
		String userId=ContextUtil.getCurrentUserId();
		String depId=ContextUtil.getCurrentUser().getMainGroupId();
		
		Integer  endTime=0;
		String timeLimitHander=remindDef.getTimeLimitHandler();
		if(StringUtil.isNotEmpty(timeLimitHander)){
			ITimeLimitHandler handler=(ITimeLimitHandler) AppBeanUtil.getBean(timeLimitHander);
			endTime=handler.getExpireTimeLimit(userId, depId,taskEnt.getProcessDefinitionId(),solId, nodeId,  instId, taskEnt.getId());
		}
		else{
			//过期时间。
			endTime=getMinite(remindDef.getExpireDate());
		}
		
		
		//计算出未来的时间。
		Date endDate=getFutureTime(taskEnt.getAssignee(), baseTime, remindDef.getDateType(), endTime);
		
		BpmRemindInst remindInst=new BpmRemindInst();
		remindInst.setId(IdUtil.getId());
		
		remindInst.setActInstId(taskEnt.getProcessInstanceId());
		remindInst.setSolId(remindDef.getSolId());
		remindInst.setNodeId(remindDef.getNodeId());
		remindInst.setTaskId(taskEnt.getId());
		remindInst.setScript(remindInst.getScript());
		remindInst.setSolutionName(remindDef.getSolutionName());
		remindInst.setNodeName(remindDef.getNodeName());
		
		
	
		//通知类型
		if(StringUtil.isNotEmpty(remindDef.getNotifyType())){
			Integer   timeToSend=0;
			if(StringUtil.isNotEmpty(timeLimitHander)){
				ITimeLimitHandler handler=(ITimeLimitHandler) AppBeanUtil.getBean(timeLimitHander);
				endTime=handler.getSendTimeLimit(userId, depId,taskEnt.getProcessDefinitionId(),
						solId,nodeId, instId, taskEnt.getId());
			}
			else{
				timeToSend=getMinite(remindDef.getTimeToSend());
			}
			Date startTime=getFutureTime(taskEnt.getAssignee(),baseTime,remindDef.getDateType(),timeToSend);
			
			remindInst.setTimeToSend(startTime);
			remindInst.setNotifyType(remindDef.getNotifyType());
			
			
			remindInst.setSendTimes(remindDef.getSendTimes());
			//发送间隔时间
			int sendInterval=getMinite( remindDef.getSendInterval());
			remindInst.setSendInterval(sendInterval);
			
			//获取间隔
			int tmp=sendInterval * (remindDef.getSendTimes()-1);
			Date endRemindDate= DateUtil.add(startTime, Calendar.MINUTE, tmp);
			if(endRemindDate.after(endDate)){
				throw new RuntimeException("催办时间必须小于到期时间!");
			}
		}
		
		remindInst.setTenantId(remindDef.getTenantId());
		remindInst.setStatus("create");
		
		remindInst.setExpireDate(endDate);
		
		remindInst.setAction(remindDef.getAction());
		remindInst.setName(remindDef.getName());
		
		
		bpmRemindInstDao.create(remindInst);
	}
	
	/**
	 * 计算将来的时间。
	 * @param userId
	 * @param startTime
	 * @param dateType
	 * @param miniute
	 * @return
	 */
	private Date getFutureTime(String userId,Date startTime,String dateType, Integer miniute){
		//没有配置日历的情况。
		if("common".equals(dateType)){
			return  DateUtil.add(startTime, Calendar.MINUTE, miniute);
		}
		
		if(calendarService==null) throw  new RuntimeException("系统没有实现日历接口!");
		// 用户不为空的情况。
		if(StringUtil.isNotEmpty(userId)){
			try{
				return calendarService.getByUserId(userId, startTime, miniute);
			}
			catch(Exception ex){
				throw new RuntimeException("获取日历时间出错!");
			}
		}
		else{
			try {
				CalSetting calSetting= calSettingManager.getDefault();
				if(calSetting==null) throw new RuntimeException("没有设置默认日历!");
				return  calendarService.getByCalendarId(calSetting.getSettingId(), startTime, miniute);
			} catch (Exception e) {
				throw new RuntimeException("获取日历时间出错!");
			}
		}
	}
	
	
	
	
	/**
	 * 获取发起的时间。
	 * @param remindDef
	 * @param taskEnt
	 * @return
	 */
	private Date getStartTime(BpmRemindDef remindDef,TaskEntity taskEnt){
		ProcessMessage processMessage = ProcessHandleHelper.getProcessMessage();
		String curNode=remindDef.getNodeId();
		//全局配置，开始时间取当前的时间。
		if(BpmRemindDef.GLOBAL_DEF_NAME.equals(curNode)){
			return new Date();
		}
		String relNode=remindDef.getRelNode();
		if(curNode.equals(relNode)  ){
			if("complete".equals( remindDef.getEvent())){
				processMessage.addErrorMsg("催办配置错误:相对节点相同,不能配置完成事件!");
				return null;
			}
			//否则取当前时间
			return new Date();
		}
		else{
			//获取最近的处理时间。
			BpmNodeJump nodeJump= bpmNodeJumpDao.getLastByInstNode(taskEnt.getProcessInstanceId(), relNode);
			if(nodeJump==null){
				processMessage.addErrorMsg("催办配置错误:没有审批记录,请检查相对节点配置是否正确!");
				return null;
			}
			if("complete".equals( remindDef.getEvent())){
				Date date=nodeJump.getCompleteTime();
				if(date==null){
					return new Date();
				}
				return nodeJump.getCompleteTime();
			}
			else{
				return nodeJump.getCreateTime();
			}
		}
	}
	
	/**
	 * {"day":0,"hour":"4","minute":"45"}
	 * @param json
	 * @return
	 */
	private int getMinite(String json){
		JSONObject jsonObj=JSONObject.parseObject(json);
		int day=jsonObj.getIntValue("day");
		int hour=jsonObj.getIntValue("hour");
		int minute=jsonObj.getIntValue("minute");
		int total=(24* 60 ) * day + hour* 60 + minute;
		return total;
	}

}
