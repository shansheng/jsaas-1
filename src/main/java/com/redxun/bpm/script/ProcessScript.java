package com.redxun.bpm.script;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.core.annotion.cls.ClassDefine;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.manager.InfInboxManager;
import com.redxun.oa.info.manager.InsMsgDefManager;
import com.redxun.oa.info.manager.InsMsgboxDefManager;
import com.redxun.oa.info.manager.InsNewsManager;
import com.redxun.oa.mail.manager.InnerMailManager;
import com.redxun.oa.mail.manager.OutMailManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysSeqIdManager;
import com.redxun.sys.org.dao.OsGroupDao;
import com.redxun.sys.org.dao.OsUserDao;
import com.redxun.sys.org.entity.OsAttributeValue;
import com.redxun.sys.org.entity.OsCustomAttribute;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsAttributeValueManager;
import com.redxun.sys.org.manager.OsCustomAttributeManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
/**
 * 流程脚本处理类，放置于脚本运行的环境, 配置@ClassDefine及@MethodDefine目的是
 * 为了可以把系统中自带的API显示出来给配置人员查看及选择使用
 * 
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 *            本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@ClassDefine(title = "流程脚本服务类")
public class ProcessScript implements GroovyScript {
	
	protected Logger logger=LogManager.getLogger(ProcessScript.class);
	
	@Resource
	RuntimeService runtimeService;
	@Resource
	TaskService taskService;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmFormInstManager bpmFormInstManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	OsGroupDao groupDao;
	@Resource
	OsUserDao userDao;
	@Resource
	BpmInstDataManager bpmInstDataManager ;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	InsNewsManager insNewsManager;
	@Resource
	InfInboxManager infInboxManager;
	@Resource
	OutMailManager outMailManager;
	@Resource
	InnerMailManager innerMailManager;
	@Resource
	InsMsgboxDefManager insMsgboxDefManager;
	@Resource
	InsMsgDefManager insMsgDefManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	CommonDao commonDao;
	@Resource
	SysSeqIdManager sysSeqIdManager;
	@Resource
	OsCustomAttributeManager osCustomAttributeManager;
	@Resource
	OsAttributeValueManager osAttributeValueManager;
	
	/**
	 * 获取流水号。
	 * @param alias
	 * @return
	 */
	public String getSeqNoByAlias(String alias){
		String tenantId=ContextUtil.getCurrentTenantId();
		String seqNo= sysSeqIdManager.genSequenceNo(alias, tenantId);
		return seqNo;
	}

	

	/**
	 * 通过userId获取主部门名
	 * 
	 * @param
	 * @return
	 */
	@MethodDefine(title = "通过账号名获得用户列表",category="用户")
	public String getUserMainDep() {
		String userId = ContextUtil.getCurrentUserId();
		String logTenantId = ContextUtil.getCurrentTenantId();
		return osGroupManager.getMainDeps(userId,logTenantId).getName();
	}
	
	/**
	 * 保存表单的值
	 * @param actInstId
	 * @param json
	 */
	@MethodDefine(title = "修改当前Json的值",category="表单", params = {@ParamDefine(title = "ACT流程实例Id", varName = "actInstId"),
			@ParamDefine(title = "表单JSON值", varName = "json值")})
	public void updateFormJson(String actInstId,String json){
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		IFormDataHandler handler=BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		JSONObject jsonObj=JSONObject.parseObject(json);
		String boDefId=jsonObj.getString(BpmInst.BO_DEF_ID);
		
		handler.saveData(boDefId, bpmInst.getInstId(), jsonObj);
	}
	
	/**
	 * 把表单的值从一个属性拷至另一个属性上
	 * @param actInstId
	 * @param sourceProperty
	 * @param targetProperty
	 */
	@MethodDefine(title = "拷贝表单的属性至另一属性上",category="表单",
			params = {@ParamDefine(title = "ACT流程实例Id", varName = "actInstId"),
			@ParamDefine(title = "目标属性", varName = "targetProperty"),@ParamDefine(title = "boId", varName = "boDefId"),
			@ParamDefine(title = "源属性", varName = "sourceProperty")})
	public void copyFormProperty(String actInstId,String targetProperty,String boDefId, String sourceProperty){
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		String pk=bpmInstDataManager.getPk(bpmInst.getInstId(), boDefId);
		IFormDataHandler handler=BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		JSONObject json= handler.getData(boDefId, pk);
		Object sourcePros=json.get(sourceProperty);
		if(sourcePros!=null){
			json.put(targetProperty,sourcePros);
		}
		handler.saveData(boDefId, pk, json);
	}
	
	/**
	 * 设置表单的属性值
	 * @param actInstId
	 * @param property
	 * @param propertyVal
	 */
	@MethodDefine(title = "设置表单属性值",category="表单", params = {@ParamDefine(title = "ACT流程实例Id", varName = "actInstId"),@ParamDefine(title = "boId", varName = "boDefId"),
			@ParamDefine(title = "目标属性", varName = "targetProperty"),@ParamDefine(title = "源属性", varName = "sourceProperty")})
	public void setFormProperty(String actInstId,String boDefId, String property,Object propertyVal){
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		String pk=bpmInstDataManager.getPk(bpmInst.getInstId(), boDefId);
		IFormDataHandler handler=BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		JSONObject json= handler.getData(boDefId, pk);
		json.put(property, propertyVal);
		handler.saveData(boDefId, bpmInst.getBusKey(), json);
	}
	
	/**
	 * 获得表单的JSON属性值
	 * @param actInstId
	 * @param property
	 * @return
	 */
	@MethodDefine(title="获得表单属性",category="表单",params = {@ParamDefine(title = "ACT流程实例Id", varName = "actInstId"),@ParamDefine(title = "boId", varName = "boDefId"),
			@ParamDefine(title = "属性名", varName = "property")})
	public String getFormProperty(String actInstId,String boDefId, String property){
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		String pk=bpmInstDataManager.getPk(bpmInst.getInstId(), boDefId);
		IFormDataHandler handler=BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		JSONObject json= handler.getData(boDefId, pk);
		return json.getString(property);
	}

	
	/**
	 * 发起用户是否为在某个用户组里
	 * 
	 * @param groupNames
	 * @return
	 */
	@MethodDefine(title = "检查用户是否在某个用户组中",category="用户", params = {@ParamDefine(title = "用户Id", varName = "userId"), @ParamDefine(title = "用户名，如:研发部,合同部", varName = "groupNames")})
	public boolean isInGroups(String userId, String groupNames) {
		boolean isExist = false;
		if (StringUtils.isEmpty(userId) || StringUtils.isEmpty(groupNames)) {
			return isExist;
		}
		String[] gNames = groupNames.split("[,]");
		List<OsGroup> groups = osGroupManager.getBelongGroups(userId);
		for (OsGroup g : groups) {
			for (String name : gNames) {
				if (g.getName().equals(name)) {
					return true;
				}
			}
		}
		return isExist;
	}
	
	@MethodDefine(title = "检查当前用户是否在某个用户组中",category="用户", params = { @ParamDefine(title = "用户名，如:研发部,合同部", varName = "groupNames")})
	public boolean isInGroups(String groupNames) {
		String userId=ContextUtil.getCurrentUserId();
		return isInGroups(userId, groupNames);
	}
	

	@MethodDefine(title = "取得某公司下某部门下的某组人员", category="用户",params = {@ParamDefine(title = "公司Id", varName = "cmpId"),
			@ParamDefine(title = "部门名称", varName = "depName"),
			@ParamDefine(title = "组名称", varName = "groupName")})
	public List<OsUser> getByCompayIdDepNameGroupName(String cmpId,String depName,String groupName){
		
		OsGroup osGroup=osGroupManager.getByParentIdGroupName(cmpId, depName);
		if(osGroup==null) {
            return new ArrayList<OsUser>();
        }
		List<OsUser> osUsers=osUserManager.getByGroupIdRelTypeId(osGroup.getGroupId(),OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
		if(StringUtils.isEmpty(groupName)) {
            return osUsers;
        }
		
		List<OsUser> tmpUsers=new ArrayList<OsUser>();
		for(OsUser osUser:osUsers){
			List<OsGroup> groups=osGroupManager.getByUserId(osUser.getUserId());
			for(OsGroup p:groups){
				if(p.getName().equals(groupName)){
					tmpUsers.add(osUser);
					break;
				}
			}
		}
		return tmpUsers;
		
	}
	
	@MethodDefine(title = "获得某个维度下的某用户组的用户",category="用户", params = {@ParamDefine(title = "维度Key", varName = "dimKey"), @ParamDefine(title = "用户组名称", varName = "groupName")})
	public Collection<TaskExecutor> getUsersFromDimGroup(String dimKey, String groupName) {
		List<TaskExecutor> osUser = new ArrayList<TaskExecutor>();
		List<OsGroup> osGroups = osGroupManager.getByDimKeyGroupName(dimKey, groupName);
		if (osGroups.size() == 0) {
			return osUser;
		}
		String groupId = osGroups.get(0).getGroupId();
		List<OsUser> osUsers = osUserManager.getByGroupIdRelTypeId(groupId, OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
		for(OsUser user:osUsers){
			osUser.add(new TaskExecutor(user.getUserId(),user.getFullname()));
		}
		return osUser;
	}
	
	/**
	 * 设置执行实例的多个变量
	 * 
	 * @param executionId
	 * @param variables
	 */
	@MethodDefine(title = "设置执行实例的多个流程变量", category="流程",params = {@ParamDefine(title = "执行ID", varName = "executionId"), @ParamDefine(title = "变量", varName = "variables")})
	public void setVariables(String executionId, Map<String, Object> variables) {
		runtimeService.setVariables(executionId, variables);
	}
	/**
	 * 设置执行流程实例的变量
	 * 
	 * @param executionId
	 * @param variableName
	 * @param varValue
	 */
	@MethodDefine(title = "设置执行实例的流程变量",category="流程", params = {@ParamDefine(title = "执行ID", varName = "executionId"), @ParamDefine(title = "变量名", varName = "variableName"),
			@ParamDefine(title = "变量值", varName = "varValue")})
	public void setVariable(String executionId, String variableName, Object varValue) {
		runtimeService.setVariable(executionId, variableName, varValue);
	}
	/**
	 * 设置任务变量
	 * 
	 * @param taskId
	 * @param variableName
	 * @param varValue
	 */
	@MethodDefine(title = "设置任务的流程变量",category="流程", params = {@ParamDefine(title = "任务ID", varName = "taskId"), @ParamDefine(title = "变量名", varName = "variableName"),
			@ParamDefine(title = "变量值", varName = "varValue")})
	public void setTaskVariable(String taskId, String variableName, Object varValue) {
		taskService.setVariable(taskId, variableName, varValue);
	}
	
	/**
	 * 变量是否存在
	 * @param taskId 任务Id
	 * @param variableName 变量名称
	 */
	@MethodDefine(title = "变量是否存在",category="流程", params = {@ParamDefine(title = "任务ID", varName = "taskId"), @ParamDefine(title = "变量名", varName = "variableName")})
	public boolean isVariableExist(String taskId,String variableName){
		Object val=taskService.getVariable(taskId, variableName);
		return val!=null;
	}
	
	/**
	 * 
	 * @param taskId
	 * @param varName
	 * @return
	 */
	@MethodDefine(title = "获得任务的流程变量", category="流程",params = {@ParamDefine(title = "任务ID", varName = "taskId"), @ParamDefine(title = "变量名", varName = "variableName")})
	public Object getTaskVariable(String taskId,String varName){
		Object val=taskService.getVariable(taskId, varName);
		return val;
	}
	
	/**
	 * 
	 * @param taskId
	 * @param varName
	 * @return
	 */
	@MethodDefine(title = "删除流程变量", category="流程",params = {@ParamDefine(title = "任务ID", varName = "taskId"), @ParamDefine(title = "变量名", varName = "variableName")})
	public void removeTaskVariable(String taskId,String varName){
		taskService.removeVariable(taskId, varName);
	}
	
	/**
	 * 设置任务变量
	 * 
	 * @param taskId
	 * @param
	 * @param
	 */
	@MethodDefine(title = "设置多个任务的流程变量",category="流程", params = {@ParamDefine(title = "任务ID", varName = "taskId"), @ParamDefine(title = "变量映射", varName = "variables")})
	public void setTaskVariables(String taskId, Map<String, Object> variables) {
		taskService.setVariables(taskId, variables);
	}
	@MethodDefine(title = "获得当前用户ID",category="用户")
	public String getCurUserId() {
		return ContextUtil.getCurrentUserId();
	}

	@MethodDefine(title = "查找组织负责人再根据汇报关系查找上级",category="用户", params = {@ParamDefine(title = "组关系名称", varName = "groupRelation"), @ParamDefine(title = "汇报名称", varName = "reportName"),
			@ParamDefine(title = "汇报级别(从1开始)", varName = "level")})
	public Collection getUserByReport(String groupRelation, String reportName, Integer level) {
		String userId = ContextUtil.getCurrentUserId();
		Collection userList = getUserByReport(userId, groupRelation, reportName, level);
		return userList;

	}
	
	/**
	 * 根据当前人去查找上级,以及上级的上级....
	 * 直到上级是当前人的(等级为level)部门的组负责人为止,
	 * 若途中找不到上级,则直接查找当前人的(等级为level)部门的组负责人
	 * @param rankLevel
	 * @return
	 */
	@MethodDefine(title = "海雅定制:查找上级等于部门负责人",category="用户", params = {@ParamDefine(title = "查找等级", varName = "rankLevel")})
	public Collection getLeaderOrManager(int rankLevel) {
		String userId = ContextUtil.getCurrentUserId();
		String logTenantId = ContextUtil.getCurrentTenantId();
		OsGroup osGroup=osGroupManager.getMainDeps(userId,logTenantId);//主部门
		OsGroup department=new OsGroup();//该级别查找部门
		List<OsGroup> groups=osGroupManager.getRelatedGroupByGroupId(osGroup.getGroupId());//我的关联组集
		for (OsGroup osGroup2 : groups) {
			if(osGroup2.getRankLevel()==rankLevel){
				department=osGroup2;
			}
		}
		OsRelType managerRel=osRelTypeManager.getByKeyTenanId("GROUP-USER-LEADER", SysInst.ADMIN_TENANT_ID);
		List<OsRelInst> managerInsts=osRelInstManager.getByRelTypeIdParty1(managerRel.getId(),department.getGroupId(),logTenantId);
		
		OsRelInst osRelInst=managerInsts.get(0);
		OsUser manager=osUserManager.get(osRelInst.getParty2());
		
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId("USER-UP-LOWER", SysInst.ADMIN_TENANT_ID);
		String relTypeId=osRelType.getId();
		List<OsUser> osUsers=new ArrayList<OsUser>();
		findLeaderThenManager(userId, relTypeId, osUsers, manager,rankLevel);
		if(!osUsers.contains(manager)){
			osUsers.add(manager);
		}
		return osUsers;

	}
	
	/**
	 * 
	 * @param attrKey
	 * @param
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@MethodDefine(title = "海雅定制:通过属性key,查找发起人对应组里属性值相等人员们",category="用户", params = {@ParamDefine(title = "属性key", varName = "attrKey"),@ParamDefine(title = "发起人", varName = "userId")})
	public Collection getUsersWithAttributeKeyFromGroup(String attrKey,String userId) {
		OsUser osUser=osUserManager.get(userId);
		String tenantId=osUser.getTenant().getTenantId();
		List<OsUser> returnUsers=new ArrayList<>();
		OsCustomAttribute osCustomAttribute=osCustomAttributeManager.getBykey(attrKey, tenantId);
		String attrId=osCustomAttribute.getID();
		List<OsAttributeValue> osAttributeValues=osAttributeValueManager.getAttrByAttrIdAndValue(attrId, tenantId);
		for (OsAttributeValue osAttributeValue : osAttributeValues) {
			List<OsUser> osUsers= osUserManager.getByGroupId(osAttributeValue.getTargetId());
			returnUsers.addAll(osUsers);
		}
		for (int i = 0; i < returnUsers.size(); i++) {
			if(returnUsers.get(i).getUserId().equals(userId)) {
				returnUsers.remove(i);
				--i;
			}
		}
		return returnUsers;
	}
	
	/**
	 * 
	 * @param userId 
	 * @param relTypeId
	 * @param osUsers
	 * @param rankLevel
	 * @param
	 */
	private void findLeaderThenManager(String userId,String relTypeId,Collection osUsers,OsUser manager,int rankLevel){
		List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty2(relTypeId, userId);//上级列表
		if(osRelInsts.size()>0&&!(osRelInsts.get(0).getParty1()).equals("0")){//如果有上级
				OsRelInst osRelInst=osRelInsts.get(0);
				OsUser leader=osUserManager.get(osRelInst.getParty1());
				osUsers.add(leader);//加入
				String leaderId=leader.getUserId();
				if(!(leaderId).equals(manager.getUserId())){//如果不是则继续迭代,查找上级
					findLeaderThenManager(leaderId, relTypeId, osUsers, manager,rankLevel);
				}
		}else{//没有上级 找出我的组的负责人
			String logTenantId = ContextUtil.getCurrentTenantId();
			findLeaderThenLeader(osGroupManager.getMainDeps(userId,logTenantId),osUsers, rankLevel);
		}
	}
	/**
	 * 找负责人上级的上级直到达到level
	 * @param
	 * @param
	 * @param osUsers
	 * @param
	 * @param rankLevel
	 */
	private void findLeaderThenLeader(OsGroup myMainGroup,Collection osUsers,int rankLevel){
		int myRankLevel=myMainGroup.getRankLevel();
		if(myRankLevel>rankLevel){
			OsRelType managerRel=osRelTypeManager.getByKeyTenanId("GROUP-USER-LEADER", SysInst.ADMIN_TENANT_ID);
			List<OsRelInst> managerInsts=osRelInstManager.getByRelTypeIdParty1(managerRel.getId(),myMainGroup.getGroupId(),myMainGroup.getTenantId());
			OsRelInst osRelInst=managerInsts.get(0);
			OsUser leader=osUserManager.get(osRelInst.getParty2());
			osUsers.add(leader);//将这个组的负责人加入
			OsGroup nextGroup=osGroupManager.getByPath((myMainGroup.getPath().replaceFirst(myMainGroup.getGroupId()+".", "")));
			if(nextGroup!=null){
				findLeaderThenLeader(nextGroup, osUsers, rankLevel);
			}
			
		}
	}

	@MethodDefine(title = "根据汇报关系查找人员",category="用户", params = {@ParamDefine(title = "汇报名称", varName = "reportName"), @ParamDefine(title = "汇报级别(从1开始)", varName = "level")})
	public Collection getUserByReportName(String reportName, Integer level) {
		String userId = ContextUtil.getCurrentUserId();

		Collection userList = getUserByReportName(userId, reportName, level);

		return userList;

	}
	
	
	@MethodDefine(title="获取所有用户",category="用户", params={@ParamDefine(title="是否包含当前用户",varName="containMe")})
	public Collection getAllUser(Boolean containMe){
		String userId=ContextUtil.getCurrentUserId();
		List<OsUser> userList=userDao.getAll();
		Iterator<OsUser> it=userList.iterator();
		if(!containMe){
			while(it.hasNext()){
				OsUser user=it.next();
				if(user.getUserId().equals(userId)){
					it.remove();
				}
			}
		}
		
		return userList;
	}

	@MethodDefine(title = "根据汇报关系查找人员",category="用户", params = {@ParamDefine(title = "用户ID", varName = "userId"), @ParamDefine(title = "汇报名称", varName = "reportName"),
			@ParamDefine(title = "汇报级别(从1开始)", varName = "level")})
	public Collection getUserByReportName(String userId, String reportName, Integer level) {

		OsUser user = userDao.getByReportLine(reportName, userId);
		// 向上查找汇报人
		int i = 1;
		while (i < level) {
			user = userDao.getByReportLine(reportName, user.getUserId());
			i++;
		}
		List<OsUser> userList = new ArrayList<OsUser>();
		userList.add(user);
		return userList;

	}
	
	@MethodDefine(title="查找当前用户在职位维度下的组,并且是主职位的名字",category="用户")
	public String findMainTitle(){
		String userId=ContextUtil.getCurrentUserId();
		String tenantId=ContextUtil.getCurrentTenantId();
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId("USER-TITLE", tenantId);
		List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty2(osRelType.getId(), userId);
		if(osRelInsts.size()>0){
			String groupId=osRelInsts.get(0).getParty1();
			OsGroup osGroup=osGroupManager.get(groupId);
			if(osGroup!=null){
				return osGroup.getName();
			}
		}
		return "";
	}
	
	@MethodDefine(title="查找当前用户在职位维度下的组,并且是主职位的ID",category="用户")
	public String findMainTitleId(){
		String userId=ContextUtil.getCurrentUserId();
		String tenantId=ContextUtil.getCurrentTenantId();
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId("USER-TITLE", tenantId);
		List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty2(osRelType.getId(), userId);
		if(osRelInsts.size()>0){
			String groupId=osRelInsts.get(0).getParty1();
			OsGroup osGroup=osGroupManager.get(groupId);
			if(osGroup!=null){
				return osGroup.getGroupId();
			}
		}
		return "";
	}

	@MethodDefine(title = "查找组织负责人再根据汇报关系查找上级",category="用户", params = {@ParamDefine(title = "用户ID", varName = "userId"), @ParamDefine(title = "组关系名称", varName = "groupRelation"),
			@ParamDefine(title = "汇报名称", varName = "reportName"), @ParamDefine(title = "汇报级别(从1开始)", varName = "level")})
	public Collection getUserByReport(String userId, String groupRelation, String reportName, Integer level) {

		// 查找用户所在的组
		OsGroup group = groupDao.getMainGroupByUserId(userId);
		// 查找负责人
		OsUser user = userDao.getByRelationName(group.getGroupId(), groupRelation);
		// 向上查找汇报人
		int i = 0;
		while (i < level) {
			user = userDao.getByReportLine(reportName, user.getUserId());
			i++;
		}
		List<OsUser> userList = new ArrayList<OsUser>();
		userList.add(user);
		return userList;

	}

	@MethodDefine(title = "查找组织负责人再根据汇报关系查找上级是否属于维度的组织列表",category="用户",
            params = {@ParamDefine(title = "用户ID", varName = "userId"), @ParamDefine(title = "组关系名称", varName = "groupRelation"),
			          @ParamDefine(title = "汇报名称", varName = "reportName"), @ParamDefine(title = "汇报级别(从1开始)", varName = "level"),
                      @ParamDefine(title = "维度名称", varName = "dimName"),@ParamDefine(title = "所属组名", varName = "groupName")})
	public boolean getUserByReportGroup(String userId, String groupRelation, String reportName, Integer level, String dimName, String groupName) {
		// 查找用户所在的组
		OsGroup group = groupDao.getMainGroupByUserId(userId);
		// 查找负责人
		OsUser user = userDao.getByRelationName(group.getGroupId(), groupRelation);
		if (user == null){
            return false;
        }
		// //向上查找汇报人
		// user= userQueryDao.getByReportLine(reportName, user.getUserId());
		//
		// 根据这人找到所属维度的组织列表，遍历这个列表，看是是否输入的组名符合，如果符合则停止查找。
		int i = 0;
		while (i < level) {
			user = userDao.getByReportLine(reportName, user.getUserId());
			if (user == null){
                break;
            }
			i++;
		}
		if (user == null){
            return false;
        }

		boolean isMap = isUserMapped(user, groupName, dimName);
		return isMap;

	}

	private boolean isUserMapped(OsUser user, String groupName, String dimName) {
		List<OsGroup> osGroup = groupDao.getByReportUserIdByGroup(user.getUserId(), dimName);
		for (OsGroup oGroup : osGroup) {
			if (oGroup.getName().equals(groupName)) {
				return true;
			}
		}
		return false;
	}
	
	@MethodDefine(title = "根据行政维度和所在用户组找用户所在目标等级用户组",category="用户",
            params = {@ParamDefine(title = "用户ID", varName = "userId"),@ParamDefine(title = "目标用户组等级", varName = "targetLevel")})
	public OsGroup getTargetGroupByLevel(String userId,Integer targetLevel) {

		// 查找用户所在的组
		OsGroup group = groupDao.getMainGroupByUserId(userId);
		
		OsGroup targetGroup=getTargetGroup(group,targetLevel);
		return targetGroup;

	}
	
	private OsGroup getTargetGroup(OsGroup oldGroup, int targetGroupLevel) {
		OsGroup group=oldGroup;
		while (targetGroupLevel<group.getRankLevel()) {
			if(!"0".equals(group.getParentId())){
                group=osGroupManager.get(group.getParentId());
            }
			if(group.getRankLevel()==targetGroupLevel){
                break;
            }
		}
		return group;
	}
	
	@MethodDefine(title = "根据行政维度和所在用户组和用户组找用户所在目标等级用户组",category="用户",
            params = {@ParamDefine(title = "用户ID", varName = "userId"),
                    @ParamDefine(title = "目标用户组等级", varName = "targetLevel"),
                    @ParamDefine(title = "目标任务组名字(全模糊)", varName = "groupName")})
	public OsGroup getTargetGroupByLevelAndName(String userId,Integer targetLevel,String groupName) {

		// 查找用户所在的组
		OsGroup group = groupDao.getMainGroupByUserId(userId);
		
		OsGroup targetGroup=getTargetGroupByName(group,targetLevel,groupName);
		return targetGroup;

	}
	
	private OsGroup getTargetGroupByName(OsGroup oldGroup, int targetGroupLevel,String groupName) {
		OsGroup group=oldGroup;
		while (targetGroupLevel-1<group.getRankLevel()) {
			if(!"0".equals(group.getParentId())){
                group=osGroupManager.get(group.getParentId());
            }
			if(group.getRankLevel()==targetGroupLevel){
                break;
            }
		}
		QueryFilter queryFilter=new QueryFilter();
		queryFilter.addFieldParam("name", QueryParam.OP_LIKE,groupName);
		queryFilter.addFieldParam("parentId", group.getParentId());
		List<OsGroup> childGroups=osGroupManager.getAll(queryFilter);
		if(childGroups.size()>0){
            return childGroups.get(0);
        }
		return new OsGroup();
			
		//return group;
	}
	

	
	
	@MethodDefine(title = "根据角色维度和用户组名找用户组",category="用户",
            params = {@ParamDefine(title = "用户ID", varName = "userId"),@ParamDefine(title = "目标用户组等级", varName = "targetLevel"),
                      @ParamDefine(title = "目标任务组名字(全模糊)", varName = "groupName")})
	public OsGroup getGroupByRoleName(String groupName) {
		QueryFilter queryFilter=new QueryFilter();
		queryFilter.addFieldParam("osDimension.dimId", OsDimension.DIM_ROLE_ID);
		queryFilter.addFieldParam("name", groupName);
		List<OsGroup> groups=osGroupManager.getAll(queryFilter);
		if(groups.size()>0){
            return groups.get(0);
        }
		return new OsGroup();

	}
	
	@MethodDefine(title = "根据角色维度和用户组名找用户组",category="用户", params = {@ParamDefine(title = "机构ID", varName = "instId")})
	public Collection getUserByTenantId(String tenantId) {
		Collection<OsUser> users=osUserManager.getAllByTenantId(tenantId);
		return users;
	}
	
	@MethodDefine(title = "获得唯一的ID",category="流水号",params={})
	public String getUID(){
		return IdUtil.getId();
	}
	
	@MethodDefine(title = "根据流程实例和表名获取数据",category="流程", params = {@ParamDefine(title = "流程实例ID", varName = "instId"),
			@ParamDefine(title = "表名", varName = "tableName")})
	public Map<String,Object> getByTbNameInst(String instId,String tableName){
		String sql="select * from " + tableName + " where INST_ID_=#{instId}";
		SqlModel sqlModel=new SqlModel(sql);
		sqlModel.addParam("instId",instId);
		return commonDao.queryForMap(sqlModel);
	}
	
	
	
	@MethodDefine(title = "根据表单字段名称获取用户",category="用户", params = {@ParamDefine(title = "字段名称", varName = "fieldName")})
	public Set<String> getFormRightsUser(Map<String,Object> model,String fieldName){
		Set<String> set=new HashSet<String>();
		JSONObject json= (JSONObject) model.get("json");
		
		String userId=json.getString(fieldName);
		
		if(StringUtil.isEmpty(userId)){
            return set;
        }
		String[] ary=userId.split(",");
		for(int i=0;i<ary.length;i++){
			set.add(ary[i]);
		}
		return set;
	}

}
