package com.redxun.sys.org.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.constants.MStatus;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.security.provider.ISecurityDataProvider;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysInstType;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.manager.SubsystemManager;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.core.manager.SysInstTypeManager;
import com.redxun.sys.core.manager.SysMenuManager;
import com.redxun.sys.core.manager.SysTypeSubRefManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGroupManager;

/**
 * 用户组管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/org/osGroup/")
public class OsGroupController extends BaseListController{
    @Resource
    OsGroupManager osGroupManager;
    @Resource
    OsDimensionManager osDimensionManager;
    @Resource
    SubsystemManager subsystemManager;
    @Resource
    SysMenuManager sysMenuManager;
    @Resource
    SysInstManager sysInstManager;
    @Resource
    SysInstTypeManager sysInstTypeManager;
    @Resource
    SysTypeSubRefManager sysTypeSubRefManager;
    
	//加入系统安全资源配置提供器，当权限授权发生变化时，更新资源安全配置信息
	@Autowired
	private ISecurityDataProvider securityDataProvider;

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}

	/**
	 * 分级管理员拥有资源授权的菜单列表
	 * @param request
	 * @param reponse
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getMyMenusByInstType")
	@ResponseBody
	public List<JSONObject> getMyMenusByInstType(HttpServletRequest request,HttpServletResponse reponse) throws Exception{
		IUser curUser = ContextUtil.getCurrentUser();
		String instType = curUser.getTenant().getInstType();

		String tenantId=request.getParameter("tenantId");
		boolean isSaaSMgr=false;
		//只有当前机构才能传入机构Id进行菜单的授权
		if(StringUtils.isNotEmpty(tenantId)){
			if(!tenantId.equals(curUser.getTenant().getTenantId())&& WebAppUtil.isSaasMgrUser()){
				SysInst sysInst=sysInstManager.get(tenantId);
				if(sysInst!=null && StringUtils.isNotEmpty(sysInst.getInstType())){
					instType=sysInst.getInstType();
					isSaaSMgr=true;
				}
			}
		}

		List<JSONObject> menus=new ArrayList<JSONObject>();
		List<Subsystem> subsystems = new ArrayList<Subsystem>();
		if(curUser.isSuperAdmin()) {
			subsystems=subsystemManager.getInstTypeValidSystem(instType);
		}else {
			subsystems=subsystemManager.getGrantSubsByUserId(curUser.getUserId(), tenantId, instType);
		}
		for(Subsystem system:subsystems){

			JSONObject topMenu=new JSONObject();
			topMenu.put("menuId", system.getSysId());
			topMenu.put("name", system.getName());
			topMenu.put("parentId", "0");

			//加上授权子系统
			menus.add(topMenu);

			List<SysMenu> subMenus = new ArrayList<SysMenu>();

			//超级管理员

			if(curUser.isSuperAdmin()) {
				subMenus=sysMenuManager.getBySysId(system.getSysId());
			}else {
				subMenus=sysMenuManager.getGrantMenusBySysIdUserId(system.getSysId(), curUser.getUserId(), tenantId, "NO");
			}

			for(SysMenu menu:subMenus){

				JSONObject subMenu=new JSONObject();
				subMenu.put("menuId", menu.getMenuId());
				subMenu.put("name", menu.getName());
				subMenu.put("parentId", menu.getParentId());

				menus.add(subMenu);
			}


		}
		return menus;
	}

	/**
	 * 显示资源授权的菜单列表
	 * @param request
	 * @param reponse
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("grantResource")
	@ResponseBody
	public List<SysMenu> grantResource(HttpServletRequest request,HttpServletResponse reponse) throws Exception{
		String tenantId=request.getParameter("tenantId");
		IUser curUser=ContextUtil.getCurrentUser();
		SysInst sysInst=null;
		if(StringUtils.isNotEmpty(tenantId)){
			sysInst=sysInstManager.get(tenantId);
		}
		List<SysMenu> menus=new ArrayList<SysMenu>();
		List<Subsystem> subsystems=null;
		if(sysInst!=null){
			subsystems=subsystemManager.getByInstTypeStatus(sysInst.getInstType(), MStatus.ENABLED.name());
		}else if(WebAppUtil.getOrgMgrDomain().equals(curUser.getTenant().getDomain())){//Saas机构
			subsystems=subsystemManager.getByValidSystem();
		}
		
		for(Subsystem system:subsystems){
			SysMenu topMenu=new SysMenu();
			topMenu.setName(system.getName());
			topMenu.setMenuId(system.getSysId());
			//加上授权子系统
			menus.add(topMenu);	
			List<SysMenu> subMenus=sysMenuManager.getBySysId(system.getSysId());
			
			menus.addAll(subMenus);
		}
		return menus;
	}
	
	/**
	 * 多机构的显示资源授权的菜单列表
	 * @param request
	 * @param reponse
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getMenusByInstType")
	@ResponseBody
	public List<JSONObject> getMenusByInstType(HttpServletRequest request,HttpServletResponse reponse) throws Exception{
		IUser curUser = ContextUtil.getCurrentUser();
		String instType = curUser.getTenant().getInstType();
		
		boolean isPlatformTenant= WebAppUtil.isSaasMgrUser();
		String tenantId=request.getParameter("tenantId");
		//只有平台机构才能传入机构Id进行菜单的授权
		if(StringUtils.isNotEmpty(tenantId)){
				SysInst sysInst=sysInstManager.get(tenantId);
				if(sysInst!=null && StringUtils.isNotEmpty(sysInst.getInstType())){
					instType=sysInst.getInstType();
				}
				isPlatformTenant=WebAppUtil.isSaasMgrTenant(sysInst);
		}else{
			SysInst sysInst=sysInstManager.get(curUser.getTenant().getTenantId());
			instType=sysInst.getInstType();
			isPlatformTenant=WebAppUtil.isSaasMgrTenant(ContextUtil.getTenant());
		}
		String instTypeId=SysInstType.INST_TYPE_MINI_ID;
		if(StringUtils.isEmpty(instType)){
			instType=SysInstType.INST_TYPE_MINI;
		}else{
			SysInstType sysInstType=sysInstTypeManager.getByCode(instType);
			if(sysInstType!=null){
				instTypeId=sysInstType.getTypeId();
			}
		}
		
		List<JSONObject> menus=new ArrayList<JSONObject>();
		//取得该类型下的授权的所有权限
		List<Subsystem> subsystems=subsystemManager.getInstTypeValidSystem(instType);
		for(Subsystem system:subsystems){

			JSONObject topMenu=new JSONObject();
			topMenu.put("menuId", system.getSysId());
			topMenu.put("name", system.getName());
			topMenu.put("parentId", "0");	//根目录值默认为0
			//加上授权子系统
			menus.add(topMenu);	
			List<SysMenu> subMenus = new ArrayList<SysMenu>();
			
			//平台超级管理员
			if(isPlatformTenant){
				subMenus=sysMenuManager.getBySysId(system.getSysId());
			}else{//按机构类型显示其授权的资源
				subMenus=sysMenuManager.getGrantMenusBySysIdInstTypeId(system.getSysId(),instTypeId);
			}

			for(SysMenu menu:subMenus){
				JSONObject subMenu=new JSONObject();
				subMenu.put("menuId", menu.getMenuId());
				subMenu.put("name", menu.getName());
				subMenu.put("parentId", menu.getParentId());
				menus.add(subMenu);
			}

		}
		return menus;
	}
	
	/**
	 * 获得授权的资源ID
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getGrantedResourceIds")
	@ResponseBody
	public JsonResult getGrantedResourceIds(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String groupId=request.getParameter("groupId");
		List<Subsystem> grantSyses=subsystemManager.getGrantSubsByGroupId(groupId);
		List<SysMenu> grantMenus=sysMenuManager.getGrantMenusByGroupId(groupId);
		StringBuffer sb=new StringBuffer();
		
		for(Subsystem sys:grantSyses){
			if(sys==null)continue;
			sb.append(sys.getSysId()).append(",");
		}
		
		for(SysMenu menu:grantMenus){
			if(menu==null)continue;
			sb.append(menu.getMenuId()).append(",");;
		}
		if(sb.length()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		return new JsonResult(true,"成功查询",sb.toString());
	}
	
	@RequestMapping("saveGrant")
	@ResponseBody
	@LogEnt(action = "saveGrant", module = "组织架构", submodule = "系统用户组")
	public JsonResult saveGrant(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String groupId=request.getParameter("groupId");
		String menuIds=request.getParameter("menuIds");
		String sysIds=request.getParameter("sysIds");
		
		//带根节点的菜单及Id
		Set<String> includeSysIdMenuIds=StringUtil.toSet(menuIds);
		//子系统的Id
		Set<String> sysIdSet=StringUtil.toSet(sysIds);
		//获得有效的允许访问的子系统
		includeSysIdMenuIds.removeAll(sysIdSet);
		
		osGroupManager.saveGrantMenus(groupId, includeSysIdMenuIds, sysIdSet);
		
		//更新权限的配置资源缓存
		securityDataProvider.reloadSecurityDataCache();
				
		return new JsonResult(true,"成功进行用户组授权!");
	}
	
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "组织架构", submodule = "系统用户组")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                osGroupManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        OsGroup osGroup=null;
        if(StringUtils.isNotBlank(pkId)){
           osGroup=osGroupManager.get(pkId);
        }else{
        	osGroup=new OsGroup();
        }
        return getPathView(request).addObject("osGroup",osGroup);
    }
    
    /**
     * 用户组明细
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("detail")
    public ModelAndView detail(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("groupId");
        OsGroup osGroup=osGroupManager.get(pkId);
        OsDimension osDimension=osDimensionManager.get(osGroup.getDimId());
        return getPathView(request).addObject("osGroup",osGroup).addObject("osDimension",osDimension);
    }
 
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	OsGroup osGroup=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osGroup=osGroupManager.get(pkId);
    		if("true".equals(forCopy)){
    			osGroup.setGroupId(null);
    		}
    	}else{
    		osGroup=new OsGroup();
    	}
    	return getPathView(request).addObject("osGroup",osGroup);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return osGroupManager;
	}
	


}
