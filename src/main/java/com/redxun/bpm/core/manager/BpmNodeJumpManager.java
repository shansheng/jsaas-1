package com.redxun.bpm.core.manager;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import com.redxun.saweb.util.IdUtil;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmNodeJumpDao;
import com.redxun.bpm.core.entity.BpmCheckFile;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsUser;
/**
 * <pre> 
 * 描述：BpmNodeJump业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmNodeJumpManager extends BaseManager<BpmNodeJump>{
	@Resource
	private BpmNodeJumpDao bpmNodeJumpDao;
	@Resource
	private UserService userService;
	@Resource
	private GroupService groupService;
	
	@Resource
	private BpmCheckFileManager bpmCheckFileManager;
	@Resource
	private BpmFormViewManager bpmFormViewManager;
	
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmNodeJumpDao;
	}
	
	@Override
	public void create(BpmNodeJump entity) {
		entity.setJumpId(IdUtil.getId());
		super.create(entity);
	}
	
	 /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId){
    	return bpmNodeJumpDao.getByActInstId(actInstId);
    
    }
    

	public BpmNodeJump getLastNodeJump(String actInstId,String nodeId){
		return bpmNodeJumpDao.getLastByInstNode(actInstId, nodeId);
	}
	
    
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @param status
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId,String status){
    	return bpmNodeJumpDao.getByActInstId(actInstId,status);
    }
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @param page
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId,Page page){
    	return bpmNodeJumpDao.getByActInstId(actInstId,page);
    }
    
    /**
     * 获得任务节点的最新审批映射
     * @param actInstId
     * @return
     */
    public Map<String,BpmNodeJump> getMapByActInstId(String actInstId){
    	Map<String,BpmNodeJump> nodeMap=new LinkedHashMap<String,BpmNodeJump>();
    	List<BpmNodeJump> list=bpmNodeJumpDao.getByActInstId(actInstId);
    	for(BpmNodeJump jump:list){
    		if(jump.getHandlerId()!=null 
    				&& jump.getCompleteTime()!=null 
    				&& !nodeMap.containsKey(jump.getNodeId())){
    			nodeMap.put(jump.getNodeId(), jump);
    		}
    	}
    	return nodeMap;
    }
    
    /**
     * 取得任务实例中的跳转记录
     * @param taskId
     * @return
     */
    public BpmNodeJump getByTaskId(String taskId){
    	return bpmNodeJumpDao.getByTaskId(taskId);
    }
    
    /**
     * 获得某个节点的审批记录
     * @param actInstId
     * @param nodeId
     * @return
     */
    public List<BpmNodeJump> getByActInstIdNodeId(String actInstId,String nodeId){
    	return bpmNodeJumpDao.getByActInstIdNodeId(actInstId, nodeId);
    }
    
    /**
     * 获得上一节点的所有审批人
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    public String getBeforeUser(String actInstId) {
    	List<BpmNodeJump> list=getByActInstId(actInstId);
    	StringBuffer sb = new StringBuffer();
    	Set<String> s = new HashSet<String>();
    	for(BpmNodeJump node:list){
    		if(BeanUtil.isEmpty(node.getCompleteTime())) continue;
    		if(StringUtil.isEmpty(node.getHandlerId())) continue;
			IGroup mainDep=groupService.getMainByUserId(node.getHandlerId());
			IUser osUser=userService.getByUserId(node.getHandlerId());
			if(mainDep!=null){
    			String depName = mainDep.getIdentityName();
    			s.add(depName +":"+osUser.getFullname()+",");
			}else if(osUser!=null){
				s.add(osUser.getFullname()+",");
			}
    	}
    	for(String userSet:s){
    		sb.append(userSet);
    	}
    	if(sb.length() >0){
    		sb.deleteCharAt(sb.length()-1);
    	}
    	return sb.toString();
    	
    }
    
    /**
     * 获得某个实例其已经审批的人员ID集合
     * @param actInstId
     * @return
     */
    public Set<String> getNodeHandleUserIds(String actInstId){
    	Set<String> userIds=new HashSet<String>();
    	List<BpmNodeJump> list=getByActInstId(actInstId);
    	for(BpmNodeJump node:list){
    		if(BeanUtil.isEmpty(node.getCompleteTime()) || StringUtils.isEmpty(node.getHandlerId()) ) continue;
    		userIds.add(node.getHandlerId());
    	}
    	return userIds;
    }
    
    
    
    
    /**
     * 找到最新的回退记录列表
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getLatestBackStart(String actInstId){
    	return bpmNodeJumpDao.getLatestBackStart(actInstId);
    }
    
    /**
     * 找到最新的用户审批的人员，回退后，原节点的人员审批不算在内。
     * @param actInstId
     * @return
     */
    public Set<String> getLatestHadCheckedUserIds(String actInstId){
    	Set<String> userIds=new HashSet<String>();
    	List<BpmNodeJump> nodeJumps= getLatestBackStart(actInstId);
    	if(nodeJumps.size()>0){
    		BpmNodeJump backPath=nodeJumps.get(0);
    		List<BpmNodeJump> nodeJumpList=bpmNodeJumpDao.getByActInstIdGtCreateTinme(actInstId, backPath.getCreateTime());
    		for(BpmNodeJump p:nodeJumpList){
    			if(StringUtils.isNotEmpty(p.getHandlerId())){
    				userIds.add(p.getHandlerId());
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
    	List<BpmNodeJump> bpmNodeJumps=bpmNodeJumpDao.getByActInstIdJumpType(actInstId,TaskOptionType.AGREE.name());
    	Set<String> userIds=new HashSet<String>();
    	for(BpmNodeJump p:bpmNodeJumps){
    		if(StringUtils.isNotEmpty(p.getHandlerId())){
    			userIds.add(p.getHandlerId());
    		}
    	}
    	return userIds;
    }
    
    /**
     * 根据实例获取表单意见。
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getFormOpinionByActInstId(String actInstId){
    	List<BpmNodeJump> bpmNodeJumps=bpmNodeJumpDao.getFormOpinionByActInstId(actInstId);
    	return bpmNodeJumps;
    }
    
    /**
     * 根据实例删除。
     * @param actInstId
     */
    public void removeByActInst(String actInstId){
    	bpmNodeJumpDao.removeByActInst(actInstId);
    }
    
    
    /**
     * 更新node jump 这个一般在审批完成后调用修改。
     * @param taskId
     */
    public void updateNodeJump(String taskId) {
		IExecutionCmd cmd = ProcessHandleHelper.getProcessCmd();
		if (!(cmd instanceof ProcessNextCmd))  return;

		BpmNodeJump nodeJump = getByTaskId(taskId);
		if (nodeJump == null) return;
		
		String opIds = cmd.getOpFiles();
		//添加意见附件
		addOpFiles(opIds,nodeJump);

		OsUser curUser=(OsUser)ContextUtil.getCurrentUser();
		nodeJump.setCheckStatus(cmd.getJumpType());
		//if(StringUtil.isNotEmpty(cmd.getOpinion())){
		nodeJump.setRemark(cmd.getOpinion());
		//}
		nodeJump.setHandlerId(curUser.getUserId());
		nodeJump.setJumpType(cmd.getJumpType());
		nodeJump.setCompleteTime(new Date());
		nodeJump.setOpinionName(cmd.getOpinionName());
		
		//保存处理人部门信息
		nodeJump.setHandleDepId(curUser.getMainGroupId());
		nodeJump.setHandleDepFull(curUser.getDepPathNames());
		
		Long duration = nodeJump.getCompleteTime().getTime()- nodeJump.getCreateTime().getTime();
		nodeJump.setDuration(duration);
		update(nodeJump);
	}
    
    /**
     * 添加意见附件。
     * @param opFiles
     * @param nodeJump
     */
    public void addOpFiles(String opFiles,BpmNodeJump nodeJump){
    	if(StringUtils.isEmpty(opFiles)) return;
    	
		JSONArray arr = JSONArray.parseArray(opFiles);
		Iterator<Object> it = arr.iterator();
		while(it.hasNext()) {
		     JSONObject ob = (JSONObject) it.next();
		     String fileName = ob.getString("fileName");
		     String fileId = ob.getString("fileId");
		     BpmCheckFile cfile = new BpmCheckFile();
		     cfile.setJumpId(nodeJump.getJumpId());
		     cfile.setFileName(fileName);
		     cfile.setFileId(fileId);
		     bpmCheckFileManager.create(cfile);
		}
		
    }
    
    /**
     * 创建意见。
     * @param taskEntity
     * @return
     */
    public BpmNodeJump createNodeJump(TaskEntity taskEntity) {
		
		BpmNodeJump nodeJump = new BpmNodeJump();
		nodeJump.setJumpId(IdUtil.getId());
		nodeJump.setActDefId(taskEntity.getProcessDefinitionId());
		nodeJump.setActInstId(taskEntity.getProcessInstanceId());
		nodeJump.setTaskId(taskEntity.getId());
		// 获得任务的创建时间
		nodeJump.setNodeName(taskEntity.getName());
		nodeJump.setNodeId(taskEntity.getTaskDefinitionKey());
		// nodeJump.setHandlerId(ContextUtil.getCurrentUserId());
		IExecutionCmd cmd = ProcessHandleHelper.getProcessCmd();
		nodeJump.setCheckStatus(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		nodeJump.setJumpType(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		
		nodeJump.setRemark("无");
		if (cmd instanceof ProcessStartCmd) {
			if(StringUtils.isNotEmpty(cmd.getOpinion())){
				nodeJump.setRemark(cmd.getOpinion());
			}
			create(nodeJump);
		} else {
			create(nodeJump);
		}
		nodeJump.setEnableMobile(taskEntity.getEnableMobile());

		return nodeJump;
	}
    
    /**
     * 创建nodejump。
     * @param bpmTask
     * @return
     */
    public BpmNodeJump createNodeJump(BpmTask bpmTask) {
     	
		BpmNodeJump nodeJump = new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setTaskId(bpmTask.getId());
		nodeJump.setCreateTime(new Date());
		// 获得任务的创建时间
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		// nodeJump.setHandlerId(ContextUtil.getCurrentUserId());
		IExecutionCmd cmd = ProcessHandleHelper.getProcessCmd();
		nodeJump.setCheckStatus(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		nodeJump.setJumpType(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		
		nodeJump.setRemark("无");
		if (cmd instanceof ProcessStartCmd) {
			if(StringUtils.isNotEmpty(cmd.getOpinion())){
				nodeJump.setRemark(cmd.getOpinion());
			}
			create(nodeJump);
		} else {
			create(nodeJump);
		}
		

		return nodeJump;
	}

    /**
     * 添加意见。
     * @param bpmTask
     */
    public void addNodeJump(BpmTask bpmTask) {
		BpmNodeJump nodeJump = new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setTaskId(bpmTask.getId());
		nodeJump.setCreateTime(new Date());
		// 获得任务的创建时间
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setCheckStatus(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		nodeJump.setJumpType(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		
		nodeJump.setRemark("无");
		nodeJump.setOwnerId(bpmTask.getOwner());
		create(nodeJump);
	}
    
    public List<BpmNodeJump> getNodeJumpByInstId(String instId){
    	return bpmNodeJumpDao.getNodejumpByInstId(instId);
    }
}