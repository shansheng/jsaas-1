
package com.redxun.sys.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.dao.SysWordTemplateDao;
import com.redxun.sys.core.entity.SysWordTemplate;
import com.redxun.sys.core.util.DbUtil;

/**
 * 
 * <pre> 
 * 描述：SYS_WORD_TMPLATE【模板表】 处理接口
 * 作者:mansan
 * 日期:2018-05-16 11:29:19
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysWordTemplateManager extends MybatisBaseManager<SysWordTemplate>{
	
	@Resource
	private SysWordTemplateDao sysWordTemplateDao;
	@Resource
	CommonDao commonDao;
	@Resource
	SysBoEntManager boEntManager;
	@Resource
	SysBoDefManager sysBoDefManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysWordTemplateDao;
	}
	
	public SysWordTemplate getByAlias(String alias){
		SysWordTemplate sysWordTemplate = sysWordTemplateDao.getByAlias(alias);
		return sysWordTemplate;
	}
	
	@Override
	public void create(SysWordTemplate entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
	}

	@Override
	public void update(SysWordTemplate entity) {
		super.update(entity);
	}

	/**
	 * 判断别名是否存在。
	 * @param entity
	 * @return
	 */
	public boolean isAliasExist(SysWordTemplate entity){
		Integer rtn= sysWordTemplateDao.isAliasExist(entity.getId(), entity.getTemplateName());
		return rtn>0;
	}
	
	/**
	 * 根据模版ID返回元数据。
	 * @param templateId
	 * @return
	 * @throws Exception
	 */
	public JSONArray getMetaData(SysWordTemplate sysWordTemplate) throws Exception{
		String sqlType = sysWordTemplate.getType();
		if (sqlType.equals("sql")) {
			return getBySql( sysWordTemplate);
		} 
		else {
			return getBySqlBoDefId(sysWordTemplate.getBoDefId());
		}
	}
	
	/**
	 * {
	 * 	main：sql
	 *  sub:[{name:"",type:"",sql:""}]
	 * }
	 * @author mical 2018年5月23日
	 * describe：
	 * @param setting
	 * @return
	 * @throws Exception
	 */
	private JSONArray getBySql(SysWordTemplate template) throws Exception{
		String setting=template.getSetting();
		setDsAlias(template);
		JSONArray jsonAray=new JSONArray();
		JSONObject json=JSONObject.parseObject(setting);
		//main
		String sql=json.getString("main");
		sql = sql.replace("{pk}", "0");
		List<GridHeader> list = DbUtil.getGridHeaders(sql);
		JSONArray jsonAry=getJsonAray(list,"","main");
		jsonAray.addAll(jsonAry);
		
		//sub
		JSONArray subAry=json.getJSONArray("sub");
		if(subAry.size()>0){
			for(int i=0;i<subAry.size();i++){
				JSONObject subTb=subAry.getJSONObject(i);
				String name=subTb.getString("name");
				String type=subTb.getString("type");
				String subSql=subTb.getString("sql");
				subSql = subSql.replace("{pk}", "0");
				
				JSONObject jsonTb=new JSONObject();
				jsonTb.put("field",name);
				jsonTb.put("type",type);
				String typeName=getRelationType(type);
				jsonTb.put("comment", name + typeName);
				jsonTb.put("isField", false);
								
				List<GridHeader> sublist = DbUtil.getGridHeaders(subSql);
				JSONArray subTableAry=getJsonAray(sublist,name,type);
				jsonTb.put("children", subTableAry);
				jsonAray.add(jsonTb);
			}
		}
		return jsonAray;
	}
	
	private JSONArray getBySqlBoDefId(String boDefId) throws Exception{
		JSONArray jsonAray=new JSONArray();
		SysBoEnt sysBoEnt = boEntManager.getByBoDefId(boDefId);
		
		JSONArray jsonAry = getBoJsonAray(sysBoEnt.getSysBoAttrs(),"","main");
		jsonAray.addAll(jsonAry);
		
		
		List<SysBoEnt> boEntList = sysBoEnt.getBoEntList(); //子表集合
		if (boEntList.size() > 0) {
			for (SysBoEnt sub : boEntList) {
				String subName = sub.getName();
				JSONObject jsonTb=new JSONObject();
				jsonTb.put("field", subName);
				String type=getRelationType(sub.getRelationType());
				jsonTb.put("comment", sub.getComment()+type);
				jsonTb.put("type", sub.getRelationType());
				jsonTb.put("isField", false);
				
				JSONArray subAry=getBoJsonAray(sub.getSysBoAttrs(),subName,sub.getRelationType());
				jsonTb.put("children", subAry);
				jsonAray.add(jsonTb);
			}
		}
		
		
		return jsonAray;
	}
	
	private void setDsAlias(SysWordTemplate template) throws IllegalAccessException, NoSuchFieldException{
		String dsAlias=template.getDsAlias();
		if(StringUtil.isEmpty(dsAlias)) return ;
		DbContextHolder.setDataSource(dsAlias);
	}
	
	private String getRelationType(String type){
		if(type.equals("onetoone")){
			return "[一对一]";
		}
		if(type.equals("onetomany")){
			return "[一对多]";
		}
		return "";
	}
	
	/**
	 * @author mical 2018年5月18日
	 * describe：
	 * @param setting
	 * @return
	 */
	private JSONArray getJsonAray(List<GridHeader> list,String tableName,String type){
		JSONArray jsonArray = new JSONArray();
		for (GridHeader header:list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("field", header.getFieldName());
			jsonObject.put("comment", header.getFieldLabel());
			jsonObject.put("dataType", header.getDataType());
			jsonObject.put("tableName", tableName);
			jsonObject.put("isField", true);
			jsonObject.put("type", type);
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	private JSONArray getBoJsonAray(List<SysBoAttr> list,String tableName,String type){
		JSONArray jsonArray = new JSONArray();
		for (SysBoAttr attr:list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("field", attr.getName());
			jsonObject.put("comment", attr.getComment());
			jsonObject.put("dataType", attr.getDataType());
			jsonObject.put("tableName", tableName);
			jsonObject.put("isField", true);
			jsonObject.put("type", type);
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	/**
	 * 根据模版和主键获取数据。
	 * @param templateId
	 * @param pk
	 * @return
	 * @throws IllegalAccessException
	 * @throws NoSuchFieldException
	 */
	public JSONObject getData(SysWordTemplate sysWordTemplate,String pk) throws IllegalAccessException, NoSuchFieldException{
		String type = sysWordTemplate.getType();
		String boDefId = sysWordTemplate.getBoDefId();
	
		//存在主表、子表的情况下，传入的是主表的pk，查出主表的数据，获取子表的主键，再通过子表的主键获取子表的数据
		if ("sql".equals(type)) {
			return  getDataBySql( sysWordTemplate, pk);
		}
		else { 
			return sysBoDefManager.getDataByBoDef(boDefId, pk);
		}
	}
	
	private JSONObject getDataBySql(SysWordTemplate template ,String pk) throws IllegalAccessException, NoSuchFieldException{
		String setting=template.getSetting();
		setDsAlias(template);
		JSONObject settingJson=JSONObject.parseObject(setting);
		JSONObject returnJson = new JSONObject();
		JSONObject subTableJson = new JSONObject();
		//main
		String mainSql=settingJson.getString("main");
		mainSql = mainSql.replace("{pk}", pk);
		SqlModel sqlModel=new SqlModel(mainSql);
		Object main = commonDao.queryForMap(sqlModel);
		returnJson.put("main", main);
		//sub
		JSONArray subAry=settingJson.getJSONArray("sub");
		
		if(BeanUtil.isNotEmpty(subAry)){
			for(int i=0;i<subAry.size();i++){
				JSONObject subJson=subAry.getJSONObject(i);
				String name=subJson.getString("name");
				String type=subJson.getString("type");
				String subSql=subJson.getString("sql");
				subSql = subSql.replace("{pk}", pk);
				if(SysBoRelation.RELATION_ONETOONE.equals(type)){
					SqlModel subModel=new SqlModel(subSql);
					Object subData = commonDao.queryForMap(subModel);
					subTableJson.put(name, subData);
				}
				else{
					List subData = commonDao.query(subSql);
					subTableJson.put(name, subData);
				}
			}
			returnJson.put("sub", subTableJson);
		}
		return returnJson;
	}
	
	
	
}
