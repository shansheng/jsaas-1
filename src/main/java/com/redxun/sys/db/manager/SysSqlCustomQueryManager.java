
package com.redxun.sys.db.manager;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.proxy.jdbc.ClobProxyImpl;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmRegLib;
import com.redxun.bpm.core.manager.BpmRegLibManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.api.model.Column;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.database.util.CustomQueryConfigBean;
import com.redxun.core.database.util.DbUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.db.dao.SysSqlCustomQueryDao;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.redxun.sys.util.SysUtil;
import com.thoughtworks.xstream.XStream;

import freemarker.template.TemplateException;

/**
 * 
 * <pre> 
 * 描述：自定义查询 处理接口
 * 作者:cjx
 * 日期:2017-02-21 15:32:09
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysSqlCustomQueryManager extends MybatisBaseManager<SysSqlCustomQuery>{
	@Resource
	private SysSqlCustomQueryDao sysSqlCustomQueryDao;
	
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	ContextHandlerFactory contextHandlerFactory;
	@Resource
	CommonDao commonDao;
	@Resource
	FreemarkEngine freemarkEngine;  
	@Resource
	BpmRegLibManager bpmRegLibManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysSqlCustomQueryDao;
	}
	
	
	
	public List getQueryData(String alias,Map<String,Object> params) throws Exception{
		SysSqlCustomQuery sqlCustomQuery=getByKey(alias);
		
		String ds=sqlCustomQuery.getDsAlias();
		//切换数据源
		DbContextHolder.setDataSource(ds);
		Page page=null;
		if(sqlCustomQuery.getIsPage()==1){
			Object pageObj= params.get("pageIndex");
			if(pageObj!=null){
				page=new Page(Integer.parseInt(pageObj.toString()) ,Integer.parseInt(sqlCustomQuery.getPageSize()));
			}
			if(null==page){
				page=new Page(0,Integer.parseInt(sqlCustomQuery.getPageSize()));
			}
		}
		List list=getData(sqlCustomQuery, params,page);
		
		DbContextHolder.setDefaultDataSource();
		
		return list;
	}
	
	/**
	 * 通过key查找对象
	 * 
	 * @Description 
	 * @Title  findById 
	 * @param  @param id
	 * @param  @return  参数说明 
	 * @return SysSqlCustomQuery    返回类型 
	 * @throws
	 */
	public SysSqlCustomQuery getByKey(String key) {
		String tenantId=ContextUtil.getCurrentTenantId();
		SysSqlCustomQuery cusQuery=this.sysSqlCustomQueryDao.getByAlias(key, tenantId);
		if(cusQuery==null){
			cusQuery=this.sysSqlCustomQueryDao.getByAlias(key, ITenant.ADMIN_TENANT_ID);
		}
		return cusQuery;
	}
	
	/**
	 * 将JSON参数转换成一个Map.
	 * @param jsonStr
	 * @return
	 */
	public Map<String,Object> jsonToMap(String jsonStr){
		Map<String,Object> params=new HashMap<String, Object>();
		if(StringUtil.isEmpty(jsonStr)) return params;
		JSONObject jsonObject=JSONObject.parseObject(jsonStr);
		Set<String> set = jsonObject.keySet();
		for (String key : set) {
			String val=jsonObject.getString(key);
			if(StringUtil.isEmpty(val)) continue;
			String str=DbUtil.encodeSql(val);
			params.put(key, str);
		}
		return params;
	}
	
	@SuppressWarnings("rawtypes")
	public List getData(SysSqlCustomQuery sqlCustomQuery,Map<String,Object> requestParams,Page page) throws TemplateException, IOException{
		Map<String, Object> handleParams=getParams(sqlCustomQuery,requestParams);
		List result=null;
		//自定义SQL
		if("sql".equals(sqlCustomQuery.getSqlBuildType())){
			Map<String,Object> params=new HashMap<String, Object>();
			params.putAll(handleParams);
			params.put("params", handleParams);
			
			String handleSqlDiy=sqlCustomQuery.getSqlDiy();   //处理常量
			handleSqlDiy=SysUtil. replaceConstant(handleSqlDiy);
			String sql=(String)groovyEngine.executeScripts(handleSqlDiy, params);   //获取SQL
			if(1==sqlCustomQuery.getIsPage()){
				result=commonDao.query(sql,null,page);
			}
			else{
				result=commonDao.query(sql);
			}
			List finalResults=handleSqlDiyResult(sqlCustomQuery, result);	//处理结果集
			return finalResults;
		}else if("table".equals(sqlCustomQuery.getSqlBuildType())){
			SqlModel sqlModel=bulidSql(sqlCustomQuery,requestParams);
			if(1==sqlCustomQuery.getIsPage()){
				result=commonDao.query(sqlModel.getSql(), sqlModel.getParams(),page);
			}
			else{
				result=commonDao.query(sqlModel.getSql(), sqlModel.getParams());
			}
			return result;
		}
		else if("freeMakerSql".equals(sqlCustomQuery.getSqlBuildType())){
			
			String sql=SysUtil. replaceConstant(sqlCustomQuery.getSql());
			sql=  freemarkEngine.parseByStringTemplate(handleParams, sql);
			if(1==sqlCustomQuery.getIsPage()){
				result=commonDao.query(sql,null,page);
			}
			else{
				result=commonDao.query(sql);
			}
			List finalResults=handleSqlDiyResult(sqlCustomQuery, result);	//处理结果集
			return finalResults;
		}
		return null;
	}

	
	
	
	
	
	private Map<String, Object> getParams(SysSqlCustomQuery  sqlCustomQuery,Map<String,Object> requestParams){
		String whereSql=sqlCustomQuery.getWhereField();
		if(StringUtil.isEmpty(whereSql)) return Collections.EMPTY_MAP;
	
		Map<String, Object> handleParams=new HashMap<String, Object>();
		JSONArray whereArray=JSONArray.parseArray(whereSql);
		for (int i = 0; i < whereArray.size(); i++) {
			JSONObject jsonObject=(JSONObject)whereArray.get(i);
			if(!"param".equals(jsonObject.get("valueSource"))) continue;
			
			String name=jsonObject.getString("fieldName");
			if(!requestParams.containsKey(name)) continue;
			
			Object obj=requestParams.get(name);
			if(obj==null) continue;
			if(obj instanceof String){
				String tmp=(String)obj;
				if(StringUtil.isNotEmpty(tmp)){
					handleParams.put(name,tmp);
				}
			}
			else{
				handleParams.put(name,obj);
			}
		}
		return handleParams;
		
	}
	
	/**
	 * 根据自定义查询配置，处理自定义sql结果集。
	 * @param sqlCustomQuery
	 * @param result
	 * @return
	 */
	private List handleSqlDiyResult(SysSqlCustomQuery sqlCustomQuery,List result){
		JSONArray resultArray=JSONArray.parseArray(sqlCustomQuery.getResultField());
		if(BeanUtil.isEmpty(resultArray)) return null;    
		
		List finalResults=new ArrayList<String>();
		for (Object object : result) {
			Map<String,Object> tmpResult=new HashMap<String, Object>();
			for (int i = 0; i < resultArray.size(); i++) {
				Map<String, Object> resultItem=(Map<String, Object>)object;
				String fieldName=(String)((JSONObject)resultArray.get(i)).get("fieldName");
				String reg=(String)((JSONObject)resultArray.get(i)).get("reg");
				Object val=resultItem.get(fieldName);
		        if(val instanceof ClobProxyImpl ){
					ClobProxyImpl clob=(ClobProxyImpl)val;
					val = FileUtil.clobToString(clob);
				}
				if(val==null) continue;
				BpmRegLib lib = bpmRegLibManager.getRegByKeyReplace(reg);
				if(BeanUtil.isNotEmpty(lib) && val instanceof String) {
					String regText = lib.getRegText();
				    String mentText = lib.getMentText();
				    String obj = val.toString();
				    val = obj.replaceAll(regText, mentText);
				}
				tmpResult.put(fieldName, val);
			}
			finalResults.add(tmpResult);
		}
		return finalResults;
	}
	
	/**
	 * 构建自定义SQL语句
	 * @param sqlCustomQuery
	 * @param requestParams
	 * @return
	 */
	private SqlModel bulidSql(SysSqlCustomQuery sqlCustomQuery,Map<String,Object> requestParams){
		
		String sql="SELECT ";
		
		sql+=" "+buildResultField(sqlCustomQuery.getResultField());
		
		sql+=" from "+sqlCustomQuery.getTableName();
		SqlModel whereSql=bulidWhere(sqlCustomQuery, requestParams);
		sql+=" "+whereSql.getSql();
		
		sql+=getOrderBy(sqlCustomQuery);
		
		return new SqlModel(sql, whereSql.getParams());
	}
	
	/**
	 * 构建where 语句。
	 * @param sqlCustomQuery
	 * @param requestParams
	 * @return
	 */
	private SqlModel bulidWhere(SysSqlCustomQuery sqlCustomQuery, Map<String,Object> requestParams){
		
		if(StringUtil.isEmpty(sqlCustomQuery.getWhereField())) 	return new SqlModel("",Collections.EMPTY_MAP);
		
		String whereSql=" where 1=1 ";
		JSONArray whereJsonArray=JSONArray.parseArray(sqlCustomQuery.getWhereField());
		Map<String,Object> params=new HashMap<String, Object>();
			
		for (int i=0;i<whereJsonArray.size();i++) {
			JSONObject jsonObject=(JSONObject)whereJsonArray.get(i);
			String columnType=(String)jsonObject.get("columnType");

			String specialSentence=""; 
			
			String value=(String) getValue(requestParams,jsonObject);
			if(StringUtils.isEmpty(value)) continue;
			
			if(Column.COLUMN_TYPE_VARCHAR.equals(columnType)){      //字符类型处理
				specialSentence+=handleVarchar(jsonObject,  requestParams, params);				
			}else if(Column.COLUMN_TYPE_NUMBER.equals(columnType)){
				specialSentence+=handleNumber(jsonObject,  requestParams, params);
			}else if(Column.COLUMN_TYPE_DATE.equals(columnType)){
				specialSentence+=handleDate(jsonObject,  requestParams, params);
			}
			whereSql+=" and "+specialSentence;
		}
		return new SqlModel(whereSql, params);
	}
	
	/**
	 * 处理字符类型的SQL。
	 * @param jsonObject
	 * @param requestParams
	 * @param params
	 * @return
	 */
	private String handleVarchar(JSONObject jsonObject,  Map<String,Object> requestParams,Map<String,Object> params){
		String fieldName=(String)jsonObject.get("fieldName");
		String typeOperate=(String)jsonObject.get("typeOperate");
		String specialSentence=fieldName; 
		
		String value=(String) getValue(requestParams,jsonObject);
		//处理IN查询
		if(CustomQueryConfigBean.TypeOperateIn.equals(typeOperate)){  //IN查询
			specialSentence+=handInParams(fieldName,value,params);		
		}else if(CustomQueryConfigBean.TypeOperateEqual.equals(typeOperate)){
			specialSentence+= " = " + getMyBatisName(fieldName);
			params.put(fieldName, value);
		}
		else if(CustomQueryConfigBean.TypeOperateNotEqual.equals(typeOperate)){
			specialSentence+= " != " + getMyBatisName(fieldName);
			params.put(fieldName, value);
		}
		else{
			specialSentence+= " like " + getMyBatisName(fieldName);
			if(CustomQueryConfigBean.TypeOperateLike.equals(typeOperate)){   //全模糊
				params.put(fieldName, "%"+value+"%");
			}else if(CustomQueryConfigBean.TypeOperateLikeLeft.equals(typeOperate)){   //左模糊
				params.put(fieldName, value+"%");
			}else if(CustomQueryConfigBean.TypeOperateLikeRight.equals(typeOperate)){  //右模糊
				params.put(fieldName, "%"+value);
			}
		}	
	
		return specialSentence;
	}
	
	/**
	 * 处理数字SQL。
	 * @param jsonObject
	 * @param requestParams
	 * @param params
	 * @return
	 */
	private String handleNumber(JSONObject jsonObject,  Map<String,Object> requestParams,Map<String,Object> params){
		String fieldName=(String)jsonObject.get("fieldName");
		String typeOperate=(String)jsonObject.get("typeOperate");
		String specialSentence=fieldName; 
		
		String value=(String) getValue(requestParams,jsonObject);
		
		if(CustomQueryConfigBean.TypeOperateBetween.equals(typeOperate)){  //BETWEEN查询
			if(value.indexOf("|")<0) return "";
			String[] aryVal=value.split("\\|");
			specialSentence+=" between " + getMyBatisName(fieldName+"_start") +"  and " +getMyBatisName(fieldName+"_end");
			params.put(fieldName+"_start", Integer.parseInt(aryVal[0]));
			params.put(fieldName+"_end",Integer.parseInt(aryVal[1]));
		}else if(CustomQueryConfigBean.TypeOperateIn.equals(typeOperate)){  //IN查询
			specialSentence+=handInParams(fieldName,value,params);
						
		}else{
			specialSentence+=typeOperate + getMyBatisName(fieldName);
			params.put(fieldName, Integer.parseInt(value));
		}
		return specialSentence;
	}
	
	/**
	 * 处理in参数
	 * @param fieldName
	 * @param value
	 * @param params
	 * @return
	 */
	private String handInParams(String fieldName,String value,Map<String,Object> params){
		if(StringUtil.isEmpty(value)) return "";
		String[] inParams=value.split(",");
		String inStrings="";
		for (int i = 0; i < inParams.length; i++) {
			if(i==0){
				inStrings=getMyBatisName(fieldName+"_"+i);
				params.put(fieldName+"_"+i, inParams[i]);
				continue;
			}
			inStrings+=","+getMyBatisName(fieldName+"_"+i);
			params.put(fieldName+"_"+i, inParams[i]);
		}
		return " in ("+inStrings+")";
			
	}
	
	/**
	 * 日期类型的处理。
	 * @param jsonObject
	 * @param requestParams
	 * @param params
	 * @return
	 */
	private String handleDate(JSONObject jsonObject,  Map<String,Object> requestParams,Map<String,Object> params){
		String fieldName=(String)jsonObject.get("fieldName");
		String typeOperate=(String)jsonObject.get("typeOperate");
		String specialSentence=fieldName; 
		
		String value=(String) getValue(requestParams,jsonObject);
		
		if(CustomQueryConfigBean.TypeOperateBetween.equals(typeOperate)){  //BETWEEN查询
			if(value.indexOf("|")<0) return "";
			String[] aryVal=value.split("\\|");
			specialSentence+=" between " + getMyBatisName(fieldName+"_start") +"  and " +getMyBatisName(fieldName+"_end");
			params.put(fieldName+"_start", DateUtil.parseDate(aryVal[0]));
			params.put(fieldName+"_end",DateUtil.parseDate(aryVal[1]));
		}else{
			specialSentence+=typeOperate + getMyBatisName(fieldName);
			params.put(fieldName, DateUtil.parseDate(value));
		}
		return specialSentence;
	}
	
	
	/**
	 * JSON 结构。
	 * @param requestParams
	 * @param valSource
	 * @param jsonObject
	 * @return
	 */
	private Object getValue(Map<String,Object> requestParams,JSONObject jsonObject){
		String fieldName=(String)jsonObject.get("fieldName");
		String valSource=(String)jsonObject.get("valueSource");
		String valueDef=(String)jsonObject.get("valueDef");
		Map<String,Object> vars=new HashMap<String, Object>();
		Object val=null;
		if("param".equals(valSource)){      //传入参数
			val=requestParams.get(fieldName);
//			JSONObject co=JSONObject.parseObject((String)requestParams.get("params"));
//			if(co!=null){
//				
//			}
		}else if("fixedVar".equals(valSource)){   //固定值
			val=valueDef;
		}else if("script".equals(valSource)){    //脚本
			val=(String)groovyEngine.executeScripts(valueDef,vars);
		}else if("constantVar".equals(valSource)){
			val=contextHandlerFactory.getValByKey(valueDef,vars);
		}
		return val;
	}
	
	
	
	private String getMyBatisName(String fieldName){
		return  "#{"+fieldName+"}";
	}
	
	/**
	 * 构建ORDER BY
	 * @param sqlCustomQuery
	 * @return
	 */
	private String getOrderBy(SysSqlCustomQuery sqlCustomQuery){
		if(StringUtil.isEmpty(sqlCustomQuery.getOrderField())) return "";
		String orderFieldString=" order by ";
		JSONArray orderJsonArray=JSONArray.parseArray(sqlCustomQuery.getOrderField());
		for (int i=0;i<orderJsonArray.size();i++) {
			JSONObject jsonObject=(JSONObject)orderJsonArray.get(i);
			String fieldName=(String)jsonObject.get("fieldName");
			String typeOrder=(String)jsonObject.get("typeOrder");
			String order=typeOrder;
			if (i==0){
				orderFieldString+=fieldName+" "+order;
				continue;
			}
			orderFieldString+=","+fieldName+" "+order;
		}
		return orderFieldString;
	}
	
	/**
	 * 处理结果集。
	 * @param resultField
	 * @return
	 */
	private String buildResultField(String resultField){
		String resultFieldString="";
		JSONArray queryJsonArray=JSONArray.parseArray(resultField);
		for (int i=0;i<queryJsonArray.size();i++) {
			JSONObject jsonObject=(JSONObject)queryJsonArray.get(i);
			String fieldName=(String)jsonObject.get("fieldName");
			if (i==0){
				resultFieldString+=fieldName;
				continue;
			}
			resultFieldString+=","+fieldName;
		}
		return resultFieldString;
	}
	
	/**
	 * 根据租户ID获取列表。
	 * @param tenantId
	 * @return
	 */
	public List<SysSqlCustomQuery> getByTenantId(String tenantId){
		return sysSqlCustomQueryDao.getByTenantId(tenantId);
	}

	public List<SysSqlCustomQuery> getSysSqlCustomQueryByIds(String[] keys) {
		List< SysSqlCustomQuery> list=new ArrayList<SysSqlCustomQuery>();
		for (String key : keys) {
			SysSqlCustomQuery sysSqlCustomQuery = getByKey(key);
	
			if(BeanUtil.isEmpty(sysSqlCustomQuery)) continue;
			list.add(sysSqlCustomQuery);
		}
		return list;
	}

	/**
	 * 
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @throws Exception
	 */
	public void doImport(MultipartFile file) throws Exception{
		
		ProcessHandleHelper.initProcessMessage();
		
		List<SysSqlCustomQuery>   list=getBpmSolutionExts(file);
		String tenantId = ContextUtil.getCurrentTenantId();
		for(SysSqlCustomQuery sysSqlCustomQuery:list){
			doImport( sysSqlCustomQuery, tenantId);
		}
	}
	
	/**
	 * 读取上传的对象。
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	private List<SysSqlCustomQuery> getBpmSolutionExts(MultipartFile file) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("sysSqlCustomQuery", SysSqlCustomQuery.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<SysSqlCustomQuery> list=new ArrayList<SysSqlCustomQuery>();

		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysSqlCustomQuery sysSqlCustomQuery = (SysSqlCustomQuery) xstream.fromXML(xml);
			list.add(sysSqlCustomQuery);
		}
		zipIs.close();
		return list;
	
	}
	
	/**
	 * 流程方案的导入
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void doImport(SysSqlCustomQuery sysSqlCustomQuery,String tenantId) throws Exception{
		
		sysSqlCustomQuery.setTenantId(tenantId);
		
		/**
		 * 如果方案已经存在则直接退出。
		 * 这里对方案的 租户ID进行修改。
		 */
		sysSqlCustomQuery.setId(IdUtil.getId());
		Boolean isExist= getByKey(sysSqlCustomQuery.getKey())!=null?true:false;
		if(isExist){
			ProcessHandleHelper.addErrorMsg(sysSqlCustomQuery.getName() + "查询已经存在!");
			return;
		}
		//查询
		sysSqlCustomQueryDao.create(sysSqlCustomQuery);
      
	}
	

}
