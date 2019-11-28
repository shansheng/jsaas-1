package com.redxun.saweb.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.CookieUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.core.util.Tree;
import com.redxun.oa.info.manager.InfInnerMsgManager;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.saweb.config.ui.UiConfig;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.menu.UIMenu;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.manager.SubsystemManager;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.manager.SysInstTypeManager;
import com.redxun.sys.core.manager.SysMenuManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsUserManager;


/**
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 * @author csx
 */
@Controller
@RequestMapping("/")
public class IndexController extends BaseController{
	@Resource
	UiConfig uiConfig;
	@Resource
	SubsystemManager subsystemManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	InfInnerMsgManager infInnerMsgManager;
	@Resource
	SysInstTypeManager sysInstTypeManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	SysFileManager sysFileManager;
	
	@Resource SysMenuManager sysMenuManager;
	@Resource GroupService groupService;
	
    @RequestMapping("index")
    public ModelAndView index(HttpServletRequest request,HttpServletResponse response) throws Exception{

    	//加载系统的可访问子系统
    	IUser curUser=ContextUtil.getCurrentUser();
    	String recId = ContextUtil.getCurrentUserId();
    	int newMsgCount = infInnerMsgManager.getNewMsgCountByRecId(recId);
    	IGroup curDep=groupService.getMainByUserId(curUser.getUserId());
    	String theme=CookieUtil.getValueByName("index", request);
    	if(StringUtil.isEmpty(theme)){
    		theme="index4";
    	}
    	OsUser osUser= osUserManager.get(recId);
    	String photoId=osUser.getPhoto();
    	String appName=SysPropertiesUtil.getGlobalProperty("app.name","红迅JSAAS敏捷开发平台");
		String fullPath ="";
		if(StringUtils.isNotBlank(photoId)){
			SysFile sysFile=sysFileManager.get(photoId);
			String fileId=sysFile==null?"":sysFile.getFileId();
			fullPath = request.getContextPath() + "/sys/core/file/download/"+fileId+".do";
		}else{
			fullPath = request.getContextPath()+"/styles/images/index/index_tap_06.png";
		}
		List<UIMenu> rootList= getRootMenu();
    	return new ModelAndView("index/"+ theme+ ".jsp")
    	.addObject("appName",appName)
    	.addObject("curUser",curUser)
    	.addObject("curDep",curDep)
    	.addObject("newMsgCount", newMsgCount)
    	.addObject("fullPath", fullPath)
    	.addObject("menus", rootList)
    	.addObject("menuSize", rootList.size());
    	
    }
    
    /**
     * 一次性获取菜单。
     * @return
     * @throws Exception 
     */
    @ResponseBody
    @RequestMapping("getMenusByMenuId")
    public List<UIMenu> getMenusByMenuId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String menuId=request.getParameter("menuId");
    	if(StringUtil.isEmpty(menuId)) {
    		List<UIMenu> rootList= getRootMenu();
    		menuId=rootList.get(0).getMenuId();
        }
    	List list=getBySysId(menuId);
    	for(Object obj: list){
    		UIMenu subMenu = (UIMenu) obj;  
    		callBackMenu(subMenu);
    	}
    	return list;
    }
   
    /**
     * 一次性获取菜单。
     * @return
     * @throws Exception 
     */
    @ResponseBody
    @RequestMapping("getMenus")
    public List<UIMenu> getMemus() throws Exception{
    	List<UIMenu> rootList= getRootMenu();
    	for(UIMenu root:rootList){
    		List list=getBySysId(root.getMenuId());
    		for(Object obj: list){
    			UIMenu subMenu = (UIMenu) obj;  
    			callBackMenu(subMenu);
    		}
     		root.setChildren(list);
    	}
    	return rootList;
    }
    
    private void callBackMenu(UIMenu menu) {
    	String showType=menu.getShowType();
		if("TAB_NAV".equals(showType) ||
				"FUN".equals(showType)||"FUNS".equals(showType)||"FUNS_BLOCK".equals(showType)){
			menu.setChildren(null); 
		}
		if(BeanUtil.isEmpty(menu.getChildren()))return;
		for (Tree subMenu : menu.getChildren()) {
			callBackMenu((UIMenu)subMenu);
		}
    }
    
    /**
     * 根据系统获取菜单。
     * @param sysId
     * @return
     * @throws Exception 
     */
    private List<UIMenu> getBySysId(String sysId) throws Exception{
    	String tenantId=ContextUtil.getCurrentTenantId();
    	IUser curUser=ContextUtil.getCurrentUser();
		String mgrDomain=WebAppUtil.getOrgMgrDomain();
		List<SysMenu> menums=null;
		if(mgrDomain.equals(curUser.getTenant().getDomain()) && curUser.isSuperAdmin()){//Saas管理员
			menums= sysMenuManager.getBySysIdIsBtnMenu(sysId,MBoolean.NO.name());
		}else if(curUser.isSaaSAdmin()){//租户管理员
			//根据租户找到菜单,		
			menums= sysMenuManager.getUrlMenuByTenantMgr(sysId,tenantId,MBoolean.NO.name());
		}else{
			//menums=sysMenuManager.getGrantMenusBySysIdUserId(sysId, curUser.getUserId(),tenantId,MBoolean.NO.name());
			Set<String> groupIds=((OsUser)curUser).getGroupIds();
			menums=sysMenuManager.getGrantMenusBySysIdGroupIds(sysId, groupIds);
		}
		List<UIMenu> rtnMemu=getByMemus(menums);
		List<UIMenu> memus= BeanUtil.listToTree(rtnMemu);
		return memus;
    }
    
    /**
     * 构建菜单结构。
     * @param menus
     * @return
     */
    private List<UIMenu> getByMemus(List<SysMenu> menus){
    	List<UIMenu> rtnList=new ArrayList<UIMenu>();
    	for(SysMenu menu:menus){
    		UIMenu uiMenu=new UIMenu(menu.getMenuId(), menu.getKey(), menu.getName(), menu.getUrl(), "", menu.getSn());
    		if(StringUtil.isNotEmpty(menu.getIconCls())){
    			uiMenu.setIconCls(menu.getIconCls().trim());
    		}
    		uiMenu.setParentId(menu.getParentId());
    		uiMenu.setIsBtnMenu(menu.getIsBtnMenu());
    		uiMenu.setShowType(menu.getShowType());	
    		rtnList.add(uiMenu);
    	}
    	return rtnList;
    }
    
    /**
     * 获取根菜单。
     * @return
     * @throws Exception 
     */
    private List<UIMenu> getRootMenu() throws Exception{
    	//String tenantId=ContextUtil.getCurrentTenantId();
    	ITenant curTenant=ContextUtil.getTenant();
    	IUser curUser=ContextUtil.getCurrentUser();
    	String mgrDomain=WebAppUtil.getOrgMgrDomain();
		List<Subsystem> syses=null;
		//获得平台级的登录用户
		if(mgrDomain.equals(curUser.getTenant().getDomain())  && curUser.isSuperAdmin()){
			syses=subsystemManager.getPlatformValidSystem();
		}else if(curUser.isSaaSAdmin()){//授权租户管理员使用
			syses=subsystemManager.getInstTypeValidSystem(curTenant.getInstType());
		}else{//根据用户所属的组来进行授权
			Set<String> groupIds=((OsUser)curUser).getGroupIds();
			syses=subsystemManager.getGrantSubsByGroupIds(groupIds);
			//syses=subsystemManager.getGrantSubsByUserId(curUser.getUserId(),curTenant.getTenantId(),curTenant.getInstType());
		}
		return getBySystem(syses);
    }
    
    /**
     * 将子系统转换为菜单。
     * @param sysList
     * @return
     */
    private List<UIMenu> getBySystem(List<Subsystem> sysList){
    	List<UIMenu> rootList=new ArrayList<UIMenu>();
    	for(Subsystem sys:sysList){
    		UIMenu menu=new UIMenu(sys.getSysId(), sys.getKey(), sys.getName(), sys.getHomeUrl(), "", sys.getSn());
        	menu.setIconCls(sys.getIconCls());
        	rootList.add(menu);
    	}
    	return rootList;
    }
    

}
