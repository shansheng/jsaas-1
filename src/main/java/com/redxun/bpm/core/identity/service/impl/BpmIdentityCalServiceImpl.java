package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.AbstractExecutionCmd;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.bpm.core.identity.service.IdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityTypeService;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmSolUserManager;
import com.redxun.bpm.core.manager.BpmSolUsergroupManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.service.UserService;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
/**
 * 实现人员计算
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmIdentityCalServiceImpl implements BpmIdentityCalService{
	@Resource
	BpmSolUserManager bpmSolUserManager;
	@Resource
	IdentityTypeService identityTypeService;
	@Resource
	UserService userService;
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	BpmSolUsergroupManager bpmSolUsergroupManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	
	@Override
	public Collection<TaskExecutor> calNodeUsersOrGroups(String actDefId,
			String nodeId, Map<String, Object> vars) {
			String solId=(String)vars.get("solId");
			String nodeUserIds=(String)vars.get(ProcessVarType.NODE_USER_IDS.getKey());
			Set<TaskExecutor> idInfos=UserCalcUtil.getFromStartVars(nodeUserIds,nodeId);
			if(BeanUtil.isNotEmpty(idInfos)) return idInfos;
			Map<String,Object> model=new HashMap<>();
			AbstractExecutionCmd cmd= (AbstractExecutionCmd) ProcessHandleHelper.getProcessCmd();
			if(cmd!=null) {
				model.put("cmd", cmd);
				//获取表单数据
				BpmSolution bpmSolution = bpmSolutionManager.get(solId);
				JSONObject data = JSONObject.parseObject(cmd.getJsonData());
				Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(data,bpmSolution.getBoDefId());
				vars.put("jsonData", modelFieldMap);
				vars.putAll(cmd.getVars());
			}
			model.put("vars", vars);
			
			//取得人员配置的信息列表
			List<BpmSolUser> bpmSolUsers = new ArrayList<>();
			List<BpmSolUsergroup> list = bpmSolUsergroupManager.getBySolNode(solId, actDefId, nodeId, BpmSolUsergroup.GROUP_TYPE_TASK);
			for(BpmSolUsergroup bpmSolUsergroup : list) {
				String setting = bpmSolUsergroup.getSetting();
				if(StringUtil.isNotEmpty(setting)) {
					Object flag = groovyEngine.executeScripts(setting, model);
					if(flag instanceof Boolean && (Boolean)flag) {
						bpmSolUsers = bpmSolUsergroup.getUserList();
						break;
					}
				}else {
					bpmSolUsers = bpmSolUsergroup.getUserList();
					break;
				}
			}
			//用于存储返回的用户或组信息
			Set<TaskExecutor> idInfoList= calNodeUsersOrGroups(actDefId,nodeId,bpmSolUsers,vars);
			
			return idInfoList;
	}
	
	
	
	@Override
	public Set<TaskExecutor> calNodeUsersOrGroups(String actDefId,String nodeId,List<BpmSolUser> bpmSolUsers, Map<String, Object> vars) {
		//用于存储返回的用户或组信息
		Set<TaskExecutor> idInfoList=new LinkedHashSet<TaskExecutor>();

		String instId=(String)vars.get("instId");
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		String logic=null;
		int i=0;
		//计算每个人员的具体信息
		for(BpmSolUser bsu:bpmSolUsers){
			IdentityCalService service=identityTypeService.getIdentityCalServicesMap().get(bsu.getUserType());
			IdentityCalConfig idCalConfig=new IdentityCalConfig();
//			idCalConfig.setFormJson(instId);
			idCalConfig.setCalcMode(bsu.getIsCal());
			idCalConfig.setNodeId(nodeId);
			idCalConfig.setProcessInstId(instId);
			idCalConfig.setProcessDefId(actDefId);
			idCalConfig.setJsonConfig(bsu.getConfig());
			idCalConfig.setVars(vars);
			if(cmd!=null){
				idCalConfig.setToken(cmd.getToken());
			}
			Collection<TaskExecutor> list=service.calIdentities(idCalConfig);
			
			OsRelType osRelType=osRelTypeManager.getBelongRelType();
			
			Collection<TaskExecutor> tmpList= calcUsers(list, osRelType, bsu.getIsCal());
			
			//第一条
			if(i++==0){
				idInfoList.addAll(tmpList);
			}else if(BpmSolUser.LOGIC_NOT.equals(logic)){
				idInfoList.removeAll(tmpList);
			}else if(BpmSolUser.LOGIC_AND.equals(logic)){
				idInfoList.retainAll(tmpList);
			}else{
				idInfoList.addAll(tmpList);
			}
			logic=bsu.getCalLogic();
			
		}
		return idInfoList;
	}
	
	/**
	 * 对应用进行运算。
	 * @param tmpList
	 * @param osRelType
	 * @param isCalc
	 * @return
	 */
	private Collection<TaskExecutor> calcUsers(Collection<TaskExecutor> tmpList,OsRelType osRelType,String calcMode){
		Collection<TaskExecutor> list=new ArrayList<>();
		
		for(TaskExecutor info:tmpList){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())){
				list.add(info);
			}
			else{
				if(TaskExecutor.CALC_MODE_YES.equals(calcMode)){
					List<OsUser> users=osUserManager.getByGroupIdRelTypeId(info.getId(), osRelType.getId());
					for(OsUser user:users){
						list.add(new TaskExecutor(user.getUserId(),user.getFullname()));
					}
				}
				else{
					info.setCalcMode(calcMode);
					list.add(info);
				}
			}
		}
		return list;
	}
	
}
