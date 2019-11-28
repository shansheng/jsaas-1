
package com.redxun.bpm.form.manager;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.dao.BpmFormulaMappingDao;
import com.redxun.bpm.form.dao.BpmTableFormulaDao;
import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.bpm.form.service.TableFieldValueHandlerConfig;
import com.redxun.core.dao.IDao;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.dao.SysFormulaMappingDao;

/**
 * 
 * <pre> 
 * 描述：表间公式 处理接口
 * 作者:mansan
 * 日期:2018-08-07 09:06:53
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmTableFormulaManager extends MybatisBaseManager<BpmTableFormula>{
	
	@Resource
	private BpmTableFormulaDao bpmTableFormulaDao;
	@Resource
	private SysFormulaMappingDao sysFormulaMappingDao;
	@Resource
	private BpmFormulaMappingDao bpmFormulaMappingDao;
	@Resource
	private TableFieldValueHandlerConfig tableFieldValueHandlerConfig;
	@Resource
	private SysBoAttrManager sysBoAttrManager;
	@Resource
	private SysBoEntManager sysBoEntManager;
	

	/**
	 * 删除公式。
	 * 删除关联的表单方案配置。
	 * 删除流程表单配置。
	 */
	@Override
	public void delete(String id) {
		sysFormulaMappingDao.removeByFormulaId(id);
		bpmFormulaMappingDao.removeByFormulaId(id);
		super.delete(id);
	}


	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmTableFormulaDao;
	}

	/**
	 * 根据表单方案ID获取公式。
	 * @param formSolId
	 * @return
	 */
	public List<BpmTableFormula> getByFormSolId(String formSolId){
		return  bpmTableFormulaDao.getByFormSolId(formSolId);
	}
	
	/**
	 * 获取节点表间公式配置。
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public List<BpmTableFormula> getBySolIdNode(String solId,String  actDefId,String  nodeId){
		return  bpmTableFormulaDao.getBySolIdNode(solId, actDefId, nodeId);
	}
	
	/**
	 * 列表转换成键值对。
	 * @param list
	 * @return
	 */
	private KeyValEnt<String> convertToKv( List<BpmTableFormula> list){
		KeyValEnt<String> kv=new KeyValEnt<>();
		if(list.size()==0) return kv;
		String formulaIds="";
		String formulaNames="";
		for(int i=0;i<list.size();i++){
			BpmTableFormula formula=list.get(i);
			String pre=(i==0)?"" :",";
			formulaIds+=pre+ formula.getId();
			formulaNames+=pre +formula.getName();
		}
		kv.setKey(formulaIds);
		kv.setVal(formulaNames);
		return kv;
	}
	
	/**
	 * 根据表单方案ID获取键值对。
	 * @param formSolId
	 * @return
	 */
	public KeyValEnt<String> getKvByFormSolId(String formSolId){
		List<BpmTableFormula> list=bpmTableFormulaDao.getByFormSolId(formSolId);
		KeyValEnt<String> kv=convertToKv(list);
		return kv;
	}
	
	/**
	 * 根据流程节点获取键值对。
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public KeyValEnt<String> getKvSolIdNode(String solId,String  actDefId,String  nodeId){
		List<BpmTableFormula> list=bpmTableFormulaDao.getBySolIdNode(solId, actDefId, nodeId);
		KeyValEnt<String> kv=convertToKv(list);
		return kv;
	}
	
	/**
	 * 获取表单数据，isPage为true时，页面显示，isPage为false时，为数据提交
	 * @param dataHolder
	 * @param obj
	 * @param isPage
	 * @return
	 */
	public JSONObject getTableFieldValueHandler(DataHolder dataHolder,JSONObject obj,boolean isPage) {
		JSONArray gridData = obj.getJSONArray("gridData");
		String tableName = obj.getString("tableName");
		String relType = obj.getString("relationType");
		JSONArray mapper= getJsonAry(gridData);
		String pre = "SUB_";
		if(isPage) {
			pre = "grid_";
		}
		SysBoEnt ent = sysBoEntManager.getByTableName(tableName);
		JSONObject formData = new JSONObject();
		Map<String,SysBoAttr> map = sysBoAttrManager.getAttrsMapByEntId(tableName);
		
		
		if(SysBoRelation.RELATION_MAIN.equals(relType) || SysBoRelation.RELATION_ONETOONE.equals(relType)) {
			obj.put("index", 0);
			formData = getFormData(mapper, map, dataHolder,obj);
		}
		if(SysBoRelation.RELATION_ONETOMANY.equals(relType)) {
			String userSubTable = obj.getString("userSubTable");
			SysBoEnt subEnt = sysBoEntManager.get(userSubTable);
			JSONArray array = dataHolder.getCurMain().getJSONArray("SUB_"+subEnt.getName());
			JSONArray temp = new JSONArray();
			for (int i = 0; i < array.size(); i++) {
				obj.put("index", i);
				temp.add(getFormData(mapper, map, dataHolder,obj));
			}
			formData.put(pre+ent.getName(), temp);
			return formData;
		}
		return formData;
	}
	
	private JSONObject getFormData(JSONArray mapper,Map<String,SysBoAttr> map,DataHolder dataHolder,JSONObject obj) {
		JSONObject formData = new JSONObject();
		for(int i=0;i<mapper.size();i++){
			JSONObject json=mapper.getJSONObject(i);
			String mapType=json.getString("mapType");
			ITableFieldValueHandler valHandler=tableFieldValueHandlerConfig.getByMapType(mapType);
			String fieldName=json.getString("fieldName");
			if(valHandler==null || "ID_".equals(fieldName)){
				continue;
			}
			String columnType=json.getString("columnType");
			String mapValue=json.getString("mapValue");
			Object val= valHandler.getFieldValue(columnType, null, 
					dataHolder, null, null, mapValue,JSONUtil.json2Map(obj.toJSONString()));
			if(map.containsKey(fieldName)) {
				SysBoAttr attr = map.get(fieldName);
				Integer single = attr.getIsSingle();
				if(single==0) {
					SysBoAttr nameAttr = new SysBoAttr();
					String name = attr.getFieldName().toUpperCase()+"_name";
					nameAttr.setName(attr.getName()+"_name");
					map.put(name, nameAttr);
				}
				fieldName = attr.getName();
			}
			formData.put(fieldName, val);
		}
		return formData;
	}
	
	private JSONArray getJsonAry(JSONArray mapper){
		JSONArray ary=new JSONArray();
		for(int i=0;i<mapper.size();i++){
			JSONObject json=mapper.getJSONObject(i);
			String mapType=json.getString("mapType");
			if(StringUtil.isEmpty(mapType)) continue;
			ary.add(json);
		}
		return ary;
	}
	
	
}
