package com.redxun.bpm.activiti.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.context.ContextUtil;

/**
 * Activiti的流程任务服务类
 * @author csx
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Service
public class ActTaskService {
	@Resource
	TaskService taskService;
	@Resource
	RepositoryService repositoryService;
	
	
	/**
	 * 修改流程定义，让当前节点指向对应的目标节点，同时返回原目标节点
	 * @param processDefinition
	 * @param curAct 当前节点
	 * @param aryDestination 跳转至任意的目标节点Id
	 * @return
	 */
	private List<PvmTransition> changeActivityTrans(ProcessDefinitionEntity processDefinition,ActivityImpl curAct,String[] aryDestination){
		
		List<PvmTransition> newTrans=new ArrayList<PvmTransition>();
		List<PvmTransition> outList=null;
		try {
			outList=(List<PvmTransition>) FileUtil.cloneObject(curAct.getOutgoingTransitions()) ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		 //清除当前节点目标节点指向自己。
		cleanTargetIncoming(curAct);
		newTrans.addAll(outList);
		curAct.getOutgoingTransitions().clear();
		//创建目标连接
		if(BeanUtil.isNotEmpty(aryDestination)){
			for(String targetNodeId:aryDestination){//创建一个连接
				ActivityImpl destAct= processDefinition.findActivity(targetNodeId);
				TransitionImpl transitionImpl = curAct.createOutgoingTransition();
				transitionImpl.setDestination(destAct);
			}
		}
		return newTrans;
	}
	
	/**
	 * 清理目标节点指向当前节点的PvmTransition.
	 * @param curAct
	 */
	private void cleanTargetIncoming(ActivityImpl curAct){
		List<PvmTransition> outTrans=curAct.getOutgoingTransitions();
		for(Iterator<PvmTransition> it=outTrans.iterator();it.hasNext();){
			PvmTransition transition=it.next();
			PvmActivity activity= transition.getDestination();
			List<PvmTransition> inTrans= activity.getIncomingTransitions();
			for(Iterator<PvmTransition> itIn=inTrans.iterator();itIn.hasNext();){
				PvmTransition inTransition=itIn.next();
				if(inTransition.getSource().getId().equals(curAct.getId())){
					itIn.remove();
				}
			}
		}
	}

	/**
	 * 通过指定目标节点，实现任务的跳转
	 * @param taskId 任务ID
	 * @param destNodeIds 跳至的目标节点ID
	 * @param vars 流程变量
	 */
	public  void completeTask(ProcessNextCmd cmd,String[] destNodeIds,Map<String,Object> vars) {
		TaskEntity task=(TaskEntity)taskService.createTaskQuery().taskId(cmd.getTaskId()).singleResult();
		String curNodeId=task.getTaskDefinitionKey();
		String actDefId=task.getProcessDefinitionId();
		
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		ActivityImpl curAct= processDefinition.findActivity(curNodeId);
		//若为多实例的任务进行步转,则把其他同节点的任务实例进行了撤消处理
//		if(curAct.getProperty("multiInstance")!=null){
//			List<Task> actTaskList=taskService.createTaskQuery().processInstanceId(task.getProcessInstanceId()).list();
//			//保存原来的意见
//			String opinion=cmd.getOpinion();
//			//设置新的备注信息
//			cmd.setOpinion("任务被"+ContextUtil.getCurrentUser().getFullname()+"进行跳转干预,被撤消了!");
//			for(Task t:actTaskList){
//				if(task.getTaskDefinitionKey().equals(t.getTaskDefinitionKey()) &&
//						(!t.getId().equals(task.getId()))){
//					taskService.complete(t.getId());
//				}
//			}
//			//重新回原来的意见
//			cmd.setOpinion(opinion);
//		}
		
		List<PvmTransition> trans= changeActivityTrans(processDefinition, curAct, destNodeIds);
		try{
			taskService.complete(cmd.getTaskId());
		}
		catch(Exception ex){
			throw new RuntimeException(ex);
		}
		finally{
			curAct.getOutgoingTransitions().clear();
			curAct.getOutgoingTransitions().addAll(trans);
		}
	}
}
