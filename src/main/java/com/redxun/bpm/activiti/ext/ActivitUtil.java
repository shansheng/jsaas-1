package com.redxun.bpm.activiti.ext;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;

public class ActivitUtil {
	
	/**
	 * 创建路径。
	 * @param execution
	 */
	public static void createPath(ActivityExecution execution){
		BpmRuPathManager bpmRuPathManager=AppBeanUtil.getBean(BpmRuPathManager.class);
		BpmInstManager bpmInstManager=AppBeanUtil.getBean(BpmInstManager.class); 
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmRuPath path=new BpmRuPath();

		path.setPathId(IdUtil.getId());
		path.setActDefId(execution.getProcessDefinitionId());
		path.setActInstId(execution.getProcessInstanceId());
		path.setExecutionId(execution.getId());
		path.setNodeName(execution.getCurrentActivityName());
		path.setNodeId(execution.getCurrentActivityId());
		String type=(String) execution.getActivity().getProperty("type");
		path.setNodeType(type);
		cmd.setRunPathId(path.getPathId());

		path.setStartTime(new Date());
		path.setToken(cmd.getToken());
		
		if(cmd instanceof ProcessStartCmd){//若为启动时，需要从线程中获得
			ProcessStartCmd startCmd=(ProcessStartCmd)cmd;
			path.setInstId(startCmd.getBpmInstId());
			path.setSolId(startCmd.getSolId());
		}else{
			BpmInst bpmInst=bpmInstManager.getByActInstId(execution.getProcessInstanceId());
			path.setInstId(bpmInst.getInstId());
			path.setSolId(bpmInst.getSolId());
			path.setNextJumpType(((ProcessNextCmd)cmd).getNextJumpType());
		}
		
		path.setIsMultiple(MBoolean.NO.name());
			
		
		//记录跳转的原节点,并且把跳转记录挂至该节点上
		BpmRuPath parentPath=bpmRuPathManager.getFarestPath(execution.getProcessInstanceId(),cmd.getNodeId());
		path.setParentId(parentPath.getPathId());
		path.setLevel(parentPath.getLevel()+1);
		
		
		cmd.setNodeId(execution.getCurrentActivityId());
		
		
		bpmRuPathManager.create(path);
	}
	
	/**
	 * 返回上下文数据。
	 * 上下文数据有：
	 * json：表单数据
	 * vars：流程变量
	 * cmd ：cmd对象。
	 * @param execution
	 * @return
	 */
	public static Map<String,Object> getContextData(ActivityExecution execution){
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		
		Map<String,Object> model=new HashMap<String,Object>();
		Map<String,Object> vars=execution.getVariables();
		if(cmd!=null){
			String json=cmd.getJsonData();
			if(StringUtil.isNotEmpty(json)){
				JSONObject jsonData=JSONObject.parseObject(json);
				model.put("json", jsonData);
			}
			model.put("cmd", cmd);
		}
		model.put("vars", vars);
		return model;
	}
}
