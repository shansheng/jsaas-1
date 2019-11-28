
package com.redxun.bpm.core.manager;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.core.dao.BpmOvertimeNodeDao;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmOvertimeNode;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.core.dao.IDao;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.calendar.entity.CalSetting;
import com.redxun.oa.calendar.entity.WorkCalendar;
import com.redxun.oa.calendar.manager.CalSettingManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ICalendarService;

/**
 * 
 * <pre> 
 * 描述：流程超时节点表 处理接口
 * 作者:ray
 * 日期:2019-03-27 18:50:23
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmOvertimeNodeManager extends MybatisBaseManager<BpmOvertimeNode>{
	
	@Resource
	private BpmOvertimeNodeDao bpmOvertimeNodeDao;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Autowired(required=false)
	ICalendarService iCalendarService;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmOvertimeNodeDao;
	}
	
	
	
	public BpmOvertimeNode getBpmOvertimeNode(String uId){
		BpmOvertimeNode bpmOvertimeNode = get(uId);
		return bpmOvertimeNode;
	}
	

	
	
	@Override
	public void create(BpmOvertimeNode entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(BpmOvertimeNode entity) {
		super.update(entity);
	}
	
	public void addTaskLog(TaskEntity task, String jumpType, String content) {
		BpmOvertimeNode log=new BpmOvertimeNode();
		log.setId(IdUtil.getId());
		log.setSolId(task.getSolId());
		log.setInstId(task.getInstId());
		log.setNodeId(task.getTaskDefinitionKey());
		log.setOpType(jumpType);
		log.setOpContent(content);
		Integer overtime = getOverTime(task.getSolId(),task.getProcessDefinitionId(),task.getTaskDefinitionKey(),task.getCreateTime());
		if(overtime>0) {
			log.setStatus("1");
		}
		log.setOvertime(overtime);
		create(log);
	}
	
	/**
	 * 获取超时时间，未超时返回0，异常返回-1
	 * @param task
	 * @return
	 */
	public Integer getOverTime(String solId,String procDefId,String taskDefKey,Date createTime) {
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(solId, procDefId,taskDefKey);
		String calenderId=taskConfig.getCalSettingId();
		if(StringUtil.isEmpty(calenderId)){
			return -1;
		}
		int overtime=taskConfig.getOverTime();
		try{
			Date result=iCalendarService.getByCalendarId(calenderId,createTime, overtime);
			//时间小于当前时间表示已超时
			if(result.compareTo(new Date())==-1){
				int minute=(int) DateUtil.betweenMinute(result, new Date());
				return minute;
			}
			else{
				return 0;
			}
		}
		catch(Exception ex){
			logger.error(ExceptionUtil.getExceptionMessage(ex));
			return -1;
		}
	}
	

}
