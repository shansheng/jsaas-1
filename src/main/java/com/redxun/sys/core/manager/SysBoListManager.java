
package com.redxun.sys.core.manager;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.cache.ICache;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.dao.mybatis.domain.PageList;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.Base64Util;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.core.dao.SysBoListDao;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysBoTopButton;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.TreeConfig;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.ui.grid.GridColEditParseConfig;
import com.redxun.ui.grid.GridColEditParseHandler;
import com.redxun.ui.query.QueryControlParseConfig;
import com.redxun.ui.query.QueryControlParseHandler;
import com.redxun.ui.view.model.UrlColumn;
import com.thoughtworks.xstream.XStream;

import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;
import oracle.sql.TIMESTAMP;

/**
 * 
 * <pre> 
 * 描述：系统自定义业务管理列表 处理接口
 * 作者:mansan
 * 日期:2017-05-21 12:11:18
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysBoListManager extends MybatisBaseManager<SysBoList>{
	
	@Resource
	private SysBoListDao sysBoListDao;
	@Resource
	CommonDao commonDao;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	QueryControlParseConfig queryControlParseConfig;
	@Resource
	GridColEditParseConfig gridColEditParseConfig;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	SysInstManager sysInstManager;
	
	@Override
	protected IDao getDao() {
		return sysBoListDao;
	}
	
	
	
	
	/**
	 * 
	 * @param key
	 * @param tenantId
	 * @return
	 */
	public SysBoList getByKey(String key,String tenantId){
		SysBoList sysBoList=sysBoListDao.getByKey(key, tenantId);
		if(sysBoList==null){
			sysBoList=sysBoListDao.getByKey(key, SysInst.ADMIN_TENANT_ID);
		}
		return sysBoList;
	}
	
	/**
	 * 
	 * 判断Key是否存在
	 * @param key
	 * @param tenantId
	 * @param pkId
	 * @return
	 */
	public boolean isKeyExist(String key,String tenantId,String pkId){
		SysBoList sysBoList=getByKey(key,tenantId);
		//为空表示没找到就是不存在
		if(BeanUtil.isEmpty(sysBoList)){
			return false;
		}
		//新增的情况
		if(StringUtils.isEmpty(pkId) ){
			return true;
		}
		//更新的情况
		else{
			if(!pkId.equals(sysBoList.getPkId())){
				return true;
			}
			return false;
		}
		
	}
	/**
	 * 获得栏目的HTML
	 * @param colJsons
	 * @return
	 */
	private String getColumnsHtml(String colJsons,List<UrlColumn> urlColumns,Map<String,Object> params){
		JSONArray columnJsons=JSONArray.parseArray(colJsons);
		Element el=new Element(Tag.valueOf("div"),"");
		el.attr("property","columns");
		
		Element indexCol=new Element(Tag.valueOf("div"),"");
		indexCol.attr("type","indexcolumn");
		el.appendChild(indexCol);
		
		Element checkCol=new Element(Tag.valueOf("div"),"");
		checkCol.attr("type","checkcolumn");
		el.appendChild(checkCol);
		
		genGridColumns(columnJsons,el,urlColumns,params);
		return el.toString();
	}
	
	private String getRapidSearchHtml(JSONArray searchJsonArr,Map<String,Object> params){
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<searchJsonArr.size();i++){
			JSONObject config=searchJsonArr.getJSONObject(i);
			String fieldLabel=config.getString("fieldLabel");
			if(StringUtils.isEmpty(fieldLabel))continue;

			String fc=config.getString("fc");
			Element span=new Element(Tag.valueOf("span"),"");
			span.attr("class","rapid-class");
			QueryControlParseHandler handler=queryControlParseConfig.getControlParseHandler(fc);
			
			Element conEl=handler.parse(config,params);
			conEl.attr("onenter","onRapidSearch()");
			conEl.attr("emptyText",fieldLabel);
			span.appendChild(conEl);
			sb.append(span.toString()).append("&nbsp;");
		}
		return sb.toString();
	}
	
	/**
	 * 获得搜索栏的Html
	 * @param searchJson
	 * @return
	 */
	private String getSearchHtml(String searchJson,Map<String,Object> params){
		if(StringUtils.isEmpty(searchJson)){
			return "";
		}
		Element divEl=new Element(Tag.valueOf("div"),"");
		Element ulEl=null;
		JSONArray jsonArray=JSONArray.parseArray(searchJson);
		JSONArray jsonAry=getByType(jsonArray,"query");
		for(int i=0;i<jsonAry.size();i++){
			if(i==0){
				ulEl=new Element(Tag.valueOf("ul"),"");
				divEl.appendChild(ulEl);
			}
			JSONObject config=jsonAry.getJSONObject(i);
			String fieldLabel=config.getString("fieldLabel");
			String fieldOp=config.getString("fieldOp");
			if(StringUtils.isEmpty(fieldLabel))continue;
			//分割符，则换行
			if("-".equals(fieldOp)){
				ulEl=new Element(Tag.valueOf("ul"),"");
				divEl.appendChild(ulEl);
				continue;
			}
			
			String fc=config.getString("fc");
			Element li=new Element(Tag.valueOf("li"),"");
			Element span=new Element(Tag.valueOf("span"),"");
			span.text(fieldLabel +"：");
			span.attr("class","text");
			li.appendChild(span);
		
			QueryControlParseHandler handler=queryControlParseConfig.getControlParseHandler(fc);
			
			Element conEl=handler.parse(config,params);
			li.appendChild(conEl);
			ulEl.appendChild(li);
			
		}
		return divEl.html();
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
	 * 返回头部的按钮配置
	 * @param topButtonJson
	 * @return
	 */
	private JSONArray getTopButtonHtml(String topButtonJson,boolean needSearch){
		if(StringUtils.isEmpty(topButtonJson)){
			topButtonJson="[]";
			return JSONArray.parseArray(topButtonJson);
		}
		JSONArray jsonArr=JSONArray.parseArray(topButtonJson);
		if(needSearch){
			JSONObject search = new JSONObject();
			search.put("btnName", "Search");
			search.put("btnClick", "onSearch()");
			search.put("btnIconCls", "icon-add");
			search.put("btnLabel", "查询");
			JSONObject clear = new JSONObject();
			clear.put("btnName", "Clear");
			clear.put("btnClick", "onClear()");
			clear.put("btnIconCls", "icon-add");
			clear.put("btnClass", "btn-red");
			clear.put("btnLabel", "清空查询");
			jsonArr.add(search);
			jsonArr.add(clear);
		}
		for (Object object : jsonArr) {
			JSONObject obj = (JSONObject)object;
			if("Remove".equals(obj.getString("btnName"))){
				obj.put("btnClass", "btn-red");
			}
		}
		return jsonArr;
	}
	
	
	public Map<String,Object> getGenParams(SysBoList sysBoList,boolean needSearch) throws  Exception{
		Map<String,Object> params=new HashMap<>();
		params.put("name", sysBoList.getName());
		params.put("leftNav", sysBoList.getLeftNav());
		params.put("isLeftTree", sysBoList.getIsLeftTree());
		params.put("enableFlow", "YES".equals(sysBoList.getEnableFlow())?"YES":"NO");
		params.put("isDialog",sysBoList.getIsDialog());
		params.put("isInitData", sysBoList.getIsInitData());
		
		//当值都大于0时，才会冻结某列
		if(sysBoList.getStartFroCol()!=null && 
				sysBoList.getEndFroCol()!=null && sysBoList.getEndFroCol()>0){
			params.put("showFroCol", "true");
		}else{
			params.put("showFroCol", "false");
		}
		//数据行控件绑定
		if("tree".equals(sysBoList.getDataStyle())){
			params.put("controlClass","mini-treegrid");
		}else{
			params.put("controlClass","mini-datagrid");
		}
		
		List<UrlColumn> urlColumns=new ArrayList<UrlColumn>();
		
		//产生表格的Html的Json
		String colsHtml=getColumnsHtml(sysBoList.getColsJson(),urlColumns,params);
		params.put("gridColumns", colsHtml);
		colsHtml=getColumnsHtml(sysBoList.getFieldsJson(),urlColumns,params);
		params.put("dialgColumns", colsHtml);
		params.put("urlColumns",urlColumns);
		//产生搜索条件的Html
		String searchHtml=getSearchHtml(sysBoList.getSearchJson(),params);
		params.put("searchHtml",searchHtml);

		//返回json字段。
		JSONArray fieldRtn = getRtnJson(sysBoList);
		params.put("fieldsJson",fieldRtn);
		params.put("colsJson",JSONArray.parseArray(sysBoList.getColsJson()));
		
		JSONArray searchJson=  JSONArray.parseArray(sysBoList.getSearchJson());
		JSONArray querySearchJson=getSearchJson(searchJson,"query");
		JSONArray inSearchJson=getSearchJson(searchJson,"income");
		JSONArray rapidSerchJson=getSearchJson(searchJson,"rapid_query");
		
		params.put("querySearchJson",querySearchJson);
		params.put("inSearchJson",inSearchJson);
		params.put("rapidSerchJson",rapidSerchJson);
		
		//产生快速搜索条件的Html
		String rapidSearchHtml=getRapidSearchHtml(rapidSerchJson,params);
		params.put("rapidSearchHtml",rapidSearchHtml);
		
		//产生头部的功能按钮
		JSONArray topButtonJson=getTopButtonHtml(sysBoList.getTopBtnsJson(),needSearch);
		params.put("topButtonJson",topButtonJson);
		params.put("hasButton",topButtonJson.size()>0);
		
		params.put("sysBoList", sysBoList);
		params.put("drawCellScript", StringUtils.isNotEmpty(sysBoList.getDrawCellScript())?sysBoList.getDrawCellScript():"");
		List<TreeConfig> treeConfigs=JSONArray.parseArray(sysBoList.getLeftTreeJson(), TreeConfig.class);
		if(treeConfigs!=null){
			int i=1;
			for(TreeConfig config:treeConfigs){
				if(StringUtils.isNotEmpty(config.getOrgSql())){
					String sql=new String(Base64Util.encode(config.getOrgSql().getBytes("UTF-8")));
					config.setSuitableSql(sql);
				}
				if(StringUtils.isEmpty(config.getTreeId())){
					config.setTreeId("leftTree_"+i++);
				}
				if(StringUtils.isEmpty(config.getDs())){
					config.setDs("");
				}
			}
			params.put("treeConfigs", treeConfigs);
		}
		
		TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(this.getClass());
		params.put("SysBoListUtil", sysBoListModel);
		
		//处理手机端时，不能带有跨列的字段控制
		JSONArray orgColumns=(JSONArray)params.get("colsJson");
		JSONArray destColumns=new JSONArray();
		genColumns(orgColumns,destColumns);
		params.put("mobileCols", destColumns);
		
		return params;
	}
	
	
	/**
	 * 产生对应的页面
	 * @param sysBoList
	 * @return
	 * @throws TemplateException 
	 * @throws IOException 
	 */
	public String[] genHtmlPage(SysBoList sysBoList,Map<String,Object> params) throws Exception{
		JSONArray searchArr = JSONArray.parseArray(sysBoList.getSearchJson());
		Map<String,Object> tmpParams= getGenParams(sysBoList, (searchArr.size() == 0) ? false : true);
		params.putAll(tmpParams);

		String mobileHtml=freemarkEngine.mergeTemplateIntoString("list/mobileListTemplate.ftl", params);
		String html=freemarkEngine.mergeTemplateIntoString("list/pageListTemplate.ftl", params);
		String[] htmlAry=new String[2];
		htmlAry[0]=html;
		htmlAry[1]=mobileHtml;
		return htmlAry;
	}
	
	/**
	 * 生成表单使用代码。
	 * @param sysBoList
	 * @return
	 * @throws Exception
	 */
	public String genFormHtmlPage(SysBoList sysBoList,Map<String,Object> params) throws Exception{
		Map<String,Object> tmpParams= getGenParams(sysBoList,false);
		params.putAll(tmpParams);
		String html=freemarkEngine.mergeTemplateIntoString("list/formListTemplate.ftl", params);
		return html;
	}
	
	/**
	 * 产生新列头
	 * @param orgArr
	 * @param
	 */
	private void genColumns(JSONArray orgArr,JSONArray destArr){
		if(orgArr==null) return;
		for(int i=0;i<orgArr.size();i++){
			JSONObject field=orgArr.getJSONObject(i);
			JSONArray children=field.getJSONArray("children");
			if(children==null || children.size()==0){
				destArr.add(field);
			}
			genColumns(children,destArr);
		}
	}
	
	
	public static String removeByKeys(Object ary,String keys){
		JSONArray jsonAry=(JSONArray) JSONArray.toJSON(ary);
		String[] aryKey=keys.split(",");
		for(int i=0;i<jsonAry.size();i++){
			Object obj=jsonAry.get(i);
			JSONObject json=(JSONObject)obj;
			for(String key:aryKey){
				json.remove(key);
			}
		}
		return jsonAry.toJSONString();
	}
	
	private JSONArray getSearchJson(JSONArray searchJson,String type){
		JSONArray rtnAry=new JSONArray();
		for(Object obj : searchJson){
			JSONObject field=(JSONObject)obj;
			if(StringUtils.isEmpty(field.getString("type"))){
				continue;
			}
			if(field.getString("type").equals(type)){
				rtnAry.add(field);
			}
		}
		return rtnAry;
	}

	private JSONArray getRtnJson(SysBoList sysBoList) {
		JSONArray fieldAry=JSONArray.parseArray(sysBoList.getFieldsJson());
		JSONArray fieldRtn=new JSONArray();
		for(Object obj : fieldAry){
			JSONObject field=(JSONObject)obj;
			Object isRtn= field.get("isReturn");
			if(isRtn!=null && "YES".equals(isRtn.toString())){
				fieldRtn.add(field);
			}
		}
		return fieldRtn;
	}
	
	
	/**
	 * 产生对应的页面
	 * @param sysBoList
	 * @return
	 * @throws TemplateException 
	 * @throws IOException 
	 */
	public String genTreeDlgHtmlPage(SysBoList sysBoList,Map<String,Object> params) throws IOException, TemplateException{
		params.put("sysBoList", sysBoList);
		params.put("idField", sysBoList.getIdField());
		params.put("textField", sysBoList.getTextField());
		params.put("parentField", sysBoList.getParentField()==null?"":sysBoList.getParentField());
		params.put("onlySelLeaf", StringUtils.isEmpty(sysBoList.getOnlySelLeaf())?"NO":sysBoList.getOnlySelLeaf());
		params.put("allowCheck", StringUtils.isNotEmpty(sysBoList.getMultiSelect())? sysBoList.getMultiSelect():"false");
		String html=freemarkEngine.mergeTemplateIntoString("list/treeDlgTemplate.ftl", params);
		return html;
	}
	
	public Map<String,GridHeader> getGridHeaderMap(String colJsons){
		Map<String,GridHeader> headerMap=new HashMap<String,GridHeader>();
		JSONArray columnArr=JSONArray.parseArray(colJsons);
		genGridColumnHeaders(headerMap,columnArr);
		return headerMap;
	}
	
	/**
	 * 获得表格的列头
	 * @param headerMap
	 * @param columnArr
	 */
	private void genGridColumnHeaders(Map<String,GridHeader> headerMap,JSONArray columnArr){
		for(int i=0;i<columnArr.size();i++){
			JSONObject jsonObj=columnArr.getJSONObject(i);
			JSONArray children=jsonObj.getJSONArray("children");
			if(children!=null && children.size()>0){
				genGridColumnHeaders(headerMap,children);
				continue;
			}
			String header=jsonObj.getString("header");
			String field=jsonObj.getString("field");
			String renderType=jsonObj.getString("renderType");
			String renderConf=jsonObj.getString("renderConf");
			GridHeader gh=new GridHeader();
			gh.setFieldLabel(header);
			gh.setFieldName(field);
			gh.setRenderType(renderType);
			if(StringUtils.isNotEmpty(renderConf)){
				JSONObject conf=JSONObject.parseObject(renderConf);	
				gh.setRenderConfObj(conf);
			}
			headerMap.put(field,gh);
		}
	}
	
	/**
	 * 产生表格的miniui的grid列项
	 * @param columnArr
	 * @return
	 */
	private Element genGridColumns(JSONArray columnArr,Element el,List<UrlColumn> urlColumns,Map<String,Object> params){
		for(int i=0;i<columnArr.size();i++){
			JSONObject jsonObj=columnArr.getJSONObject(i);
			JSONArray children=jsonObj.getJSONArray("children");
			
			String header=jsonObj.getString("header");
			
			if(children!=null && children.size()>0){
				
				Element subEl=new Element(Tag.valueOf("div"),"");
				subEl.attr("header",header);
				String headerAlign=jsonObj.getString("headerAlign");
				if(StringUtils.isNotEmpty(headerAlign)){
					subEl.attr("headerAlign",headerAlign);
				}
				
				Element subColumns=new Element(Tag.valueOf("div"),"");
				subColumns.attr("property","columns");
				
				genGridColumns(children,subColumns,urlColumns,params);
				subEl.appendChild(subColumns);
				el.appendChild(subEl);
				params.put("IsChildren", "YES");
			}else{
				String field=jsonObj.getString("field");
				String allowSort=jsonObj.getString("allowSort");
				String width=jsonObj.getString("width");
				String headerAlign=jsonObj.getString("headerAlign");
				String format=jsonObj.getString("format");
				String datatype=jsonObj.getString("dataType");
				String url=jsonObj.getString("url");
				String urlType=jsonObj.getString("linkType");
				String control=jsonObj.getString("control");
				String visible=jsonObj.getString("visible");
				String renderType=jsonObj.getString("renderType");
				if(StringUtils.isEmpty(urlType)) {
					urlType="openWindow";
				}
				Element columnEl=new Element(Tag.valueOf("div"),"");
				
				if(format!=null && datatype!=null){
					if("date".equals(datatype)){
						columnEl.attr("dateFormat",format);
					}else if("float".equals(datatype) || "int".equals(datatype) || "currency".equals(datatype)){
						columnEl.attr("numberFormat",format);
					}
					columnEl.attr("dataType",datatype);
				}
				
				if(StringUtils.isNotEmpty(allowSort)){
					columnEl.attr("allowSort",allowSort);
				}
				if(StringUtils.isNotEmpty(header)){
					columnEl.attr("header",header);
				}
				if(StringUtils.isNotEmpty(width)){
					columnEl.attr("width",width);
				}
				
				if(StringUtils.isNotEmpty(field)){
					columnEl.attr("field",field);
					columnEl.attr("name",field);
					if("mini-buttonedit".equals(control)){
						columnEl.attr("displayField",field);
					}
					//加入连接字段
					if(StringUtils.isNotEmpty(url)) {
						UrlColumn urlColumn=new UrlColumn(field, url, urlType);
						urlColumns.add(urlColumn);
					}
				}
				
				if(StringUtils.isNotEmpty(headerAlign)){
					columnEl.attr("headerAlign",headerAlign);
				}
				columnEl.text(header);
				el.appendChild(columnEl);
				//若配置了编辑器框，则生成带有编辑控件
				String controlConf=jsonObj.getString("controlConf");
				//String control=jsonObj.getString("control");
				if(StringUtils.isNotEmpty(control)){
					JSONObject controlConfJson = new JSONObject();
					if(StringUtils.isNotEmpty(controlConf)) {
						controlConfJson=JSONObject.parseObject(controlConf);
					}
					GridColEditParseHandler handler=gridColEditParseConfig.getControlParseHandler(control);
					Element editor=handler.parse(columnEl,controlConfJson, params);
					if(editor!=null){
						columnEl.appendChild(editor);
					}
				}
				
				if(StringUtils.isNotEmpty(visible)) {
					columnEl.attr("visible",visible.equals("YES")?"true":"false");
				}
				if(StringUtil.isNotEmpty(renderType)){
					if("IMG".equals(renderType)){
						columnEl.attr("renderer","onImgRender");
					}else if("APPENDIX".equals(renderType)){
						columnEl.attr("renderer","onFileRender");
					}

				}
			}
		}
		
		return el;
	}

	
	
	/**
	 * 通过外部参数获得业务实体的SQL
	 * @param sysBoList
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String getValidSql(SysBoList sysBoList,Map<String,Object> params) throws Exception{

		String newSql=null;
		if("YES".equals(sysBoList.getUseCondSql())){
			String sql=freemarkEngine.parseByStringTemplate(params, sysBoList.getCondSqls());
			newSql=(String)groovyEngine.executeScripts(sql, params);
		}else{
			newSql=freemarkEngine.parseByStringTemplate(params, sysBoList.getSql());
		}
		//若不存在授权配置，则直接返回
		if(StringUtils.isEmpty(sysBoList.getDataRightJson())){
			return newSql;
		}
		
		JSONArray arr=JSONArray.parseArray(sysBoList.getDataRightJson());
		if(arr==null || arr.size()==0){
			return newSql;
		}
		//若需要进行授权，则在外面需要嵌多一层集合数据以进行数据权限的过滤
		StringBuffer sb=new StringBuffer("select * from (");
		//取得最后的order by 
		String orderBy=null;
		String alias=null;
		int lastOrderBy=newSql.toUpperCase().indexOf(" ORDER BY ");
		
		if(lastOrderBy!=-1){
			orderBy=newSql.substring(lastOrderBy);
			int dotIndex=orderBy.indexOf(".");
			if(dotIndex!=-1){
				alias=orderBy.substring(10,dotIndex);
			}
			newSql=newSql.substring(0,lastOrderBy);
		}
		
		if(orderBy==null){
			orderBy="";
		}
		if(alias==null){
			alias="_tmp";
		}
		sb.append(newSql).append(") ").append(alias).append(" where 1=1 ");
		//权限SQL
		sb.append(" and (");
		String rightSql=getPermissionSql(arr, alias);
		sb.append(rightSql.toString());
		sb.append(")");
		
		sb.append(orderBy);
		return sb.toString();
	}
	
	private String getPermissionSql(JSONArray arr,String alias){
		IUser curUser=ContextUtil.getCurrentUser();
		StringBuffer conSb=new StringBuffer();
		for(int i=0;i<arr.size();i++){
			JSONObject obj=arr.getJSONObject(i);
			String field=obj.getString("field");
			String scope=obj.getString("scope");
			
			if(SysBoEnt.FIELD_CREATE_BY.equals(field)){//按创建用户查询
				if("SELF".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append( "."+SysBoEnt.FIELD_CREATE_BY+"='").append(curUser.getUserId()).append("'");
					continue;
				}
				String upLowPath=curUser.getUserUpLowPath();
				//若路径为空，则只能看到自己本身的数据
				if(StringUtils.isEmpty(upLowPath)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+ SysBoEnt.FIELD_CREATE_BY +"='").append(curUser.getUserId()).append("'");
					continue;
				}
				//直属上级用户
				if("DUP_USERS".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+SysBoEnt.FIELD_CREATE_BY+" in ").append("(select PARTY1_ from OS_REL_INST oi where oi.PATH_='"+upLowPath+"' and oi.REL_TYPE_ID_='3')");
				}
				//所有上级用户
				else if("UP_USERS".equals(scope)){
					String parentPath=StringUtil.getParentPath(upLowPath);
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+SysBoEnt.FIELD_CREATE_BY+" in ").append("(").append(StringUtil.getArrCharString(parentPath)).append(")");
				}
				//直属下级用户
				else if("DDOWN_USERS".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+SysBoEnt.FIELD_CREATE_BY+" in ").append("(select PARTY2_ from OS_REL_INST oi where oi.PARTY1_='"+curUser.getUserId()+"' and oi.REL_TYPE_ID_='3')");
				}else if("DOWN_USERS".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+ SysBoEnt.FIELD_CREATE_BY +" in (select PARTY2_ from OS_REL_INST oi where oi.PATH_ like '"+curUser.getUserUpLowPath()+"%')");
				}
			}else if(SysBoEnt.FIELD_GROUP .equals(field)){//按用户组查找
				String curDepId=curUser.getMainGroupId();
				if(curDepId==null){
					curDepId="0";
					continue;
				}
				OsGroup mainGroup=((OsUser)curUser).getMainDep();
				//默认部门
				if("SELF_DEP".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+ SysBoEnt.FIELD_GROUP +"='").append(curDepId).append("'");
					continue;
				}
				//直属上级部门
				else if("DUP_DEPS".equals(scope)){
					//取得上级部门
					OsGroup upGroup=osGroupManager.get(mainGroup.getParentId());
					String parentGpId=(upGroup!=null)?upGroup.getGroupId():"0";
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_GROUP+"='").append(parentGpId).append("'");
				}else if("UP_DEPS".equals(scope)){//所有上级部门
					String groupPath=StringUtils.isEmpty(mainGroup.getPath())?"-1":mainGroup.getPath();//若当前的目录路径为空,则让他找不到数据
					String parentPath=StringUtil.getParentPath(groupPath);
					String idArr=StringUtil.getArrCharString(parentPath);
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_GROUP+" in ("+idArr+")");
				}
				//直接下级
				else if("DDOWN_DEPS".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_GROUP+" in (select group_id_ from os_group p where p.parent_id_='"+mainGroup.getGroupId()+"')");
				}else if("DOWN_DEPS".equals(scope)){
					String groupPath=StringUtils.isEmpty(mainGroup.getPath())?"-1":mainGroup.getPath();//若当前的目录路径为空,则让他找不到数据
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+ SysBoEnt.FIELD_GROUP +" in (select group_id_ from os_group p where p.path_ like '"+groupPath+"%')");
				}
			}else if (SysBoEnt.FIELD_TENANT .equals(field)){//按机构查询
				String curTenantId=curUser.getTenant().getTenantId();
				if(curTenantId==null){
					curTenantId="0";
					continue;
				}
				SysInst itenant=(SysInst)curUser.getTenant();
				
				if("SELF_TENANT".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias)
					.append("."+SysBoEnt.FIELD_TENANT+"='").append(curTenantId).append("'");
					continue;
				}else if("DUP_TENANTS".equals(scope)){
					//取得上级机构 
					SysInst pInst=sysInstManager.get(itenant.getParentId());
					String pInstId=(pInst!=null)?pInst.getInstId():"0";
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_TENANT+"='").append(pInstId).append("'");
				}else if("UP_TENANTS".equals(scope)){//所有上级部门
					//取得上级机构 
					SysInst pInst=sysInstManager.get(itenant.getParentId());
					String pPath=StringUtils.isEmpty(pInst.getPath())?"-1":pInst.getPath();//若当前的目录路径为空,则让他找不到数据
					String parentPath=StringUtil.getParentPath(pPath);
					String idArr=StringUtil.getArrCharString(parentPath);
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_TENANT+" in ("+idArr+")");
				}else if("DDOWN_TENANTPS".equals(scope)){
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_TENANT+" in (select inst_id_ from sys_inst p where p.parent_id_='"+curTenantId+"')");
				}else if("DOWN_TENANTS".equals(scope)){
					String pPath=StringUtils.isEmpty(itenant.getPath())?"-1":itenant.getPath();//若当前的目录路径为空,则让他找不到数据
					if(conSb.length()>0){
						conSb.append(" or ");
					}
					conSb.append(alias).append("."+SysBoEnt.FIELD_TENANT+" in (select inst_id_ from sys_inst p where p.path_ like '"+pPath+"%')");
				}
			}
		}
		return conSb.toString();
		
	}
	
	/**
	 * 返回sql的查询结果
	 * @param sql
	 * @param page
	 * @return
	 */
	public PageList<Map<String,Object>> getPageDataBySql(String sql,Page page){
		//获得SQL数据结果并分页
		PageList<Map<String,Object>> results=commonDao.query(sql, null, page);
		return results;
	}
	
	public PageList<Map<String,Object>> getPageDataBySql(String sql,QueryFilter filter){
		return commonDao.queryDynamicList(sql, filter,null);
	}
	
	public List getDataBySql(String sql,QueryFilter filter) throws SQLException{
		List list= commonDao.queryForList(sql, filter, null);
		for(Object row:list){
			Map<String,Object> o=(Map<String,Object>)row;
			handRow( o);
		}
		return list;
	}
	
	private void handRow(Map<String,Object> row) throws SQLException{
		for (Map.Entry<String, Object> ent : row.entrySet()) {
			Object obj=ent .getValue();
			if (obj instanceof TIMESTAMP) {
				Date date= getOracleTimestamp((TIMESTAMP)obj);
				row.put(ent.getKey(), date);
			}
		}
	}
	
	private Date  getOracleTimestamp(TIMESTAMP value) throws SQLException { 
		return value.dateValue();
	}
	
	public SysBoList getByKey(String key){
		String tenantId=ContextUtil.getCurrentTenantId();
		return getByKey(key, tenantId);
	}
	
	public Long insertData(List<Map<String,Object>> dataList,SysBoEnt boent){
		String tableName = boent.getTableName();
		long l = 0 ;
		String pkField = boent.getPkField();
		for(Map<String,Object> data:dataList){
			StringBuffer keysb = new StringBuffer();
			StringBuffer valuesb = new StringBuffer();
			
			Map<String,Object> params=new HashMap<String, Object>();
			keysb.append(pkField).append(",");
			valuesb.append("#{"+pkField+"},");
			params.put(pkField,IdUtil.getId());
			for(Map.Entry<String, Object> entry:data.entrySet()){
				if(pkField.contains(entry.getKey())) {
					params.put(pkField,entry.getValue());
					continue;
				}
				keysb.append(entry.getKey()).append(",");
				valuesb.append("#{").append(entry.getKey()).append("},");
				params.put(entry.getKey(),entry.getValue());

			}
			if(!boent.isDbMode()){
				if(keysb.indexOf(SysBoEnt.FIELD_CREATE_BY )==-1) {
					keysb.append(SysBoEnt.FIELD_CREATE_BY ).append(",");
					valuesb.append("#{"+SysBoEnt.FIELD_CREATE_BY +"},");
					params.put(SysBoEnt.FIELD_CREATE_BY ,ContextUtil.getCurrentUserId());
				}
				if(keysb.indexOf(SysBoEnt.FIELD_CREATE_TIME )==-1) {
					keysb.append(SysBoEnt.FIELD_CREATE_TIME).append(",");
					valuesb.append("#{"+SysBoEnt.FIELD_CREATE_TIME+"},");
					params.put(SysBoEnt.FIELD_CREATE_TIME,new Date());
				}
			}
			if(keysb.length()>0){
				keysb.deleteCharAt(keysb.length()-1);
				valuesb.deleteCharAt(valuesb.length()-1);
			}
			String sql = "insert into "+tableName+" ("+keysb+") values ("+valuesb+")" ;
			commonDao.execute(sql, params);
			l++;
		}
		return l;
	}

	/**
	 * 根据boId获取需要导出的对象。
	 * @param boKeys
	 * @param isDialog
	 * @return
	 */
	public List<SysBoList> getSysBoListByIds(String[] boKeys, String isDialog) {
		String tenantId=ContextUtil.getCurrentTenantId();
		List< SysBoList> list=new ArrayList<SysBoList>();
		for (String boKey : boKeys) {
			if("true".equals(isDialog)) {//对话框
				SysBoList sysBoList = getByKey(boKey,tenantId);
	
				if(BeanUtil.isEmpty(sysBoList)) continue;
				list.add(sysBoList);
			}
		}
		return list;
	}

	/**
	 * 
	 * @param file
	 */
	public void doImport(MultipartFile file) throws Exception{
		
		ProcessHandleHelper.initProcessMessage();
		
		List<SysBoList>   list=getBpmSolutionExts(file);
		String tenantId = ContextUtil.getCurrentTenantId();
		for(SysBoList sysBoList:list){
			doImport( sysBoList, tenantId);
		}
	}
	
	/**
	 * 读取上传的对象。
	 * @param file
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	private List<SysBoList> getBpmSolutionExts(MultipartFile file) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("sysBoList", SysBoList.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<SysBoList> list=new ArrayList<SysBoList>();

		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysBoList sysBoList = (SysBoList) xstream.fromXML(xml);
			list.add(sysBoList);
		}
		zipIs.close();
		return list;
	
	}
	
	/**
	 * 流程方案的导入
	 * @param sysBoList
	 * @param tenantId
	 * @throws Exception
	 */
	private void doImport(SysBoList sysBoList,String tenantId) throws Exception{
		
		sysBoList.setTenantId(tenantId);
		
		/**
		 * 如果方案已经存在则直接退出。
		 * 这里对方案的 租户ID进行修改。
		 */
		/*sysBoList.setId(IdUtil.getId()); 
		Boolean isExist= isKeyExist(sysBoList.getKey(), tenantId, sysBoList.getId());
		if(isExist){
			ProcessHandleHelper.addErrorMsg(sysBoList.getName() + "业务列表已经存在!");
			return;
		}*/
		//Id不发生变化，以防引用的表单找不到，modify by Louis
		Boolean isExist = isKeyExist2(sysBoList.getKey(), tenantId, sysBoList.getId());
		if(isExist) {
			return;
		}
		//对话框
		sysBoListDao.create(sysBoList);
      
	}
	
	//writed by Louis
	public boolean isKeyExist2(String key, String tenantId, String pkId){
		SysBoList sysBoList=getByKey(key,tenantId);
		//为空表示没找到就是不存在
		if(BeanUtil.isNotEmpty(sysBoList)){
			ProcessHandleHelper.addErrorMsg(sysBoList.getName() + "业务列表已经存在相同别名!");
			return true;
		}
		List<SysBoList> boLists = getAll();
		for(SysBoList li : boLists) {
			if(li.getId().equals(pkId)) {
				ProcessHandleHelper.addErrorMsg(sysBoList.getName() + "业务列表已经存在导入数据的主键!");
				return true;
			}
		}
		return false;
	}
	
	/**
     * 从缓存或数据中获得bo对象
     * @param boKey
     * @return
     */
    private  SysBoList getCurBoList(String boKey){
    	String domain=ContextUtil.getTenant().getDomain();
		SysBoList sysBoList=(SysBoList)CacheUtil.getCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ domain);
		if(sysBoList==null){
			sysBoList =getByKey(boKey, ContextUtil.getCurrentTenantId());
			updSysBoList( sysBoList);
			//放置于缓存
			CacheUtil.addCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ domain, sysBoList);
		}
		return sysBoList;
	}
    
    /**
     * 共享缓存 指的是平台给其他租户使用。
     * @param boKey
     * @return
     */
    private SysBoList getPlatformBoList(String boKey){
    	String platformDomain=WebAppUtil.getOrgMgrDomain();
		SysBoList sysBoList=(SysBoList)CacheUtil.getCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ platformDomain);
		if(sysBoList==null){
			sysBoList =getByKey(boKey, ITenant.ADMIN_TENANT_ID);
			updSysBoList( sysBoList);
			//放置于缓存
			CacheUtil.addCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ platformDomain, sysBoList);
		}
		return sysBoList;
	}
    
    private void updSysBoList(SysBoList sysBoList){
    	//在Bo中增加缓存的按钮处理
		if(StringUtils.isNotEmpty(sysBoList.getTopBtnsJson())){
			List<SysBoTopButton> buttons=JSONArray.parseArray(sysBoList.getTopBtnsJson(), SysBoTopButton.class);
			sysBoList.getTopButtonMap().clear();
			for(SysBoTopButton btn:buttons){
				sysBoList.getTopButtonMap().put(btn.getBtnName(), btn);
			}
		}
		
		//在Bo中增加左树的缓存处理
		if(StringUtils.isNotEmpty(sysBoList.getLeftTreeJson())){
			List<TreeConfig> trees=JSONArray.parseArray(sysBoList.getLeftTreeJson(), TreeConfig.class);
			sysBoList.getLeftTreeMap().clear();
			for(TreeConfig conf:trees){
				sysBoList.getLeftTreeMap().put(conf.getTreeId(), conf);
			}
		}

    }
    
    /**
     * 根据bokey 和是否共享获取数据。
     * @param boKey
     * @return
     */
    public SysBoList getBoList(String boKey){
    	SysBoList boList= getCurBoList( boKey);
    	if(boList==null){
    		boList=getPlatformBoList(boKey);
    	}
    	return boList;
    	
    	
    }
  
	
}
