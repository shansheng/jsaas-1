package com.redxun.bpm.core.manager;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import com.redxun.bpm.core.entity.*;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActProcessDef;
import com.redxun.bpm.activiti.ext.ActivitiDefCache;
import com.redxun.bpm.activiti.handler.ProcessStartAfterHandler;
import com.redxun.bpm.activiti.handler.ProcessStartPreHandler;
import com.redxun.bpm.activiti.service.ActInstService;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.service.CallModel;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.dao.BpmInstDao;
import com.redxun.bpm.core.dao.BpmOpinionTempDao;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.TaskNodeUser;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormulaSetting;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.listener.ListenerUtil;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.BoResult.ACTION_TYPE;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.core.entity.SysSeqId;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysSeqIdManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.sun.star.uno.RuntimeException;


/**
 * <pre>
 * 描述：BpmInst业务服务类
 * 构建组：
 * 作者：mansan
 * 邮箱: chshxuan@163.com
 * 日期:2016-2-1-上午12:52:41
 * @Copyright (c) 2016-2017 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmInstManager extends BaseManager<BpmInst> {
	@Resource
	RuntimeService runtimeService;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmFormInstManager bpmFormInstManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmLogManager bpmLogManager;
	@Resource
	ActInstService actInstService;
	@Resource
	ActRepService actRepService;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	TaskService taskService;
	@Resource
	BpmSolCtlManager bpmSolCtlManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	BpmTestCaseManager  bpmTestCaseManager;
	@Resource
	BpmSolVarManager bpmSolVarManager;
	@Resource
	GroovyEngine groovyEngine;

	@Resource
	BpmInstDao bpmInstDao;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	BpmRuPathManager bpmRuPathManager;
	@Resource
	BpmCheckFileManager bpmCheckFileManager;
	@Resource
	BpmInstAttachManager bpmInstAttachManager;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	private SysTreeManager sysTreeManager;
	@Resource
	BpmInstCcManager bpmInstCcManager;
	@Resource
	BpmInstDataManager bpmInstDataManager;
	@Resource
	CommonDao commonDao;
	@Resource
	BpmOpinionTempManager bpmOpinionTempManager;
	@Resource
	BpmInstReadManager bpmInstReadManager;
	@Resource
	BpmSignDataManager bpmSignDataManager;
	@Resource
	BpmRemindInstManager bpmRemindInstManager;
	@Resource
	UserService userService;
    @Resource
    BpmOpinionTempDao bpmOpinionTempDao;
	@Resource
	SysSeqIdManager sysSeqIdManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	TaskManager taskManager;
	@Resource
	BpmMessageBoardManager  bpmMessageBoardManager;
	@Resource
	BpmTestSolManager bpmTestSolManager;
	@Resource
	BpmInstStartLogManager bpmInstStartLogManager;
	@Resource
    BpmSolUserManager bpmSolUserManager;
	@Resource
	BpmExecutionManager bpmExecutionManager;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	
	private static Pattern regexSubject = Pattern.compile("\\$\\{(\\S*?)\\}");
	
	/**
	 * 与解决方案分类进行联合查询
	 * 
	 * @param filter
	 * @return
	 */
	public List<BpmInst> getInstByTreeId(QueryFilter filter,String treeId) {
		IUser user=ContextUtil.getCurrentUser();
		
		List<BpmInst> 	bpmInstList=null;
		if(user.isSuperAdmin()){
			bpmInstList = bpmInstDao.getInstsByAdminTreeId(filter);
		}
		else{
			Map<String, Set<String>> profileMap= ProfileUtil.getCurrentProfile();
			String grantType=BpmAuthSettingManager.getGrantType();
			if(StringUtils.isNotBlank(treeId)){
				filter.addFieldParam("treeId",treeId);
			}
			filter.addFieldParam("profileMap", profileMap);
			filter.addFieldParam("grantType", grantType);
			bpmInstList = bpmInstDao.getInstsByTreeId(filter);
		}
		
		return bpmInstList;
		

	}
	/**
	 * 结束流程
	 * 
	 * @param instId
	 */
	public void doEndProcessInstance(String instId) {
		BpmInst bpmInst = get(instId);
		
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(bpmInst.getSolId(),bpmInst.getActDefId());
		
		String script=processConfig.getEndProcessScript();
		
		if(StringUtil.isNotEmpty(script)){
			Map<String,Object> params=new HashMap<>();
			params.put("bpmInst", bpmInst);
			groovyEngine.executeScripts(script, params);
		}
		// 结束Activiti的流程实例
		bpmExecutionManager.delByInstId(bpmInst.getActInstId());
		// 人工干预结束的
		bpmInst.setStatus(BpmInst.STATUS_ABORT_END);
		update(bpmInst);
		
		bpmLogManager.addInstLog(bpmInst.getSolId(), instId, BpmLog.OP_TYPE_INST_END, "人工结束流程实例-"
				+ bpmInst.getSubject());
	}
	/**
	 * 流程作废
	 * 
	 * @param instId
	 */
	public void doDiscardProcessInstance(String instId) {
		BpmInst bpmInst = get(instId);
		String actInstId = bpmInst.getActInstId();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		
		// 结束Activiti的流程实例
		String delTaskSql = "delete from act_ru_task where PROC_INST_ID_=#{actInstId}";
		String delVariableSql = "delete from act_ru_variable where PROC_INST_ID_=#{actInstId}";
		String queryExecutionSql = "select * from act_ru_execution where PROC_INST_ID_=#{actInstId}";
		
		delIdentitylinkSql(actInstId);
		commonDao.execute(delTaskSql, params);
		commonDao.execute(delVariableSql, params);
		List result=commonDao.query(queryExecutionSql, params);
		delExecutionSql(result);		
		// 人工干预结束的
		bpmInst.setStatus(BpmInst.STATUS_DISCARD);
		update(bpmInst);
		
		//将关联数据状态改成作废
		bpmInstDataManager.updFormDataStatus(instId, BpmInst.STATUS_DISCARD); 
		
		bpmLogManager.addInstLog(bpmInst.getSolId(), instId, BpmLog.OP_TYPE_INST_DISCARD, "作废流程实例-"
				+ bpmInst.getSubject());
	}
	
	private void delIdentitylinkSql(String actInstId){
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> taskparams = new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		String delIdentitylinkSql = "delete from act_ru_identitylink where PROC_INST_ID_=#{actInstId}";
		commonDao.execute(delIdentitylinkSql, params);
		String queryIdentitylinkSql = "select * from act_ru_task where PROC_INST_ID_=#{actInstId}";
		List result=commonDao.query(queryIdentitylinkSql, params);
		String delIdentitylinkSqlByTaskId = "delete from act_ru_identitylink where TASK_ID_=#{taskId}";
		for(int i=0;i<result.size();i++){
			Map<String, String> map=(HashMap<String, String>)result.get(i);
			String id = map.get("ID_");
			taskparams.put("taskId", id);
			commonDao.execute(delIdentitylinkSqlByTaskId, taskparams);
		}

	}
	
	private void delExecutionSql(List result){
	
		if(result.size()==0) return;
		
		String delExecutionSql = "delete from act_ru_execution where ID_=#{id}";
		Map<String, Object> params = new HashMap<String, Object>();
		Iterator it = result.iterator();
		while(it.hasNext()){
			boolean isParent = false;
			Map<String, String> pmap=(HashMap<String, String>)it.next();
			String id = pmap.get("ID_");
			for(int j=0;j<result.size();j++){
				Map<String, String> map=(HashMap<String, String>)result.get(j);
				String parentId = map.get("PARENT_ID_");
				if(StringUtil.isNotEmpty(parentId)&&parentId.equals(id)){
					isParent = true;
				}
			}
			if(!isParent){
				it.remove();
				params.put("id", id);
				commonDao.execute(delExecutionSql, params);				
			}
		}
		delExecutionSql(result);
		
	}
	

	/**
	 * 挂起流程实例
	 * 
	 * @param instId
	 */
	public void doPendingProcessInstance(String instId) {
		BpmInst bpmInst = get(instId);
		// 扶起Activiti的流程实例
		runtimeService.suspendProcessInstanceById(bpmInst.getActInstId());
		// 人工干预结束的
		bpmInst.setStatus(BpmInst.STATUS_PENDING);
		update(bpmInst);
		bpmLogManager.addInstLog(bpmInst.getSolId(), instId, BpmLog.OP_TYPE_INST_PEND,
				"流程实例-" + bpmInst.getSubject() + "被挂起");
	}

	/**
	 * 激活挂起流程实例
	 * 
	 * @param instId
	 */
	public void doActivateProcessInstance(String instId) {
		BpmInst bpmInst = get(instId);
		// 扶起Activiti的流程实例
		runtimeService.activateProcessInstanceById(bpmInst.getActInstId());
		// 人工干预结束的
		bpmInst.setStatus(BpmInst.STATUS_RUNNING);
		update(bpmInst);
		bpmLogManager.addInstLog(bpmInst.getSolId(), instId, BpmLog.OP_TYPE_INST_ACTIVE,
				"流程实例-" + bpmInst.getSubject() + "被重新激活来运行！");
	}

	/**
	 * 删除流程实例
	 * 
	 * @param instId
	 * @param reason
	 */
	public void deleteCascade(String instId, String reason) {
		BpmInst inst = bpmInstDao.get(instId);
		if (inst == null) return;
		
		if (inst.getStatus().equals(BpmInst.STATUS_RUNNING)) {
			//删除流程引擎相关
			if (StringUtils.isNotEmpty(inst.getActInstId())) {
				runtimeService.deleteProcessInstance(inst.getActInstId(),
						reason);
			}
			String actInstId=inst.getActInstId();
			//bpm_check_file
			removeCheckFile(actInstId);
			//删除bpm_node_jump
			bpmNodeJumpManager.removeByActInst(actInstId);
			//bpm_sign_data
			bpmSignDataManager.delByActInstId(actInstId);
			//删除催办
			bpmRemindInstManager.removeByActInst(actInstId);
		}
		//删除抄送
		bpmInstCcManager.delByInstId(instId);
		//删除测试用例
		bpmTestCaseManager.delByInstId(instId);
		//删除流程实例数据。
		bpmInstDataManager.removeByInstId(instId);
		//bpm_inst_read
		bpmInstReadManager.removeByInst(instId);
		//删除bpm_ru_path
		bpmRuPathManager.removeByInst(instId);
		
		delete(instId);
		
		bpmLogManager.addInstLog(inst.getSolId(), instId, BpmLog.OP_TYPE_DEL,
				"流程实例-" + inst.getSubject() + "被删除!");
	}
	
	/**
	 * 删除checkfile。
	 * @param actInstId
	 */
	private void removeCheckFile(String actInstId){
		String sql="delete from bpm_check_file where JUMP_ID_ in (SELECT JUMP_ID_ FROM bpm_node_jump WHERE ACT_INST_ID_=#{actInstId})";
		SqlModel sqlModel=new SqlModel(sql);
		sqlModel.addParam("actInstId", actInstId);
		commonDao.execute(sqlModel);
	}

	/**
	 * 按工作流实例Id删除
	 * 
	 * @param actInstId
	 * @param reason
	 */
	public void deleteCasecadeByActInstId(String actInstId, String reason) {
		BpmInst inst = bpmInstDao.getByActInstId(actInstId);
		if (inst == null)
			return;
		if (inst.getStatus().equals(BpmInst.STATUS_RUNNING)) {
			if (StringUtils.isNotEmpty(inst.getActInstId())) {
				runtimeService.deleteProcessInstance(inst.getActInstId(),
						reason);
			}
		}
//		bpmFormInstManager.delByBpmInstId(inst.getInstId());
		delete(inst.getInstId());
	}

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstDao;
	}

	/**
	 * 通过Activiti的流程实例ID获得扩展的流程实例列表
	 * 
	 * @param actInstId
	 * @return
	 */
	public BpmInst getByActInstId(String actInstId) {
		return bpmInstDao.getByActInstId(actInstId);
	}

	/**
	 * 获得流程实例数
	 * 
	 * @param solId
	 * @return
	 */
	public int getCountsBySolId(String solId) {
		return bpmInstDao.getCountsBySolId(solId);
	}

	/**
	 * 通过流程定义Id获得实例数
	 * 
	 * @param actDefId
	 * @return
	 */
	public int getCountsByActDefId(String actDefId) {
		return bpmInstDao.getCountsByActDefId(actDefId);
	}

	/**
	 * 返回流程实例
	 * 
	 * @param subRule
	 * @param instJson
	 * @return
	 */
	private String parseSubject(String subRule, Map<String, Object> vars) throws Exception{
		Matcher regexMatcher = regexSubject.matcher(subRule);
		while (regexMatcher.find()) {
			String str=vars.get(regexMatcher.group(1))==null?"":vars.get(regexMatcher.group(1)).toString();
			subRule=subRule.replace( regexMatcher.group(0),str);
		} 
		return subRule;
	}

	
	public static void main(String[] args) {
		String titleString="test${jd.name} dddd";
		Map<String, String> maps=new HashMap<String, String>();
		maps.put("jd.name", "home");
		
		Matcher regexMatcher = regexSubject.matcher(titleString);
		if (regexMatcher.find()) {
			String str=maps.get(regexMatcher.group(1))==null?"":maps.get(regexMatcher.group(1));
			titleString=titleString.replace( regexMatcher.group(0),str);
		} 
		System.out.println(titleString);
	}
	
	/**
	 * 计算流程标题
	 * 
	 * @param subjectRule
	 * @param processName
	 * @param modelJson
	 * @return
	 */
	private String getSubject(String subjectRule, String processName,Map<String,Object> modelMap) throws Exception{
		String subject = null;
		String curTime= DateUtil.formatDate(new Date(), DateUtil.DATE_FORMAT_FULL);
		String curDate= DateUtil.formatDate(new Date(), DateUtil.DATE_FORMAT_YMD);
		
		modelMap.put("processName", processName);
		modelMap.put("createTime", curTime);
		modelMap.put("curDate", curDate);
		modelMap.put("createUser", ContextUtil.getCurrentUser().getFullname());

		if (StringUtils.isNotEmpty(subjectRule)) {
			subject = parseSubject(subjectRule, modelMap);
		}
		// 检查是否已经存在流程实例标题的规则设置
		if (StringUtils.isEmpty(subject)) {
			subject = processName + "-由"
					+ ContextUtil.getCurrentUser().getFullname() + "创建于"
					+ curDate;
		}
		return subject;
	}
	
	/**
	 * 
	 * @param json 
	 * 格式如：
	 * <pre>
	 * 
	 * </pre>
	 * @return
	 */
	private Map<String,Object> getModelFieldsFromJson(com.alibaba.fastjson.JSONObject jsonObj){
		Map<String,Object> maps=new HashMap<String, Object>();
		
		if(jsonObj==null){return maps;}
		com.alibaba.fastjson.JSONArray jsonArr=jsonObj.getJSONArray("vars");
		if(jsonArr!=null){
			for(int i=0;i<jsonArr.size();i++){
				com.alibaba.fastjson.JSONObject varObj=jsonArr.getJSONObject(i);
				String key=varObj.getString("key");
				String val=varObj.getString("val");
				if(StringUtils.isEmpty(key)||StringUtils.isEmpty(val)){
					continue;
				}
				maps.put(key, val);
			}
		}
		
		com.alibaba.fastjson.JSONArray boArr=jsonObj.getJSONArray("bos");
		
		if(boArr!=null){
			for(int i=0;i<boArr.size();i++){
				com.alibaba.fastjson.JSONObject varObj=boArr.getJSONObject(i);
				String formKey=varObj.getString("formKey");
				com.alibaba.fastjson.JSONObject boData=varObj.getJSONObject("data");
				//多于一个了字段表单时
				if(StringUtils.isNotEmpty(formKey) && boArr.size()>1){
					formKey=formKey+".";
				}else {
					formKey="";
				}
				Map<String,Object> boFields=FastjsonUtil.json2Map(formKey, boData);
				maps.putAll(boFields);
			}
		}
		return maps; 
	}

	/**
	 * 保存草稿，生成流程实例及表单的数据，仅支持在线表单的绑定 仅需要生成流程实例及流程
	 * 
	 * @param cmd
	 * @return
	 */
	public BpmInst doSaveDraft(ProcessStartCmd cmd) throws Exception{
		ProcessHandleHelper.setProcessCmd(cmd);
		BpmInst bpmInst= doStartProcess(cmd, false);
		
		//记录启动流程日志
		bpmLogManager.addInstLog(bpmInst.getSolId(), bpmInst.getInstId(), BpmLog.OP_TYPE_INST_DRAFT, bpmInst.getSubject());
		return bpmInst;
	}

	/**
	 * 启动流程
	 * 
	 * @param cmd
	 * @return
	 * @throws Exception
	 */
	public BpmInst doStartProcess(ProcessStartCmd cmd) throws Exception {
		//清除线程缓存。
		ActivitiDefCache.clearLocal();
		if (StringUtils.isEmpty(cmd.getJsonData())) {
			cmd.setJsonData("{}");
		}
		
		ProcessHandleHelper.setProcessCmd(cmd);
		BpmInst bpmInst = doStartProcess(cmd, true);
		
		//删除暂存
		bpmOpinionTempDao.delTemp(BpmOpinionTemp.TYPE_INST, bpmInst.getInstId());
		//存储调用日志
		CallModel callModel= cmd.getCallModel();
		if(callModel!=null){
			bpmInstStartLogManager.addLog(bpmInst, callModel);
		}
		//记录启动流程日志
		bpmLogManager.addInstLog(bpmInst.getSolId(), bpmInst.getInstId(), BpmLog.OP_TYPE_INST_START, bpmInst.getSubject());
		
		return bpmInst;
	}


	


	/**
	 * 根据配置是否跳过第一节点
	 * 
	 * @param cmd
	 * @param bpmInst
	 */
	protected void skipFirstTask(ProcessStartCmd cmd, BpmInst bpmInst,ProcessConfig processConfig) {
		
		// 跳过第一个节点
		if (!"true".equals(processConfig.getIsSkipFirst())) {return;}
		// 获得开始节点后的第一个节点
		ActNodeDef actNodeDef = actRepService.getStartNode(bpmInst.getActDefId());
		List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
		
		for (Task task : taskList) {
			for (ActNodeDef flowNode : actNodeDef.getOutcomeNodes()) {
				if (!task.getTaskDefinitionKey().equals(flowNode.getNodeId())) continue;
				
				cmd.cleanTasks();
				cmd.setNodeId(task.getTaskDefinitionKey());
				cmd.setHandleNodeId(task.getTaskDefinitionKey());

				taskService.complete(task.getId());
				// 跳过的则认为是同意处理
				BpmNodeJump nodeJump = bpmNodeJumpManager.getByTaskId(task.getId());
				String opFiles = cmd.getOpFiles();
				if (nodeJump != null) {
					bpmNodeJumpManager.addOpFiles(opFiles, nodeJump);
					nodeJump.setCompleteTime(new Date());
					nodeJump.setHandlerId(ContextUtil.getCurrentUserId());
					nodeJump.setCheckStatus(TaskOptionType.AGREE.name());
					nodeJump.setJumpType(TaskOptionType.AGREE.name());
					nodeJump.setRemark(cmd.getOpinion());
					bpmNodeJumpManager.update(nodeJump);
				}
				break;
			}
		}
	}
	
	/**
	 * 保存表单数据
	 * @param cmdJsonObj 业务数据的JSON
	 * @param instId 流程实例Id
	 * @param busKey 业务主键
	 * @param instStatus 流程实例的状态
	 * @param dataSaveMode 数据保存模式
	 */
	private void saveFormData(JSONObject cmdJsonObj,BpmInst bpmInst,String busKey,String instStatus,String dataSaveMode,String boDefIds,String actDefId,Map<String, Object> modelFieldMap){
		String instId=bpmInst.getInstId();
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		IFormDataHandler handler=BoDataUtil.getDataHandler(dataSaveMode);

		String saveSetting="";
		BpmSolFv fv= bpmSolFvManager.getBySolIdActDefIdNodeId(bpmInst.getSolId(), actDefId, BpmFormView.SCOPE_START);
		if(fv!=null) {
			saveSetting=fv.getDataConfs();
		}

		com.alibaba.fastjson.JSONArray jsonArr=cmdJsonObj.getJSONArray("bos");
		if(jsonArr==null || jsonArr.size()==0){
			return;
		}
		//可由参数不进行传值
		List<String> boDefIdList=StringUtil.toList(boDefIds);
		
		BoResult result=null;
		
		for(int i=0;i<jsonArr.size();i++){
			com.alibaba.fastjson.JSONObject jsonObj=jsonArr.getJSONObject(i);
			String boDefId=jsonObj.getString("boDefId");
			String formKey=jsonObj.getString("formKey");
			if(StringUtils.isEmpty(boDefId) && i<boDefIdList.size()){
				boDefId=boDefIdList.get(i);
				if(StringUtils.isEmpty(formKey)){
					List<String> keys=bpmFormViewManager.getAliasByBoIdMainVersion(boDefId);
					if(keys!=null && keys.size()>0){
						formKey=keys.get(0);
					}
				}
			}
			if(boDefId==null){
				continue;
			}
			//
			com.alibaba.fastjson.JSONObject boDataJson=jsonObj.getJSONObject("data");
			
			boDataJson.put(SysBoEnt.FIELD_INST,instId);

			if(StringUtil.isNotEmpty(saveSetting)){
				IDataSettingHandler settingHandler=AppBeanUtil.getBean(IDataSettingHandler.class);
				JSONObject settingJson=JSONObject.parseObject(saveSetting);
				settingHandler.handSetting(boDataJson, boDefId, settingJson, true,modelFieldMap);
			}

			if(BpmInst.STATUS_RUNNING.equals(instStatus)){
				boDataJson.put(SysBoEnt.FIELD_INST_STATUS_, BpmInst.STATUS_RUNNING);
			}else{
				boDataJson.put(SysBoEnt.FIELD_INST_STATUS_, BpmInst.STATUS_DRAFTED);
			}
			//若主键为空，则执行保存数据操作
			if(StringUtils.isEmpty(busKey)) {
				//判断数据是否已经做了关联。
				String pk=bpmInstDataManager.getPk(instId, boDefId);
				//处理插入数据，当数据为添加的时候则插入关联数据。
				result= handler.saveData(boDefId, pk, boDataJson);
				if(result.getAction().equals(ACTION_TYPE.ADD)){
					bpmInstDataManager.addBpmInstData(boDefId, result.getPk(), instId);
				}
				//这里处理直接根据数据启动流程的请款即表单数据已经存在，启动流程的情况。
				else if(StringUtil.isEmpty(pk)){
					bpmInstDataManager.addBpmInstData(boDefId, result.getPk(), instId);
				}
			}
			//放置BO映射中，可供脚本后续运行环境中使用
			cmd.getBoDataMaps().put(formKey, boDataJson);
		}
		if(jsonArr.size()==1 ){
			bpmInst.setBusKey(result.getPk());
		}
	}

	public String getNextNode(String actDefId,boolean isFristNode){
		ActProcessDef actDef=actRepService.getProcessDef(actDefId);
		String startNodeId=actDef.getStartNodeId();
		ActNodeDef startNode= actDef.getNodesMap().get(startNodeId);

		ActNodeDef node=null;
		if(isFristNode){
			node= startNode.getOutcomeNodes().get(0);

		}
		else{
			ActNodeDef firstNode= startNode.getOutcomeNodes().get(0);
			node=firstNode.getOutcomeNodes().get(0);
		}
		return node.getNodeId();
	}

	/**
	 * 启动流程实例
	 * 
	 * @param cmd
	 * @param startFlow
	 *            是否启动流程
	 * @return
	 */
	public BpmInst doStartProcess(ProcessStartCmd cmd, boolean startFlow) throws Exception{

		BpmSolution bpmSolution = bpmSolutionManager.get(cmd.getSolId());

		String actDefId = bpmSolution.getActDefId();
		// 取得最新的流程定义
		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
		// 取得流程的全局配置
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(bpmSolution.getSolId(),actDefId);
		
		if ("true".equals(processConfig.getIsSkipFirst())) {
			cmd.setJumpType(TaskOptionType.SKIP.name());
		}
		
		// 处理前置处理器。
		handlePreHanle( processConfig, cmd);

		
		// 使用了在线表单
		boolean isCreated = false;
		
		if(StringUtil.isEmpty(cmd.getJsonData())){
			cmd.setJsonData("{}");
		}
		
		OsUser curUser=(OsUser)ContextUtil.getCurrentUser();


		//获得转化后的FieldMap
		Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(cmd.getJsonDataObject(),bpmSolution.getBoDefId());
		if(cmd.getJsonDataObject()!=null){
			cmd.setJsonData(cmd.getJsonDataObject().toJSONString());
		}
		BpmInst bpmInst = null;
		// 从草稿中启动
		if (StringUtils.isNotEmpty(cmd.getBpmInstId())) {
			bpmInst = get(cmd.getBpmInstId());
		} else {// 新建实例
			bpmInst = new BpmInst();
			isCreated = true;
			bpmInst.setInstId(IdUtil.getId());
			//保存发起人部门信息
			bpmInst.setStartDepId(curUser.getMainGroupId());
			bpmInst.setStartDepFull(curUser.getDepPathNames());
			
			if(StringUtils.isNotEmpty(cmd.getBusinessKey())){
				bpmInst.setBusKey(cmd.getBusinessKey());
			}
			bpmInst.setDataSaveMode(bpmSolution.getDataSaveMode());
			bpmInst.setSupportMobile(bpmSolution.getSupportMobile());
			// 1.获得流程实例的标题
			try{
			//设置单号
				String billNo=sysSeqIdManager.genSequenceNo(SysSeqId.ALIAS_BPM_INST_BILL_NO,ITenant.PUBLIC_TENANT_ID);
				bpmInst.setBillNo(billNo);
			}catch(Exception ex){
				ex.printStackTrace();
				bpmInst.setBillNo(bpmInst.getInstId());
			}
		}
		//标题
		String subject = getSubject(processConfig.getSubRule(), bpmSolution.getName(), modelFieldMap);
		
		if(BpmSolution.FORMAL_NO.equals(bpmSolution.getFormal())){
			subject="[测试]" + subject;
		}
		
		bpmInst.setSubject(subject);
		
		if (StringUtils.isNotEmpty(cmd.getCheckFileId())) {
			bpmInst.setCheckFileId(cmd.getCheckFileId());
		} else {
			bpmInst.setCheckFileId("");
		}
		bpmInst.setSolKey(bpmSolution.getKey());
		bpmInst.setSolId(bpmSolution.getSolId());
		bpmInst.setIsTest(BpmSolution.FORMAL_YES.equals(bpmSolution.getFormal()) ? MBoolean.YES.name() : MBoolean.NO.name());
		bpmInst.setVersion(bpmDef.getVersion());
		
		String instStatus=startFlow?BpmInst.STATUS_RUNNING:BpmInst.STATUS_PENDING;

		//启动流程表单公式设定
		setFormulaSetting(bpmSolution,startFlow);
		
		if(StringUtils.isEmpty(cmd.getBusinessKey())) {
            // 2.存储表单数据
			saveFormData(cmd.getJsonDataObject(), bpmInst,cmd.getBusinessKey(),instStatus,bpmSolution.getDataSaveMode(),bpmSolution.getBoDefId(),actDefId,modelFieldMap);
		}
		else{
			/**
			 * 业务场景
			 * 通过代码在主流程启动流程的情况
			 *  主流程和子流程的数据是一致的。即主子流程用的同一份数据，BO可能不同，表单也可能不同。
			 */
			String busKey=cmd.getBusinessKey();
			String from=cmd.getFrom();
			if("BO".equals(from)){
				String boDefId= bpmSolution.getBoDefId();
				if(StringUtil.isNotEmpty(boDefId) && boDefId.indexOf(",")==-1){
					bpmInstDataManager.addBpmInstData(boDefId,busKey, bpmInst.getInstId());
				}
			}
		}
		// 是否启动流程
		if (startFlow) {
			// 3.存储流程变量
			Map<String, Object> vars = new HashMap<String, Object>();
			// 加上解决方案ID
			vars.put(ProcessVarType.SOL_ID.getKey(), cmd.getSolId());
			vars.put(ProcessVarType.SOL_KEY.getKey(), bpmInst.getSolKey());
			vars.put(ProcessVarType.INST_ID.getKey(), bpmInst.getInstId());
			vars.put(ProcessVarType.START_USER_ID.getKey(),curUser.getUserId());
			// 加上启动用户ID
			vars.put(ProcessVarType.START_DEP_ID.getKey(),curUser.getMainGroupId());
			vars.put(ProcessVarType.PROCESS_SUBJECT.getKey(),bpmInst.getSubject());
			if(StringUtil.isNotEmpty(bpmInst.getBusKey())){
				vars.put(ProcessVarType.BUS_KEY.getKey(), bpmInst.getBusKey());
			}
			
			if (StringUtils.isNotEmpty(cmd.getNodeUserIds())) {
				vars.put(ProcessVarType.NODE_USER_IDS.getKey(),cmd.getNodeUserIds());
			}
			// 解析modelJson，存储于流程变量中，实现数据存储.
			Map<String,Object> varMap=handleTaskVars(cmd.getSolId(),bpmSolution.getActDefId(),modelFieldMap);
			vars.putAll(varMap);
			// 加上提交的变量
			if (BeanUtil.isNotEmpty( cmd.getVars() )) {
				vars.putAll(cmd.getVars());
			}

			/**
			 * 携带流程的数据进去，用于记录后续的节点跳转情况
			 */
			cmd.setBpmInstId(bpmInst.getInstId());
			cmd.setSolId(bpmInst.getSolId());

			ProcessInstance processInstance = runtimeService.startProcessInstanceById(bpmSolution.getActDefId(),bpmInst.getBusKey(), vars);
			bpmInst.setStatus(BpmInst.STATUS_RUNNING);
			bpmInst.setActInstId(processInstance.getId());
			//更改列表状态
			if(StringUtil.isEmpty( cmd.getBusinessKey())){
				bpmInstDataManager.updFormDataStatus(bpmInst.getInstId(), BpmInst.STATUS_RUNNING);
			}

			// 处理后置处理器。
			handleAfter( processConfig, cmd, bpmInst);
			
		} else {
			bpmInst.setStatus(BpmInst.STATUS_DRAFTED);
			bpmOpinionTempManager.createTemp(BpmOpinionTemp.TYPE_INST, bpmInst.getInstId(), cmd.getOpinion(), cmd.getOpFiles());
		}

		bpmInst.setActDefId(bpmDef.getActDefId());
		bpmInst.setDefId(bpmDef.getDefId());
		
		
		// 创建流程业务数据
		if (isCreated) {
			create(bpmInst);
		} else {
			// 重新更新创建时间
			bpmInst.setCreateTime(new Date());
			update(bpmInst);
		}
		
		if(startFlow){
			// 根据配置是否跳过第一节点
			skipFirstTask(cmd, bpmInst,processConfig);
			// 跳过后续有相同节点的任务
			taskManager.handJump(processConfig);

		}

		return bpmInst;
	}
	
	/**
	 * 触发表间公式。
	 * @param solution
	 * @param startFlow
	 */
	private void setFormulaSetting(BpmSolution solution,boolean startFlow){
		FormulaSetting setting=new FormulaSetting();
		setting.setMode(FormulaSetting.FLOW);
		setting.setSolId(solution.getSolId());
		setting.setActDefId(solution.getActDefId());
		setting.setNodeId(ProcessConfig.PROCESS_NODE_ID);
		
		String op=startFlow?"start":"draft";
		setting.addExtParams("op",op );
		setting.addExtParams("mode", FormulaSetting.FLOW);
		
		ProcessHandleHelper.setFormulaSetting(setting);
		
	}
	
	
	
	/**
	 * 处理后置处理器。
	 * @param processConfig
	 * @param cmd
	 * @param bpmInst
	 */
	private void handleAfter(ProcessConfig processConfig,ProcessStartCmd cmd,BpmInst bpmInst){
		if(StringUtils.isEmpty(processConfig.getAfterHandle()) || cmd.isSkipHandler()) return;
		String afterHandle=processConfig.getAfterHandle().trim();
		
		Object afterBean = AppBeanUtil.getBean(afterHandle);
		if (afterBean instanceof ProcessStartAfterHandler) {
			ProcessStartAfterHandler handler = (ProcessStartAfterHandler) afterBean;
			// 回写业务键至流程引擎中
			String busKey = handler.processStartAfterHandle(processConfig,cmd,bpmInst);
			if (StringUtils.isNotEmpty(busKey)) {
				bpmInst.setBusKey(busKey);
			}
		}
	}
	
	/**
	 * 处理前置处理器。
	 * @param processConfig
	 * @param cmd
	 */
	private void handlePreHanle(ProcessConfig processConfig,ProcessStartCmd cmd){
		if (StringUtils.isEmpty(processConfig.getPreHandle()) || cmd.isSkipHandler()) return;

		Object preBean = AppBeanUtil.getBean(processConfig.getPreHandle());
		if (preBean instanceof ProcessStartPreHandler) {
			ProcessStartPreHandler handler = (ProcessStartPreHandler) preBean;
			handler.processStartPreHandle(cmd);
		}
	}
	

	public Map<String,Object> handleTaskVarsFromJson(String solId,String actDefId,com.alibaba.fastjson.JSONObject jsonData){
		Map<String,Object> fieldMaps=getModelFieldsFromJson(jsonData);
		return handleTaskVars(solId, actDefId, fieldMaps);
	}
	
	

	/**
	 * 处理任务中的流程变量
	 * 
	 * @param task
	 * @param jsonData
	 * @return
	 */
	public Map<String, Object> handleTaskVars(String solId, String actDefId, Map<String,Object> fieldsMap) {
		Map<String, Object> vars = new HashMap<String, Object>();
		
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("params", fieldsMap);
		params.putAll(fieldsMap);

		List<BpmSolVar> configVars = bpmSolVarManager.getBySolIdActDefIdNodeId(solId, actDefId,BpmSolVar.SCOPE_PROCESS);

		// 变量是否有效，检查变量是否已经全部有输入
		StringBuffer varSb = new StringBuffer();

		
		for (BpmSolVar var : configVars) {
			String key = var.getKey();
			String formField=var.getFormField();
			Object val=null;
			//优先从表单字段映射
			if(StringUtils.isNotEmpty(formField)){
				val= (Object) fieldsMap.get(formField);
			}
			if(val==null) {
				val= (Object) fieldsMap.get(key);	
			}
			if (StringUtils.isNotEmpty(var.getExpress())) {
				val= groovyEngine.executeScripts(var.getExpress(),params);
			} 
			if (val == null) {
				val= var.getDefVal();
			}
			if(val==null) continue;
			try {
				// 计算后的变量值
				Object exeVal = null;
				// 计算表达式以获得值
				if (BpmSolVar.TYPE_DATE.equals(var.getType())) {// 直接从页面中获得值进行转化
					exeVal = DateUtil.parseDate(val.toString());
				} else if (BpmSolVar.TYPE_NUMBER.equals(var.getType())) {
					exeVal = new Double(val.toString());
				} else {
					exeVal = val;
				}

				if ((exeVal == null || "".equals(exeVal))
						&& "YES".equals(var.getIsReq())) {
					varSb.append(var.getName()).append("(")
							.append(var.getKey()).append(")").append(",");
				}
				vars.put(key, exeVal);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
		}

		if (varSb.length() > 0) {
			throw new RuntimeException("变量:" + varSb.toString() + "没有输入值。");
		}

		return vars;
	}

	/**
	 * 获得流程节点的配置人员，根据传进来的流程变量
	 * 
	 * @param actDefId
	 * @param variables
	 * @return
	 */
	public Map<String, Collection<TaskExecutor>> getNodeUsersFromConfig(
			String actDefId, Map<String, Object> variables) {
		Map<String, Collection<TaskExecutor>> mapDeps = new HashMap<String, Collection<TaskExecutor>>();
		Collection<TaskDefinition> taskDefs = actRepService
				.getTaskDefs(actDefId);
		for (TaskDefinition def : taskDefs) {
			// 取当前任务的审批人
			Collection<TaskExecutor> bpmIdenties = bpmIdentityCalService
					.calNodeUsersOrGroups(actDefId, def.getKey(), variables);
			mapDeps.put(def.getKey(), bpmIdenties);
		}
		return mapDeps;
	}
	
	/**
	 * 获得我的参与审批的事项列表
	 * @param filter
	 * @return
	 */
	public List<BpmInst> getMyInsts(SqlQueryFilter filter) {
		return bpmInstDao.getMyCheckInst(filter);
	}
	
	public List<BpmInst>getMyDrafts(QueryFilter filter){
		return bpmInstDao.getMyDrafts(filter);
	}
	
	/**
	 * 获得我的参与审批的事项列表数
	 * @param filter
	 * @return
	 */
	public Long getMyCheckInstCounts(SqlQueryFilter filter){
		return bpmInstDao.getMyCheckInstCount(filter);
	}

	
	/**
	 * 为Saas机构管理员增加数据过滤菜单
	 * @param queryFilter
	 * @return
	 */
	public List<BpmInst> getInstsForSaasAdmin(QueryFilter queryFilter){
		return bpmInstDao.getInstsForSaasAdmin(queryFilter);
	}
	

	/**
	 * 获取当前用户是否能查看该流程
	 * 
	 * @param instId
	 * @return
	 */
	public boolean canRead(BpmInst bpmInst) {
		String currentUserId = ContextUtil.getCurrentUserId();
		boolean canRead = false;
		// 判断是否全部人员
		String solId = bpmInst.getSolId();
		List<BpmSolCtl> solCtls = bpmSolCtlManager.getBySolIdAndType(solId,
				BpmSolCtl.CTL_TYPE_READ);
		// 若其没有进行权限的默认控制，则表示可以所有人可以查看
		if (solCtls.size() == 0) {
			return true;
		}

		BpmSolCtl solCtl = solCtls.get(0);
		String type = solCtl.getType();
		String right=solCtl.getRight();
		if ("LIMIT".equals(right)) {// 判断指定的时候是有有指定人
			if (StringUtils.isNotEmpty(solCtl.getUserIds())) {
				String[] userIds = solCtl.getUserIds().split(",");
				for (String userId : userIds) {
					if (userId.equals(currentUserId)) {
						return true;
					}
				}
			}
			if (StringUtils.isNotEmpty(solCtl.getGroupIds())) {// 判断是否有指定组
				String[] groupIds = solCtl.getGroupIds().split(",");
				List<OsGroup> groups = osGroupManager
						.getBelongGroups(currentUserId);
				for (String groupId : groupIds) {
					for (OsGroup group : groups) {
						if (group.getGroupId().equals(groupId)) {
							return true;
						}
					}
				}
			}
		} else {// 判断是否设置为所有人可阅
			return true;
		}

		// 是否为管理员
		if(ContextUtil.getCurrentUser().isSuperAdmin()){
			return true;
		}

		// 默认的发起人和经办人可以查看
		String actInstId = bpmInst.getActInstId();
		if(currentUserId.equals(bpmInst.getCreateBy())){
			return true;
		}
		List<BpmNodeJump> lists = bpmNodeJumpManager.getByActInstId(actInstId);
		for (BpmNodeJump list : lists) {
			String handleId = list.getHandlerId();
			if (StringUtils.isNotEmpty(handleId)
					&& handleId.equals(currentUserId)) {

				return true;
			}
		}
		return canRead;
	}
	
	/**
	 * 1.获取全部的分类。
	 * 2.获取使用了的分类。
	 * 3.对数据进行处理，删除没有使用的树形数据。
	 * @return
	 */
	public List<SysTree> getInstTree(){
		String tenantId=ContextUtil.getCurrentTenantId();
		
		
		Map<String,Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		List<SysTree> sysTrees= sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, tenantId);
		//用过的树形数据。
		// 行数据为map，键值为 TREE_ID_,TREE_PATH_,AMOUNT
		List userList= bpmInstDao.getCategoryTree(tenantId, profileMap);
		//取得删除的树形数据。
		List<SysTree> removeTrees = sysTreeManager.getRemoveList(sysTrees, userList);
		
		sysTrees.removeAll(removeTrees);
		
		return sysTrees;
	}
	
	
	public KeyValEnt getUserInfoIdNames(Collection<TaskExecutor> identityInfos){
		StringBuffer userNames=new StringBuffer();
		StringBuffer userIds=new StringBuffer();
		//显示用户
		for(TaskExecutor info:identityInfos){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())){
				userNames.append(info.getName()).append(",");
				userIds.append(info.getId()).append(",");
			}else {
				List<IUser> osUsers=userService.getByGroupId(info.getId());
				for(IUser user:osUsers){
					userNames.append(user.getFullname()).append(",");
					userIds.append(user.getUserId()).append(",");
				}
			}
		}

		if(userNames.length()>0){
			userNames.deleteCharAt(userNames.length()-1);
			userIds.deleteCharAt(userIds.length()-1);
		}
		
		return new KeyValEnt(userIds.toString(), userNames.toString());
		
	}
	
	/**
	 */
	public List<BpmInst> getMyInstBySolutionId(QueryFilter filter){
		return bpmInstDao.getMyInstBySolutionId(filter);
	}
	
	
	
	public BpmInst getByBusKey(String busKey){
		return bpmInstDao.getByBusKey(busKey);
	}
	
	/**
	 * 获取我的实例。
	 * @param filter
	 * @return
	 */
	public List<BpmInst> getMyInst(QueryFilter filter){
		return bpmInstDao.getMyInst(filter);
	}
	
	public List<BpmInst> getMyCommonInst(QueryFilter filter){
		return bpmInstDao.getMyCommonInst(filter);
	}
	
	
	public JsonResult recoverInst(String instId) throws Exception{
		BpmInst bpmInst=this.get(instId);
		ProcessHandleHelper.clearBackPath();
		if(!BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
			return new JsonResult(false,"撤销失败,流程实例不是运行状态!");
		}
		List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
		//检查当前任务的前一任务是否为当前用户，若为当前用户则允许追回按钮
		IUser curUser=ContextUtil.getCurrentUser();

		boolean isFromMe=false;
		//前一个任务节点Id
		String preMyTaskNodeId=null;
		Task curTask=null;
		for(Task task:taskList){
			ActivityImpl taskNode=actRepService.getActivityImplByActDefIdNodeId(task.getProcessDefinitionId(), task.getTaskDefinitionKey());
			if(taskNode==null) continue;
			
			List<PvmActivity> acts=getPreTaskActivity(taskNode);
			for(PvmActivity pa:acts){
				//查找该节点的审批过的人员是否为当前人
				String nodeId=pa.getId();
				TaskEntity bpmTask=(TaskEntity)task;
				BpmRuPath bpmRuPath=bpmRuPathManager.getFarestPath(bpmInst.getActInstId(), nodeId,bpmTask.getToken());
				if(bpmRuPath==null) {
					bpmRuPath=bpmRuPathManager.getFarestPath(bpmInst.getActInstId(), nodeId,null);
				}
				if(bpmRuPath!=null && StringUtils.isNotEmpty(bpmRuPath.getAssignee())){
					if(curUser.getUserId().equals(bpmRuPath.getAssignee())){
						preMyTaskNodeId=bpmRuPath.getNodeId();
						isFromMe=true;
						curTask=task;
						break;
					}
				}
			}
			if(isFromMe){
				break;
			}
		}
		
		if(curTask!=null && StringUtils.isNotEmpty(preMyTaskNodeId)){
			ProcessNextCmd cmd=new ProcessNextCmd();
			cmd.setTaskId(curTask.getId());
			cmd.setJsonData("{}");
			cmd.setDestNodeId(preMyTaskNodeId);
			cmd.setJumpType(TaskOptionType.RECOVER.name());
			//设置撤回的用户Id
			cmd.getNodeUserMap().put(preMyTaskNodeId,new BpmDestNode(preMyTaskNodeId,curUser.getUserId()));
			cmd.setOpinion(curUser.getFullname()+"进行了撤回的处理。");
			bpmTaskManager.doNext(cmd);
			return new JsonResult(true,"成功进行了任务的撤回！");
		}
			
		
		
		return new JsonResult(false,"撤销失败");
		
	}
	
	private List<PvmActivity> getPreTaskActivity(PvmActivity act){
		List<PvmActivity> pvmActs=new ArrayList<PvmActivity>();
		List<PvmTransition> trans=act.getIncomingTransitions();
		for(PvmTransition t:trans){
			PvmActivity pa= t.getSource();
			String nodeType=(String)pa.getProperty("type");
			if("userTask".equals(nodeType)){
				pvmActs.add(pa);
			}else if("exclusiveGateway".equals(nodeType) || 
					"includeGateway".equals(nodeType) || "parallelGateway".equals(nodeType)){
				pvmActs.addAll(getPreTaskActivity(pa));
			}
		}
		return pvmActs;
	}
	
	public 	List<BpmInst> getBpmInstListBySolId( String solId) {
		List<BpmInst> 	bpmInstList = bpmInstDao.getBpmInstListBySolId(solId);
		return bpmInstList;
	}
	
	
	
	/**
	 * @author mical 2018年5月14日
	 * describe： 清除测试相关数据
	 * @param instId 流程实例id 例如 instId = "2930000001050029";
	 * @param reason
	 */
	public void doCleanByInstId(BpmInst inst ) {
		String instId=inst.getInstId();
		
		if (inst.getStatus().equals(BpmInst.STATUS_RUNNING)) {
			//删除流程引擎相关
			if (StringUtils.isNotEmpty(inst.getActInstId())) {
				runtimeService.deleteProcessInstance(inst.getActInstId(), "");
			}
		}
		String actInstId = inst.getActInstId();
		//bpm_check_file 根据 JUMP_ID_ 删除审批意见附件表 bpm_check_file 的数据
		removeCheckFile(actInstId);
		//3、****根据流程实例ID 清除 bpm_inst_tmp	流程实例启动临时表	
		bpmInstTmpManager.deleteByInst(instId);
		//4、****根据流程实例ID 清除bpm_opinion_temp  流程临时意见表中的数据
		bpmOpinionTempManager.deleteByInst(instId);
		//5、****根据流程实例ID清除bpm_message_board 流程沟通留言板表中的数据
		bpmMessageBoardManager.deleteByInst(instId);
		//6、****根据流程实例ID清除 bpm_inst_attach 流程实例附件表中的数据
		bpmInstAttachManager.delByInstId(instId); 
		
		//删除bpm_node_jump 7、根据流程实例ID actInstId  删除意见数据表 BPM_node_jump 的数据 
		bpmNodeJumpManager.removeByActInst(actInstId);
		//bpm_sign_data 8、根据流程实例 清除 bpm_sign_data 中的信息
		bpmSignDataManager.delByActInstId(actInstId);
		//删除催办 9、清除催办实例数据，传入参数actInstId(首先清除催办历史，然后清除催办实例)
		bpmRemindInstManager.removeByActInst(actInstId);
		
		//删除抄送 10、根据instId清除bpm_inst_cc 流程抄送 表中的数据，首先清除 bpm_inst_cp 流程抄送人员的数据，在清除bpm_inst_cc中的数据
		bpmInstCcManager.delByInstId(instId);
		//删除测试用例 11、bpm_test_case
		bpmTestCaseManager.delByInstId(instId);
		
		//12、**** 删除流程测试方案表的数据  bpm_test_sol
		bpmTestSolManager.delete(inst.getSolId());
				
		//删除流程实例数据。 13、根据流程实例ID清除bpm_inst_data表中的测试数据   	instId
		bpmInstDataManager.removeByInstId(instId);
		//bpm_inst_read 14、根据流程实例ID清除  bpm_inst_read  流程实例阅读表中的数据
		bpmInstReadManager.removeByInst(instId);
		//删除bpm_ru_path 15、根据流程实例ID清除 bpm_ru_path 流程实例运行路线表
		bpmRuPathManager.removeByInst(instId);
		//16、清除实例
		delete(instId);
		
	}
	
	/**
	 * 获取执行节点。
	 * @param solId
	 * @param vars
	 * @return
	 */
	public List<TaskNodeUser> getRunPath(String solId,String jsonText){
		
		JSONObject jsonDataObj=JSONObject.parseObject(jsonText);
		
		List<TaskNodeUser> list=new ArrayList<TaskNodeUser>();
		BpmSolution solution=this.bpmSolutionManager.get(solId);
		String actDefId=solution.getActDefId();
		
		Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsons(jsonDataObj);
		
		Map<String,Object> vars= handleTaskVars(solId, actDefId, modelFieldMap);
		OsUser osUser=(OsUser)ContextUtil.getCurrentUser();
		String startUserId=ContextUtil.getCurrentUserId();
		String startDepId=osUser.getMainGroupId();
		
		vars.put("startUserId", startUserId);
		vars.put("startDepId", startDepId);
		vars.put("solId", solId);
		
		
		
		ActProcessDef actProcessDef = actRepService.getProcessDef(actDefId);
		
		String startNodeId=actProcessDef.getStartNodeId();
		Map<String, ActNodeDef> mapNodes= actProcessDef.getNodesMap();
	
		
		List<ActNodeDef> nodes= mapNodes.get(startNodeId).getOutcomeNodes();
		//从当前节点往下遍历。
		ActNodeDef node=nodes.get(0);
		bpmTaskManager.handNode(node,list,actDefId,solId,vars);
		
		return list;
	}
	
	/**
	 * 获取我创建的实例数量。
	 * @param userId
	 * @param status
	 * @return
	 */
	public Integer getMyInstCount(String userId,String status){
		return  bpmInstDao.getMyInstCount(userId, status);
	}
	
	/**
	 * 发送催办
	 * @param instId
	 * @param opinion
	 * @param notifyTypes
	 */
	public void doUrge(String instId,String opinion,final String notifyTypes){
		BpmInst bpmInst=this.get(instId);
		List<BpmTask> tasks= bpmTaskManager.getByActInstId(bpmInst.getActInstId());
		Map<String,Object> vars=new HashMap<>();
		vars.put("opinion", opinion);
		for(BpmTask task:tasks){
			String taskId=task.getId();
			Set<IUser> users=bpmTaskManager.getTaskUsers(taskId);
			users.forEach(receiver->{
				ListenerUtil.sendMsg(task ,"催办消息",  receiver, notifyTypes, "urge",vars);
			});
		}
		//添加日志。
		bpmLogManager.addInstLog(bpmInst.getSolId(), bpmInst.getInstId(), BpmLog.OP_TYPE_URGE, bpmInst.getSubject() +"," +opinion);
	}
}