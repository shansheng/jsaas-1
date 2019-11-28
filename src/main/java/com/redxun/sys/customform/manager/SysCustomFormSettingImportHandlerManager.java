package com.redxun.sys.customform.manager;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.seq.IdGenerator;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.bo.manager.SysBoRelationManager;
import com.redxun.sys.core.entity.SysFormulaMapping;
import com.redxun.sys.core.manager.SysFormulaMappingManager;
import com.redxun.sys.customform.entity.SysCustomFormSetting;

/**
 * 表单方案导入处理
 * @author Louis
 */
@Service
public class SysCustomFormSettingImportHandlerManager {
	
	@Resource
	protected IdGenerator idGenerator;
	
	@Resource
	private SysCustomFormSettingManager sysCustomFormSettingManager;
	
	@Resource
	private SysBoDefManager sysBoDefManager;
	
	@Resource
	private SysBoEntManager sysBoEntManager;
	
	@Resource
	private SysBoAttrManager sysBoAttrManager;
	
	@Resource
	private SysBoRelationManager sysBoRelationManager;
	
	@Resource
	private BpmFormViewManager bpmFormViewManager;
	
	@Resource
	private BpmTableFormulaManager bpmTableFormulaManager;
	
	@Resource
	private SysFormulaMappingManager sysFormulaMappingManager;
	
	@Resource
	private BpmFormRightManager bpmFormRightManager;

	/**
	 * 表单方案导入
	 * @param json
	 * @throws Exception
	 */
	public void doImport(JSONObject json) throws Exception {
		//1.导入自定义表单
		importCustomForm(json);
		//2.导入业务对象定义
		importBoDef(json);
		//3.导入业务实体对象, include: boEntity, boAttr, boRelation
		importBoEnt(json);
		//4.导入业务表单视图
		importBpmFormView(json);
		//5.导入表间公式以及映射
		importBpmTableFormula(json);
		//6.导入表单权限
		importBpmFormRight(json);
	}
	/**
	 * 电脑表单导入
	 * @param json
	 * @throws Exception
	 */
	public void doImportForm(JSONObject json) throws Exception {
		//1.导入业务对象定义
		importBoDef(json);
		//2.导入业务实体对象, include: boEntity, boAttr, boRelation
		importBoEnt(json);
		//3.导入业务表单视图
		importBpmFormView(json);
	}
	
	//导入自定义表单
    private void importCustomForm(JSONObject json) throws Exception {
    	JSONArray sysCustomFormSettingArr = json.getJSONArray("SYS_CUSTOMFORM_SETTING"); //获取到sysCustomFormSetting的列表
		for(int k = 0; k < sysCustomFormSettingArr.size(); k++) {
    		SysCustomFormSetting customFormSetting = sysCustomFormSettingArr.getObject(k, SysCustomFormSetting.class); //json数据转换成实体 - 导入的数据
			if(customFormSetting == null) {
				continue;
			}
			SysCustomFormSetting oldCustomFormSetting = sysCustomFormSettingManager.getByAlias(customFormSetting.getAlias()); //数据库中是否已经存在该自定义表单 - old数据
			if(oldCustomFormSetting == null) {
				String customFormSettingId = idGeneratorGetNewID();
				modifyRelationTableIncludeCustomformid(json, customFormSetting.getId(), customFormSettingId);
				
				customFormSetting.setId(customFormSettingId);
				customFormSetting.setTenantId(json.getString("tenantId"));
				customFormSetting.setSolId(null);
				//customFormSetting.setTreeId("");
				sysCustomFormSettingManager.create(customFormSetting);
			} else {
				modifyRelationTableIncludeCustomformid(json, customFormSetting.getId(), oldCustomFormSetting.getId());
				
				customFormSetting.setId(oldCustomFormSetting.getId());
				customFormSetting.setTenantId(json.getString("tenantId"));
				customFormSetting.setTreeId(oldCustomFormSetting.getTreeId());
				sysCustomFormSettingManager.update(customFormSetting);
			}
		}
    }
    
    private void modifyRelationTableIncludeCustomformid(JSONObject json, String customFormId, String insertId) {
    	JSONArray sysFormulaMappingArr = json.getJSONArray("SYS_FORMULA_MAPPING"); //获取sysFormulaMapping的列表
    	JSONArray bpmFormRightArr = json.getJSONArray("BPM_FORM_RIGHT"); //获取bpmFormRight的列表
    	//修改表单方案公式映射sysFormulaMapping关联的表单id：formSolId
		JSONArray newSysFormulaMappingArr = new JSONArray();
		for(int kk = 0; kk < sysFormulaMappingArr.size(); kk++) {
			SysFormulaMapping formulaMapping = sysFormulaMappingArr.getObject(kk, SysFormulaMapping.class);
			if(formulaMapping != null && formulaMapping.getFormSolId().equals(customFormId)) {
				formulaMapping.setFormSolId(insertId);
			}
			newSysFormulaMappingArr.add(formulaMapping);
		}
		json.put("SYS_FORMULA_MAPPING", newSysFormulaMappingArr); //保存新的数据到json中
		//修改表单权限的solId
		JSONArray newBpmFormRightArr = new JSONArray();
		for(int kk = 0; kk < bpmFormRightArr.size(); kk++) {
			BpmFormRight right = bpmFormRightArr.getObject(kk, BpmFormRight.class);
			if(right != null && right.getSolId().equals(customFormId)) {
				right.setSolId(insertId);
			}
			newBpmFormRightArr.add(right);
		}
		json.put("BPM_FORM_RIGHT", newBpmFormRightArr); //保存新数据到json中
    }
    
    //导入业务对象定义
    private void importBoDef(JSONObject json) throws Exception {
    	JSONArray sysBoDefArr = json.getJSONArray("SYS_BO_DEFINITION"); //获取到sysBoDefinition的列表
    	for(int k = 0; k < sysBoDefArr.size(); k++) {
			SysBoDef boDef = sysBoDefArr.getObject(k, SysBoDef.class); // json数据转成实体 - 导入的数据
			if(boDef == null) {
				continue;
			}
			SysBoDef oldBoDef = sysBoDefManager.getByAlias(boDef.getAlais());
			if(oldBoDef == null) { //如果boDef不存在，创建boDef，并更新customFormSeting对应的boDefId
				String boDefId = idGeneratorGetNewID();
				modifyRelationTableIncludeBodefid(json, boDef, boDefId);
				
				boDef.setId(boDefId);
				boDef.setTenantId(json.getString("tenantId"));
				sysBoDefManager.create(boDef);
				SysCustomFormSetting customFormSetting = sysCustomFormSettingManager.getByAlias(boDef.getAlais());
				customFormSetting.setBodefId(boDefId);
				sysCustomFormSettingManager.update(customFormSetting);
			} else { //如果boDef已经存在，更新
				boDef.setId(oldBoDef.getId());
				boDef.setTenantId(json.getString("tenantId"));
				sysBoDefManager.update(boDef);
				
				modifyRelationTableIncludeBodefid(json, boDef, oldBoDef.getId());
			}
		}
    }
    
    /**
     * 相关表中的boDefId的处理
     * @param json 
     * @param boDef 原bodef
     * @param newBoDefId 替换的boDefId
     */
    private void modifyRelationTableIncludeBodefid(JSONObject json, SysBoDef boDef, String boDefId) throws Exception {
    	JSONArray sysBoRelArr = json.getJSONArray("SYS_BO_RELATION"); //获取sysBoRelation的关联列表
    	JSONArray bpmFormViewArr = json.getJSONArray("BPM_FORM_VIEW"); //获取bpmFormView的关联列表
    	JSONArray bpmTableFormulaArr = json.getJSONArray("BPM_TABLE_FORMULA"); //获取bpmTableFormula的关联列表
    	JSONArray sysFormulaMappingArr = json.getJSONArray("SYS_FORMULA_MAPPING"); //获取sysFormulaMapping的关联列表
    	JSONArray bpmFormRightArr = json.getJSONArray("BPM_FORM_RIGHT"); //获取bpmFormRight的关联列表
    	//1.先修改boRel中的关联defId
		JSONArray newSysBoRelArr = new JSONArray();
		for(int kk = 0; kk < sysBoRelArr.size(); kk++) {
			SysBoRelation boRel = sysBoRelArr.getObject(kk, SysBoRelation.class);
			if(boRel != null) {
				boRel.setBoDefid(boDefId);
				newSysBoRelArr.add(JSONObject.toJSON(boRel));
			}
		}
		json.put("SYS_BO_RELATION", newSysBoRelArr); //设置boRelation的boDefId并保存到json
		//2.修改bpmFormView中关联的defId
		JSONArray newBpmFormViewArr = new JSONArray();
		for(int kk = 0; kk < bpmFormViewArr.size(); kk++) {
			BpmFormView formView = bpmFormViewArr.getObject(kk, BpmFormView.class);
			if(formView != null) {
				formView.setBoDefId(boDefId);
				newBpmFormViewArr.add(JSONObject.toJSON(formView));
			}
		}
		json.put("BPM_FORM_VIEW", newBpmFormViewArr);
		//3.修改bpmTableFormula中关联的defId
		JSONArray newBpmTableFormulaArr = new JSONArray();
		if(bpmTableFormulaArr!=null) {
			for(int kk = 0; kk < bpmTableFormulaArr.size(); kk++) {
				BpmTableFormula formula = bpmTableFormulaArr.getObject(kk, BpmTableFormula.class);
				if(formula != null) {
					formula.setBoDefId(boDefId);
					newBpmTableFormulaArr.add(JSONObject.toJSON(formula));
				}
			}
		}
		json.put("BPM_TABLE_FORMULA", newBpmTableFormulaArr);
		//导入表间公式
		//importBpmTableFormula(json);
		//4.修改sysFormulaMapping中关联的defId
		JSONArray newSysFormulaMappingArr = new JSONArray();
		if(sysFormulaMappingArr!=null) {
			for(int kk = 0; kk < sysFormulaMappingArr.size(); kk++) {
				SysFormulaMapping formulaMapping = sysFormulaMappingArr.getObject(kk, SysFormulaMapping.class);
				if(formulaMapping != null) {
					formulaMapping.setBoDefId(boDefId);
					newSysFormulaMappingArr.add(formulaMapping);
				}
			}
		}
		json.put("SYS_FORMULA_MAPPING", newSysFormulaMappingArr);
		//importSysFormulaMapping(json);
		//5.修改bpmFormRight中关联的defId
		JSONArray newBpmFormRightArr = new JSONArray();
		if(bpmFormRightArr!=null) {
			for(int kk = 0; kk < bpmFormRightArr.size(); kk++) {
				BpmFormRight formRight = bpmFormRightArr.getObject(kk, BpmFormRight.class);
				if(formRight != null) {
					formRight.setBoDefId(boDefId);
					newBpmFormRightArr.add(formRight);
				}
			}
		}
		json.put("BPM_FORM_RIGHT", newBpmFormRightArr);
		
		
		//修改customFormSetting中的boDefId
		JSONArray sysCustomFormSettingArr = json.getJSONArray("SYS_CUSTOMFORM_SETTING");
		if(sysCustomFormSettingArr!=null) {
			for(int kk = 0; kk < sysCustomFormSettingArr.size(); kk++) {
				SysCustomFormSetting customForm = sysCustomFormSettingArr.getObject(kk, SysCustomFormSetting.class);
				if(customForm != null) {
					customForm.setBodefId(boDefId);
					SysCustomFormSetting sourceCustomForm = sysCustomFormSettingManager.getByAlias(customForm.getAlias());
					if(sourceCustomForm == null) {
						customForm.setId(idGeneratorGetNewID());
						customForm.setTenantId(json.getString("tenantId"));
						sysCustomFormSettingManager.create(customForm);
					} else {
						customForm.setId(sourceCustomForm.getId());
						customForm.setTenantId(json.getString("tenantId"));
						sysCustomFormSettingManager.update(customForm);
					}
				}
			}
		}
    }
    
    
    //导入业务实体对象
    private void importBoEnt(JSONObject json) throws Exception {
    	JSONArray sysBoEntArr = json.getJSONArray("SYS_BO_ENTITY"); //获取到sysBoEnt的列表
    	JSONArray sysBoRelArr = json.getJSONArray("SYS_BO_RELATION"); 
    	JSONArray sysBoAttrArr = json.getJSONArray("SYS_BO_ATTR");
    	for(int k = 0; k < sysBoEntArr.size(); k++) {
    		SysBoEnt boEnt = sysBoEntArr.getObject(k, SysBoEnt.class); //json数据转成实体 - 导入的数据
    		if(boEnt == null) {
    			continue;
    		}
    		SysBoEnt oldBoEnt = sysBoEntManager.getByName(boEnt.getName()); 
    		if(oldBoEnt == null) {
    			String boEntId = idGeneratorGetNewID();
    			//先修改boRel中关联的entId
    			SysBoRelation boRel = null;
    			for(int kk = 0; kk < sysBoRelArr.size(); kk++) {
    				boRel = sysBoRelArr.getObject(kk, SysBoRelation.class);
    				if(boRel.getBoEntid().equals(boEnt.getId())) { //如果boEnt的id和boRel的entId相同，设置boRel的entId为新的entId，并跳出
    					boRel.setBoEntid(boEntId);
    					break;
    				}
    			}
    			//在修改boAttr中关联的entId
    			JSONArray newSysBoAttrArr = new JSONArray();
    			List<SysBoAttr> newSysBoAttrList = new ArrayList<SysBoAttr>();
    			for(int kk = 0 ; kk < sysBoAttrArr.size(); kk++) {
    				SysBoAttr boAttr = sysBoAttrArr.getObject(kk, SysBoAttr.class);
    				if(boAttr.getEntId().equals(boEnt.getId())) {
    					boAttr.setEntId(boEntId);
    					newSysBoAttrArr.add(JSONObject.toJSON(boAttr));
        				newSysBoAttrList.add(boAttr);
    				}
    			}
    			json.put("SYS_BO_ATTR", newSysBoAttrArr); //设置boAttr中的boEntId并保存到json
    			
    			boEnt.setId(boEntId);
    			boEnt.setTenantId(json.getString("tenantId"));
    			boEnt.setSysBoAttrs(newSysBoAttrList);
    			sysBoEntManager.create(boEnt);
    			
    			//建表
    			sysBoEntManager.createTable(boEnt);
    			//导入属性
    			importBoAttr(json);
    			//导入关系
    			importBoRelation(boRel, json.getString("tenantId"));
    		} else {
    			List<SysBoAttr> newSysBoAttrList = new ArrayList<SysBoAttr>();
    			for(int kk = 0 ; kk < sysBoAttrArr.size(); kk++) {
    				SysBoAttr boAttr = sysBoAttrArr.getObject(kk, SysBoAttr.class);
    				if(boAttr.getEntId().equals(boEnt.getId())) {
        				newSysBoAttrList.add(boAttr);
    				}
    			}
    			boEnt.setSysBoAttrs(newSysBoAttrList);
    			
    			boEnt.setId(oldBoEnt.getId());
    			boEnt.setTenantId(json.getString("tenantId"));
    			
    			sysBoEntManager.createTable(boEnt);
    			sysBoEntManager.update(boEnt);
    		}
    	}
    }
    
    //导入业务实体属性定义
    private void importBoAttr(JSONObject json) throws Exception {
    	JSONArray sysBoAttrArr = json.getJSONArray("SYS_BO_ATTR"); //获取到sysBoAttr的列表
    	for(int k = 0; k < sysBoAttrArr.size(); k++) {
    		SysBoAttr boAttr = sysBoAttrArr.getObject(k, SysBoAttr.class);
    		boAttr.setId(idGeneratorGetNewID());
    		boAttr.setTenantId(json.getString("tenantId"));
    		sysBoAttrManager.create(boAttr);
    	}
    }
    
    //导入业务对象关系定义
    private void importBoRelation(SysBoRelation boRel, String tenantId) throws Exception {
    	boRel.setId(idGeneratorGetNewID());
    	boRel.setTenantId(tenantId);
    	sysBoRelationManager.create(boRel);
    }
    
    //导入业务表单视图
    private void importBpmFormView(JSONObject json) throws Exception {
    	JSONArray bpmFormViewArr = json.getJSONArray("BPM_FORM_VIEW");
    	for(int k = 0; k < bpmFormViewArr.size(); k++) {
    		BpmFormView formView = bpmFormViewArr.getObject(k, BpmFormView.class);
    		if(formView == null || formView.getIsMain().equals("NO")) { //非主版本，跳过
    			continue;
    		}
    		//注意检测bpmFormView的版本号
    		BpmFormView oldFormView = bpmFormViewManager.getLatestByKey(formView.getKey(), json.getString("tenantId"));
    		if(oldFormView == null) { //如果不存在历史版本，插入新数据
    			formView.setViewId(idGeneratorGetNewID());
    			formView.setTenantId(json.getString("tenantId"));
    			formView.setTreeId(null);
    			bpmFormViewManager.create(formView);
    		} else {
    			//如果已经存在历史版本，插入新版，注意treeId
    			formView.setViewId(idGeneratorGetNewID());
    			formView.setTenantId(json.getString("tenantId"));
    			formView.setVersion(oldFormView.getVersion() + 1);
    			formView.setIsMain("YES");
    			formView.setTreeId(oldFormView.getTreeId());
    			bpmFormViewManager.create(formView);
    			//修改历史版本数据
    			oldFormView.setIsMain("NO");
    			oldFormView.setTenantId(json.getString("tenantId"));
    			bpmFormViewManager.update(oldFormView);
    		}
    	}
    }
    
    //导入表间公式
    private void importBpmTableFormula(JSONObject json) throws Exception {
    	JSONArray sysCustomFormSettingArr = json.getJSONArray("SYS_CUSTOMFORM_SETTING");
    	JSONArray bpmTableFormulaArr = json.getJSONArray("BPM_TABLE_FORMULA");
    	JSONArray sysFormulaMappingArr = json.getJSONArray("SYS_FORMULA_MAPPING");
    	for(int k = 0; k < sysCustomFormSettingArr.size(); k++) {
    		SysCustomFormSetting customForm = sysCustomFormSettingArr.getObject(k, SysCustomFormSetting.class);
    		customForm = sysCustomFormSettingManager.getByAlias(customForm.getAlias());
    		if(customForm != null) {
    			List<BpmTableFormula> formulaList = bpmTableFormulaManager.getByFormSolId(customForm.getId());
        		if(formulaList.size() > 0) { //如果表间公式已经存在，删除
        			for(BpmTableFormula sourceFormula : formulaList) {
        				bpmTableFormulaManager.deleteObject(sourceFormula);
        			}
        		}
    		}
    		
    	}
    	for(int k = 0; k < bpmTableFormulaArr.size(); k++) {
			BpmTableFormula formula = bpmTableFormulaArr.getObject(k, BpmTableFormula.class);
			String formulaId = idGeneratorGetNewID();
			//1.改变sysFormulaMapping中的formulaId
			JSONArray newSysFormulaMappingArr = new JSONArray();
			for(int kk = 0; kk < sysFormulaMappingArr.size(); kk++) {
				SysFormulaMapping formulaMapping = sysFormulaMappingArr.getObject(kk, SysFormulaMapping.class);
				if(formulaMapping.getFormulaId().equals(formula.getId())) {
					formulaMapping.setFormulaId(formulaId);
				}
				newSysFormulaMappingArr.add(formulaMapping);
			}
			json.put("SYS_FORMULA_MAPPING", newSysFormulaMappingArr);
			
			formula.setId(formulaId);
			formula.setTenantId(json.getString("tenantId"));
			bpmTableFormulaManager.create(formula);
		}
    	
    	importSysFormulaMapping(json);
    }
    
    //导入表单方案公式映射
    private void importSysFormulaMapping(JSONObject json) throws Exception {
    	JSONArray sysCustomFormSettingArr = json.getJSONArray("SYS_CUSTOMFORM_SETTING");
    	JSONArray sysFormulaMappingArr = json.getJSONArray("SYS_FORMULA_MAPPING");
    	JSONArray newSysFormulaMappingArr = new JSONArray();
    	for(int k = 0; k < sysCustomFormSettingArr.size(); k++) {
    		SysCustomFormSetting customForm = sysCustomFormSettingArr.getObject(k, SysCustomFormSetting.class);
    		SysCustomFormSetting sourceCustomForm = sysCustomFormSettingManager.getByAlias(customForm.getAlias());
    		if(sourceCustomForm != null) {
    			List<SysFormulaMapping> formulaMappingList = sysFormulaMappingManager.getByFormSolId(sourceCustomForm.getId());
    			for(int kk = 0; kk < sysFormulaMappingArr.size(); kk++) {
    				SysFormulaMapping mapping = sysFormulaMappingArr.getObject(k, SysFormulaMapping.class);
					mapping.setFormSolId(sourceCustomForm.getId());
					newSysFormulaMappingArr.add(mapping);
    			}
    			
        		if(formulaMappingList.size() > 0) {
        			for(SysFormulaMapping mapping : formulaMappingList) {
        				sysFormulaMappingManager.deleteObject(mapping);
        			}
        		}
    		}
    	}
    	for(int k = 0; k < newSysFormulaMappingArr.size(); k++) {
    		SysFormulaMapping mapping = newSysFormulaMappingArr.getObject(k, SysFormulaMapping.class);
    		mapping.setId(idGeneratorGetNewID());
    		mapping.setTenantId(json.getString("tenantId"));
    		sysFormulaMappingManager.create(mapping);
    	}
    }
    
    //导入表单权限
    private void importBpmFormRight(JSONObject json) throws Exception {
    	JSONArray sysCustomFormSettingArr = json.getJSONArray("SYS_CUSTOMFORM_SETTING");
    	JSONArray bpmFormRightArr = json.getJSONArray("BPM_FORM_RIGHT");
    	JSONArray newBpmFormRightArr = new JSONArray();
    	for(int k = 0; k < sysCustomFormSettingArr.size(); k++) {
    		SysCustomFormSetting customForm = sysCustomFormSettingArr.getObject(k, SysCustomFormSetting.class);
    		SysCustomFormSetting sourceCustomForm = sysCustomFormSettingManager.getByAlias(customForm.getAlias());
    		if(sourceCustomForm != null) {
    			List<BpmFormRight> rightList = bpmFormRightManager.getBySolForm(sourceCustomForm.getId(), "", BpmFormRight.NODE_FORM_SOL);
    			for(int kk = 0; kk < bpmFormRightArr.size(); kk++) {
    				BpmFormRight right = bpmFormRightArr.getObject(kk, BpmFormRight.class);
    				if(right == null){
    					continue;
    				}
    				right.setSolId(sourceCustomForm.getId());
    				newBpmFormRightArr.add(right);
    			}
    			
    			if(rightList.size() > 0) {
    				for(BpmFormRight right : rightList) {
    					bpmFormRightManager.deleteObject(right);
    				}
    			}
    		}
    	}
    	
    	for(int k = 0; k < bpmFormRightArr.size(); k++) {
    		BpmFormRight right = bpmFormRightArr.getObject(k, BpmFormRight.class);
    		if(right == null){
    			continue;
    		}
    		right.setId(idGeneratorGetNewID());
    		right.setTenantId(json.getString("tenantId"));
    		bpmFormRightManager.create(right);
    	}
    }
    
    //生成主键
    private String idGeneratorGetNewID() {
    	return idGenerator.getSID();
    }
}
