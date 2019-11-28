
package com.redxun.sys.core.manager;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.elastic.JestService;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.core.dao.SysEsQueryDao;
import com.redxun.sys.core.entity.SysEsQuery;
import com.redxun.sys.util.SysUtil;

import io.searchbox.client.JestResult;

/**
 * 
 * <pre> 
 * 描述：ES自定义查询 处理接口
 * 作者:ray
 * 日期:2018-11-28 14:21:52
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysEsQueryManager extends MybatisBaseManager<SysEsQuery>{
	
	@Resource
	private SysEsQueryDao sysEsQueryDao;
	@Resource
	private GroovyEngine groovyEngine;
	@Resource
	private JestService jestService;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysEsQueryDao;
	}
	
	
	
	public SysEsQuery getSysEsQuery(String uId){
		SysEsQuery sysEsQuery = get(uId);
		return sysEsQuery;
	}
	
	/**
	 * 判断ES查询是否存在。
	 * @param query
	 * @return
	 */
	public boolean isExist(SysEsQuery query){
		Integer rtn=sysEsQueryDao.getCountByAlias(query.getAlias(), query.getTenantId(), query.getId());
		return rtn>0;
	}
	
	
	/**
	 * 根据别名获取查询。
	 * @param alias
	 * @param tenantId
	 * @return
	 */
	public SysEsQuery getByAlias(String alias,String tenantId){
		SysEsQuery esQuery=sysEsQueryDao.getByAlias(alias, tenantId);
		return esQuery;
	}
	
	
	
	
	
	/**
	 * 获取条件。
	 * [{"type":"keyword","name":"real_name","typeOperate":"=","typeOperate_name":"等于","valueSource":"param"}]
	 * @param esQuery
	 * @return
	 */
	public JSONArray getConditions(SysEsQuery esQuery){
		JSONArray aryOut=new JSONArray();
		if(StringUtil.isEmpty( esQuery.getConditionFields())){
			return aryOut;
		}
		JSONArray array=JSONArray.parseArray(esQuery.getConditionFields());
	
		for(int i=0;i<array.size();i++){
			JSONObject obj=array.getJSONObject(i);
			if(obj.getString("valueSource").equals("param")){
				aryOut.add(obj);
			}
		}
		return aryOut;
	}
	
	/**
	 * [{
		"name": "id_card",
		"type": "keyword",
		"keyword": false
		}, {
			"name": "admin",
			"type": "keyword",
			"keyword": false
		}]
	 * @param returnJson
	 */
	private String buildReturnFields(String returnJson){
		JSONArray ary=JSONArray.parseArray(returnJson);
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			list.add(obj.getString("name"));
		}
		return StringUtil.join(list, ",");
	}
	
	/**
	 * 构造SQL语句。
	 * @param query
	 * @param params
	 * @return
	 */
	private String buildTableSql(SysEsQuery query,Map<String,Object> params){
		String sql="select " + buildReturnFields(query.getReturnFields()) +" from " + query.getEsTable() ;
		String where=buildWhere(query.getConditionFields(),params);
		if(StringUtil.isNotEmpty(where)){
			sql+=" where " + where;
		}
		String sort=buildSortFields(query.getSortFields());
		if(StringUtil.isNotEmpty(sort)){
			sql+=" order by " +sort;
		}
		return sql;
	}
	
	private String buildWhere(String conditions,Map<String,Object> params){
		if(StringUtil.isEmpty(conditions)) return "";
		JSONArray ary=JSONArray.parseArray(conditions);
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			//[{"type":"keyword","name":"real_name","typeOperate":"=","typeOperate_name":"等于","valueSource":"param"}]
			JSONObject obj=ary.getJSONObject(i);
			String rtn=getCondition( obj, params);
			list.add(rtn);
		}
		
		return StringUtil.join(list, " and ");
	}
	

	/**
	 * 	获取变量的值。
	 * 	var valueSource = [ {id : "param",text : '参数传入'}, {id : "fixedVar",text : '固定值'}, 
	 * 	{id : "script",text : '脚本'}, {id : "constantVar",text : '常量'} ];
	 * @param obj
	 * @param params
	 * @return
	 */
	private String getValue(JSONObject obj,Map<String,Object> params){
		String val="";
		String valSrc=obj.getString("valueSource");
		if(valSrc.equals("param")){
			String name=obj.getString("name");
			if(params.containsKey(name)){
				val=(String) params.get(name);
			}
		}
		else if(valSrc.equals("fixedVar")){
			val=obj.getString("valueDef");
		}
		else if(valSrc.equals("script")){
			Map<String,Object> vars=new HashMap<>();
			vars.put("params", params);
			vars.putAll(params);
			val=(String) groovyEngine.executeScripts(valSrc, vars);
		}
		else if(valSrc.equals("constantVar")){
			String valueDef=obj.getString("valueDef");
			ContextHandlerFactory contextHandlerFactory=AppBeanUtil.getBean(ContextHandlerFactory.class);
			val=(String) contextHandlerFactory.getValByKey(valueDef,null);
		}
		return val;
	}
	
	private boolean isString(String value){
		if("text".contentEquals(value) || "keywork".contentEquals(value)){
			return true;
		}
		return true;
	}
	
	private String getCondition(JSONObject obj,Map<String,Object> params){
		String tmp= obj.getString("name");
		String type= obj.getString("type");
		String op=obj.getString("typeOperate");
		String val= getValue(obj,params);
		
//		如果是in操作的参数的格式,如:{"fieldName":"value1,value2"},
//		between操作的参数格式,如{"fieldName":"value1|value2"}
		if(op.equals("between")){
			String[] ary=val.split("[|]");
			tmp+=op +"("+ary[0] + "and"+ ary[1] +")";
		}
		else if(op.equals("in")){
			if(isString(type)){
				String tmpVal="";
				String[] ary=val.split(",");
				for(int i=0;i<ary.length;i++){
					tmpVal=(i==0)? "'" +ary[i] +"'" :",'" +ary[i] +"'";
				}
				tmp+=op  + "(" + tmpVal +")" ;
			}
			else{
				tmp+=op  + "(" + val +")" ;
			}
		}
		else{
			if(isString(type)){
				tmp+=op + "'" + val +"'";
			}
			else{
				tmp+=op  + val  ;
			}
			
		}
		return tmp;
	}
	
	
	
	/**
	 * [{"name":"admin","typeOrder":"ASC"}]
	 * 
	 * @param sortFields
	 * @return
	 */
	private String buildSortFields(String sortFields){
		if(StringUtil.isEmpty(sortFields)) return "";
		
		JSONArray ary=JSONArray.parseArray(sortFields);
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String tmp=obj.getString("name");
			if(obj.containsKey("typeOrder")){
				tmp+=obj.getString("typeOrder");
			}
			else{
				tmp+= " asc" ;
			}
			list.add(tmp);
		}
		String order= StringUtil.join(list, ",");
		return order;
	}
	
	
	
	
	/**
	 * 构建SQL语句。
	 * @param query
	 * @param params
	 * @return
	 */
	private String buildSql(SysEsQuery query,Map<String,Object> params){
		//基于配置
		if(1==query.getQueryType().intValue()){
			return buildTableSql(query,params);
		}
		//使用脚本。
		else{
			String sqlScript=query.getQuery();
			//替换常量
			sqlScript=SysUtil.replaceConstant(sqlScript);
			Map<String,Object> model=new HashMap<>();
			model.put("params", params);
			model.putAll(params);
			return (String) groovyEngine.executeScripts(sqlScript, model);
		}
	}
	
	/**
	 * 分页查询。
	 * @param query
	 * @param params
	 * @param page page从0开始
	 * @return
	 * @throws IOException
	 */
	public JsonResult queryForPage(SysEsQuery query,Map<String,Object> params,int page) throws IOException{
		JsonResult rtn=new JsonResult<>(true);
		String sql=buildSql(query, params);
		
		JsonResult totalResult=  getTotal( sql);
		if(!totalResult.getSuccess()) return totalResult;
		
		int pageSize=query.getPageSize();
		
		int limit=pageSize * (page+1);
		int start=pageSize * page;
		
		String pageSql=sql +" limit " + limit;
		
		JestResult jsonRtn=  jestService.searchBySql(pageSql);
		
		List<String> rtnFields= getRtnFields( query);
		
		
		JSONArray ary= getByResult(jsonRtn.getJsonString(),rtnFields, start);
		
		Map<String,Object> rtnMap = new HashMap<String,Object>();
		
		
		JSONObject  pageResult=new JSONObject();
		int total=(int)totalResult.getData();
		
		int totalPage= (total / pageSize) +((total%pageSize) >0?1:0);
		//总数
		pageResult.put("totalCount", total);
		//总页数
		pageResult.put("totalPages", totalPage);
		//当前页数
		pageResult.put("page", page);
		//分页结果
		rtnMap.put("pageResult", pageResult);
		//页大小
		rtnMap.put("pageSize", query.getPageSize());
		//分页列表
		rtnMap.put("list", ary);
		
		rtn.setData(rtnMap);
	
		return rtn;
	}
	
	/**
	 * 获取数量。
	 * @param sql
	 * @return
	 * @throws IOException
	 */
	private JsonResult  getTotal(String sql) throws IOException{
		JsonResult rtn=new JsonResult<>(true);
		String countSql="select count(*) amount from (" +sql +")";
		JestResult result=  jestService.searchBySql(countSql);
		if(result.isSucceeded()){
			 JSONObject object=JSONObject.parseObject( result.getJsonString());
			 JSONArray  rows=object.getJSONArray("rows");
			 JSONArray tmpAry=rows.getJSONArray(0);
			 Integer i=tmpAry.getInteger(0);
			 rtn.setData(i);
		}
		else{
			rtn.setSuccess(false);
			rtn.setData(result.getErrorMessage());
		}
		
		return rtn;
	}
	
	/**
	 * 查询列表。
	 * @param query
	 * @param params
	 * @return
	 * @throws IOException
	 */
	public JsonResult queryForList(SysEsQuery query,Map<String,Object> params) throws IOException{
		String sql=buildSql(query, params);
		List<String> rtnFields= getRtnFields( query);
		JsonResult rtn=new JsonResult<>(true);
		JestResult result=  jestService.searchBySql(sql);
		
		if(result.isSucceeded()){
			JSONArray ary= getByResult(result.getJsonString(),rtnFields,0);
			Map<String,Object> rtnMap = new HashMap<String,Object>();
			rtnMap.put("list", ary);
			rtn.setData(rtnMap);
		}
		else{
			rtn.setSuccess(false);
			rtn.setData(result.getErrorMessage());
		}
		return rtn;
	}
	
	/**
	 * 获取返回字段。
	 * @param query
	 * @return
	 */
	private List<String> getRtnFields(SysEsQuery query){
		JSONArray ary=JSONArray.parseArray(query.getReturnFields());
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			list.add(obj.getString("name"));
		}
		return list;
	}
	
	
	/**
	 * 将查询输出的JSON进行转换。
	 * @param json
	 * <pre>
	 * {
	 *  "columns": [{"name": "address","type": "text"},
	 *   {"name": "birthday", "type": "date"},
	 *   {"name": "name", "type": "text"}
	 * 	],
	 *	  "rows": [
	 *	    [
	 *	      "四川重庆",
	 *	      "1920-10-10T00:00:00.000Z",
	 *	      "张飞"
	 *	    ]
	 *	  ]
	 *	}
	 * </pre>
	 * @param fields
	 * <pre>
	 * 	需要查询返回的字段列表
	 * </pre>
	 * @param start 从返回的数据起始行返回数据，默认从0开始。
	 * @return
	 * <pre>
	 * [
	 *  {name:"",age:1},
	 *  {name:"",age:20}
	 * ]
	 * </pre>
	 */
	public static JSONArray getByResult(String json,List<String> fields,int start){
		JSONObject jsonObj=JSONObject.parseObject(json);
		JSONArray columns=jsonObj.getJSONArray("columns");
		JSONArray rows=jsonObj.getJSONArray("rows");
		//构建位置到列名的映射。
		//1,name ,2 ,age 等。
		Map<Integer,String> fieldsMap=new HashMap<>();
		for(int i=0;i<columns.size();i++){
			JSONObject o=columns.getJSONObject(i);
			String name=o.getString("name");
			if(!fields.contains(name)) continue;
			fieldsMap.put(i, name);
		}
		//构建最终的JSON 
		JSONArray rtn=new JSONArray();
		for(int i=start;i<rows.size();i++){
			JSONObject o=new JSONObject();
			JSONArray row=rows.getJSONArray(i);
			for (Map.Entry<Integer, String> ent : fieldsMap.entrySet()) { 
				Integer pos=ent.getKey();
			    o.put(ent.getValue(), row.get(pos))	;
			}
			rtn.add(o);
		}
		
		return rtn;
	}
	
	
	
	
	
	public static void main(String[] args) {
		List<String>  list=new ArrayList<>();
		list.add("name");
		list.add("address");
		String json="{ \"columns\": [ {\"name\": \"address\", \"type\": \"text\"},{ \"name\": \"birthday\", \"type\": \"date\"}, {  \"name\": \"name\",\"type\": \"text\" } ], \"rows\": [[\"四川重庆\",\"1920-10-10T00:00:00.000Z\",\"张飞\" ],[ \"四川重庆\",  \"1910-10-10T00:00:00.000Z\",\"刘备\" ]]}";
		JSONArray ary= getByResult( json, list,0);
		System.out.println(ary);
	}

	
}
