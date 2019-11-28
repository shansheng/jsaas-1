package com.redxun.bpm.core.manager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmRuPathDao;
import com.redxun.bpm.core.entity.BpmNodeStatus;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;

/**
 * <pre> 
 * 描述：BpmRuPath业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmRuPathManager extends BaseManager<BpmRuPath>{
	@Resource
	private BpmRuPathDao bpmRuPathDao;

	@Resource
	TaskService taskService;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmRuPathDao;
	}
	
	public BpmRuPath getLastPathByNode(String actInstId,String nodeId){
		return bpmRuPathDao.getLastPathByNode(actInstId, nodeId);
	}
	
	public BpmRuPath getMinPathByNode(String actInstId,String nodeId){
		return bpmRuPathDao.getMinPathByNode(actInstId, nodeId);
	}
	
	
	/**
     * 取得离开始节点的最远路径点
     * @param actInstId
     * @param nodeId
     * @return
     */
    public BpmRuPath getFarestPath(String actInstId,String nodeId){
    	return bpmRuPathDao.getFarestPath(actInstId, nodeId);
    }
    
    /**
     * 取得离开始节点的最远路径点
     * @param actInstId
     * @param nodeId
     * @return
     */
    public BpmRuPath getFarestPath(String actInstId,String nodeId,String token){
    	if(StringUtils.isNotEmpty(token)){
    		return bpmRuPathDao.getFarestPath(actInstId, nodeId,token);
    	}else{
    		return bpmRuPathDao.getFarestPath(actInstId, nodeId);
    	}
    }
    
    /**
     * 获得父节点下的执行路径
     * @param parentId
     * @return
     */
    public List<BpmRuPath> getByParentId(String parentId){
    	return bpmRuPathDao.getByParentId(parentId);
    }
    /**
     * 获得流程实例的跳转路线
     * @param actInstId
     * @return
     */
    public List<BpmRuPath> getByActInstId(String actInstId){
    	return bpmRuPathDao.getByActInstId(actInstId);
    }
    
    /**
     * 获得某个父节点下的某个节点的跳转记录
     * @param parentId
     * @param nodeId
     * @return
     */
    public BpmRuPath getByParentIdNodeId(String parentId,String nodeId){
    	return bpmRuPathDao.getByParentIdNodeId(parentId, nodeId);
    }
    
    /**
	 * 获得最新的审批节点及其审批状态
	 * @param actInstId
	 * @return
	 */
	public List<BpmRuPath> getLatestByActInstId(String actInstId){
		return bpmRuPathDao.getLatestByActInstId(actInstId);
	}
	
	/**
	 * 获得最新的状态
	 * @param actInstId
	 * @return
	 */
	public Map<String,String> getLatestStatus(String actInstId){
		Map<String,String> maps=new HashMap<String, String>();
		if(StringUtils.isEmpty(actInstId)){
			return maps;
		}
		List<BpmRuPath> paths= bpmRuPathDao.getLatestByActInstId(actInstId);
		for(BpmRuPath path:paths){
			if(StringUtils.isNotEmpty(path.getJumpType())){
				maps.put(path.getNodeId(),path.getJumpType());
			}else{
				maps.put(path.getNodeId(),TaskOptionType.AGREE.name());
			}
		}
		List<Task> tasks=taskService.createTaskQuery().processInstanceId(actInstId).list();
		
		for(Task task:tasks){
			maps.put(task.getTaskDefinitionKey(), "UNHANDLE");
		}
		
		return maps;
	}
	
	
	public Map<String,BpmNodeStatus> getBpmInstNodeStatus(String actInstId){
		
		Map<String,BpmNodeStatus> maps=new HashMap<String, BpmNodeStatus>();
		List<BpmRuPath> paths= bpmRuPathDao.getLatestByActInstId(actInstId);
		
		for(BpmRuPath path:paths){
			BpmNodeStatus bpmNodeStatus=new BpmNodeStatus();
			bpmNodeStatus.setNodeId(path.getNodeId());
			bpmNodeStatus.setJumpType(path.getJumpType());
			bpmNodeStatus.setTimeoutStatus(StringUtils.isEmpty(path.getTimeoutStatus())?"0":path.getTimeoutStatus());
			maps.put(path.getNodeId(), bpmNodeStatus);
		}
		
		List<Task> tasks=taskService.createTaskQuery().processInstanceId(actInstId).list();
		
		for(Task task:tasks){
			TaskEntity taskEnt=(TaskEntity)task;
			BpmNodeStatus bns=maps.get(task.getTaskDefinitionKey());
			
			if(bns==null){
				bns=new BpmNodeStatus();
				bns.setNodeId(task.getTaskDefinitionKey());
				bns.setTimeoutStatus(taskEnt.getTimeoutStatus());
				bns.setJumpType("UNHANDLE");
				maps.put(task.getTaskDefinitionKey(), bns);
			}else{
				bns.setJumpType("UNHANDLE");
				bns.setTimeoutStatus(taskEnt.getTimeoutStatus());
			}
		}
		
		return maps;
	}
	
	
	 /**
     * 找到最新的回退记录列表
     * @param actInstId
     * @return
     */
    public List<BpmRuPath> getLatestBackStart(String actInstId){
    	return bpmRuPathDao.getLatestBackStart(actInstId);
    }
    
    /**
     * 找到最新的用户审批的人员，回退后，原节点的人员审批不算在内。
     * @param actInstId
     * @return
     */
    public Set<String> getLatestHadCheckedUserIds(String actInstId){
    	Set<String> userIds=new HashSet<String>();
    	List<BpmRuPath> backPaths= getLatestBackStart(actInstId);
    	if(backPaths.size()>0){
    		BpmRuPath backPath=backPaths.get(0);
    		List<BpmRuPath> newBackRuPaths=bpmRuPathDao.getByActInstIdGtCreateTinme(actInstId, backPath.getCreateTime());
    		for(BpmRuPath p:newBackRuPaths){
    			if(TaskOptionType.AGREE.name().equals(p.getJumpType()) 
    					&& StringUtils.isNotEmpty(p.getAssignee())){
    				String[]assignees=p.getAssignee().split("[,]");
    				for(String agn:assignees){
    					userIds.add(agn);
    				}
    			}
    		}
    	}else{
    		userIds=getAgreeCheckTasksUserIds(actInstId);
    	}
    	return userIds;
    }
	
	 /**
     * 通过某个实例所有通过审批的人员列表
     * @param actInstId
     * @param nodeType
     * @param jumpType
     * @return
     */
    public Set<String> getAgreeCheckTasksUserIds(String actInstId){
    	List<BpmRuPath> bpmRuPaths=bpmRuPathDao.getByActInstIdNodeTypeJumpType(actInstId, "userTask", TaskOptionType.AGREE.name());
    	Set<String> userIds=new HashSet<String>();
    	for(BpmRuPath p:bpmRuPaths){
    		if(StringUtils.isNotEmpty(p.getAssignee())){
    			String[]assignees=p.getAssignee().split("[,]");
				for(String agn:assignees){
					userIds.add(agn);
				}
    		}
    	}
    	return userIds;
    }
    
    public void removeByInst(String instId){
    	bpmRuPathDao.removeByInst(instId);
    }
    
    /**
     * 根据execution和节点返回path。
     * @param executionId
     * @param nodeId
     * @return
     */
    public BpmRuPath getByExecutionNode(String executionId,String nodeId){
    	List<BpmRuPath> list=this.bpmRuPathDao.getByExecutionNode(executionId, nodeId);
    	if(list.size()>0){
    		return list.get(0);
    	}
    	return null;
    }
    
    /**
     * 获取返回路径。
     * <pre>
     * 	1.如果前面是任务节点，这种情况可以直接驳回。
     * 	2.如果前面节点的有网关的情况，那么不能直接驳回。
     * </pre>
     * @param executionId
     * @param nodeId
     * @return
     */
    public PathResult getBackNode(String actInstId,String nodeId){
    	BpmRuPath path=getFarestPath(actInstId, nodeId);
    	if(path==null) return null;
    	BpmRuPath parent=this.get(path.getParentId());
    	if(parent==null) return null;
    	String nodeType=parent.getNodeType();
    	String jumpType=parent.getJumpType();
    	String nextJumpType=parent.getNextJumpType();
    	String gateWay="";
    	boolean isDirect=true;
    	while(!"0".equals(parent.getParentId()) && !(TaskOptionType.INTERPOSE.name().equals(jumpType) || TaskOptionType.AGREE.name().equals(jumpType) 
    			|| TaskOptionType.REFUSE.name().equals(jumpType))){
    		if(nodeType.equals("userTask") && (TaskOptionType.AGREE.name().equals(jumpType) 
    				|| TaskOptionType.REFUSE.name().equals(jumpType))){
    			break;
    		}
    		//中间隔了一个网关
    		if(nodeType.indexOf("parallelGateway")!=-1 || nodeType.indexOf("inclusiveGateway")!=-1){
    			if(isDirect){
    				isDirect=false;
        			gateWay=parent.getNodeId();
    			}
    		}
    		if("normal".equals(nextJumpType)) {
    			path=bpmRuPathDao.getMinPathByNode(actInstId, nodeId);
    			parent=this.get(path.getPathId());
    		}else {
    			path=bpmRuPathDao.getLastPathByNode(actInstId, nodeId,path.getCreateTime());
    			if(path==null){
        			path=parent;
        		}
        		parent=this.get(path.getParentId());
        	}
    		nodeType=parent.getNodeType();
    		jumpType=parent.getJumpType();
    	}
    	PathResult result=new PathResult(isDirect, parent);
    	result.setGateWay(gateWay);
    	return result;
    }
    
    public Integer getMaxLevel(String actInstId,String nodeId){
    	return this.bpmRuPathDao.getMaxLevel(actInstId, nodeId);
    }
    
    /**
     * 获取能够驳回的节点。
     * <pre>
     * 1. 获取指定节点最早的驳回节点  。
     * 		start A1 B1 C1 B2 A2 B2 C2 。 从 C1 往前获取。得到节点序列 C1,B1,A1 。
     * 2. 从 C 往回查找。
     * </pre>
     * @param actInstId
     * @param nodeId
     * @return
     */
    public List<BpmRuPath> getBackNodes(String actInstId,String nodeId){
    	List<BpmRuPath> paths= bpmRuPathDao.getEarliestByActInstId(actInstId,nodeId);
    	BpmRuPath curPath=null;
    	for(Iterator<BpmRuPath> it=paths.iterator();it.hasNext();){
    		BpmRuPath path=it.next();
    		if(path.getNodeId().equals(nodeId)){
    			curPath=path;
    			it.remove();
    		}
    	}
    	
    	List<BpmRuPath> ruPaths= new ArrayList<BpmRuPath>();
    	Map<String,BpmRuPath> pathMap=new HashMap<>();
    	for(BpmRuPath path:paths){
    		pathMap.put(path.getPathId(), path);
    	}
    	BpmRuPath parent=pathMap.get(curPath.getParentId());
    	
    	if(parent!=null){
	    	while(true){
	    		if("startEvent".equals(parent.getNodeType())) break;
	    		if(TaskOptionType.AGREE.name().equals(parent.getJumpType()) ||
	    				TaskOptionType.ABSTAIN.name().equals(parent.getJumpType()) ||
	    				TaskOptionType.REFUSE.name().equals(parent.getJumpType())){
	    			ruPaths.add(parent);
	    		}
	    		String pid=parent.getParentId();
	    		if("0".equals(pid)) break;
	    		parent=pathMap.get(pid);
	    	}
    	}
    	
    	return ruPaths;
    }
    
}