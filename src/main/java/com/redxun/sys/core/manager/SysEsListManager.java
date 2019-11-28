
package com.redxun.sys.core.manager;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.elastic.JestService;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.core.dao.SysEsListDao;
import com.redxun.sys.core.entity.SysEsList;
import com.redxun.sys.util.SysUtil;
import com.redxun.ui.query.QueryControlParseConfig;
import com.redxun.ui.query.QueryControlParseHandler;

import freemarker.template.TemplateHashModel;
import io.searchbox.client.JestResult;

/**
 * 
 * <pre> 
 * 描述：SYS_ES_LIST 处理接口
 * 作者:ray
 * 日期:2019-01-19 15:01:59
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysEsListManager extends MybatisBaseManager<SysEsList>{
	
	@Resource
	private SysEsListDao sysEsListDao;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	private GroovyEngine groovyEngine;
	@Resource
	private JestService jestService;
	@Resource
	QueryControlParseConfig queryControlParseConfig;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysEsListDao;
	}
	
	
	
	public SysEsList getSysEsList(String uId){
		SysEsList sysEsList = get(uId);
		return sysEsList;
	}
	
	@Override
	public void create(SysEsList entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysEsList entity) {
		super.update(entity);
	}

	public SysEsList getEsList(String alias) {
		return sysEsListDao.getByAlias(alias);
	}



	public String[] genHtmlPage(SysEsList sysEsList, Map<String, Object> params) throws Exception {
		Map<String,Object> tmpParams= getGenParams(sysEsList);
		params.putAll(tmpParams);
				
		String html=freemarkEngine.mergeTemplateIntoString("list/pageEsListTemplate.ftl", params);
		String[] htmlAry=new String[2];
		htmlAry[0]=html;
		return htmlAry;
	}
	
	public Map<String,Object> getGenParams(SysEsList sysEsList) throws  Exception{
		Map<String,Object> params=new HashMap<>();
		params.put("name", sysEsList.getName());
		params.put("sysEsList", sysEsList);
		
		String colsHtml=getColumnsHtml(sysEsList.getReturnFields(),params);
		params.put("gridColumns", colsHtml);
		//产生搜索条件的Html
		String searchHtml=getSearchHtml(sysEsList.getConditionFields(),params,true);
		params.put("searchHtml",searchHtml);
		
		TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(this.getClass());
		params.put("SysBoListUtil", sysBoListModel);
		
		return params;
	}
	
	/**
	 * 获得栏目的HTML
	 * @param colJsons
	 * @return
	 */
	private String getColumnsHtml(String colJsons,Map<String,Object> params){
		JSONArray columnJsons=JSONArray.parseArray(colJsons);
		Element el=new Element(Tag.valueOf("div"),"");
		el.attr("property","columns");
		
		Element indexCol=new Element(Tag.valueOf("div"),"");
		indexCol.attr("type","indexcolumn");
		el.appendChild(indexCol);
		
		Element checkCol=new Element(Tag.valueOf("div"),"");
		checkCol.attr("type","checkcolumn");
		el.appendChild(checkCol);
		
		genGridColumns(columnJsons,el,params);
		return el.toString();
	}
	
	/**
	 * 产生表格的miniui的grid列项
	 * @param columnArr
	 * @return
	 */
	private Element genGridColumns(JSONArray columnArr,Element el,Map<String,Object> params){
		for(int i=0;i<columnArr.size();i++){
			JSONObject jsonObj=columnArr.getJSONObject(i);
			
				String field=jsonObj.getString("name");
				String datatype=jsonObj.getString("type");
				Element columnEl=new Element(Tag.valueOf("div"),"");
				
				if(datatype!=null){
					if("date".equals(datatype)){
						columnEl.attr("dateFormat","yyyy-MM-dd HH:mm:ss");
					}else if("float".equals(datatype) || "int".equals(datatype) || "currency".equals(datatype)){
						columnEl.attr("numberFormat","");
					}else if("keyword".equals(datatype)) {
						datatype = "string";
					}
					columnEl.attr("dataType",datatype);
				}
				
				
				if(StringUtils.isNotEmpty(field)){
					columnEl.attr("field",field);
					columnEl.attr("name",field);
					columnEl.attr("headerAlign","center");
					columnEl.text(field);
				}
				
				el.appendChild(columnEl);
			}
		
		return el;
	}
	
	public JSONArray getByType(JSONArray jsonArray,String type){
		JSONArray ary=new JSONArray();
		for(int i=0;i<jsonArray.size();i++){
			JSONObject config=jsonArray.getJSONObject(i);
			if(config.containsKey("type")){
				if(config.getString("type") .equals(type)){
					ary.add(config);
				}
			}
			else {
				if("query".equals(type)){
					ary.add(config);
				}
			}
		}
		return ary;
	}
	
	/**
	 * 获得搜索栏的Html
	 * @param searchJson
	 * @return
	 */
	private String getSearchHtml(String searchJson,Map<String,Object> params,boolean needSearch){
		if(StringUtils.isEmpty(searchJson)){
			return "";
		}
		Element divEl=new Element(Tag.valueOf("div"),"");
		Element ulEl=null;
		JSONArray jsonArray=JSONArray.parseArray(searchJson);
		for(int i=0;i<jsonArray.size();i++){
			if(i==0){
				ulEl=new Element(Tag.valueOf("ul"),"");
				divEl.appendChild(ulEl);
			}
			JSONObject config=jsonArray.getJSONObject(i);
			String fieldLabel=config.getString("name");
			String fieldOp=config.getString("typeOperate");
			if(StringUtils.isEmpty(fieldLabel))continue;
			//分割符，则换行
			if("-".equals(fieldOp)){
				ulEl=new Element(Tag.valueOf("ul"),"");
				divEl.appendChild(ulEl);
				continue;
			}
			
			String type=config.getString("type");
			Element li=new Element(Tag.valueOf("li"),"");
			Element span=new Element(Tag.valueOf("span"),"");
			span.text(fieldLabel);
			
			li.appendChild(span);
			if("date".equals(type)) {
				type = "mini-datepicker";
			}else {
				type = "mini-textbox";
			}
			QueryControlParseHandler handler=queryControlParseConfig.getControlParseHandler(type);
			JSONObject json = new JSONObject();
			json.put("fieldName", config.get("name")+"_search");
			json.put("autoFilter", "NO");
			Element conEl=handler.parse(json,params);
			li.appendChild(conEl);
			ulEl.appendChild(li);
		
			if(needSearch && (i==jsonArray.size()-1)){
				String searchBtns="<li class=\"liBtn\"><a class=\"mini-button \" onclick=\"onSearch()\" >搜索</a><a class=\"mini-button \"";
				searchBtns+=" onclick=\"onClear()\">清空</a></li>";
				ulEl.append(searchBtns);
			}
			
			
		}
		return divEl.html();
	}
	
	/**
	 * 构造SQL语句。
	 * @param query
	 * @param params
	 * @return
	 */
	private String buildTableSql(SysEsList list,Map<String,Object> params){
		String sql="select " + buildReturnFields(list.getReturnFields()) +" from " + list.getEsTable() ;
		String where=buildWhere(list.getConditionFields(),params);
		if(StringUtil.isNotEmpty(where)){
			sql+=" where " + where;
		}
		String sort=buildSortFields(list.getSortFields());
		if(StringUtil.isNotEmpty(sort)){
			sql+=" order by " +sort;
		}
		return sql;
	}
	
	private String buildSortFields(String sortFields){
		if(StringUtil.isEmpty(sortFields)) return "";
		
		JSONArray ary=JSONArray.parseArray(sortFields);
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String tmp=obj.getString("name");
			if(obj.containsKey("typeOrder")){
				tmp+=" "+obj.getString("typeOrder");
			}
			else{
				tmp+= " asc" ;
			}
			list.add(tmp);
		}
		String order= StringUtil.join(list, ",");
		return order;
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
	
	private String getCondition(JSONObject obj,Map<String,Object> params){
		String tmp= obj.getString("name");
		String type= obj.getString("type");
		String op=obj.getString("typeOperate");
		String val= getValue(obj,params);
		if(StringUtil.isEmpty(val))return "";
		
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
	
	private boolean isString(String value){
		if("text".contentEquals(value) || "keywork".contentEquals(value)){
			return true;
		}
		return true;
	}
	
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
	 * 构建SQL语句。
	 * @param query
	 * @param params
	 * @return
	 */
	private String buildSql(SysEsList list,Map<String,Object> params){
		//基于配置
		if(1==list.getQueryType().intValue()){
			return buildTableSql(list,params);
		}
		//使用脚本。
		else{
			String sqlScript=list.getQuery();
			//替换常量
			sqlScript=SysUtil.replaceConstant(sqlScript);
			Map<String,Object> model=new HashMap<>();
			model.put("params", params);
			model.putAll(params);
			return (String) groovyEngine.executeScripts(sqlScript, model);
		}
	}
	
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
			rtn.setData(0);
		}
		
		return rtn;
	}

	/**
	 * 分页查询。
	 * @param query
	 * @param params
	 * @param page page从0开始
	 * @return
	 * @throws IOException
	 */
	public List queryForPage(SysEsList list,QueryFilter filter) throws IOException{
		String sql=buildSql(list, filter.getParams());
		Integer page = filter.getPage().getPageIndex();
		
		JsonResult totalResult=  getTotal( sql);
		if(!totalResult.getSuccess()) return new ArrayList();
		
		Page obj = (Page) filter.getPage();
		obj.setTotalItems(Integer.parseInt(totalResult.getData().toString()));
		
		int pageSize=filter.getPage().getPageSize();
		
		int limit=pageSize * (page+1);
		int start=pageSize * page;
		
		String pageSql=sql +" limit " + limit;
		
		JestResult jsonRtn=  jestService.searchBySql(pageSql);
		
		List<String> rtnFields= getRtnFields( list);
		
		
		List ary= getByResult(jsonRtn.getJsonString(),rtnFields, start);
		
		return ary;
	}
	
	public static List getByResult(String json,List<String> fields,int start){
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
	
	private List<String> getRtnFields(SysEsList query){
		JSONArray ary=JSONArray.parseArray(query.getReturnFields());
		List<String> list=new ArrayList<>();
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			list.add(obj.getString("name"));
		}
		return list;
	}



	public List queryForList(SysEsList sysEsList, QueryFilter filter) throws Exception {
		String sql=buildSql(sysEsList, filter.getParams());
		List<String> rtnFields= getRtnFields( sysEsList);
		JestResult result=  jestService.searchBySql(sql);
		List ary = new ArrayList();
		
		if(result.isSucceeded()){
			ary= getByResult(result.getJsonString(),rtnFields,0);
		}
		return ary;
	}
	
	
}
