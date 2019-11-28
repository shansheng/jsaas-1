package com.redxun.bpm.core.service.sign;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.listener.EventUtil;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDestNode;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmSignData;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.config.MultiTaskConfig;
import com.redxun.bpm.core.entity.config.TaskIdentityConfig;
import com.redxun.bpm.core.entity.config.TaskVotePrivConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmSignDataManager;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.enums.TaskVarType;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;

/**
 * 会签配置服务类
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class CounterSignService {
	@Resource
	private BpmSignDataManager bpmSignDataManager;
	@Resource
	private BpmNodeSetManager bpmNodeSetManager;
	@Resource
	private UserService userService;
	@Resource
	private GroupService groupService;
	@Resource
	private BpmIdentityCalService bpmIdentityCalService;
	@Resource
	private ActRepService actRepService;
	@Resource
	private BpmRuPathManager bpmRuPathManager;

	protected Logger logger=LogManager.getLogger(CounterSignService.class);
	
	/**
	 * 取得内嵌子流程的任务及用户
	 * @param execution
	 * @return
	 */
	private List<TaskExecutor> getSubProcessTaskUsers(ActivityExecution execution){
		List<TaskExecutor> userIds=new ArrayList<TaskExecutor>();
		String subProcessNodeId=execution.getActivity().getId();
		//从子流程中的第一个人工任务来取人员作为多实例的变量集合
		ActNodeDef firstNodeDef=actRepService.getSubProcessFirstTaskNodeDef(execution.getProcessDefinitionId(),subProcessNodeId);
		if(firstNodeDef==null) return userIds;
		List<TaskExecutor> users= getUsers(execution,firstNodeDef.getNodeId());
		return users;
	}
	
	/**
	 * 从数据配置读取。
	 * @param execution
	 * @param nodeId
	 * @return
	 */
	private List<TaskExecutor> getFromDb(ActivityExecution execution,String nodeId){
		//取得人员配置的信息列表
		Collection<TaskExecutor> idInfoList=bpmIdentityCalService.calNodeUsersOrGroups(execution.getProcessDefinitionId(), nodeId,execution.getVariables());
		List<TaskExecutor> rtn=new ArrayList<>();
		rtn.addAll(idInfoList);
		return rtn;
		
	}
	
	/**
	 * 获取会签节点人员。
	 * @param execution
	 * @return
	 */
	private List<TaskExecutor> getSignNodeUsers(ActivityExecution execution){
		String nodeId=execution.getActivity().getId();
		List<TaskExecutor> users= getUsers(execution,nodeId);
		return users;
	}
	
	/**
	 * 人员获取逻辑。
	 * <pre>
	 * 	1. 如果这个节点时驳回的情况，从驳回设置中找人。
	 * 	2. 如果查看流程变量中是否有人，有人则返回。
	 * 	3. 从上下文变量中查看是否有人，有人则返回。
	 * 	4. 从数据库中获取人员。
	 * </pre>
	 * @param execution
	 * @param nodeId
	 * @return
	 */
	private List<TaskExecutor> getUsers(ActivityExecution execution ,String nodeId){
		List<TaskExecutor> executors=new ArrayList<TaskExecutor>();
		//1.回退处理通过
		BpmRuPath backRuPath=ProcessHandleHelper.getBackPath();
		if(backRuPath!=null && "YES".equals(backRuPath.getIsMultiple())){
			String uIds=backRuPath.getUserIds();
			String[] aryUser=uIds.split(",");
			for(String userId:aryUser){
				executors.add(TaskExecutor.getUserExecutor(userId, ""));
			}
			execution.setVariable(TaskVarType.SIGN_USER_IDS_.getKey()+nodeId,executors);
			return executors;
		}
		//2.通过变量来判断是否第一次进入该方法
		List<TaskExecutor> signUserIds=(List<TaskExecutor>)execution.getVariable(TaskVarType.SIGN_USER_IDS_.getKey()+nodeId);
		
		if(BeanUtil.isNotEmpty(signUserIds)) return signUserIds;
		
		
		//3.从变量中取用户
		IExecutionCmd nextCmd=ProcessHandleHelper.getProcessCmd();
		BpmDestNode bpmDestNode=nextCmd.getNodeUserMap().get(nodeId);
		
		if(bpmDestNode!=null && (StringUtils.isNotEmpty(bpmDestNode.getUserIds())
				|| StringUtils.isNotEmpty(bpmDestNode.getGroupIds()))){
			if(StringUtils.isNotEmpty(bpmDestNode.getUserIds())){
				String[] aryUser=bpmDestNode.getUserIds().split(",");
				for(String userId:aryUser){
					executors.add(TaskExecutor.getUserExecutor(userId, ""));
				}
			}
			if( StringUtils.isNotEmpty(bpmDestNode.getGroupIds())){
				String[] aryUser=bpmDestNode.getGroupIds().split(",");
				for(String userId:aryUser){
					executors.add(TaskExecutor.getUserExecutor(userId, ""));
				}
			}
			//加至流程变量中，以使后续继续不需要从线程及数据库中获取
			execution.setVariable(TaskVarType.SIGN_USER_IDS_.getKey()+nodeId,executors);
			return executors;
		}
		//4.从数据库获取
		List<TaskExecutor>  userIds= getFromDb(execution,nodeId);

		if(userIds.size()==0){
			String name=(String)execution.getActivity().getProperty("name");
			ProcessMessage msg=ProcessHandleHelper.getProcessMessage();
			msg.getErrorMsges().add("节点["+name+"]没有设置执行人员，请联系管理员！");
		}else{
			execution.setVariable(TaskVarType.SIGN_USER_IDS_.getKey()+nodeId,userIds);
		}

		return userIds;
	}
	
	/**
	 * 获得会签任务中的人员计算集合
	 * @param execution
	 * @return
	 */
	public List<TaskExecutor> getUsers(ActivityExecution execution){
		logger.debug("enter the CounterSignService========================== ");
		ActivityImpl curExe=(ActivityImpl)execution.getActivity();
		String type=(String)curExe.getProperty("type");
		
		//多实例时,需要获得其更新的停牌
		//多实例子流程
		if("subProcess".equals(type)){
			return getSubProcessTaskUsers(execution);
		}
		//会签节点
		else{
			return getSignNodeUsers(execution);
		}
	}

	
	/**
	 * 会签是否计算完成。
	 * @param execution
	 * @return
	 */
	public boolean isComplete(ActivityExecution execution){
		IExecutionCmd cmd= ProcessHandleHelper.getProcessCmd();
		String jumpType=cmd.getJumpType();
		boolean isComplete=false;
		
		String solId=(String)execution.getVariable("solId");
		String nodeId=execution.getActivity().getId();
		UserTaskConfig taskConfig=bpmNodeSetManager.getTaskConfig(solId,execution.getProcessDefinitionId(), nodeId);
		//驳回直接完成
		if(TaskOptionType.BACK.name().equals(jumpType) ||
				TaskOptionType.BACK_SPEC.name().equals(jumpType)
				|| TaskOptionType.RECOVER.name().equals(jumpType)){

			//执行脚本。
			EventUtil. executeSignScript(  execution, taskConfig );
			
			isComplete=true;

		}
		else{
			isComplete=handApprove( execution,taskConfig);
		}
		return isComplete;
	}
	
	/**
	 * 处理审批的情况。
	 * @param execution
	 * @return
	 */
	private boolean handApprove(ActivityExecution execution,UserTaskConfig taskConfig){
		//完成会签的次数
		Integer completeCounter=(Integer)execution.getVariable("nrOfCompletedInstances");
		//总循环次数
		Integer instanceOfNumbers=(Integer)execution.getVariable("nrOfInstances");
		
		String nodeId=execution.getActivity().getId();
		
		String actInstId=execution.getProcessInstanceId();
		
		
		
		//获得任务及其多实例的配置,则任务不进行任何投票的设置及处理，即需要所有投票完成后来才跳至下一步。
		MultiTaskConfig signConfig=taskConfig.getMultiTaskConfig();
		
		//获得会签的数据
		List<BpmSignData> bpmSignDatas=bpmSignDataManager.getByInstIdNodeId(actInstId, nodeId);
		
		//通过票数
		int passCount=0;
		//反对票数
		int refuseCount=0;
		
		for(BpmSignData data:bpmSignDatas){
			int calCount=1;
			//弃权不作票数统计
			if(TaskOptionType.ABSTAIN.name().equals(data.getVoteStatus())){
				continue;
			}
			String userId=data.getUserId();
			//检查是否有特权的处理
			TaskVotePrivConfig config= getConfig(userId,signConfig);
			if(config!=null){
				calCount=config.getVoteNums();
			}
			//统计同意票数
			if(TaskOptionType.AGREE.name().equals(data.getVoteStatus())){
				passCount+=calCount;
			}else{//统计反对票数
				refuseCount+=calCount;
			}
		}
		
		logger.debug("==============================passCount:"+passCount+" refuseCount:" + refuseCount );
		//是否可以跳出会签
		VoteResult rtn=getVoteResult( signConfig, instanceOfNumbers, passCount, refuseCount);
		
		String handType=signConfig.getHandleType();
		
		if((MultiTaskConfig.HANDLE_TYPE_DIRECT.equals(handType)&& rtn.getCompleted())//直接处理
				|| (MultiTaskConfig.HANDLE_TYPE_WAIT_TO.equals(handType) && completeCounter.equals(instanceOfNumbers))){//等待所有的处理完
			execution.setVariable("voteResult_"+nodeId, rtn.getResult());
			
			/**
			 * 更新会签节点真正的执行人。
			 */
			updRuPath( actInstId, nodeId);
			
			//删除该节点的会签数据
			bpmSignDataManager.delByActInstIdNodeId(actInstId,nodeId);
			//删除流程变量
			execution.removeVariable("signUserIds_" +nodeId);
			
			//成功完成会签
			finishToUpdateToken();
			
			//执行脚本。
			EventUtil. executeSignScript(  execution, taskConfig );
			
			return true;
		}
		
		return false;
	}
	
	/**
	 * 更新会签节点真正的执行人
	 * @param actInstId
	 * @param nodeId
	 */
	private void updRuPath(String actInstId,String nodeId){
		
		List<BpmSignData> signDatas= bpmSignDataManager.getByInstIdNodeId(actInstId, nodeId);
		String userIds="";
		for(int i=0;i<signDatas.size();i++){
			BpmSignData data=signDatas.get(i);
			if(i==0){
				userIds+=data.getUserId();
			}
			else{
				userIds+="," + data.getUserId();
			}
		}
		IExecutionCmd cmd= ProcessHandleHelper.getProcessCmd();
		cmd.addTransientVar("signUsers", userIds);
		
	}
	
	/**
	 * 判断是否有权限加签。
	 * @param signConfig
	 * @param userId
	 * @return
	 */
	public boolean hasAddPermission(MultiTaskConfig signConfig,String userId){
		boolean hasPermission=false;
		List<IGroup> osGroups=groupService.getGroupsByUserId(userId);
		List<TaskIdentityConfig> configs= signConfig.getAddSignConfigs();
		for(TaskIdentityConfig config:configs){
			if(TaskIdentityConfig.All_USER.equals(config.getIdentityType())){
				hasPermission=true;
				break;
			}
			if(TaskIdentityConfig.USER.equals(config.getIdentityType())){
				if(config.getIdentityIds().contains(userId)){
					hasPermission=true;
					break;
				}
			}
			if(TaskIdentityConfig.GROUP.equals(config.getIdentityType())){
				for(IGroup group:osGroups){
					if(config.getIdentityIds().contains(group.getIdentityId())){
						hasPermission=true;
						break;
					}
				}
			}
		}
		return hasPermission;
	}
	
	private TaskVotePrivConfig getConfig(String userId,MultiTaskConfig signConfig){
		if(BeanUtil.isEmpty(signConfig.getVotePrivConfigs())) return null;
		TaskVotePrivConfig rtnConfig=null;
		//计算用户的用户组
		List<IGroup> osGroups=groupService.getGroupsByUserId(userId);
		
		for(TaskVotePrivConfig voteConfig:signConfig.getVotePrivConfigs()){
			//为用户类型
			if(TaskVotePrivConfig.USER.equals(voteConfig.getIdentityType()) 
					&& voteConfig.getIdentityIds().contains(userId)){
				rtnConfig=voteConfig;
			}else{//为用户组类型
				for(IGroup osGroup:osGroups){
					if(voteConfig.getIdentityIds().contains(osGroup.getIdentityId())){
						rtnConfig=voteConfig;
						break;
					}
				}
			}
		}
		return rtnConfig;
		
	}
	
	private VoteResult getVoteResult(MultiTaskConfig signConfig,int instanceOfNumbers,int passCount,int refuseCount){
		VoteResult rtn=new VoteResult();
		
		//按投票通过数进行计算
		if(MultiTaskConfig.VOTE_TYPE_PASS.equals(signConfig.getVoteResultType())){
			rtn.setResult("REFUSE");
			//计算是否通过
			//按投票数进行统计
			if(MultiTaskConfig.CAL_TYPE_NUMS.equals(signConfig.getCalType())){
				//代表通过
				if(passCount>=signConfig.getVoteValue()){
					rtn.setCompleted(true);
					rtn.setResult("PASS");
				}
			}else{//按百分比进行计算
				int resultPercent=new Double(passCount*100/instanceOfNumbers).intValue();
				//代表通过
				if(resultPercent>=signConfig.getVoteValue()){
					rtn.setCompleted(true);
					rtn.setResult("PASS");
				}
			}
		}else{//按投票反对数进行计算
			//计算是否通过
			rtn.setResult("PASS");
			//按投票数进行统计
			if(MultiTaskConfig.CAL_TYPE_NUMS.equals(signConfig.getCalType())){
				//代表通过
				if(refuseCount>=signConfig.getVoteValue()){
					rtn.setCompleted(true);
					rtn.setResult("REFUSE");
				}
			}else{//按百分比进行计算
				int resultPercent=new Double(refuseCount*100/instanceOfNumbers).intValue();
				//代表通过
				if(resultPercent>=signConfig.getVoteValue()){
					rtn.setCompleted(true);
					rtn.setResult("REFUSE");
				}
			}
		}
		return rtn;
	}
	
	
	
	/**
	 * 完成会签更新token  T_1_2   T_2
	 *  
	 */
	private void finishToUpdateToken(){
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		String token=cmd.getToken();
		if(StringUtils.isEmpty(token)){
			return;
		}
		
		String[] tokens=token.split("_");
		
		if(tokens.length<=2){
			cmd.setToken(null);
			return ;
		}
		int lastIndex=tokens.length-1;
		String newToken="";
		for(int i=0;i<lastIndex;i++){
			newToken=newToken+tokens[i];
			if(i<lastIndex-1){
				newToken=newToken+"_";
			}
		}
		cmd.setToken(newToken);
	}
	
}

class VoteResult{
	
	public VoteResult(){
	}
	
	public VoteResult(Boolean completed,  String result){
		this.completed=completed;
		this.result=result;
	}
	
	private Boolean completed=false;
	private String result="";
	
	public Boolean getCompleted() {
		return completed;
	}
	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
}
