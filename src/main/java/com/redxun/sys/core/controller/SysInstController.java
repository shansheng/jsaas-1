package com.redxun.sys.core.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.constants.MStatus;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsInstUsers;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsInstUsersManager;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 注册组织机构管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/core/sysInst/")
public class SysInstController extends MybatisListController{
    @Resource
    SysInstManager sysInstManager;
    @Resource
    OsInstUsersManager osInstUsersManager;

	@Resource
	OsUserManager osUserManager;
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
	/**
	 *
	 *查询所有加入的机构(登陆)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("queryMoreOrgnai")
	@ResponseBody
	public List<SysInst> queryMoreOrgnai(HttpServletRequest request,HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();
		List<SysInst> isJionInstList = sysInstManager.getByUserIdAndStatus(user.getUserId(),OsUser.STATUS_IN_JOB);
		return  isJionInstList;
	}

	/**
	 * 取消申请或者主动推出操作
	 */
	@RequestMapping("quitOrCancel")
	@ResponseBody
	public JsonResult quitOrCancel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String tenantId=request.getParameter("tenantId");
		String moreInstStatus=request.getParameter("moreInstStatus");
		String name = "APPLY".equals(moreInstStatus)?"取消申请操作成功":"退出操作成功";
		IUser user=ContextUtil.getCurrentUser();
		
		osInstUsersManager.removeByUserId(user.getUserId(),tenantId);
		if("ENABLED".equals(moreInstStatus)){
			osUserManager.updateTenantIdFromDomain(user.getUserId(),null);
		}
		return new JsonResult(true,name);
	}

	/**
	 * 审批操作
	 */
	@RequestMapping(value = "agreeOrRefuse", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult agreeOrRefuse(HttpServletRequest request, @RequestBody OsInstUsers osInstUsers,
									 BindingResult result) throws Exception  {
		IUser user=ContextUtil.getCurrentUser();
		String note = DateUtil.formatDate(new Date(),"yyyy-MM-dd HH:mm:ss");
		note = note+" 由"+user.getFullname()+"["+user.getUserNo()+"]审批："+osInstUsers.getNote();
		osInstUsers.setNote(note);
		osInstUsers.setApproveUser(user.getUserId());
		if("1".equals(osInstUsers.getIsAgree())){
			osInstUsers.setStatus(OsUser.STATUS_IN_JOB);
			osInstUsers.setApplyStatus("ENABLED");
		}else{
			osInstUsers.setStatus(OsUser.STATUS_OUT_JOB);
			osInstUsers.setApplyStatus("ENABLED");
		}

		osInstUsersManager.agreeOrRefuse(osInstUsers);
		return new JsonResult(true,"操作成功");
	}
	/**
	 *查询所有申请加入本机构的人员名单
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getAllApplyInstList")
	@ResponseBody
	public List<OsInstUsers> getAllApplyInstList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();
		List<OsInstUsers> allList = osInstUsersManager.getByDomain(user.getDomain());
		return  allList;
	}

	/**
	 *保存选择加入的机构
	 */
	@RequestMapping(value = "saveSelectInst", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult saveSelectInst(HttpServletRequest request, @RequestBody List<SysInst> sysInstList,
			BindingResult result) throws Exception  {
		IUser user=ContextUtil.getCurrentUser();
		for (SysInst sysInst: sysInstList) {
			String id = IdUtil.getId();
			OsInstUsers osInstUsers = new OsInstUsers();
			osInstUsers.setId(id);
			osInstUsers.setUserId(user.getUserId());
			osInstUsers.setDomain(sysInst.getDomain());
			osInstUsers.setTenantId(sysInst.getInstId());
			osInstUsers.setStatus(OsUser.STATUS_OUT_JOB);
			osInstUsers.setIsAdmin(0);
			osInstUsers.setApplyStatus("APPLY");
			osInstUsers.setCreateType("APPLY");
			osInstUsersManager.create(osInstUsers);
		}
		return new JsonResult(true,"申请处理成功，请等待管理员审批！");
	}

	/**
	 *查询所有可以加入的机构（过滤已经加入）
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectAllInstList")
	@ResponseBody
	public List<SysInst> selectAllInstList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();
		
		List<SysInst> isJionInstList = sysInstManager.getByUserIdAndStatus(user.getUserId(),null);
		List<SysInst> allInstList = sysInstManager.getALL();
		for(int i=0;isJionInstList!=null &&i<isJionInstList.size();i++){
			for(int j=0;allInstList!=null&& j<allInstList.size();j++){
				if(isJionInstList.get(i).getInstId().equals(allInstList.get(j).getInstId()) &&  !"DISABLED".equals(isJionInstList.get(i).getMoreInstStatus())){
					allInstList.remove(j);
					continue;
				}
			}
		}
		return  allInstList;
	}

	/**
	 * 申请加入机构
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("approval")
	public ModelAndView approval(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String instId = request.getParameter("instId");
		String approvalType = request.getParameter("approvalType");
		ModelAndView mv=getPathView(request);
		mv.addObject("instId",instId);
		mv.addObject("approvalType",approvalType);
		return mv;
	}

	/**
	 * 审批操作
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectDialog")
	public ModelAndView selectDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		return getPathView(request);
	}

	/**
	 * 打开申请加入机构页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("showCanApplyList")
	public ModelAndView showCanApplyList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();

		return getPathView(request).addObject("user",user);
	}


	/**
	 * 查询机构列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listApplData")
	@ResponseBody
	public List<SysInst> listApplData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();
		ITenant ITenant = user.getTenant();
		
		List<SysInst>  instList = sysInstManager.getByUserIdAndStatus(user.getUserId(),null);
		for(int i=0;instList!=null&&i<instList.size();i++){
			SysInst sysInst = instList.get(i);
			if((sysInst.getInstId().equals(ITenant.getInstId())) || ("CREATE".equals(sysInst.getMoreInstCreateType()))){
				sysInst.setPresent(true);
			}else{
				sysInst.setPresent(false);
			}
			String note = sysInst.getMoreInstNote();
			if(StringUtil.isNotEmpty(note) && note.contains("|")){
				String[] noteList = note.split("|");
				if(noteList!=null){
					sysInst.setMoreInstNote(noteList[0]);
				}
			}
		}
		return instList;
	}

	/**
	 * 机构申请审批
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("showApplyInstList")
	public ModelAndView showApplyInstList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String pkId=request.getParameter("pkId");
		SysInst inst=null;
		if(StringUtils.isNotBlank(pkId)){
			inst=sysInstManager.get(pkId);
		}else{
			inst=new SysInst();
		}
		return getPathView(request).addObject("sysInst",inst);
	}

   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "系统内核", submodule = "注册机构")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	SysInst sysInst=sysInstManager.get(id);
            	if(sysInst==null) continue;
            	if(WebAppUtil.getOrgMgrDomain().equals(sysInst.getDomain())){
            		return new JsonResult(false,"超级管理机构不允许删除！");
            	}else if(!MStatus.INIT.toString().equals(sysInst.getStatus())){
            		return new JsonResult(false,"仅允许删除[初始化]状态的机构！");
            	}
            	sysInstManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 获得对话框的信息
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listForDialog")
    @ResponseBody
    public JsonPageResult<SysInst> listForDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(request);
    	List<SysInst> insts=sysInstManager.getAll(filter);
    	return new JsonPageResult(insts,filter.getPage().getTotalItems());
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("pkId");
        SysInst inst=null;
        if(StringUtils.isNotBlank(pkId)){
           inst=sysInstManager.get(pkId);
        }else{
        	inst=new SysInst();
        }
        return getPathView(request).addObject("sysInst",inst);
    }
    
    /**
     * 获得单条记录
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("getRecord")
    @ResponseBody
    public SysInst getRecord(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("pkId");
        SysInst inst=null;
        if(StringUtils.isNotBlank(pkId)){
           inst=sysInstManager.get(pkId);
        }
        return inst;
    }
    
	/**
	 * 判断当前租户是否是平台用户
	 * @return
	 */
    @RequestMapping("isAdmin")
    @ResponseBody
	public boolean isAdmin(){
		String tenantId = ContextUtil.getCurrentTenantId();
		SysInst sysInst = sysInstManager.get(tenantId);
		if(sysInst!=null&&"PLATFORM".equals(sysInst.getInstType())){
			return true;
		}
		return false;
	}
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	SysInst sysInst=null;
    	ModelAndView mv=getPathView(request);
    	if(StringUtils.isNotEmpty(pkId)){
    		sysInst=sysInstManager.get(pkId);
    		if(StringUtils.isNotEmpty(sysInst.getPath()) && StringUtils.isNotEmpty(sysInst.getParentId())){
    			SysInst parentInst=sysInstManager.get(sysInst.getParentId());
    			mv.addObject("parentInst",parentInst);
    		}
    	}else{
    		sysInst=new SysInst();
    	}
    	return mv.addObject("sysInst",sysInst);
    }
    
    @RequestMapping("domainEdit")
    public ModelAndView domainEdit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	return edit(request, response);
    }
    
    @RequestMapping("saveDomain")
    @ResponseBody
    @LogEnt(action = "saveDomain", module = "系统内核", submodule = "注册机构")
    public JsonResult saveDomain(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId = request.getParameter("pkId");
    	String newDomain = request.getParameter("newDomain");
    	
    	SysInst inst = sysInstManager.getByDomain(newDomain);
    	if(BeanUtil.isNotEmpty(inst)) {
    		return new JsonResult(false, "存在相同域名！");
    	}
    	inst = sysInstManager.get(pkId);
    	sysInstManager.saveDomain(inst,newDomain);
    	
    	return new JsonResult(true,"成功操作！");
    }
    
    
    @RequestMapping("enable")
    @ResponseBody
    @LogEnt(action = "enable", module = "系统内核", submodule = "注册机构")
    public JsonResult enable(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String ids=request.getParameter("ids");
    	String enable=request.getParameter("enable");
    	if(StringUtils.isEmpty(ids) || StringUtils.isEmpty(enable)){
    		return new JsonResult(false,"提交的参数不正确！");
    	}
    	
    	String[] pkIds=ids.split("[,]");
    	for(String pk:pkIds){
    		SysInst sysInst=sysInstManager.get(pk);
    		if(sysInst!=null){
    			sysInst.setStatus(enable);
    			sysInstManager.update(sysInst);
    		}
    	}
    	
    	return new JsonResult(true,"成功操作！");
    }
    
    @RequestMapping("pass")
    @ResponseBody
    @LogEnt(action = "pass", module = "系统内核", submodule = "注册机构")
    public JsonResult pass(HttpServletRequest request, @Valid SysInst sysInst, BindingResult result) throws Exception{
    	SysInst orgInst=sysInstManager.get(sysInst.getInstId());
    	BeanUtil.copyNotNullProperties(orgInst, sysInst);
    	orgInst.setStatus(MStatus.ENABLED.toString());
    	sysInstManager.doRegister(orgInst);
    	sysInstManager.update(orgInst);
    	return new JsonResult(true,"审批已通过，启用此机构！");
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysInstManager;
	}

}
