package com.redxun.sys.bo.manager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.core.dao.IDao;
import com.redxun.core.database.api.ITableMeta;
import com.redxun.core.database.api.ITableOperator;
import com.redxun.core.database.api.model.Column;
import com.redxun.core.database.api.model.Table;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.database.model.DefaultColumn;
import com.redxun.core.database.model.DefaultTable;
import com.redxun.core.database.util.DbUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.dao.SysBoAttrDao;
import com.redxun.sys.bo.dao.SysBoEntDao;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.parse.BoAttrParseFactory;
import com.redxun.sys.bo.manager.parse.IBoAttrParse;
import com.redxun.sys.bo.manager.parse.impl.AttrParseUtil;

/**
 * 
 * <pre> 
 * 描述：表单实体对象 处理接口
 * 作者:ray
 * 日期:2017-02-15 15:02:18
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysBoEntManager extends MybatisBaseManager<SysBoEnt>{
	@Resource
	private SysBoEntDao sysBoEntDao;
	@Resource
	private SysBoAttrDao sysBoAttrDao;
	@Resource
	private ITableOperator  tableOperator;
	@Resource
	private BoAttrParseFactory boAttrParseFactory;
	@Resource
	JdbcTemplate jdbcTemplate;
	@Resource
	BpmFormViewDao bpmFormViewDao;
	@Resource
	SysBoRelationManager sysBoRelationManager;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Override
	protected IDao getDao() {
		return sysBoEntDao;
	}
	

	
	
	/**
	 * 解析html
	 * @param html
	 * @return
	 */
	public  SysBoEnt parseHtml(String html){
		SysBoEnt boEnt=new SysBoEnt();
		
		Document doc=Jsoup.parseBodyFragment(html);
		//先解析子表
		Elements  tables= doc.select("[plugins=\"rx-grid\"]");
		Iterator<Element> tableIt=tables.iterator();
		while(tableIt.hasNext()){
			Element tableEl=tableIt.next();
			
			Element tbEl=tableEl;
			
			SysBoEnt childEnt=new SysBoEnt();
			//处理子表数据
			parseEnt(childEnt,tableEl);

			String tableName=SysBoEntManager.getTableName(childEnt.getName());
			childEnt.setTableName(tableName.replace(" ",""));
			//设置类型
			childEnt.setRelationType(SysBoRelation.RELATION_ONETOMANY);
			
			tableEl.removeAttr("plugins");
			//解析明细表单。edittype="openwindow"
			String editType=tableEl.attr("edittype");
			//弹出表单单独处理不需要解析其中的字段。
			if(StringUtil.isNotEmpty(editType) && "editform".equals(editType)){
				String tenantId=ContextUtil.getCurrentTenantId();
				String formAlias=tableEl.attr("formkey");
				BpmFormView formView= bpmFormViewDao.getByAlias(formAlias, tenantId);
				String boDefId=formView.getBoDefId();
				SysBoEnt subEnt=this.getByBoDefId(boDefId, true);
				childEnt.setSysBoAttrs(subEnt.getSysBoAttrs());
				//设置关联表单别名。
				childEnt.setFormAlias(formAlias);
				//为引用实体。
				childEnt.setIsRef(1);

				boEnt.addBoEnt(childEnt);
				//删除子表
				tableEl.remove();
				continue;
			}
			
			if(StringUtil.isNotEmpty(editType) && "openwindow".equals(editType)){
				Elements  detailWindow=tableEl.select(".mini-window");
				if(detailWindow.size()>0){
					tableEl=detailWindow.first();
				}
			}
			
			Elements fields = tableEl.select("[plugins]");
			
			//处理子表字段,取行的控件
			if(BeanUtil.isNotEmpty(fields)){
				handFields(fields, childEnt);
			}
			else{
				//<th class="header" width="200" header="pk_elem_name"
				Elements  els= tableEl.select("th[header]");
				handHeaderFields(els,childEnt);
			}
			
			
			boEnt.addBoEnt(childEnt);
			
			//删除子表
			tbEl.remove();
		}
		//解析 onetoone
		Elements  oneToOneEls= doc.select("[relationtype=\"onetoone\"]");
		Iterator<Element> oneToOneIt=oneToOneEls.iterator();
		while(oneToOneIt.hasNext()){
			Element oneToOneEl=oneToOneIt.next();
			String tableName=oneToOneEl.attr("tablename");
			String comment=oneToOneEl.attr("comment");
			
			SysBoEnt childEnt=new SysBoEnt();
			childEnt.setName(tableName);
			childEnt.setComment(comment);
			
			childEnt.setRelationType(SysBoRelation.RELATION_ONETOONE);
			
			Elements  elements= oneToOneEl.select("[plugins]");
			handFields(  elements, childEnt);
			
			boEnt.addBoEnt(childEnt);
			oneToOneEl.remove();
		}
		
		
		//再解析主表字段
		Elements  elements= doc.select("[plugins]");
		handFields(  elements, boEnt);
		
		return boEnt;
	}
	
	/**
	 * 处理子表数据。
	 * @param boEnt
	 * @param tableEl
	 */
	private static void parseEnt(SysBoEnt boEnt, Element tableEl){
		String label=tableEl.attr("label");
		String name=tableEl.attr("name");
		//是否树形
		String treegrid=tableEl.attr("treegrid");
		String requireformfield=tableEl.attr("requireformfield");
		boEnt.setName(name.replace(" ",""));
		boEnt.setComment(label);
		String tableName=SysBoEntManager.getTableName(boEnt.getName());
		boEnt.setTableName(tableName.replace(" ",""));

		JSONObject json=new JSONObject();
		// 子表必填。
		if(StringUtil.isNotEmpty( requireformfield) && "true".equals(requireformfield)) {
			json.put("required", true);
		}
		boEnt.setExtJson(json.toJSONString());
		if(StringUtil.isEmpty(treegrid)){
			treegrid="NO";
		}
		else{
			treegrid="true".equals(treegrid)?"YES":"NO";
		}
		boEnt.setTree(treegrid);
		
	}
	
	/**
	 * 解析字段。
	 * @param elements
	 * @param ent
	 */
	private static void handFields(Elements  elements,SysBoEnt ent){
		BoAttrParseFactory factory=(BoAttrParseFactory)AppBeanUtil.getBean("boAttrParseFactory");
		for(Element el:elements){
			String pluginName=el.attr("plugins");
					
			IBoAttrParse parse=factory.getByPluginName(pluginName);
			if(parse==null) continue;
			SysBoAttr  formField=parse.parse(pluginName, el);
			
			ent.addBoAttr(formField);
		}
	}
	
	private static void handHeaderFields(Elements  elements,SysBoEnt ent){
		for(Element el:elements){
			SysBoAttr  boAttr=new SysBoAttr();
			boAttr.setControl("mini-textbox");
			boAttr.setName(el.attr("header").trim());
			boAttr.setComment(el.text().trim());
			ent.addBoAttr(boAttr);
		}
	}
	
	public SysBoEnt getByBoDefId(String boDefId){
		return this.getByBoDefId(boDefId, true);
	}
	
	public List<SysBoEnt> getEntitiesByBoDefId(String boDefId){
		return sysBoEntDao.getByBoDefId(boDefId);
	}
	
	/**
	 * 获取主BOENT对象。
	 * @param boDefId
	 * @return
	 */
	public SysBoEnt getMainByBoDefId(String boDefId){
		List<SysBoEnt> list= sysBoEntDao.getByBoDefId(boDefId);
		SysBoEnt mainEnt= getMain( list);
		List<SysBoAttr> mainAttrs=  sysBoAttrDao.getAttrsByEntId(mainEnt.getId());
		mainEnt.setSysBoAttrs(mainAttrs);
		return mainEnt;
	}
	
	/**
	 * 获得指定主Bo中的指定名的子Bo
	 * @param  mainBoDefId
	 * @param boAttrName 子bo的属性名
	 * @return
	 */
	public SysBoEnt getSubEntByMainBoDefId(String mainBoDefId,String boAttrName){
		List<SysBoEnt> list= sysBoEntDao.getByBoDefId(mainBoDefId);
		for(SysBoEnt ent:list){
			if(boAttrName.equals(ent.getName())){
				List<SysBoAttr> mainAttrs=  sysBoAttrDao.getAttrsByEntId(ent.getId());
				ent.setSysBoAttrs(mainAttrs);
				return ent;
			}
		}
		return null;
	}
	
	/**
	 * 删除由数据库产生的实体一些字段。
	 * @param boent
	 */
	public void removeEntRefFields(SysBoEnt boent){
   	 removeRefFields(boent);
   	 List<SysBoEnt> ents=boent.getBoEntList();
   	 for(SysBoEnt ent:ents){
   		 removeRefFields(ent);
   	 }
   }
   
   
   private void removeRefFields(SysBoEnt boent){
   	 if(!boent.isDbMode()) return;
   	 Iterator<SysBoAttr> it = boent.getSysBoAttrs().iterator();
        while (it.hasNext()) {
       	 SysBoAttr attr = it.next();
            if ("mini-ref".equals(attr.getControl()) || "mini-commonfield".equals(attr.getControl()) || attr.getName().equals(boent.getPkField()) || attr.getName().equals(boent.getParentField())) {
                it.remove();
            }
        }
   }
	
	/**
	 * 根据boDefId获取BOENT对象。
	 * @param boDefId
	 * @return
	 */
	public SysBoEnt getByBoDefId(String boDefId,boolean needAttr){
		if(StringUtils.isEmpty(boDefId)){
			return null;
		}
		List<SysBoEnt> list= sysBoEntDao.getByBoDefId(boDefId);
		
		SysBoEnt mainEnt= getMain( list);
		if(mainEnt==null){
			return new SysBoEnt();
		}
		if(needAttr){
			List<SysBoAttr> mainAttrs=  sysBoAttrDao.getAttrsByEntId(mainEnt.getId());
			mainEnt.setSysBoAttrs(mainAttrs);
		}
		
		List<SysBoEnt> subList= getSub( list);
		
		if(needAttr){
			if(BeanUtil.isNotEmpty(subList)){
				for(SysBoEnt subEnt:subList){
					List<SysBoAttr> subAttrs=  sysBoAttrDao.getAttrsByEntId(subEnt.getId());
					subEnt.setSysBoAttrs(subAttrs);
				}
			}
		}
		
		mainEnt.setBoEntList(subList);
		
		return mainEnt;
	}
	
	public List<SysBoEnt> getListByBoDefId(String boDefId,boolean needAttr){
		List<SysBoEnt> list= sysBoEntDao.getByBoDefId(boDefId);
		if(needAttr){
			for(SysBoEnt ent:list){
				List<SysBoAttr> mainAttrs=  sysBoAttrDao.getAttrsByEntId(ent.getId());
				ent.setSysBoAttrs(mainAttrs);
			}
		}
		return list;
	}
	
	public SysBoEnt getMain(List<SysBoEnt> list){
		for(SysBoEnt ent:list){
			if(SysBoRelation.RELATION_MAIN .equals(ent.getRelationType())){
				return ent;
			}
		}
		return null;
	}
	
	public List<SysBoEnt> getSub(List<SysBoEnt> list){
		List<SysBoEnt> rtnList=new ArrayList<SysBoEnt>();
		for(SysBoEnt ent:list){
			if(!SysBoRelation.RELATION_MAIN.equals(ent.getRelationType())){
				rtnList.add(ent);
			}
		}
		return rtnList;
	}
	
	/**
	 * 将属性的BO ENT返回为列表，方便在浏览器端显示。
	 * @param boEnt
	 * @return
	 */
	public List<SysBoEnt> getListByBoEnt(SysBoEnt boEnt,boolean clearSubEnt){
		List<SysBoEnt> list=new ArrayList<SysBoEnt>();
		list.add(boEnt);
		for(SysBoEnt ent:boEnt.getBoEntList()){
			ent.setTableName(SysBoEntManager.getTableName(ent.getName()).replace(" ",""));
			list.add(ent);
		}
		//是否清除子表。
		if(clearSubEnt){
			boEnt.clearSubBoEnt();
		}
		//
		return list;
	}
	
	/**
	 * 两个SysBoEnt进行合并。
	 * @param baseEnt
	 * @param curEnt
	 */
	public void merageBoEnt(SysBoEnt baseEnt,SysBoEnt curEnt){
		//合并属性
		List<SysBoAttr> baseAttrs=baseEnt.getSysBoAttrs();
		//当前属性
		List<SysBoAttr> curAttrs=curEnt.getSysBoAttrs();
		//合并属性。
		diffBoAttrs(baseEnt,baseAttrs,curAttrs);
		
		baseEnt.setVersion(SysBoDef.VERSION_BASE);
		
		baseEnt.setExtJson(curEnt.getExtJson());
		
		baseEnt.setRelationType(curEnt.getRelationType());
		
		baseEnt.setComment(curEnt.getComment());
		baseEnt.setTableName(curEnt.getTableName() );

		
		//合并子表。
		List<SysBoEnt>  baseEnts=baseEnt.getBoEntList();
		List<SysBoEnt> curEnts=curEnt.getBoEntList();
		
		Map<String,SysBoEnt> baseMaps= convertToEntMap(baseEnts);
		for(SysBoEnt ent:curEnts){
			String name=ent.getName().toLowerCase();
			//不存在的情况
			if(!baseMaps.containsKey(name)){
				baseEnts.add(ent);
			}
			//已存在的子表合并子表属性
			else{
				SysBoEnt baseBoEnt=baseMaps.get(name);
				baseBoEnt.setFormAlias(ent.getFormAlias());
				baseBoEnt.setIsRef(ent.getIsRef());
				baseBoEnt.setExtJson(ent.getExtJson());
				baseBoEnt.setTree(ent.getTree());
				if(1!=ent.getIsRef()){
					List<SysBoAttr> baseSubAttrs=baseBoEnt.getSysBoAttrs();
					List<SysBoAttr> curSubAttrs=ent.getSysBoAttrs();
					//对象合并。
					diffBoAttrs(baseBoEnt,baseSubAttrs,curSubAttrs);	
				}
			}
		}
	}
	
	/**
	 * 将ENT列表转成map对象。
	 * @param ents
	 * @return
	 */
	private Map<String,SysBoEnt> convertToEntMap(List<SysBoEnt>  ents){
		Map<String,SysBoEnt> maps=new HashMap<String, SysBoEnt>();
		for(SysBoEnt ent:ents){
			ent.setVersion(SysBoDef.VERSION_BASE);
			maps.put(ent.getName().toLowerCase(), ent);
		}
		return maps;
	}
	
	
	
	/**
	 * 将列表转成map对象。
	 * @param attrs
	 * @return
	 */
	private Map<String, SysBoAttr> convertToMap(List<SysBoAttr>  attrs){
		Map<String,SysBoAttr> maps=new HashMap<String, SysBoAttr>();
		for(SysBoAttr attr:attrs){
			maps.put(attr.getName().toLowerCase(), attr);
		}
		return maps;
	}
	
	private void diffBoAttrs(SysBoEnt boEnt, List<SysBoAttr>  baseAttrs,List<SysBoAttr>  curBoAttrs){
		
		//基础的属性版本。
		for(SysBoAttr attr:baseAttrs){
			attr.setStatus(SysBoDef.VERSION_BASE);
		}
		Map<String, SysBoAttr>  baseMap= convertToMap(baseAttrs);
		String preColumn=DbUtil.getColumnPre();
		for(SysBoAttr attr:curBoAttrs){
			if(attr.isContain()){
				baseAttrs.add(attr);
				boEnt.setHasConflict(true);
				continue;
			}
			String name=attr.getName().toLowerCase();
			
			if(baseMap.containsKey(name)){
				SysBoAttr baseAttr=baseMap.get(name);
				//用回新的字段名称主要因为字段有大小写的问题。
				baseAttr.setName(attr.getName());
				baseAttr.setFieldName(preColumn + attr.getName());
				
				baseAttr.setIsSingle(attr.getIsSingle());
				//变换属性版本
				if(!attr.equals(baseAttr)){
					baseAttr.setStatus(SysBoDef.VERSION_DIFF);
					String diffContent= getDiffContent( baseAttr,attr);
					baseAttr.setDiffConent(diffContent);
				}
				//复制新对象属性。
				baseAttr.setControl(attr.getControl());
				baseAttr.setDataType(attr.getDataType());
				baseAttr.setComment(attr.getComment());
				baseAttr.setLength(attr.getLength());
				baseAttr.setDecimalLength(attr.getDecimalLength());
				baseAttr.setExtJson(attr.getExtJson());
			}
			else{
				baseAttrs.add(attr);
			}
		}
	}
	
	private String getDataType(SysBoAttr attr){
		String dataType=attr.getDataType();
		if(attr.getDataType().equals(Column.COLUMN_TYPE_VARCHAR)){
			dataType=attr.getDataType() +"("+ attr.getLength() +")";
		}
		if(attr.getDataType().equals(Column.COLUMN_TYPE_NUMBER)){
			dataType=attr.getDataType() +"("+ attr.getLength() +"," + attr.getDecimalLength() +")";
		}
		return dataType;
	}
	
	/**
	 * 获取内容。
	 * @param baseAttr
	 * @param curAttr
	 * @return
	 */
	private String getDiffContent(SysBoAttr baseAttr,SysBoAttr curAttr){
		JSONObject json=new JSONObject();
		
		JSONObject ctlJson=new JSONObject();
		
		ctlJson.put("base", baseAttr.getControl());
		ctlJson.put("new", curAttr.getControl());
		
		json.put("control", ctlJson);
		
		JSONObject dateTypeJson=new JSONObject();
		
		String baseType=getDataType(baseAttr);
		String newType=getDataType(curAttr);;
		
		dateTypeJson.put("base", baseType);
		dateTypeJson.put("new", newType);
		
		json.put("dataType", dateTypeJson);
		
		return json.toJSONString();
			
	}
	
	/**
	 * 检测实体是否存在。
	 * @param list
	 * @return
	 */
	public JsonResult isEntExist(List<SysBoEnt> list){
		JsonResult result=new JsonResult(true);
		String msg="下列实体已存在:";
		for(SysBoEnt ent:list){
			if(ent.getIsRef()==1) continue;
			boolean isExist=isEntExist(ent);
			if(isExist){
				result.setSuccess(false);
				msg+=" " +ent.getName();
			}
		}
		if(!result.isSuccess()){
			result.setMessage(msg);
		}
		return result;
	}
	
	/**
	 * 实体是否存在。
	 * @param ent
	 * @return
	 */
	private boolean isEntExist(SysBoEnt ent){
		String tenantId=ent.getTenantId();
		if(StringUtil.isEmpty(tenantId)){
			String curTenantId=ContextUtil.getCurrentTenantId();
			ent.setTenantId(curTenantId);
		}
		Integer rtn= sysBoEntDao.getCountByAlias(ent.getName(), ent.getTenantId(), ent.getId());
		return rtn>0;
	}
	
	/**
	 * 检查表是否存在。
	 * @param ents
	 * @return
	 */
	public JsonResult  isTableExist(List<SysBoEnt> ents){
		JsonResult result=new JsonResult(true);
		if(BeanUtil.isEmpty(ents)) return result;
		String msg="下列物理表已存在:";
		for(SysBoEnt ent:ents){
			//为实体引用的情况。
			if(ent.getIsRef()==1) continue;
			
			String tableName=ent.getTableName();
			boolean isExist=tableOperator.isTableExist(tableName);
			if(isExist){
				result.setSuccess(false);
				msg+=" " +ent.getName();
			}
		}
		if(!result.isSuccess()){
			result.setMessage(msg);
		}
		return result;
	}
	
	/**
	 * 使用BOENT创建列。
	 * @param boEnt
	 * @throws SQLException
	 */
	public void createTable(SysBoEnt boEnt) throws SQLException{
		List<Table> tables= getTablesByBoEnt( boEnt);
		for(Table table:tables){
			if(!tableOperator.isTableExist(table.getTableName())) {
				tableOperator.createTable(table);
				//创建索引
				if(!table.isMain()){
					tableOperator.createIndex(table.getEntName() +"_ref", table.getTableName(), "ref_id_");
				}
			}
			
		}
	}
	
	
	/**
	 * 创建单个表。
	 * @param boEnt
	 * @throws SQLException
	 */
	public void createSingleTable(SysBoEnt boEnt) throws SQLException{
		Table table= getTableByEnt( boEnt);
		tableOperator.createTable(table);
	}
	
	/**
	 * 根据层次结构的boent获取表对象。
	 * @param boEnt
	 * @return
	 */
	public List<Table> getTablesByBoEnt(SysBoEnt boEnt){
		List<Table> list=new ArrayList<Table>();
		
		Table table= getTableByEnt( boEnt);
		table.setMain(true);
		list.add(table);
		if(BeanUtil.isNotEmpty( boEnt.getBoEntList())){
			List<SysBoEnt> boEnts=boEnt.getBoEntList();
			for(SysBoEnt ent:boEnts){
				//如果是引用的BO。
				if(ent.getIsRef()==1) continue;
				
				Table subTable= getTableByEnt( ent);
				list.add(subTable);
			}
		}
		return list;
	}
	
	/**
	 * 获得bo对应的主物理表
	 * @param boDefId
	 * @return
	 */
	public Table getMainTableByBodDefId(String boDefId){
		SysBoEnt sysBoEnt=getMainByBoDefId(boDefId);
		if(sysBoEnt==null){
			return null;
		}
		return getTableByEnt(sysBoEnt);
	}
	
	/**
	 * 根据boent 对象获取表对象。
	 * @param boEnt
	 * @return
	 */
	private Table getTableByEnt(SysBoEnt boEnt){
		if(tableOperator.isTableExist(boEnt.getTableName())) {
			SysBoEnt oldBoEnt = sysBoEntDao.getByName(boEnt.getName());
			try {
				//更新实体数据
				updEnt(boEnt, oldBoEnt);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		String columnPre= DbUtil.getColumnPre();
		Table table=new DefaultTable();
		
		table.setComment(boEnt.getComment());
		
		table.setTableName(boEnt.getTableName()); 
	
		table.setEntName(boEnt.getName());
		
		List<Column> cols=new ArrayList<Column>();
		List<SysBoAttr> boAttrs=  boEnt.getSysBoAttrs();
		
		for(Iterator<SysBoAttr> it=boAttrs.iterator();it.hasNext();){
			SysBoAttr attr=it.next();
			List<Column> col= getColsByAttr(attr,columnPre);
			cols.addAll(col);
		}
		
		List<Column> columns= getCommonCols(cols,boEnt);

		table.setColumnList(columns);
		return table;
	}
	
	/**
	 * 添加列。
	 * @param tableName
	 * @param attr
	 * @throws SQLException
	 */
	public void createColumn(String tableName, SysBoAttr attr) throws SQLException{
		String columnPre= DbUtil.getColumnPre();
		List<Column> columns= getColsByAttr( attr,  columnPre);
		for(Column col:columns){
			tableOperator.addColumn(tableName, col);
		}
	}
	
	/**
	 * 修改列字段
	 * @param tableName
	 * @param attr
	 * @throws SQLException
	 */
	public void updateColumn(String tableName,SysBoAttr attr)throws SQLException{
		String columnPre= DbUtil.getColumnPre();
		List<Column> columns= getColsByAttr( attr,  columnPre);
		for(Column col:columns){
			tableOperator.updateColumn(tableName, StringUtil.isEmpty(col.getOriginName()) ? col.getFieldName() : col.getOriginName(), col);
		}
		
	}

	/**
	 * 根据属性列获取列对象，属性有可能为复合属性，这样会生成两个列。
	 * @param attr
	 * @param columnPre
	 * @return
	 */
	private List<Column> getColsByAttr(SysBoAttr attr,String columnPre){
		List<Column> list=new ArrayList<Column>();
		Column col= getColumnByAttr( attr, columnPre,false);
		list.add(col);
		if(!attr.single()){
			 col= getColumnByAttr(attr, columnPre,true);
			 list.add(col);
		}
		return list;
	}
	
	/**
	 * 根据属性获取列对象。
	 * @param attr
	 * @param columnPre
	 * @param isComplex
	 * @return
	 */
	private Column getColumnByAttr(SysBoAttr attr,String columnPre,boolean isComplex){
		String dateType=attr.getDataType();
		Column col=new DefaultColumn();
		
		String name=isComplex ?SysBoEnt.COMPLEX_NAME:"";
		col.setFieldName(columnPre + attr.getName().toUpperCase() + name  );
		col.setOriginName(columnPre + attr.getOriginName().toUpperCase() + name);
		col.setColumnType(attr.getDataType());
		String comment=attr.getComment();
		
		if(!attr.single() && !isComplex){
			comment+="ID";
		}
		
		col.setComment(comment);
		
		if(Column.COLUMN_TYPE_VARCHAR.equals(dateType)){
			col.setCharLen(attr.getLength());
		}
		else if(Column.COLUMN_TYPE_NUMBER.equals(dateType)){
			col.setIntLen(attr.getLength());
			col.setDecimalLen(attr.getDecimalLength());
		}
		return col;
	}
	
	/**
	 *  批量保存行
	 * @param boDefId
	 * @param rowsJson
	 */
	public void batchRows(String boDefId,String rowsJson){
		SysBoEnt sysBoEnt=getMainByBoDefId(boDefId);
		Table mainTable=getMainTableByBodDefId(boDefId) ;
		String pkField=sysBoEnt.getPkField();
		String fkField=sysBoEnt.getParentField();
		Map<String,Column> colsMap=new HashMap<String,Column>();
		for(Column col:mainTable.getColumnList()){
			colsMap.put(col.getFieldName(), col);
		}
		//String pkField=mainTable.getColumnList()
		boolean isContainRefId=false;
    	JSONArray rowArr=JSONArray.parseArray(rowsJson);
    	IUser curUser=ContextUtil.getCurrentUser();
    	Map<String,String> idMap=new HashMap<String, String>();
    	for(int i=0;i<rowArr.size();i++){
    		JSONObject row=rowArr.getJSONObject(i);
    		String id=row.getString("_id");
    		
    		Iterator<String> fieldIt=row.keySet().iterator();
    		StringBuffer sqlBuffer=new StringBuffer("");
    		StringBuffer valBuffer=new StringBuffer("");
    		boolean isInsert=false;
    		String pkId=row.getString(pkField);
    		
    		if(pkId==null){
    			isInsert=true;
    			sqlBuffer.append("insert into " + mainTable.getTableName()).append("(");
    		}else{
    			sqlBuffer.append("update " + mainTable.getTableName());
    		}
    		List<Object> params=new ArrayList<Object>();
    		
    		int cn=0;
    		while(fieldIt.hasNext()){
    			String field=fieldIt.next();
    			if("REF_ID_".equals(field)){
    				isContainRefId=true;
    			}
    			if(StringUtils.isNotEmpty(field) && !field.startsWith("_")){
    				Column fieldCol=colsMap.get(field.toUpperCase());
    				if(fieldCol==null){
    					continue;
    				}
    				Object val = null; 
    				if("number".equals(fieldCol.getColumnType())){
    					val=row.getDouble(field);
    				}else if("date".equals(fieldCol.getColumnType())){
    					val=row.getDate(field);
    				}else{
    					val=row.getString(field);
    				}
    				
        			if(isInsert){
        				if(cn>0){
            				sqlBuffer.append(",");
            				valBuffer.append(",");
            			}
        				sqlBuffer.append(field);
        				valBuffer.append("?");
        				params.add(val);
        				cn++;
        			}else if(!field.equals(pkField)){
        				if(cn>0){
            				sqlBuffer.append(",");
            			}else{
            				sqlBuffer.append(" set ");
            			}
        				sqlBuffer.append(field).append("=?,");
        				params.add(val);
        				cn++;
        			}
    			}
    		}
    		
    		if(!isInsert){
    			if(cn==0){
    				sqlBuffer.append(" set ");
    			}
    			if(!sysBoEnt.isDbMode()) {
	    			sqlBuffer.append(SysBoEnt.FIELD_UPDATE_TIME).append("=?");
	    			params.add(new Date());
    			}
    			
    			sqlBuffer.append(" where ").append(pkField).append("=?");
    			params.add(pkId);
    			logger.info("sql:"+ sqlBuffer.toString());
    			jdbcTemplate.update(sqlBuffer.toString(), params.toArray());
    			
    		}else{
    			if(cn>0){
    				sqlBuffer.append(",");
    				valBuffer.append(",");
    			}
    			sqlBuffer.append(pkField);
    			//1. 插入主键ID
    			valBuffer.append("?");
    			String nPkId=IdUtil.getId();
    			params.add(nPkId);
    			idMap.put(id, nPkId);
    			if(!isContainRefId){
	    			//2 . 插入外键
    				String pField = fkField;
	    			String parentId=row.getString("_pid");
    				String pId=idMap.get(parentId);
    				if(StringUtil.isNotEmpty(sysBoEnt.getParentField())) {
    					pField = sysBoEnt.getParentField();
    					if(StringUtil.isEmpty(pId)) {
    						pId = row.getString(pField);
    					}
    				}
    				
	    			sqlBuffer.append(","+pField);
	    			valBuffer.append(",?");
	    			
	    			if("-1".equals(parentId)){
	    				params.add("0");
	    			}else{
	    				params.add(pId);
	    			}
	    			
    			}
    			
    			if(!SysBoEnt.GENMODE_DB.equals(sysBoEnt.getGenMode())){
	    			//3.插入用户ID
	    			sqlBuffer.append(",").append(SysBoEnt.FIELD_CREATE_BY);
	    			valBuffer.append(",?");
	    			params.add(curUser.getUserId());
	    			//4.组ID
	    			sqlBuffer.append(",").append(SysBoEnt.FIELD_GROUP);
	    			valBuffer.append(",?");
	    			params.add(curUser.getMainGroupId());
	    			//5.创建时间
	    			sqlBuffer.append(",").append(SysBoEnt.FIELD_CREATE_TIME);
	    			valBuffer.append(",?");
	    			params.add(new Date());
	    			//6.租户ID
	    			sqlBuffer.append(",").append(SysBoEnt.FIELD_TENANT);
	    			valBuffer.append(",?");
	    			params.add(curUser.getTenant().getTenantId());
    			}
    			sqlBuffer.append(") values(").append(valBuffer.toString()).append(")");
    			logger.info("sql:"+ sqlBuffer.toString());
    			jdbcTemplate.update(sqlBuffer.toString(), params.toArray());
    		}
    	}
		
	}
	
	private List<Column> getCommonCols(List<Column> cols,SysBoEnt ent){
		List<Column> list=new ArrayList<Column>();
		list.addAll(cols);
		if(SysBoEnt.GENMODE_DB.equals(ent.getGenMode())) {
			String pk = DbUtil.getColumnPre()+ent.getPkField().toUpperCase();
			for (Column column : list) {
				if(column.getFieldName().equals(pk)) {
					column.setIsPk(true);
					column.setFieldName(ent.getPkField());
				}else {
					column.setFieldName(column.getFieldName().split(DbUtil.getColumnPre())[1]);
				}
			}
			return list;
		}
		String pkField = ent.getPkField();
		Column colPk=new DefaultColumn();
		colPk.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colPk.setCharLen(64);
		colPk.setIsPk(true);
		colPk.setComment("主键");
		colPk.setFieldName(pkField);
		
		String fkField = ent.getParentField();
		Column colFk=new DefaultColumn();
		colFk.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colFk.setCharLen(64);
		colFk.setComment("外键");
		colFk.setFieldName(fkField);
		
		
		Column colUser=new DefaultColumn();
		colUser.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colUser.setCharLen(64);
		colUser.setComment("创建人ID");
		colUser.setFieldName(SysBoEnt.FIELD_CREATE_BY);
		
		
		
		Column colCreateTime=new DefaultColumn();
		colCreateTime.setColumnType(Column.COLUMN_TYPE_DATE);
		colCreateTime.setComment("创建时间");
		colCreateTime.setFieldName(SysBoEnt.FIELD_CREATE_TIME);
		
		Column colUpdTime=new DefaultColumn();
		colUpdTime.setColumnType(Column.COLUMN_TYPE_DATE);
		colUpdTime.setComment("更新时间");
		colUpdTime.setFieldName(SysBoEnt.FIELD_UPDATE_TIME);
		
		Column colUpdBy=new DefaultColumn();
		colUpdBy.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colUpdBy.setCharLen(64);
		colUpdBy.setComment("更新人");
		colUpdBy.setFieldName(SysBoEnt.FIELD_UPDATE_BY);
		//租户ID
		Column colTenantId=new DefaultColumn();
		colTenantId.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colTenantId.setCharLen(64);
		colTenantId.setComment("租户ID");
		colTenantId.setFieldName(SysBoEnt.FIELD_TENANT);
		//实例ID
		Column instId=new DefaultColumn();
		instId.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		instId.setCharLen(64);
		instId.setComment("流程实例ID");
		instId.setFieldName(SysBoEnt.FIELD_INST);
		
		//draft(草稿),runing(运行),complete(完成)
		Column status=new DefaultColumn();
		status.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		status.setCharLen(20);
		status.setComment("状态");
		status.setFieldName(SysBoEnt.FIELD_INST_STATUS_);
		
		Column colGroup=new DefaultColumn();
		colGroup.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colGroup.setCharLen(64);
		colGroup.setComment("组ID");
		colGroup.setFieldName(SysBoEnt.FIELD_GROUP);
		
		list.add(colPk);
		list.add(colFk);
		//增加父ID字段
		
		Column colParent=new DefaultColumn();
		colParent.setColumnType(Column.COLUMN_TYPE_VARCHAR);
		colParent.setCharLen(64);
		colParent.setComment("父ID");
		colParent.setFieldName(SysBoEnt.FIELD_PARENTID);
		list.add(colParent);
		
		
		list.add(instId);
		list.add(status);
		
		list.add(colTenantId);
		
		list.add(colCreateTime);
		list.add(colUser);
		
		list.add(colUpdBy);
		list.add(colUpdTime);
		
		list.add(colGroup);
		
		return list;
	}
	
	/**
	 * 添加bo实体。
	 * @param boEnt
	 * @return
	 */
	public SysBoEnt createBoEnt(SysBoEnt boEnt,boolean genId){
		if(genId || StringUtil.isEmpty(boEnt.getId())){
			String id=IdUtil.getId();
			boEnt.setId(id);
		}
		String entId=boEnt.getId();
		//设置创建模式
		boEnt.setGenMode(SysBoDef.GEN_MODE_FORM);
		boEnt.setIsMain(1);
		boEnt.setDsName(DataSourceUtil.LOCAL);
		
		//添加实体
		sysBoEntDao.create(boEnt);
		//添加属性
		List<SysBoAttr> attrs= boEnt.getSysBoAttrs();
		
		String columnPre=DbUtil.getColumnPre();
		
		for(SysBoAttr attr:attrs){
			attr.setId(IdUtil.getId());
			attr.setEntId(entId);
			attr.setFieldName(columnPre + attr.getName());
			sysBoAttrDao.create(attr);
		}
		
		return boEnt;
	}
	
	/**
	 * 通过entId获取该entity下的所有属性
	 * @param entId
	 * @return
	 */
	public List<SysBoAttr> getAttrsByEntId(String entId){
		List<SysBoAttr> attrs=  sysBoAttrDao.getAttrsByEntId(entId);
		return attrs;
	}
	
	/**
	 * 根据实体ID获取bo实体对象，包括其属性。
	 * @param entId
	 * @return
	 */
	public SysBoEnt getByEntId(String entId){
		SysBoEnt boEnt=this.get(entId);
		List<SysBoAttr> attrs=  sysBoAttrDao.getAttrsByEntId(entId);
		boEnt.setSysBoAttrs(attrs);
		return boEnt;
	}
	
	
	/**
	 * 根据boent 获取初始化数据。
	 * @param boEnt
	 * @return
	 */
	public JSONObject getInitData(SysBoEnt boEnt) {
		JSONObject rtnJson=getJsonByEnt(boEnt);
		List<SysBoEnt> subList=boEnt.getBoEntList();
		if(BeanUtil.isEmpty(subList)) return rtnJson;
		
		JSONObject initJson=new JSONObject();
		
		for(SysBoEnt subEnt:subList){
			JSONObject subJson=getJsonByEnt(subEnt);
			initJson.put(subEnt.getName(), subJson);
			if(SysBoRelation.RELATION_ONETOONE.equals(subEnt.getRelationType())){
				rtnJson.put(SysBoEnt.SUB_PRE +subEnt.getName(), new JSONObject());
			}
			else{
				JSONArray subAry=new JSONArray();
				rtnJson.put(SysBoEnt.SUB_PRE +subEnt.getName(), subAry);
			}
		}
		rtnJson.put("initData", initJson);
		
		return rtnJson;
	}
	
	public JSONObject getJsonByEnt(SysBoEnt ent){
		JSONObject json=new JSONObject();
		List<SysBoAttr>  list=ent.getSysBoAttrs();
		for(SysBoAttr attr:list){
			String plugin=attr.getControl() ;
			IBoAttrParse parse= boAttrParseFactory.getByPluginName(plugin);
			
			JSONObject obj= parse.getInitData(attr);
			if(obj!=null && obj.size()==0)continue;
			String key= AttrParseUtil.getKey(obj);
			String name= AttrParseUtil.getName(obj);
			
			json.put(attr.getName() , key==null?"":key);
			
			if(!attr.single()){
				json.put(attr.getName() + SysBoEnt.COMPLEX_NAME.toLowerCase(), name);
			}
		}
		
		return json;
	}
	
	/**
	 * 删除属性。
	 * @param attrId
	 */
	public void removeAttr(String attrId){
		SysBoAttr attr= sysBoAttrDao.get(attrId);
    	SysBoEnt boEnt= sysBoEntDao.get( attr.getEntId());
    	//删除列
    	if(SysBoDef.BO_YES.equals(boEnt.getGenTable())){
    		tableOperator.dropColumn(boEnt.getTableName(), attr.getFieldName());
    	}
    	sysBoAttrDao.delete(attrId);
	}
	/**
	 * 删除业务实体
	 * @param boEntId
	 */
	public void delByBoEntIdBoDefId(String boDefId,String boEntId){
		//删除属性列表
		List<SysBoAttr> attrs=sysBoAttrDao.getAttrsByEntId(boEntId);
		for(SysBoAttr at:attrs){
			//removeAttr(at.getId());
			sysBoAttrDao.delete(at.getId());
		}
		//删除关系
		SysBoRelation rel=sysBoRelationManager.getByDefEntId(boDefId, boEntId);
		if(rel!=null){
			sysBoRelationManager.delete(rel.getId());
		}
		//删除实体
		delete(boEntId);
		
	}

	/**
	 * 保存bo对象
	 * @param obj
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings("rawtypes")
	public JsonResult saveBoEnt(JSONObject obj) {
		JsonResult result=new JsonResult(true, "保存实体成功");
		try{
			SysBoEnt boEnt=JSONObject.toJavaObject(obj, SysBoEnt.class);
			
			if(!boEnt.isDbMode()){
				boEnt.setTableName(SysBoEntManager.getTableName(boEnt.getName()) );
			}
			boolean isUpd=StringUtil.isNotEmpty(boEnt.getId());
			
			if(isUpd){
				SysBoEnt sysBoEnt=this.get(boEnt.getId());
				boolean isEntExist=isEntExist(boEnt);
				boolean isMain=sysBoEnt.getIsMain()==1;
				if(isMain && isEntExist){
					result=new JsonResult(false,"保存BO实体失败!","【"+ boEnt.getName() +"】实体已存在!");
				}
			}
			else{
				boolean isEntExist=isEntExist(boEnt);
				if(isEntExist){
					result=new JsonResult(false,"保存BO实体失败!", "【"+ boEnt.getName() +"】实体已存在!");
					return result;
				}
			}
			//添加BO
	    	if(StringUtil.isEmpty(boEnt.getId())){
	    		return createEnt(boEnt);
	    	}
	    	/**
	    	 * 更新BO
	    	 */
			//boolean tableExist = tableOperator.isTableExist(boEnt.getTableName());
			//handTable(tableExist, boEnt);
	    	result=updEnt( boEnt, null);
	    	
		}
		catch(Exception ex){
			String msg=ExceptionUtil.getExceptionMessage(ex);
			result=new JsonResult(false,"保存BO实体失败!", msg);
		}
		
		return result;
	}

	private void handTable(boolean tableExist, SysBoEnt ent) throws SQLException {
		List<SysBoAttr> sysBoAttrs = ent.getSysBoAttrs();
		boolean genTable=ent.getGenTable().equals(SysBoDef.BO_YES);
		if(!genTable){
			return;
		}

		//未生成物理表。
		if(!tableExist){
			createTable(ent);
			return;
		}
		//已生成物理表。
		//判断物理表是否存在数据。
		SysBoEnt oldEnt = get(ent.getId());
		String tableName=oldEnt.getTableName();
		ent.setTableName(tableName);
		boolean hasData=tableOperator.hasData(tableName);
		//主表没有数据的情况，直接删除表重建。
		if(!hasData){
			rebuidTable(ent);
			resetEntVersion(ent);
			return;
		}
		//存在数据
		List<SysBoEnt> list= getListByBoEnt(ent,false);
		for(SysBoEnt boEnt:list){
			//创建的新表。
			if(SysBoDef.VERSION_NEW.equals( boEnt.getVersion())){
				createSingleTable(boEnt);
				resetEntVersion(boEnt);
			}
			//表已存在,这个时候不对表进行操作，在列属性中记录变更情况。
			else{
				//处理新增的列
				List<SysBoAttr> attrs= boEnt.getSysBoAttrs();
				for(SysBoAttr attr:attrs){
					if(attr.getStatus().equals(SysBoDef.VERSION_NEW)){
						//新增的列。
						createColumn(boEnt.getTableName(), attr);
						attr.setStatus(SysBoDef.VERSION_BASE);
					}else if((attr.getStatus().equals(SysBoDef.VERSION_DIFF))){//如果有区别
						//处理int和varchar的增大
						for (SysBoAttr sysBoAttr : sysBoAttrs) {
							if(attr.getFieldName().equals(sysBoAttr.getFieldName())){
								int disLength=attr.getLength()-sysBoAttr.getLength();//修改后的长度比原先的长度差
								if((attr.getDataType().equals(sysBoAttr.getDataType())||(attr.getDataType().equals("varchar")&&sysBoAttr.getDataType().equals("number")))&&disLength>=0){//如果数据类型一样才允许修改数据库
									updateColumn(boEnt.getTableName(), attr);
								}
							}
						}
						attr.setStatus(SysBoDef.VERSION_BASE);
					}
				}
			}
		}
	}

	private void rebuidTable(SysBoEnt ent) throws SQLException{
		//String tablePre= DbUtil.getTablePre();
		List<SysBoEnt> ents=new ArrayList<SysBoEnt>();
		ents.add(ent);
		ents.addAll(ent.getBoEntList());
		for(SysBoEnt boEnt:ents){
			//关联表不处理。
			if(boEnt.getIsRef()==1) {continue;}
			String tableName=boEnt.getTableName();
			tableOperator.dropTable(tableName);
		}
		createTable(ent);

	}

	private void resetEntVersion(SysBoEnt boEnt){
		resetEntSingleVersion(boEnt);
		List<SysBoEnt> list=boEnt.getBoEntList();
		if(BeanUtil.isEmpty(list)) {return;}
		for(SysBoEnt ent:list){
			resetEntSingleVersion(ent);
		}
	}

	private void resetEntSingleVersion(SysBoEnt boEnt){
		boEnt.setVersion(SysBoDef.VERSION_BASE);
		for(SysBoAttr attr:boEnt.getSysBoAttrs()){
			attr.setStatus(SysBoDef.VERSION_BASE);
		}
	}
	
	private Map<String, List<SysBoAttr>> getChangeAttrsForImport(List<SysBoAttr> oldList,List<SysBoAttr> newList) {
		Map<String, List<SysBoAttr>> resultMap = new HashMap<String, List<SysBoAttr>>();
		List<String> oldFieldNameList = new ArrayList<String>();
		for(SysBoAttr attr : oldList) {
			oldFieldNameList.add(attr.getFieldName().toUpperCase());
		}
		List<String> newFieldNameList = new ArrayList<String>();
		for(SysBoAttr attr : newList) {
			newFieldNameList.add(attr.getFieldName().toUpperCase());
		}
		//1.获取新增的，旧集合不包含新的属性，即为新增
		List<SysBoAttr> addList = new ArrayList<SysBoAttr>();
		for(SysBoAttr attr : newList) {
			if(oldFieldNameList.contains(attr.getFieldName().toString().toUpperCase())) {
				continue;
			}
			addList.add(attr);
		}
		if(addList.size() > 0) {
			resultMap.put("add", addList);
		}
		//2.获取删除的，即新属性不包含旧属性
		List<SysBoAttr> delList = new ArrayList<SysBoAttr>();
		for(SysBoAttr attr : oldList) {
			if(newFieldNameList.contains(attr.getFieldName().toString().toUpperCase())) {
				continue;
			}
			delList.add(attr);
		}
		if(delList.size() > 0) {
			resultMap.put("del", delList);
		}
		//3.获取更新的
		List<SysBoAttr> updList = new ArrayList<SysBoAttr>();
		for(SysBoAttr attr : newList) {
			String fieldName = attr.getFieldName().toString().toUpperCase();
			if(oldFieldNameList.contains(fieldName)) {
				for(int i = 0; i < oldList.size(); i++) {
					SysBoAttr _old = oldList.get(i);
					if(_old.getFieldName().toUpperCase().equals(fieldName)) {
						attr.setId(_old.getId());
						attr.setEntId(_old.getEntId());
						attr.setTenantId(ContextUtil.getCurrentTenantId());
					}
				}
				
				updList.add(attr);
			}
		}
		if(updList.size() > 0) {
			resultMap.put("upd", updList);
		}
		return resultMap;
	}
	
	private Map<String,List<SysBoAttr>> getChangeAttrs(List< SysBoAttr> oldList,List<SysBoAttr> newList){
		Map<String,List<SysBoAttr>> resultMap=new HashMap<>();
		//使用name 字段
		Map<String,SysBoAttr> oldMap=convertToMap(oldList);
		//判断newList中的attr是否含有originName
		boolean includeOriginName = false;
		if(newList.size() > 0 && oldList.size() > 0) {
			for(SysBoAttr attr : newList) {
				if(StringUtil.isEmpty(attr.getOriginName())) {
					continue;
				}
				includeOriginName = true;
			}
			if(!includeOriginName) {
				resultMap = getChangeAttrsForImport(oldList, newList);
				return resultMap;
			}
		}
		
		//使用 originName
		Map<String,SysBoAttr> newMap=new HashMap<String, SysBoAttr>();
		for(SysBoAttr attr:newList){
			newMap.put(attr.getOriginName().toLowerCase(), attr);
		}
		//1.获取新的 原来的集合不包含新的属性 即为新增。
		List<SysBoAttr> addList=new ArrayList<>();
		for(SysBoAttr attr:newList){
			if(!oldMap.containsKey(attr.getOriginName().toLowerCase())){
				addList.add(attr);
			}
		}
		if(addList.size()>0){
			resultMap.put("add", addList);
		}
		//2.获取删除的 新的不包含 原来的数据。
		List<SysBoAttr> delList=new ArrayList<>();
		for(SysBoAttr attr:oldList){
			if(!newMap.containsKey(attr.getName().toLowerCase())){
				delList.add(attr);
			}
		}
		if(delList.size()>0){
			resultMap.put("del", delList);
		}
		//3.获取更新的
		List<SysBoAttr> updList=new ArrayList<>();
		for(SysBoAttr attr:newList){
			if(oldMap.containsKey(attr.getOriginName().toLowerCase())){
				updList.add(attr);
			}
		}
		if(updList.size()>0){
			resultMap.put("upd", updList);
		}
		return resultMap;
	}
	
	/**
	 * 更新BO实体。
	 * <pre>
	 * 1.当修改的bo为从bo的情况的时候，只修改bo的关联信息。
	 * 2.当修改的bo 为主BO的时候。
	 * 	1.如果不生成表的情况，就更新bo的数据。
	 * 	2.如果当前为生成表的情况
	 * 		1.更新前的BO 为未创建表的情况。
	 * 			1.创建物理表
	 * 			2.更新BO实体情况。
	 * 		2.更新前已经创建了表。
	 * 			判断表中是否已经有数据。
	 * 			1.没有数据
	 * 				直接删除表，进行重建。
	 * 			2.有数据的情况
	 * 				判断数据是否能够更新
	 * </pre>
	 * @param boEnt
	 * @return
	 * @throws SQLException
	 */
	private JsonResult<String> updEnt(SysBoEnt boEnt, SysBoEnt sourceBoEnt) throws SQLException{
		SysBoEnt oldBoEnt = null;
		if(sourceBoEnt == null) {
			oldBoEnt=this.getByEntId(boEnt.getId());
		} else {
			oldBoEnt = sourceBoEnt; 
		}
		
		//从BO的情况。
		if(oldBoEnt.getIsMain()==0  || oldBoEnt.isDbMode()){
			updBoEnt( oldBoEnt , boEnt);
			return new JsonResult<>(true,"保存实体成功!");
		}
		
		if(SysBoDef.BO_YES.equals(boEnt.getGenTable())){
			String tableName=boEnt.getTableName();

			//未生成表。
			if(SysBoDef.BO_NO.equals(oldBoEnt.getGenTable())){
				//boEnt=this.getByEntId(boEnt.getId());
				boEnt.setGenTable(SysBoDef.BO_YES);
				createSingleTable(boEnt);
				updateEntAttrs( oldBoEnt, boEnt);
			}
			//已经生成物理表的情况。
			else{
				//boolean hasData=tableOperator.hasData(tableName);
				//没有数据
				/*if(!hasData){
					tableOperator.dropTable(tableName);
					updateEntAttrs(oldBoEnt, boEnt);
					boEnt=this.getByEntId(boEnt.getId());
					createSingleTable(boEnt);
				}
				else{*/
					//JsonResult<String> jsonResult= canUpdWhenHasData(  boEnt,  oldBoEnt);
					
					//更新bo实体的数据。
					updateEntAttrs(oldBoEnt, boEnt);
					//更新字段。
					//updTableWhenNoData( boEnt, oldBoEnt) ;
					/*if(!jsonResult.isSuccess()){
						return jsonResult;
					}*/
				//}
			}
		}
		else{
			updateEntAttrs( oldBoEnt, boEnt);
		}
		return new JsonResult<>(true,"保存实体成功!");
	}
	
	private void updTableWhenNoData(SysBoEnt boEnt,SysBoEnt oldBoEnt) throws SQLException{
		Map<String,List<SysBoAttr>> changeMap= getChangeAttrs(oldBoEnt.getSysBoAttrs(),boEnt.getSysBoAttrs());
		if(changeMap.containsKey("add")){
			List<SysBoAttr> addAttrs=changeMap.get("add");
			for(SysBoAttr attr : addAttrs){
				handAttrSingle(attr);
				List<Column> list=getColsByAttr(attr, DbUtil.getColumnPre());
				for(Column col:list){
					tableOperator.addColumn(boEnt.getTableName(), col);
				}
			}
		}
		
		
		List<SysBoAttr> oldAttrs= oldBoEnt.getSysBoAttrs();
		Map<String,SysBoAttr> oldAttrMap=convertToMap(oldAttrs);
		
		if(changeMap.containsKey("upd")){
			List<SysBoAttr> updList=changeMap.get("upd");
			for(SysBoAttr attr:updList){
				SysBoAttr oldAttr=oldAttrMap.get(attr.getName().toLowerCase());
				if("date".equals(attr.getDataType())||"date".equals(oldAttr.getDataType()))
					continue;
				if(!attr.getLength().equals(oldAttr.getLength())||("number".equals(attr.getDataType())&&!attr.getDecimalLength().equals(oldAttr.getDecimalLength()))){						
					handAttrSingle(attr);
					List<Column> list=getColsByAttr(attr, DbUtil.getColumnPre());
					for(Column col:list){
						tableOperator.updateColumn(boEnt.getTableName(), col.getFieldName(), col);
					}
				}
			}
		}
		//处理删除的列
		if(changeMap.containsKey("del")){
			List<SysBoAttr> delList=changeMap.get("del");
			for(SysBoAttr attr:delList){
				handAttrSingle(attr);
				List<Column> list=getColsByAttr(attr, DbUtil.getColumnPre());
				for(Column col:list){
					tableOperator.dropColumn(boEnt.getTableName(), col.getFieldName());
				}
			}
		}
	}
	
	/**
	 * 当有数据的时候，判断是否可以更改列数据。
	 * <pre>
	 * 	1.控件类型不能修改。
	 * 	2.数据类型不能修改。
	 * 	3.如果 数据类型为VARCHAR 的时候，数据长度不能缩小。
	 *  4.如果数据类型为NUMBER的时候，数据精度不能改小。
	 * </pre>
	 * @param boEnt
	 * @param oldBoEnt
	 * @return
	 */
	private JsonResult<String> canUpdWhenHasData(SysBoEnt boEnt,SysBoEnt oldBoEnt){
		if(!boEnt.getName().equals(oldBoEnt.getName())){
			return new JsonResult<>(false, "已生成物理表，表名称不能修改！");
		}
		Map<String,List<SysBoAttr>> changeMap= getChangeAttrs(oldBoEnt.getSysBoAttrs(),boEnt.getSysBoAttrs());
		List<SysBoAttr> oldAttrs= oldBoEnt.getSysBoAttrs();
		Map<String,SysBoAttr> oldAttrMap=convertToMap(oldAttrs);
		List<SysBoAttr> updList=changeMap.get("upd");
		boolean isValid=true;
		StringBuilder sb=new StringBuilder();
		
		for(SysBoAttr attr:updList){
			SysBoAttr oldAttr=oldAttrMap.get(attr.getOriginName().toLowerCase());
			if(!oldAttr.getControl().equals(attr.getControl())){
				sb.append(attr.getName() +"," + attr.getComment() +"控件类型不能更改\n");
				isValid=false;
			}
			else if(!oldAttr.getDataType().equals(attr.getDataType())){
				sb.append(attr.getName() +"," + attr.getComment() +"数据类型不能更改\n");
				isValid=false;
			}
			else if(Column.COLUMN_TYPE_VARCHAR.equals(oldAttr.getDataType())&& oldAttr.getLength()>attr.getLength()){
				sb.append(attr.getName() +"," + attr.getComment() +"数据长度不能改小\n");
				isValid=false;
			}
			else if(Column.COLUMN_TYPE_NUMBER.equals(oldAttr.getDataType())){
				if( oldAttr.getLength()>attr.getLength() ||  oldAttr.getDecimalLength()>attr.getDecimalLength()){
					sb.append(attr.getName() +"," + attr.getComment() +"数据精度不能改小\n");
					isValid=false;
				}
			}
		}
		JsonResult<String> result=new JsonResult<>(true,"保存实体成功!");
		result.setSuccess(isValid);
		if(!isValid){
			result.setMessage("保存实体失败!");
		}
		result.setData(sb.toString());
		return result;
	}
	
	/**
	 * 更新BO数据。
	 * <pre>
	 * 	1.更新
	 * </pre>
	 * @param oldBoEnt
	 * @param boEnt
	 */
	private void updateEntAttrs(SysBoEnt oldBoEnt,SysBoEnt boEnt){
		oldBoEnt.setGenTable(boEnt.getGenTable());
		oldBoEnt.setName(boEnt.getName());
		oldBoEnt.setComment(boEnt.getComment());
		oldBoEnt.setTableName(boEnt.getTableName());
        oldBoEnt.setCategoryId(boEnt.getCategoryId());
		sysBoEntDao.update(oldBoEnt);
		
		List<SysBoAttr> oldAttrList = sysBoAttrDao.getAttrsByEntId(oldBoEnt.getId());
		//Map<String,List<SysBoAttr>> changeMap= getChangeAttrs(oldBoEnt.getSysBoAttrs(),boEnt.getSysBoAttrs());
		Map<String,List<SysBoAttr>> changeMap= getChangeAttrs(oldAttrList, boEnt.getSysBoAttrs());
		//字段变更判断 1.添加字段 2.更新字段 3.删除字段
		List<SysBoEnt> boEnts =sysBoEntDao.getByMainId(boEnt.getId());
		if(changeMap.containsKey("add")){
			List<SysBoAttr> addList=changeMap.get("add");
			for(SysBoAttr attr:addList){
				attr.setId(IdUtil.getId());
				attr.setStatus(SysBoDef.VERSION_BASE);
				attr.setEntId(oldBoEnt.getId());
				handAttrSingle(attr);
				attr.setFieldName(DbUtil.getColumnPre() + attr.getName());
				sysBoAttrDao.create(attr);
				List<Column> list=getColsByAttr(attr, DbUtil.getColumnPre());
				
				//获取表中的所有栏位
				ITableMeta iTableMeta=(ITableMeta) AppBeanUtil.getBean("tableMetaFactoryBean");
				Table table=iTableMeta.getTableByName(boEnt.getTableName());
				List<Column> tableColList = table.getColumnList();
				
				for(Column col:list){
					try {
						if(boEnt.getGenTable().equals(SysBoDef.BO_YES)) {
							//需要先判断字段在表中是否存在 TODO
							boolean colExist = false;
							for(Column tabCol : tableColList) {
								if(tabCol.getFieldName().equals(col.getFieldName())) {
									colExist = true;
								}
							}
							if(!colExist) {
								tableOperator.addColumn(boEnt.getTableName(), col);
							}
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		if(changeMap.containsKey("upd")){
			List<SysBoAttr> updList=changeMap.get("upd");
			for(SysBoAttr attr:updList){
				//rewrited by Louis
				Map<String,SysBoAttr> attrMap=convertToMap(oldAttrList);
				//SysBoAttr oldAttr = attrMap.get(attr.getName().toLowerCase());
				SysBoAttr oldAttr = attrMap.get((StringUtil.isNotEmpty(attr.getOriginName()) ? attr.getOriginName().toLowerCase() : attr.getName().toLowerCase()));
				
				oldAttr.setName(attr.getName());
				oldAttr.setFieldName(DbUtil.getColumnPre() + attr.getName());
				oldAttr.setOriginName(StringUtil.isEmpty(attr.getOriginName()) ? attr.getName() : attr.getOriginName());
				oldAttr.setControl(attr.getControl()); //控件直接覆盖
				singleToMulti(boEnt, attr, oldAttr); //是否多属性变化
				dataTypeChanged(boEnt, attr, oldAttr);//字段类型发生变化
				oldAttr.setExtJson(attr.getExtJson());//扩展JSON直接覆盖
				oldAttr.setStatus(attr.getStatus());
				handAttrSingle(oldAttr);
				oldAttr.setComment(attr.getComment());
				sysBoAttrDao.update(oldAttr);
				
				try {
					if(boEnt.getGenTable().equals(SysBoDef.BO_YES)) {
						updateColumn(boEnt.getTableName(), oldAttr); //更新表字段属性
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		if(changeMap.containsKey("del")){
			List<SysBoAttr> delList=changeMap.get("del");
			for(SysBoAttr attr:delList){
				if(boEnt.isDelFromEnt().equals("1")) { //如果是从实体上删除属性
					sysBoAttrDao.delete(attr.getId());
				} else {
					deleteAttrForChanged(boEnt, attr);
				}
			}
		}
		if(BeanUtil.isEmpty(boEnts)) return;
		for(SysBoEnt ent:boEnts){
			String entId=ent.getId();
			List<SysBoAttr> attrs=sysBoAttrDao.getAttrsByEntId(entId);
			Map<String,SysBoAttr> attrMap=convertToMap(attrs);
			ent.setGenTable(boEnt.getGenTable());
			ent.setTableName(boEnt.getTableName());
			ent.setName(boEnt.getName());
			sysBoEntDao.update(ent);
			//添加
			if(changeMap.containsKey("add")){
				List<SysBoAttr> addList=changeMap.get("add");
				for(SysBoAttr attr:addList){
					attr.setId(IdUtil.getId());
					attr.setStatus(SysBoDef.VERSION_BASE);
					attr.setEntId(ent.getId());
					handAttrSingle(attr);
					sysBoAttrDao.create(attr);
				}
			}
			//删除
			if(changeMap.containsKey("del")){
				List<SysBoAttr> delList=changeMap.get("del");
				for(SysBoAttr attr:delList){
					SysBoAttr oldAttr= attrMap.get(attr.getName().toLowerCase());
					sysBoAttrDao.delete(oldAttr.getId());
				}
			}
			//更新关联字段
			if(changeMap.containsKey("upd")){
				List<SysBoAttr> updList=changeMap.get("upd");
				for(SysBoAttr attr:updList){
					SysBoAttr oldAttr= attrMap.get(attr.getName().toLowerCase());
					
					oldAttr.setControl(attr.getControl());
					oldAttr.setIsSingle(attr.getIsSingle());
					oldAttr.setDataType(attr.getDataType());
					oldAttr.setLength(attr.getLength());
					oldAttr.setDecimalLength(attr.getDecimalLength());
					handAttrSingle(oldAttr);
					
					sysBoAttrDao.update(oldAttr);
				}
			}
			
		}
	}
	
	/**
	 * Author ： Louis
	 * 字段进行了删除，但是不做处理，保留该属性attr的数据，并产生表删除栏位的操作脚本
	 * @param boEnt
	 * @param attr
	 */
	private void deleteAttrForChanged(SysBoEnt boEnt, SysBoAttr attr) {
		//删除字段不做处理，但是产生可执行脚本
		ProcessHandleHelper.addDifferMsg("-- 表" + boEnt.getTableName() + "删除了栏位(" + attr.getFieldName() + ")，程式中没有做出该操作，请自行判断以下的sql是否要执行");
		ProcessHandleHelper.addDifferMsg("ALTER TABLE " + boEnt.getTableName() + " DROP COLUMN " + attr.getFieldName() + ";");
		ProcessHandleHelper.addDifferMsg(" ");
	}
	
	/**
	 * Author : Louis
	 * 字段类型发生变化， 数字型转字符型，直接改变，字符型转数字型，生成执行过程语句 
	 * @param boEnt
	 * @param attr 新属性
	 * @param oldAttr 旧属性
	 */
	private void dataTypeChanged(SysBoEnt boEnt, SysBoAttr attr, SysBoAttr oldAttr) {
		//字符型转数字型
		if(!oldAttr.getDataType().equals("number") && attr.getDataType().equals("number")) {
			ProcessHandleHelper.addDifferMsg("-- 表" + boEnt.getTableName() + "中的" + oldAttr.getFieldName() + "是" +oldAttr.getDataType() 
					+ "类型，转换成数字类型可能会出现数据异常，执行以下sql语句时，请先确保数据的正确性");
			ProcessHandleHelper.addDifferMsg("ALTER TABLE " + boEnt.getTableName() + " ADD COLUMN " + oldAttr.getFieldName() + "_BAK " + oldAttr.getDataType() 
					+ (oldAttr.getLength() == null ? "" : ("(" + oldAttr.getLength() + (oldAttr.getDecimalLength() == null ? "" : "," + oldAttr.getDecimalLength()) + ")")) 
					+ " COMMENT '" + oldAttr.getComment() + "-备份数据';");
			ProcessHandleHelper.addDifferMsg("UPDATE " + boEnt.getTableName() + " SET " + oldAttr.getFieldName() + "_BAK = " + oldAttr.getFieldName() + ";");
			ProcessHandleHelper.addDifferMsg("-- 清空原栏位" + oldAttr.getFieldName() + "中的数据");
			ProcessHandleHelper.addDifferMsg("UPDATE " + boEnt.getTableName() + " SET " + oldAttr.getFieldName() + " = NULL;");
			ProcessHandleHelper.addDifferMsg("-- 原栏位" + oldAttr.getFieldName() + "的类型转换成数字类型");
			ProcessHandleHelper.addDifferMsg("ALTER TABLE " + boEnt.getTableName() + " MODIFY COLUMN " + oldAttr.getFieldName() + " FLOAT" 
					+ (attr.getLength() == null ? "" : ("(" + attr.getLength() + ")")) + " COMMENT '" + attr.getComment() 
					+ "'; -- 修改" + oldAttr.getFieldName() + "栏位的类型");
			ProcessHandleHelper.addDifferMsg("-- 请确定先手动把表" + boEnt.getTableName() + "中栏位(" + oldAttr.getFieldName() + "_BAK)中的数据改成 数字类型(这点非常重要) "
					+ "，再执行以下sql语句");
			ProcessHandleHelper.addDifferMsg("UPDATE " + boEnt.getTableName() + " SET " + oldAttr.getFieldName() + " = " + oldAttr.getFieldName() + "_BAK; "
					+ "-- 把备份的数据转成数字后，填回原栏位中");
			ProcessHandleHelper.addDifferMsg("ALTER TABLE " + boEnt.getTableName() + " DROP COLUMN " + oldAttr.getFieldName() + "_BAK;");
			ProcessHandleHelper.addDifferMsg(" ");
			//产生脚本后
			oldAttr.setDataType(attr.getDataType());//字段类型直接覆盖
			oldAttr.setLength(14); //字段长度判断性更新
			oldAttr.setDecimalLength(2);
			return;
		}
		
		//其他类型的转换
		oldAttr.setDataType(attr.getDataType());//字段类型直接覆盖
		oldAttr.setLength(attr.getLength() == null ? null : (attr.getLength() >= oldAttr.getLength() ? attr.getLength() : oldAttr.getLength())); //字段长度判断性更新
		oldAttr.setDecimalLength(attr.getDecimalLength());
	}
	
	/**
	 * Author : Louis
	 * 单属性转成多属性，创建额外一列，否则，生成删除语句
	 * @param boEnt 
	 * @param attr 新属性
	 * @param oldAttr 旧属性
	 */
	private void singleToMulti(SysBoEnt boEnt, SysBoAttr attr, SysBoAttr oldAttr) {
		try {
			if(attr.getIsSingle() == 0 && oldAttr.getIsSingle() == 1) { //单属性转成多属性 ,创建额外一列
				SysBoAttr extAttr = new SysBoAttr();
				extAttr.setId(IdUtil.getId());
				extAttr.setFieldName(oldAttr.getFieldName() + "_NAME");
				extAttr.setName(oldAttr.getName() + "_NAME");
				extAttr.setDataType("varchar");
				extAttr.setLength(attr.getLength());
				extAttr.setIsSingle(1);
				extAttr.setTenantId(ContextUtil.getCurrentTenantId());
				createColumn(boEnt.getTableName(), extAttr);
			} else if(attr.getIsSingle() == 1 && oldAttr.getIsSingle() == 0) {
				String delFieldName = oldAttr.getFieldName() + "_NAME";
				ProcessHandleHelper.addErrorMsg("-- 表" + boEnt.getTableName() + "中的" + oldAttr.getFieldName() + ", 由多属性转成了单属性，建议执行以下sql语句");
				ProcessHandleHelper.addErrorMsg("ALTER FROM " + boEnt.getTableName().toUpperCase() + " DROP COLUMN " + delFieldName);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 当BO为从Bo的情况。
	 * <pre>
	 * 	1.更新BOENT
	 * 	2.更新属性。
	 * </pre>
	 * @param oldBoEnt
	 * @param boEnt
	 */
	private void updBoEnt(SysBoEnt oldBoEnt ,SysBoEnt boEnt){
		oldBoEnt.setComment(boEnt.getComment());
		oldBoEnt.setCategoryId(boEnt.getCategoryId());
		oldBoEnt.setPkField(boEnt.getPkField());
		oldBoEnt.setParentField(boEnt.getParentField());
		if(!boEnt.isDbMode()){
			oldBoEnt.setTableName(boEnt.getTableName());
		}
		
		update(oldBoEnt);
		sysBoAttrDao.delByMainId(boEnt.getId());
		for(SysBoAttr attr:boEnt.getSysBoAttrs()){
			attr.setId(IdUtil.getId());
			//处理是否单值
			handAttrSingle(attr);
			
			if(boEnt.isDbMode()){
				attr.setFieldName(attr.getName());
			}
			else{
				attr.setFieldName(DbUtil.getColumnPre() + attr.getName());
			}
			attr.setStatus(SysBoDef.VERSION_BASE);
			attr.setEntId(boEnt.getId());
			sysBoAttrDao.create(attr);
		}
	}
	
	private void handAttrSingle(SysBoAttr attr){
		String plugin=attr.getControl() ;
		IBoAttrParse parse= boAttrParseFactory.getByPluginName(plugin);
		
		int isSingle=parse.isSingleAttr()?1:0;
		attr.setIsSingle(isSingle);
	}
	
	private JsonResult createEnt(SysBoEnt boEnt) throws SQLException{
	
		for(SysBoAttr attr:boEnt.getSysBoAttrs()){
			handAttrSingle(attr);
		}
		
		//生成物理表。
		if(SysBoEnt.GENMODE_CREATE.equals(  boEnt.getGenMode()) && SysBoDef.BO_YES.equals( boEnt.getGenTable())){
			if(tableOperator.isTableExist(boEnt.getTableName())){
				JsonResult result=new JsonResult(false,"【"+ boEnt.getTableName() +"】表已存在!");
				return result;
			}
			createSingleTable(boEnt);
		}
		String entId=IdUtil.getId();
		boEnt.setId(entId);
		boEnt.setIsMain(1);
		create(boEnt);
		for(SysBoAttr attr:boEnt.getSysBoAttrs()){
			attr.setId(IdUtil.getId());
			attr.setEntId(entId);
			attr.setStatus(StringUtil.isEmpty(attr.getStatus()) ? SysBoDef.VERSION_NEW : attr.getStatus());
			if(boEnt.isDbMode()){
				attr.setFieldName(attr.getName());
			}
			else{
				attr.setFieldName(DbUtil.getColumnPre() + attr.getName());
			}
			sysBoAttrDao.create(attr);
		}
		if(SysBoEnt.GENMODE_CREATE.equals(boEnt.getIsCreateMode())){
			try{
				JSONObject obj = new JSONObject();
				obj.put("treeId",boEnt.getCategoryId());
				obj.put("mainEntId",entId);
				obj.put("name",boEnt.getComment());
				obj.put("alais",boEnt.getName());
				obj.put("mainEntName",boEnt.getName());
				obj.put("supportDb","yes");
				sysBoDefManager.save(obj);
			}catch(Exception e){
				logger.debug("--SysBoEntManager.createEnt is error:--" + e.getMessage());
				return new JsonResult(true,"实体成功创建!");
			}
			return new JsonResult(true,"实体及模型成功创建!");
		}
		return new JsonResult(true,"实体成功创建!");
	}


	/**
	 * 根据实体ID生成物理表
	 * @param pkId
	 * @return
	 * @throws SQLException
	 */
	public JsonResult creatBoTable(String pkId) {
		try{
			SysBoEnt boEnt = sysBoEntDao.get(pkId);

			if(boEnt!=null){
				List<SysBoAttr> boAttrList = sysBoAttrDao.getAttrsByEntId(boEnt.getId());
				for(SysBoAttr attr : boAttrList) {
					attr.setStatus("base");
					sysBoAttrDao.update(attr);
				}
				boEnt.setSysBoAttrs(boAttrList);
				if(tableOperator.isTableExist(boEnt.getTableName())){
					JsonResult result=new JsonResult(false,"【"+ boEnt.getTableName() +"】表已存在!");
					return result;
				}
				createSingleTable(boEnt);
				sysBoEntDao.updateTableByKey(pkId,"yes");
			}
		}catch (Exception e){
			logger.debug("--SysBoEntManager.creatBoTable is error:--" + e.getMessage());
			return  new JsonResult(true,"生成表单失败!");
		}
		return  new JsonResult(true,"生成表单成功!");
	}

	/**
	 * 根据表名删除物理表
	 * @param pkId
	 * @return
	 * @throws SQLException
	 */
	public JsonResult deleteBoTable(String tableName,String pkId) {
		try{
			tableOperator.dropTable(tableName);
			sysBoEntDao.updateTableByKey(pkId,"no");
		}catch(Exception e){
			logger.debug("--SysBoEntManager.deleteBoTable is error:--" + e.getMessage());
			return  new JsonResult(true,"删除表单失败!");
		}
		return  new JsonResult(true,"删除表单成功!");
	}
	
	public JsonResult copyNew(SysBoEnt boEnt){
		JsonResult result=new JsonResult(true, "复制实体成功");
		String entId=boEnt.getId();
		SysBoEnt ent=this.get(entId);
		String newId=IdUtil.getId();
		List<SysBoAttr> attrs=sysBoAttrDao.getAttrsByEntId(entId);
		ent.setIsMain(0);
		ent.setId(newId);
		ent.setComment(boEnt.getComment());
		ent.setMainId(entId);
		ent.setCreateTime(new Date());
		for(SysBoAttr attr:attrs){
			attr.setId(IdUtil.getId());
			attr.setEntId(newId);
			sysBoAttrDao.create(attr);
		}
		this.create(ent);
		return result;
	}

	/**
	 * 删除实体。
	 * @param id
	 */
	public void removeByEntId(String id) {
		SysBoEnt boEnt=sysBoEntDao.get(id);
		if(boEnt==null){
			return;
		}
		boolean isMain=boEnt.getIsMain()==1;
		if(isMain){
			List<SysBoEnt> subEnts=sysBoEntDao.getByMainId(id);
			for(SysBoEnt ent:subEnts){
				delByEntId(ent.getId());
			}
		}
		delByEntId(id);
	}
	
	private void delByEntId(String entId){
		sysBoEntDao.delete(entId);
		sysBoAttrDao.delByMainId(entId);
	}
	
	public static Map<String,String> getCommonFields(){
		Map<String,String> params=new HashMap<>();
		params.put(SysBoEnt.SQL_PK, "主键");
		params.put(SysBoEnt.SQL_FK, "外键");
		params.put(SysBoEnt.FIELD_CREATE_BY, "用户ID");
		params.put(SysBoEnt.FIELD_GROUP, "组ID");
		params.put(SysBoEnt.FIELD_CREATE_TIME, "创建时间");
		params.put(SysBoEnt.FIELD_UPDATE_TIME, "更新时间");
		params.put(SysBoEnt.FIELD_PARENTID, "父ID");
		params.put(SysBoEnt.FIELD_TENANT, "租户ID");
		params.put(SysBoEnt.FIELD_INST_STATUS_, "状态");
		params.put(SysBoEnt.FIELD_INST, "实例ID");
		
		return params;
	}

	public SysBoEnt getByName(String name) {
		return sysBoEntDao.getByName(name);
	}
	
	public SysBoEnt getByTableName(String tableName) {
		return sysBoEntDao.getByTableName(tableName);
	}

	/**
	 * 获取表名。
	 * @param name
	 * @return
	 */
	public static String getTableName(String name){
		ITenant tenant=ContextUtil.getTenant();
		String tname=DbUtil.getTablePre() + name ;
		if (tenant.getIdSn()!=null){
			tname+="_" + tenant.getIdSn();
		}
		return tname;
	}
}
