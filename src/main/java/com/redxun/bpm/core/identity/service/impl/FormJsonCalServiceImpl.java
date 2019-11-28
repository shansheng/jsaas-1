package com.redxun.bpm.core.identity.service.impl;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

/**
 * 来自表单数据，以实现通过表单变量用户的做法
 * @author mansan
 * jsonConfig 格式:
 * {
 *   varKey:'userId',
 *   varType:'user' or 'org'
 *   varText:'',
 *   useRelation:useRelation,
	 relTypeKey:relTypeKey
 * }
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class FormJsonCalServiceImpl extends AbstractIdentityCalService{
//	@Resource
//	BpmFormInstManager bpmFormInstManager;
	@Resource
	UserService userService;  
	@Resource
	GroupService groupService;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	private OsRelTypeManager osRelTypeManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	
	
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		
		Set<TaskExecutor> idList=new LinkedHashSet<TaskExecutor>();
		if(StringUtils.isEmpty(idCalConfig.getJsonConfig())){
			return idList;
		}
		JSONObject configObj=JSONObject.parseObject(idCalConfig.getJsonConfig());
		String varKey=configObj.getString("varKey");
		String userType=configObj.getString("varType");
		String boDefId=configObj.getString("boDefId");
		
		if(StringUtils.isEmpty(varKey)) return idList;
		String instId = idCalConfig.getProcessInstId();
		if(StringUtils.isEmpty(instId)) return idList;
		
		BpmInst bpmInst=bpmInstManager.get(instId);
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		if(cmd==null  && bpmInst!=null){
			JSONObject formObj=FormUtil.getData(bpmInst,boDefId);
			String idVals=formObj.getString(varKey);
			if(StringUtils.isEmpty(idVals)) return idList;
			idList=getIdList(idVals,userType,configObj);
		}else{
			String json= cmd.getJsonData();
			if(StringUtil.isNotEmpty(json)){
				//优先从对象中获取
				JSONObject jsonObj=cmd.getJsonDataObject();
				if(jsonObj==null){
					jsonObj=JSONObject.parseObject(json);
				}
				JSONArray ary= jsonObj.getJSONArray("bos");
				if(ary==null) return idList;
				String solId = (String) idCalConfig.getVars().get("solId");
				if(bpmInst!=null) bpmInst.getSolId();
				for(int i=0;i<ary.size();i++){
					JSONObject obj= ary.getJSONObject(i);
					String bId=getBoIdBySoltion(obj,solId,i);
					//当前boDefId
					if(boDefId==null || !boDefId.equals(bId)) continue;
					JSONObject data=obj.getJSONObject("data");
					String idVals=data.getString(varKey);
					if(StringUtil.isEmpty(idVals)) break;
					idList=getIdList(idVals,userType,configObj);
				}
			}
		}
		
		return idList;
	}
	
	private String getBoIdBySoltion(JSONObject obj,String solId,int boIndex){
		if(StringUtil.isNotEmpty(obj.getString("boDefId")))
			return obj.getString("boDefId");
		BpmSolution solution=bpmSolutionManager.get(solId);
		String[] boIds=solution.getBoDefId().split("[.]");
		return boIds[boIndex];
	}
	
	private void getByRelType(JSONObject configObj,Set<TaskExecutor> idList,String orgId){
		String relTypeKey=configObj.getString("relTypeKey");
		String tenantId=ContextUtil.getCurrentTenantId();
		//查找到该关系类型
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId(relTypeKey,tenantId);
		if(osRelType==null) return;
		List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty1(osRelType.getId(), orgId,tenantId);
		for(OsRelInst inst:osRelInsts){
			IUser osUser=userService.getByUserId(inst.getParty2());
			if(osUser==null) continue;
			idList.add(new TaskExecutor(osUser.getUserId(), osUser.getUsername()));
		}
	}
	
	
	private Set<TaskExecutor> getIdList(String idVals,String type,JSONObject configObj){
		Set<TaskExecutor> idList=new LinkedHashSet<TaskExecutor>();
		String[] uIds=idVals.split("[,]");
		if("org".equals(type)){
			for(String orgId:uIds){
				if(configObj.containsKey("useRelation")){
					String useRelation=configObj.getString("useRelation");
					if("true".equals(useRelation)){
						getByRelType(configObj, idList, orgId);
					}
					else{
						IGroup osGroup=groupService.getById(orgId);
						if(osGroup==null) continue;
						idList.add(TaskExecutor.getGroupExecutor(osGroup));
					}
				}
				else{
					IGroup osGroup=groupService.getById(orgId);
					if(osGroup==null) continue;
					idList.add(TaskExecutor.getGroupExecutor(osGroup));
				}
				
			}
		}else{//user
			for(String userId:uIds){
				IUser osUser=userService.getByUserId(userId);
				if(osUser==null) continue;
				idList.add(TaskExecutor.getUserExecutor(osUser));
			}
		}
		
		return idList;
	}


	
	

}
