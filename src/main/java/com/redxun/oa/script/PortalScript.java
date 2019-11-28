package com.redxun.oa.script;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmInstCcManager;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.core.annotion.cls.ClassDefine;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.cache.ICache;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SortParam;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.doc.entity.DocFolder;
import com.redxun.oa.doc.manager.DocFolderManager;
import com.redxun.oa.info.dao.InsNewsColumnQueryDao;
import com.redxun.oa.info.entity.InfInnerMsg;
import com.redxun.oa.info.entity.InsColumnDef;
import com.redxun.oa.info.entity.InsColumnEntity;
import com.redxun.oa.info.entity.InsMsgBoxEntity;
import com.redxun.oa.info.entity.InsMsgDef;
import com.redxun.oa.info.entity.InsMsgboxDef;
import com.redxun.oa.info.entity.InsNews;
import com.redxun.oa.info.entity.InsPortalParams;
import com.redxun.oa.info.manager.InfInboxManager;
import com.redxun.oa.info.manager.InfInnerMsgManager;
import com.redxun.oa.info.manager.InsColumnDefManager;
import com.redxun.oa.info.manager.InsMsgDefManager;
import com.redxun.oa.info.manager.InsMsgboxDefManager;
import com.redxun.oa.info.manager.InsNewsManager;
import com.redxun.oa.mail.entity.InnerMail;
import com.redxun.oa.mail.entity.MailFolder;
import com.redxun.oa.mail.entity.OutMail;
import com.redxun.oa.mail.manager.InnerMailManager;
import com.redxun.oa.mail.manager.OutMailManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysBoListManager;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;
import com.redxun.sys.org.dao.OsGroupDao;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.sys.util.SysUtil;
import com.redxun.wx.portal.entity.WxMobilePortalButton;
import com.redxun.wx.portal.manager.WxMobilePortalButtonManager;
/**
 * 流程脚本处理类，放置于脚本运行的环境, 配置@ClassDefine及@MethodDefine目的是
 * 为了可以把系统中自带的API显示出来给配置人员查看及选择使用
 * 
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 *            本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@ClassDefine(title = "流程脚本服务类")
public class PortalScript implements GroovyScript {
	
	protected static Logger logger=LogManager.getLogger(PortalScript.class);
	
	@Resource
	RuntimeService runtimeService;
	@Resource
	TaskService taskService;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmFormInstManager bpmFormInstManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
    OsGroupDao groupDao;
	@Resource
	BpmInstDataManager bpmInstDataManager ;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	InsNewsManager insNewsManager;
	@Resource
	InfInboxManager infInboxManager;
	@Resource
	OutMailManager outMailManager;
	@Resource
	InnerMailManager innerMailManager;
	@Resource
	InsMsgboxDefManager insMsgboxDefManager;
	@Resource
	InsMsgDefManager insMsgDefManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	CommonDao commonDao;
	@Resource
	InsColumnDefManager insColumnDefManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	SysBoListManager sysBoListManager;
	
	@Resource
	SysSqlCustomQueryManager sysSqlCustomQueryManager;
	@Resource
	InsNewsColumnQueryDao insNewsColumnQueryDao;
	@Resource
	BpmInstCcManager bpmInstCcManager;
	@Resource
	InfInnerMsgManager infInnerMsgManager;
	@Resource
	DocFolderManager docFolderManager;

	private static final String IMG_AND_FONT="font";

	@MethodDefine(title = "自定义列表",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId"),@ParamDefine(title = "自定义SQL", varName = "alias")})
	public InsColumnEntity getByCustomSql(String colId, String alias){
		InsColumnDef col = insColumnDefManager.get(colId);
		SysSqlCustomQuery sqlCustomQuery=sysSqlCustomQueryManager.getByKey(alias);
		Page page=new Page(0,Integer.parseInt(sqlCustomQuery.getPageSize()));
		Map<String,Object> params=new HashMap<String, Object>();
		List result=new ArrayList();
		try {
			result = sysSqlCustomQueryManager.getData(sqlCustomQuery, params,page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String url = col.getDataUrl();
		InsColumnEntity<List> entity = new InsColumnEntity<List>(col.getName(), url, page.getTotalItems(), result);
		return entity;
	}
	
	
	/**
	 * 门户显示文档数据
	 * @return
	 */
	@MethodDefine(title = "个人文档",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getDocFolder(String colId) {
		
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		SqlQueryFilter filter = new SqlQueryFilter();
		filter.addFieldParam("userId", userId);
		Page page=new Page(0,5);
		filter.setPage(page);
		ArrayList<DocFolder> docFolderList=(ArrayList<DocFolder>) docFolderManager.getByUserId(userId, tenantId, "PERSONAL");	
		
		InsColumnEntity<ArrayList<DocFolder>> entity = new InsColumnEntity<ArrayList<DocFolder>>(col.getName(), "/oa/doc/docFolder/list.do", page.getTotalItems(), docFolderList);
		return entity;
	}
	
	/**
	 * 门户显示文档数据
	 * @return
	 */
	@MethodDefine(title = "公司文档",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getCompanyDocuments(String colId) {
		
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		SqlQueryFilter filter = new SqlQueryFilter();
		filter.addFieldParam("userId", userId);
		Page page=new Page(0,5);
		filter.setPage(page);
		ArrayList<DocFolder> docFolderList=(ArrayList<DocFolder>) docFolderManager.getCompanyFolder(userId, tenantId);	
		
		InsColumnEntity<ArrayList<DocFolder>> entity = new InsColumnEntity<ArrayList<DocFolder>>(col.getName(), "/oa/doc/docFolder/showIndex.do", page.getTotalItems(), docFolderList);
		return entity;
	}
	/**
	 * 门户显示文档数据
	 * @return
	 */
	@MethodDefine(title = "共享文档",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getShareDocuments(String colId) {
		
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		SqlQueryFilter filter = new SqlQueryFilter();
		filter.addFieldParam("userId", userId);
		Page page=new Page(0,5);
		filter.setPage(page);
		ArrayList<DocFolder> docFolderList=(ArrayList<DocFolder>) docFolderManager.getShareFolder(tenantId);	
		
		InsColumnEntity<ArrayList<DocFolder>> entity = new InsColumnEntity<ArrayList<DocFolder>>(col.getName(), "/oa/doc/shareFolder/list.do", page.getTotalItems(), docFolderList);
		return entity;
	}
	
	
	/**
	 * 门户已办栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的已办栏目",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalMyBpmTask(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		InsColumnDef col = insColumnDefManager.get(colId);
		SqlQueryFilter filter = new SqlQueryFilter();
		filter.addFieldParam("userId", userId);
		Page page=new Page(0,5);
		filter.setPage(page);
		ArrayList<BpmInst> bpmInstList=(ArrayList<BpmInst>) bpmInstManager.getMyInsts(filter);	
		
		InsColumnEntity<ArrayList<BpmInst>> entity = new InsColumnEntity<ArrayList<BpmInst>>(col.getName(), "/oa/personal/bpmInst/myAttends.do", page.getTotalItems(), bpmInstList);
		return entity;
	}
	
	
	/**
	 * 门户待办栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的待办栏目",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalBpmTask(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsPortalParams params =new InsPortalParams();
		InsColumnDef col = insColumnDefManager.get(colId);
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter filter=new QueryFilter();
    	Page page=new Page();
    	page.setPageIndex(0);
    	page.setPageSize(params.getPageSize());
    	filter.setPage(page);
    
    	ArrayList<BpmTask> bpmTasks=(ArrayList<BpmTask>) bpmTaskManager.getByUserId(filter);
		InsColumnEntity<ArrayList<BpmTask>> entity = new InsColumnEntity<ArrayList<BpmTask>>(col.getName(), "/bpm/core/bpmTask/myList.do", page.getTotalItems(), bpmTasks);
		return entity;
	}
	
	
	
	/**
	 * 门户抄送栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的抄送栏目",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalMyChao(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		InsColumnDef col = insColumnDefManager.get(colId);
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("from_User_Id_", userId);
		Page page = new Page(0,5);
		filter.setPage(page);
		ArrayList<BpmInstCc> list = (ArrayList<BpmInstCc>) bpmInstCcManager.getAll(filter);
		InsColumnEntity<ArrayList<BpmInstCc>> entity = new InsColumnEntity<ArrayList<BpmInstCc>>(col.getName(), "/bpm/core/bpmInstCc/list.do", page.getTotalItems(), list);
		return entity;
	}
	
	/**
	 * 我的流程草稿栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的流程草稿",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalMyDrafts(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsPortalParams params =new InsPortalParams();
		InsColumnDef col = insColumnDefManager.get(colId);
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter queryFilter= new QueryFilter();
		Page page = (Page) queryFilter.getPage();
		ArrayList<BpmSolution> bpmSolutions=(ArrayList<BpmSolution>)bpmSolutionManager.getSolutions(queryFilter,false);
		InsColumnEntity<ArrayList<BpmSolution>> entity = new InsColumnEntity<ArrayList<BpmSolution>>(col.getName(), "/oa/personal/bpmSolApply/myList.do", page.getTotalItems(), bpmSolutions);
		return entity;
	}
	
	/**
	 * 我的流程草稿栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的常用流程",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getMyCommonInst(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		InsColumnDef col = insColumnDefManager.get(colId);
		QueryFilter queryFilter= new QueryFilter();
		queryFilter.addFieldParam("userId", userId);
		Page page = (Page) queryFilter.getPage();
		page.setPageSize(10);
		ArrayList<BpmInst> bpmInsts=(ArrayList<BpmInst>)bpmInstManager.getMyCommonInst(queryFilter);
		InsColumnEntity<ArrayList<BpmInst>> entity = new InsColumnEntity<ArrayList<BpmInst>>(col.getName(), "/oa/personal/bpmSolApply/myList.do", page.getTotalItems(), bpmInsts);
		return entity;
	}
	
	/**
	 * 我的流程方案栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的流程方案",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalMySolList(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsPortalParams params =new InsPortalParams();
		InsColumnDef col = insColumnDefManager.get(colId);
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter queryFilter= new QueryFilter();
		Page page = (Page) queryFilter.getPage();
		ArrayList<BpmSolution> bpmSolutions=(ArrayList<BpmSolution>)bpmSolutionManager.getSolutions(queryFilter,false);
		InsColumnEntity<ArrayList<BpmSolution>> entity = new InsColumnEntity<ArrayList<BpmSolution>>(col.getName(), "/oa/personal/bpmSolApply/myList.do", page.getTotalItems(), bpmSolutions);
		return entity;
	}
	
	/**
	 * 门户新闻公告栏目数据
	 * @return
	 */
	@MethodDefine(title = "新闻公告栏目",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalNews(String colId) {
		Page page=new Page(0,5);
		InsColumnDef col= insColumnDefManager.get(colId);
		if(col!=null){
			ArrayList<InsNews> insNews =null;
			InsColumnEntity<ArrayList<InsNews>> entity =null;
			String newType =col.getNewType();
			if(StringUtil.isNotEmpty(newType) && !IMG_AND_FONT.equals(newType)){
				insNews = (ArrayList<InsNews>) insNewsManager.getImgAndFontByColumnId(colId,page);
				entity = new InsColumnEntity<ArrayList<InsNews>>(col.getName(), "/oa/info/insNews/byColId.do?colId="+colId+"&portal=YES", page.getTotalItems(), insNews,newType);
			}else{
				insNews = (ArrayList<InsNews>) insNewsManager.getByColumnId(colId,page);
				entity = new InsColumnEntity<ArrayList<InsNews>>(col.getName(), "/oa/info/insNews/byColId.do?colId="+colId+"&portal=YES", page.getTotalItems(), insNews);
			}
			return entity;
		}
		return null;
	}

	/**
	 * 门户我的消息数据
	 * @return
	 */
	@MethodDefine(title = "我的消息",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalMsg(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		InsPortalParams params =new InsPortalParams();
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter queryFilter = new QueryFilter();
		Page page=new Page();
    	page.setPageIndex(0);
    	page.setPageSize(params.getPageSize());
		queryFilter.setPage(page);
		ArrayList<InfInnerMsg> insMsg = (ArrayList<InfInnerMsg>) infInnerMsgManager.getInnerMsgByRecId(userId, queryFilter);
		InsColumnEntity<ArrayList<InfInnerMsg>> entity = new InsColumnEntity<ArrayList<InfInnerMsg>>(col.getName(), "/oa/info/infInbox/receive.do", page.getTotalItems(), insMsg);
		return entity;
	}
	
	/**
	 * 门户外部邮件数据
	 * @return
	 */
	@MethodDefine(title = "外部邮件",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public InsColumnEntity getPortalOutEmail(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		InsPortalParams params =new InsPortalParams();
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter queryFilter = new QueryFilter();
		Page page=new Page();
    	page.setPageIndex(0);
    	page.setPageSize(params.getPageSize());
		queryFilter.setPage(page);
		queryFilter.addFieldParam("mailFolder.type", MailFolder.TYPE_RECEIVE_FOLDER);
		queryFilter.addFieldParam("mailFolder.inOut", MailFolder.FOLDER_FLAG_OUT);
		queryFilter.addFieldParam("userId", userId);
		queryFilter.addSortParam("sendDate", SortParam.SORT_DESC);
		queryFilter.addFieldParam("status", OutMail.STATUS_COMMEN); // 只获取正常状态的外部邮件
		ArrayList<OutMail> outEmail = (ArrayList<OutMail>) outMailManager.getAll(queryFilter);
		InsColumnEntity<ArrayList<OutMail>> entity = new InsColumnEntity<ArrayList<OutMail>>(col.getName(), "/oa/mail/mailConfig/getAllConfig.do", page.getTotalItems(), outEmail);
		return entity;
	}
	
	/**
	 * 门户内部邮件数据
	 * @return
	 */
	public InsColumnEntity getPortalInEmail(String colId) {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		InsColumnDef col = insColumnDefManager.get(colId);
		InsPortalParams params =new InsPortalParams();
		params.setUserId(userId);
		params.setTenantId(tenantId);
		QueryFilter queryFilter = new QueryFilter();
		Page page=new Page();
    	page.setPageIndex(0);
    	page.setPageSize(params.getPageSize());
		queryFilter.setPage(page);
		
		ArrayList<InnerMail> inMail = (ArrayList<InnerMail>) innerMailManager.getInnerMailByUserId(userId, queryFilter,params.getPageSize());  //获取当前用户的内部邮件
		InsColumnEntity<ArrayList<InnerMail>> entity = new InsColumnEntity<ArrayList<InnerMail>>(col.getName(), "/oa/mail/mailBox/list.do", page.getTotalItems(), inMail);
		return entity;
	}
	
	@MethodDefine(title = "消息盒子",category="Portal门户", params = {@ParamDefine(title = "消息盒子Key（请修改为具体消息盒子的Key）", varName = "boxKey")})
	public InsColumnEntity getPortalMsgBox(String boxKey){
		ArrayList<InsMsgBoxEntity> boxEntity = new ArrayList<InsMsgBoxEntity>();
		InsMsgboxDef boxDef = insMsgboxDefManager.getByKey(boxKey);
		if(boxDef==null){
			return new InsColumnEntity();
		}
		List<InsMsgDef> msgDef = insMsgDefManager.getByMsgBoxId(boxDef.getBoxId());
		
		for(InsMsgDef msg:msgDef){
			InsMsgBoxEntity e = new InsMsgBoxEntity();
			if("sql".equals(msg.getType())){
				int count = getCountByType(msg,"sql");
				e.setCount(count);
			}else if("function".equals(msg.getType())){//支持查找多个数据
				Integer count = getBoxDataByType(msg);
				e.setCount(count);
			}
			e.setColor(msg.getColor());
			e.setIcon(msg.getIcon());
			e.setTitle(msg.getContent());
			e.setUrl(msg.getUrl());
			Map<String,Object> map = e.getBoxData();
			String data = getLastDataByCountType(msg);
			
			
			map.put("data", data);
			if(StringUtil.isEmpty(data)) {
				map.put("ratioNone", "ratioNone");
			}
			boxEntity.add(e);
		}
		InsColumnEntity<ArrayList<InsMsgBoxEntity>> entity = new InsColumnEntity<ArrayList<InsMsgBoxEntity>>("消息盒子", "", msgDef.size(), boxEntity);
		return entity;
	}
	
	public String getLastDataByCountType(InsMsgDef msgBox) {
		StringBuilder data = new StringBuilder();
		String countType = msgBox.getCountType();
		if(StringUtil.isEmpty(countType) || "none".equals(countType))return data.toString();
		Object title = null;
		Float lastData = 0F;
		Float nowData =0F;
		Float basisData = 0F;
		
		String sql=SysUtil.replaceConstant(msgBox.getSqlFunc());
		sql=(String)groovyEngine.executeScripts(sql, new HashMap<String, Object>());
		if(!sql.contains("where")) {
			sql += " where 1=1 ";
		}
		if("week".equals(countType)) {
			title = "同比上周";
			String lastSql = sql + " and YEARWEEK(date_format(CREATE_TIME_,'%Y-%m-%d')) = YEARWEEK(now())-1";
			SqlModel model=new SqlModel(lastSql);//获取SQL			
			lastData = Float.valueOf(commonDao.queryOne(model).toString());
			
			String nowSql = sql + " and YEARWEEK(date_format(CREATE_TIME_,'%Y-%m-%d')) = YEARWEEK(now())";
			model.setSql(nowSql);
			nowData = Float.valueOf(commonDao.queryOne(model).toString());
		}else if("month".equals(countType)) {
			title = "同比上月";
			String lastSql = sql + " and PERIOD_DIFF( date_format( now() , '%Y%m' ) , date_format( CREATE_TIME_, '%Y%m' ) ) =1";
			SqlModel model=new SqlModel(lastSql);//获取SQL			
			lastData = Float.valueOf(commonDao.queryOne(model).toString());
			
			String nowSql = sql + " and DATE_FORMAT( CREATE_TIME_, '%Y%m' ) = DATE_FORMAT( CURDATE() , '%Y%m' )";
			model.setSql(nowSql);
			nowData = Float.valueOf(commonDao.queryOne(model).toString());
		}else if("year".equals(countType)) {
			title = "同比上年";
			String lastSql = sql + " and YEAR(create_date)=YEAR(NOW())";
			SqlModel model=new SqlModel(lastSql);//获取SQL			
			lastData = Float.valueOf(commonDao.queryOne(model).toString());
			
			String nowSql = sql + " and YEAR(CREATE_TIME_)=YEAR(date_sub(now(),interval 1 YEAR))";
			model.setSql(nowSql);
			nowData = Float.valueOf(commonDao.queryOne(model).toString());
		}
		
		String em = "em";
		String icon = "▲";
		if(nowData==0) {
			icon = "-";
		}
		int basisCount = 0;
		if(lastData>0) {
			basisData = ((nowData-lastData)/lastData+1)*100;
		}else {
			basisData = nowData*100;
		}
		if(basisData<0) {
			em = "em1";
			basisData = -basisData;
			basisCount = basisData.intValue();
		}else if(basisData==0) {
			basisCount = 0;
		}else {
			basisCount = basisData.intValue();
		}
		
		data.append("<div class=\"footerCardBox\">\r\n" + 
				"     <span class=\"footerSpanLeft\">\r\n" + 
				"     <em class=\""+em+"\">"+icon+"</em>\r\n" + 
				"     <span>"+basisCount+"%</span>\r\n" + 
				"     </span>\r\n" + 
				"     <span class=\"footerSpanRight\">"+title+"</span>\r\n" + 
				"</div>");
		return data.toString();
	}
	
	/**
	 * 执行消息的sql脚本
	 * @param msgId
	 * @return
	 */
    public int getCountByType(InsMsgDef msgBox,String type) {
		String sql=SysUtil.replaceConstant(msgBox.getSqlFunc());
		sql=(String)groovyEngine.executeScripts(sql, new HashMap<String, Object>());
		SqlModel model=new SqlModel(sql);//获取SQL			
		Double count = Double.valueOf(commonDao.queryOne(model).toString());
		Integer i  = count.intValue();		
		return i;
    }
    
    public Integer getBoxDataByType(InsMsgDef msgBox){
    	Integer rtn = (Integer) groovyEngine.executeScripts(msgBox.getSqlFunc(),new HashMap<String, Object>());
    	return rtn;
    }
 
	/**
	 * 我的流程方案栏目数据
	 * @return
	 */
	@MethodDefine(title = "我的流程方案",category="Portal门户", params = {@ParamDefine(title = "栏目主键", varName = "colId")})
	public Integer getCountMySolList() {
		String userId = ContextUtil.getCurrentUserId();
		String tenantId = ContextUtil.getCurrentTenantId();
		QueryFilter queryFilter= new QueryFilter();
		((Page)queryFilter.getPage()).setPageSize(99999);
		ArrayList<BpmSolution> bpmSolutions=(ArrayList<BpmSolution>)bpmSolutionManager.getSolutions(queryFilter,false);
		return bpmSolutions.size();
	}
	
	private SysBoList getBoList(String boKey){
		SysBoList sysBoList=(SysBoList)CacheUtil.getCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ ContextUtil.getTenant().getDomain());
		if(sysBoList==null){
			sysBoList =sysBoListManager.getByKey(boKey, ContextUtil.getCurrentTenantId());
			//放置于缓存
			CacheUtil.addCache(ICache.SYS_BO_LIST_CACHE+boKey +"_"+ ContextUtil.getTenant().getDomain(), sysBoList);
		}
		return sysBoList;
	}

//自定义移动端模板所需数据 -- writed by Louis
	@Resource
	WxMobilePortalButtonManager wxPortalBtnManager;
	@Resource
	SysFileManager sysFileManager;
	
	@SuppressWarnings("rawtypes")
	@MethodDefine(title = "移动端栏位模板", params = {@ParamDefine(title = "移动端栏位id", varName = "mobileKey")})
	public InsColumnEntity getMobileTemplate(String mobileKey) {
		List<WxMobilePortalButton> wxPortalBtnList = new ArrayList<WxMobilePortalButton>();
		wxPortalBtnList = wxPortalBtnManager.getByType(mobileKey);
		for(WxMobilePortalButton wpb : wxPortalBtnList) {
			JSONObject json = new JSONObject();
			JSONArray jArr = JSON.parseArray(wpb.getIcon());
			if(jArr != null && jArr.size() > 0) {
				json = JSON.parseObject(JSON.toJSONString(jArr.get(0)));
				SysFile sysFile = sysFileManager.get(json.getString("fileId"));
				//String iconPath = SysPropertiesUtil.getGlobalProperty("upload.dir") + File.separator + sysFile.getPath();
				wpb.setIcon(sysFile.getFileId());
			}
		}
		InsColumnEntity<List<WxMobilePortalButton>> entity = new InsColumnEntity<List<WxMobilePortalButton>>("移动端栏位模板", "", null, wxPortalBtnList);
		return entity;
	}}
