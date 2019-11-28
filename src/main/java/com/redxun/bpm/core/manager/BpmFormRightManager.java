
package com.redxun.bpm.core.manager;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.dao.BpmFormRightDao;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.OpinionDef;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;

/**
 * 
 * <pre> 
 * 描述：表单权限 处理接口
 * 作者:ray
 * 日期:2018-02-09 15:54:25
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmFormRightManager extends MybatisBaseManager<BpmFormRight>{
	
	@Resource
	private BpmFormRightDao bpmFormRightDao;
	@Resource
	private BpmFormViewDao bpmFormViewDao;
	@Resource
	private SysBoEntManager sysBoEntManager;
	@Resource
	private SysBoDefManager sysBoDefManager;
	@Resource
	private GroovyEngine groovyEngine;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormRightDao;
	}
	

	
	public BpmFormRight getBpmFormRight(String uId){
		BpmFormRight bpmFormRight = get(uId);
		return bpmFormRight;
	}
	
	/**
	 * 获取表单权限。
	 * 1.根据节点获取表单权限。
	 * 2.如果表单权限发生了配置了其他的表单权限，则删除掉。
	 * 3.如果没有配置权限，那么获取初始的权限。
	 * @param tenantId
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @param formAlias
	 * @return
	 */
	public JSONObject obtainRight(String tenantId,String solId,String actDefId,String nodeId,String formAlias) {
		List<BpmFormRight> list=this.getBySolForm( solId, actDefId, nodeId);
		JSONObject rtn=null;
		for(BpmFormRight right:list){
			if(right.getFormAlias().equals(formAlias)){
				rtn=JSONObject.parseObject(right.getJson());
			}
		}
		if(BeanUtil.isEmpty(rtn)){
			rtn=this.getInitByAlias( formAlias);
		}
		return rtn;
		
	}
	
	/**
	 * 根据节点获取权限配置。
	 * json: 数据格式
	 * {
		"main": [{
			"name": "name",
			"edit": [{
				"val": "2400000000131023",
				"text": "刘凯军",
				"type": "user",
				"include": true
			},{
				"val": "2400000000131023",
				"text": "刘凯军",
				"type": "group",
				"include": true
			}],
			"read": [],
			"require": [],
			"comment": "名称"
		}],
		"sub": [{
			"name": "education",
			"comment": "教育",
			
			
			"tbRight": {
				"add": [{
					"type": "everyone"
				}],
				"addName": "所有人",
				"edit": [{
					"type": "everyone"
				}],
				"editName": "所有人",
				"del": [{
					"type": "everyone"
				}],
				"delName": "所有人",
				"hidden": [],
				"hiddenName": "",
				"require": [{
					"type": "everyone"
				}],
				"requireName": "所有人",
				"editExist": [],
				"editExistName": "",
				"delExist": [],
				"delExistName": ""
			},
			"fields": [{
				"hidden": [],
				"name": "name",
				"edit": [{
					"type": "none"
				}],
				"read": [],
				"require": [{
					"type": "everyone"
				}],
				"comment": "名称"
			}]
		}]
	 }
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @param formAlias
	 * @return
	 */
	public JSONObject getBySolFormNode(String solId,String actDefId,String nodeId,String formAlias){
		List<BpmFormRight> list=this.getBySolForm( solId, actDefId, nodeId);
		JSONObject rtn=null;
		for(BpmFormRight right:list){
			if(right.getFormAlias().equals(formAlias)){
				rtn=JSONObject.parseObject(right.getJson());
			}
		}
		return rtn;
	} 
	
	public BpmFormRight getBySolFormNodeBoDef(String solId,String actDefId,String nodeId,String boDefId){
		List<BpmFormRight> list=this.getBySolForm( solId, actDefId, nodeId);
		for(BpmFormRight right:list){
			if(right.getBoDefId().equals(boDefId)){
				return right;
			}
		}
		return null;
	} 
	
	/**
	 * 计算权限。
	 * {
			main:{
				field1:{right:"w",require:true},
				field2:{right:"w",require:true}
			},
			sub:{
				table1:{
					fields:{
						field1:{right:"w,r,none",require:true},
						field2:{right:"w",require:true}
					},
					tbright:{
						add:true,
						edit:true,
						delete:true,
						hidden:true,
						require:true,
						editExist:true,
						delExist:true
					}
				}
			},
			opinions:{
				opinion1:{right:"w,r,none",require:true},
				opinion2:{right:"w,r,none",require:true}
			},
			buttons:{
				button1:{show:true},
			}
			
		}
	 * @param rightSetting
	 * @param profileMap
	 * @param readonly
	 * @return
	 */
	public JSONObject calcRights(JSONObject rightSetting,Map<String, Set<String>> profileMap,boolean readonly,Map<String,Object> contextData){
		
		JSONObject rtnJson=new JSONObject();
		
		if(!rightSetting.containsKey("main")){
			return rtnJson;
		}
		
		//计算主表
		JSONArray main=rightSetting.getJSONArray("main");
		JSONObject mainJson=calcFields(main,profileMap,readonly,contextData);
		rtnJson.put("main", mainJson);
		//是否有子表
		if(rightSetting.containsKey("sub")){
			JSONObject subJson=new JSONObject();
			JSONArray sub=rightSetting.getJSONArray("sub");
			for(Object o :sub){
				JSONObject subTable=new JSONObject();
				
				JSONObject table=(JSONObject)o;
				String tbName=table.getString("name");
				String relationType=table.getString("relationType");
				//计算子表权限
				JSONObject tbRight=table.getJSONObject("tbRight");
				JSONObject tbRightJson= calcTbRight( tbRight, profileMap, readonly,relationType,contextData);
				subTable.put("tbright", tbRightJson);
				//子表字段
				boolean hidden= tbRightJson.getBoolean("hidden");
				if(!hidden){
					//计算字段权限
					JSONArray fields=table.getJSONArray("fields");
					JSONObject fieldJson=calcFields(fields,profileMap,readonly,contextData);
					subTable.put("fields", fieldJson);
				}
				subJson.put(tbName, subTable);
			}
			
			rtnJson.put("sub", subJson);
		}
		//计算意见
		JSONArray opinions=rightSetting.getJSONArray("opinions");
		if(opinions!=null && opinions.size()>0){
			JSONObject opinionJson=calcFields(opinions,profileMap,readonly,contextData);
			rtnJson.put("opinions", opinionJson);
		}
		//计算按钮权限
		JSONArray buttons=rightSetting.getJSONArray("buttons");
		if(buttons!=null && buttons.size()>0){
			JSONObject buttonsJson= calcButtons(buttons,profileMap,readonly,contextData);
			rtnJson.put("buttons", buttonsJson);
		}
		
		return rtnJson;
	}
	
	public JSONObject calcRights(JSONObject rightSetting,Map<String, Set<String>> profileMap,boolean readonly){
		return calcRights( rightSetting, profileMap, readonly, new HashMap());
	}
	
	private JSONObject calcFields(JSONArray fields,Map<String, Set<String>> profileMap,boolean readonly,Map<String,Object> contextData){
	
		JSONObject rtnJson=new JSONObject();
		for(Object o :fields){
			JSONObject field=(JSONObject)o;
			String name=field.getString("name");
			JSONObject rightJson= calcField(field, profileMap, readonly,contextData);
			rtnJson.put(name, rightJson);
		}
		return rtnJson;
	}
	
	private JSONObject calcButtons(JSONArray buttons,Map<String, Set<String>> profileMap,boolean readonly,Map<String,Object> contextData){
		
		JSONObject rtnJson=new JSONObject();
		for(Object o :buttons){
			JSONObject field=(JSONObject)o;
			String name=field.getString("name");
			JSONObject rightJson= calcButton(field, profileMap, readonly, contextData);
			rtnJson.put(name, rightJson);
		}
		return rtnJson;
	}
	
	private JSONObject calcTbRight(JSONObject tbRight,Map<String, Set<String>> profileMap,
			boolean readonly,String relationType,Map<String,Object> contextData){
		JSONObject tableRightJson=new JSONObject();
		JSONArray hiddenAry=tbRight.getJSONArray("hidden");
		boolean isHidden= hasRights(hiddenAry, profileMap,contextData);
		//是否隐藏
		if(isHidden){
			tableRightJson.put("hidden", true);
			return tableRightJson;
		}
		tableRightJson.put("hidden", false);
		if(SysBoRelation.RELATION_ONETOONE.equals(relationType)){
			return tableRightJson;
		}
		//只读
		if(readonly){
			tableRightJson.put("add", false);
			tableRightJson.put("edit", false);
			tableRightJson.put("del", false);
			tableRightJson.put("editExist", "false");
			tableRightJson.put("delExist", "false");
			tableRightJson.put("require", false);
			return tableRightJson;
		}
		
		//添加权限
		JSONArray addAry=tbRight.getJSONArray("add");
		boolean canAdd= hasRights(addAry, profileMap,contextData);
		tableRightJson.put("add", canAdd);
		//编辑权限
		JSONArray editAry=tbRight.getJSONArray("edit");
		boolean canEdit= hasRights(editAry, profileMap,contextData);
		tableRightJson.put("edit", canEdit);
		//编辑存在
		if(canEdit){
			JSONArray editExistAry=tbRight.getJSONArray("editExist");
			boolean canEditExist= hasRights(editExistAry, profileMap,contextData);
			
			tableRightJson.put("editExist", canEditExist?"true":"false");
		}
		else{
			tableRightJson.put("editExist", "false");
		}
		
		//删除权限
		JSONArray delAry=tbRight.getJSONArray("del");
		boolean canDel= hasRights(delAry, profileMap,contextData);
		tableRightJson.put("del", canDel);
		//删除存在
		if(canDel){
			JSONArray delExistAry=tbRight.getJSONArray("delExist");
			boolean canDelExist= hasRights(delExistAry, profileMap,contextData);
			tableRightJson.put("delExist", canDelExist?"true":"false");
		}
		else{
			tableRightJson.put("delExist", "false");
		}
		if(canAdd){
			//必填
			JSONArray requireAry=tbRight.getJSONArray("require");
			boolean require= hasRights(requireAry, profileMap,contextData);
			tableRightJson.put("require", require);
		}
		
		return tableRightJson;
	}
	
	private JSONObject calcField(JSONObject field,Map<String, Set<String>> profileMap,boolean readonly,Map<String,Object> contextData){
		JSONArray editAry=field.getJSONArray("edit");
		JSONArray readAry=field.getJSONArray("read");
		JSONArray requireAry=field.getJSONArray("require");
		boolean canEdit= hasRights(editAry, profileMap,contextData);
		JSONObject jsonRight=new JSONObject();
		//有编辑权限
		if(canEdit){
			boolean require= hasRights(requireAry, profileMap,contextData);
			if(!readonly){
				jsonRight.put("right", "w");
			}
			else{
				jsonRight.put("right", "r");
			}
			jsonRight.put("require", require);
			
		}
		else{
			//可以读取
			boolean canRead= hasRights(readAry, profileMap,contextData);
			if(canRead){
				jsonRight.put("right", "r");
			}
			else{
				jsonRight.put("right", "none");
			}
		}
		return jsonRight;
	}
	
	private JSONObject calcButton(JSONObject button,Map<String, Set<String>> profileMap,boolean readonly,Map<String,Object> contextData){
		
		JSONArray visibleAry=button.getJSONArray("visible");
		
		boolean visible= false;
		if(!readonly){
			visible= hasRights(visibleAry, profileMap,contextData);
		}
		JSONObject jsonRight=new JSONObject();
		jsonRight.put("show", visible);
		return jsonRight;
	}
	
	
	/**
	 * 计算权限。
	 * @param rightAry
	 * @param profileMap
	 * @param readOnly
	 * @return
	 */
	private boolean hasRights(JSONArray rightAry, Map<String, Set<String>> profileMap,Map<String,Object> contextData){
		if(rightAry==null||rightAry.size()==0) return false;
		for(int i=0;i<rightAry.size();i++){
			JSONObject json=rightAry.getJSONObject(i);
			String type=json.getString("type");
			//所有人
			if("everyone".equals(type)) return true;
			//无权限
			if("none".equals(type)) return false;
			String val=json.getString("val");
			Boolean include=json.getBoolean("include");
			//配置为空跳过。
			if(StringUtil.isEmpty(val)) continue;
			String userId=ContextUtil.getCurrentUserId();
			if("script".equals(type)) {
				Map<String,Object> model=new HashMap<String, Object>();
				model.put("model", contextData);
				Set<String> set=(Set<String>) groovyEngine.executeScripts(val, model);
				if(BeanUtil.isNotEmpty(set)){
					if(include){
						if(set.contains(userId)) return true;
					}
					else{
						if(!set.contains(userId)) return true;
					}
				}
			}
			String[] aryVal=val.split(",");
			for(int j=0;j<aryVal.length;j++){
				String id=aryVal[j];
				Set<String> set=profileMap.get(type);
				if(BeanUtil.isNotEmpty(set)){
					if(include){
						if(set.contains(id)) return true;
					}
					else{
						if(!set.contains(id)) return true;
					}
				}
			}
		}
		
		return false;
		
	}
	
	
	/**
	 * 
	 */
	public List<BpmFormRight> getBySolForm(String solId,String actDefId,String nodeId) {
		String tenantId=ContextUtil.getCurrentTenantId();
		return this.bpmFormRightDao.getBySolForm(tenantId, solId, actDefId, nodeId, "");
		
	}
	
	public JSONObject getInitByAlias(String formAlias) {
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView formView= bpmFormViewDao.getByAlias(formAlias, tenantId);
		String boDefId=formView.getBoDefId();
		JSONObject rtnJson= getInitByBoDefId(boDefId);
		
		String buttonDefs=formView.getButtonDef();
		JSONArray buttonAry=getInitButtonDef(buttonDefs);
		if(buttonAry!=null) {
			rtnJson.put("buttons", buttonAry);
		}
		
		SysBoDef sysBoDef= sysBoDefManager.get(boDefId);
		String opinion=sysBoDef.getOpinionDef();
		JSONArray opinionAry= getInitOpinion(opinion);
		rtnJson.put("opinions", opinionAry);
		
		return rtnJson;
	}
	
	public JSONObject getInitByBoDefId(String boDefId) {
		
		SysBoEnt boEnt= sysBoEntManager.getByBoDefId(boDefId);
		
		SysBoDef sysBoDef= sysBoDefManager.get(boDefId);
	
		JSONObject jsonObj=new JSONObject();
		
		//构建主实体的数据
		JSONArray mainAry=getFields( boEnt);
		jsonObj.put("main", mainAry);
		//构建子表
		if(BeanUtil.isNotEmpty( boEnt.getBoEntList())){
			JSONArray subObj= getBySub(boEnt);
			jsonObj.put("sub", subObj);
		}
		//构建意见
		String opinion=null;
		JSONArray opinionAry= getInitOpinion(opinion);
		if(sysBoDef!=null){
			opinion=sysBoDef.getOpinionDef();
		}
		jsonObj.put("opinions", opinionAry);

		return jsonObj;
	}
	
	
	/**
	 * 删除流程方案下数据
	 * @param solId
	 */
	public void delBySolId(String solId){
		bpmFormRightDao.delBySolId(solId);
	}
	
	/**
	 * 
	 * @param boEnt
	 * @return
	 */
	public JSONObject getInitByBo(SysBoEnt boEnt,JSONArray buttonAry,List<OpinionDef>  opinionAry ) {
		JSONObject jsonObj=new JSONObject();
		
		//构建主实体的数据
		JSONArray mainAry=getFields( boEnt);
		jsonObj.put("main", mainAry);
		//构建子表
		if(BeanUtil.isNotEmpty( boEnt.getBoEntList())){
			JSONArray subObj= getBySub(boEnt);
			jsonObj.put("sub", subObj);
		}
		
		JSONArray btnAry= getInitButtonDef(buttonAry);
		
		if(btnAry!=null) {
			jsonObj.put("buttons", btnAry);
		}
		if(BeanUtil.isNotEmpty(opinionAry)){
			JSONArray ary=new JSONArray();
			for(OpinionDef def:opinionAry){
				JSONObject json= getByParam(def.getName(),def.getLabel());
				ary.add(json);
			}
			jsonObj.put("opinions", ary);
		}
		return jsonObj;
	}
	
	
	/**
	 * 获取按钮的基础权限。
	 * @param buttonDefs
	 * @return
	 */
	private JSONArray getInitButtonDef(String buttonDefs) {
		if(StringUtil.isEmpty(buttonDefs)) return null;
		JSONArray buttonAry=JSONArray.parseArray(buttonDefs);
		if(buttonAry.size()==0) return null;
		return getInitButtonDef(buttonAry);
		
	}
	
	private JSONArray getInitButtonDef(JSONArray buttonAry) {
		if(buttonAry.size()==0) return null;
		JSONArray rtnAry=new JSONArray();
		for(int i=0;i<buttonAry.size();i++) {
			JSONObject obj=buttonAry.getJSONObject(i);
			JSONObject jObject= getButtonByParam(obj.getString("name"),obj.getString("label")); 
			rtnAry.add(jObject);
		}
		return rtnAry;
		
	}

	/**
	 * 获取初始化意见。
	 * @param opinion
	 * @return
	 */
	private JSONArray getInitOpinion(String opinion) {
		JSONArray ary=JSONArray.parseArray(opinion);
		return getInitOpinion( ary) ;
	}
	
	private JSONArray getInitOpinion(JSONArray ary) {
		JSONArray rtnAry=new JSONArray();
		if(ary==null) return rtnAry;
		for(int i=0;i<ary.size();i++) {
			JSONObject obj=ary.getJSONObject(i);
			JSONObject jObject= getByParam(obj.getString("name"),obj.getString("label")); 
			rtnAry.add(jObject);
		}
		return rtnAry;
	}
	
	private JSONArray getBySub(SysBoEnt boEnt) {
		JSONArray jsonAry=new JSONArray();
		for(SysBoEnt ent:boEnt.getBoEntList()) {
			JSONObject obj=getByEnt(ent);
			jsonAry.add(obj);
		}
		return jsonAry;
	}
	
	private JSONObject getByEnt(SysBoEnt ent) {
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("name", ent.getName());
		jsonObject.put("comment", ent.getComment());
		jsonObject.put("relationType", ent.getRelationType());
		//表的权限
		JSONObject tbRight= getTbRight(ent.getRelationType());
		jsonObject.put("tbRight", tbRight);
		//子表字段
		JSONArray fields=getFields(ent);
		jsonObject.put("fields", fields);
		
		return jsonObject;
	}
	
	private JSONObject getTbRight(String relationType) {
		JSONObject jsonObject=new JSONObject();
		
		if(SysBoRelation.RELATION_ONETOMANY.equals(relationType)){
			JSONArray addAry=getInitRightType();
			JSONArray editAry=getInitRightType();
			JSONArray delAry=getInitRightType();
			
			jsonObject.put("add", addAry);
			jsonObject.put("edit", editAry);
			jsonObject.put("del", delAry);
			
			jsonObject.put("hidden", new JSONArray());
			jsonObject.put("require", new JSONArray());
			jsonObject.put("editExist", new JSONArray());
			jsonObject.put("delExist", new JSONArray());
		}
		else{
			jsonObject.put("hidden", new JSONArray());
		}
		return jsonObject;
	}
	
	private JSONArray getFields(SysBoEnt boEnt) {
		JSONArray ary=new JSONArray();
		List<SysBoAttr> attrs= boEnt.getSysBoAttrs();
		for(SysBoAttr attr:attrs) {
			JSONObject obj=getByAttr(attr);
			ary.add(obj);
		}
		return ary;
	}
	
	private JSONObject getButtonByParam(String name,String comment) {
		//{name:"field1",comment:"",write:[{type:"everyone"}],read:[{type:"everyone"}],hidden:[{type:"everyone"}],require:[{type:"everyone"}]}
		JSONObject obj=new JSONObject();
		obj.put("name", name);
		obj.put("comment", comment);
		
		JSONArray rightAry=getInitRightType();
		
		obj.put("visible", rightAry);
		
		return obj;
	}
	
	private JSONObject getByParam(String name,String comment) {
		//{name:"field1",comment:"",write:[{type:"everyone"}],read:[{type:"everyone"}],hidden:[{type:"everyone"}],require:[{type:"everyone"}]}
		JSONObject obj=new JSONObject();
		obj.put("name", name);
		obj.put("comment", comment);
		
		JSONArray writeAry=getInitRightType();
		
		obj.put("edit", writeAry);
		obj.put("read", new JSONArray());
		obj.put("require", new JSONArray());
		return obj;
	}
	
	private JSONObject getByAttr(SysBoAttr attr) {
		JSONObject obj=getByParam(attr.getName(), attr.getComment());
		return obj;
	}
	
	
	
	private JSONArray getInitRightType() {
		JSONArray ary=new JSONArray();
		JSONObject obj=new JSONObject();
		obj.put("type", "everyone");
		ary.add(obj);
		return ary; 
	}
	
	
	public Map<String,JSONObject> getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId,String tenantId){
		Map<String,JSONObject> rightMap=new HashMap<String,JSONObject>();
		//获取权限配置，获取不到则获取全局的节点定义。
		List<BpmFormRight> rights= this.getBySolForm(solId, actDefId, nodeId);
		if(BeanUtil.isEmpty(rights)){
			rights= this.getBySolForm(solId, actDefId,BpmFormView.SCOPE_PROCESS);
		}
		if(BeanUtil.isEmpty(rights)) return rightMap;
		Set<String> formNames=new HashSet<String>();
		Map<String ,String> formBoDefMap=new HashMap<String, String>();
		
		for(BpmFormRight right:rights){
			if(StringUtil.isEmpty(right.getFormAlias())) continue;
			formNames.add(right.getFormAlias());
		}
		//构造表单和bo的map数据。
		for(String alias:formNames){
			BpmFormView formView= bpmFormViewManager.getLatestByKey(alias, tenantId);
			formBoDefMap.put(alias, formView.getBoDefId());
		}
		
		for(BpmFormRight right:rights){
			String formAlias=right.getFormAlias();
			String boDefId=formBoDefMap.get(formAlias);
			rightMap.put(boDefId, JSONObject.parseObject(right.getJson()));
		}
		return rightMap;
	}
	
	/**
	 * 删除表单。
	 * @param formRight
	 */
	public void delBySolForm(BpmFormRight formRight){
		String tenantId=ContextUtil.getCurrentTenantId();
		bpmFormRightDao.delBySolForm(tenantId, formRight.getSolId(), 
				formRight.getActDefId(), formRight.getNodeId(), formRight.getFormAlias());
	}

	public void delBySolAndBodefId(String solId, String aliasBindBodefId) {
		bpmFormRightDao.delBySolAndBodefId(solId,aliasBindBodefId);
		
	} 
	
	public BpmFormRight getBySolId(String solId) {
		return bpmFormRightDao.getBySolId(solId);
	}
	
}
