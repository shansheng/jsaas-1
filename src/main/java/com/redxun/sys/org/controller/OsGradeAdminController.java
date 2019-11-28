
package com.redxun.sys.org.controller;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysInstType;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.manager.SubsystemManager;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.core.manager.SysInstTypeManager;
import com.redxun.sys.core.manager.SysMenuManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.*;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGradeAdminManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRankTypeManager;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * 分级管理员表控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/org/osGradeAdmin/")
public class OsGradeAdminController extends MybatisListController {
    @Resource
    OsGradeAdminManager osGradeAdminManager;
    @Resource
    SubsystemManager subsystemManager;
    @Resource
    SysMenuManager sysMenuManager;
    @Resource
    SysInstManager sysInstManager;
    @Resource
    SysInstTypeManager sysInstTypeManager;
    @Resource
    private OsDimensionManager osDimensionManager;
    @Resource
    private OsGroupManager osGroupManager;
    @Resource
    private OsRankTypeManager osRankTypeManager;


    @RequestMapping("saveGroup")
    @ResponseBody
    @LogEnt(action = "savfeGroup", module = "组织结构", submodule = "系统用户组")
    public JsonResult saveGroup(HttpServletRequest request,
                                HttpServletResponse response) throws Exception {
        String dimId = request.getParameter("dimId");
        OsDimension osDimension = osDimensionManager.get(dimId);
        String data = request.getParameter("data");
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.setExcludes(new String[] { "children" });
        net.sf.json.JSONObject jsonObj = net.sf.json.JSONObject.fromObject(data, jsonConfig);
        OsGroup osGroup = (OsGroup) net.sf.json.JSONObject.toBean(jsonObj, OsGroup.class);
        String tenantId = getCurTenantId(request);
        if (StringUtils.isEmpty(osGroup.getGroupId())) {
            osGroup.setGroupId(IdUtil.getId());
            osGroup.setStatus(MBoolean.ENABLED.toString());
            if (StringUtils.isNotEmpty(osGroup.getParentId())) {
                OsGroup parentGroup = osGroupManager.get(osGroup.getParentId());
                osGroup.setPath(parentGroup.getPath() + osGroup.getGroupId()
                        + ".");
                osGroupManager.update(parentGroup);
            } else {
                osGroup.setParentId("0");
                osGroup.setPath("0." + osGroup.getGroupId() + ".");
            }
            osGroup.setChilds(0);
            osGroup.setDimId(osDimension.getDimId());
            osGroup.setTenantId(tenantId);
            osGroupManager.create(osGroup);
            creatOsGroupRole(osGroup);
        } else {
            OsGroup tmpGroup = osGroupManager.get(osGroup.getGroupId());
            BeanUtil.copyNotNullProperties(tmpGroup, osGroup);
            osGroupManager.update(tmpGroup);
        }
        return new JsonResult(true, "成功保存用户组-" + osGroup.getName(), osGroup);
    }

    @RequestMapping("delGroup")
    @ResponseBody
    @LogEnt(action = "delGroup", module = "组织结构", submodule = "系统用户组")
    public JsonResult delGroup(HttpServletRequest request,
                               HttpServletResponse response) throws Exception {
        String groupId = request.getParameter("groupId");
        OsGroup osGroup = osGroupManager.get(groupId);
        if (osGroup != null) {
            osGroupManager.delAndUpdateChilds(groupId);
            osGradeAdminManager.deleteRoleByGroupId(groupId);
            return new JsonResult(true, "成功删除用户组-" + osGroup.getName());
        }
        return new JsonResult(false, "删除失败！");
    }

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}

    /**
     * 批量保存用户组
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("batchSaveGroup")
    @ResponseBody
    @LogEnt(action = "batchSaveGroup", module = "组织结构", submodule = "系统用户组")
    public JsonResult batchSaveGroup(HttpServletRequest request,
                                     HttpServletResponse response) throws Exception {
        String dimId = request.getParameter("dimId");
        OsDimension osDimension = osDimensionManager.get(dimId);
        String gridData = request.getParameter("gridData");
        String tenantId = getCurTenantId(request);
        genGroups(gridData, null, tenantId, osDimension);

        return new JsonResult(true, "成功保存用户组！");
    }
    /**
     * 产生用户组的上下级
     *
     * @param parentGroup
     * @param tenantId
     * @param osDimension
     */
    private void genGroups(String groupJson, OsGroup parentGroup,
                           String tenantId, OsDimension osDimension) {
        JSONArray jsonArray = JSONArray.fromObject(groupJson);
        if (parentGroup != null) {
            parentGroup.setChilds(jsonArray.size());
        }
        for (int i = 0; i < jsonArray.size(); i++) {
            net.sf.json.JSONObject jsonObj = jsonArray.getJSONObject(i);
            Object groupId = jsonObj.get("groupId");
            OsGroup osGroup = null;
            // 是否为创建
            boolean isCreated = false;
            if (groupId == null) {
                osGroup = new OsGroup();
                osGroup.setGroupId(IdUtil.getId());
                osGroup.setStatus(MBoolean.ENABLED.toString());
                osGroup.setGroupId(idGenerator.getSID());
                if (StringUtils.isNotEmpty(tenantId)) {
                    osGroup.setTenantId(tenantId);
                }
                osGroup.setDimId(osDimension.getDimId());
                isCreated = true;
            } else {
                osGroup = osGroupManager.get(groupId.toString());
            }

            String name = jsonObj.getString("name");
            String key = jsonObj.getString("key");
            Integer rankLevel = JSONUtil.getInt(jsonObj, "rankLevel");
            int sn = JSONUtil.getInt(jsonObj, "sn");

            osGroup.setName(name);
            osGroup.setKey(key);
            osGroup.setRankLevel(rankLevel);
            osGroup.setSn(sn);

            if (parentGroup == null) {
                osGroup.setParentId("0");
                osGroup.setPath("0." + osGroup.getGroupId() + ".");
            } else {
                osGroup.setParentId(parentGroup.getGroupId());
                osGroup.setPath(parentGroup.getPath() + osGroup.getGroupId()
                        + ".");
            }

            String children = JSONUtil.getString(jsonObj, "children");
            if (StringUtils.isNotEmpty(children)) {
                genGroups(children, osGroup, tenantId, osDimension);
            }
            if (isCreated) {
                osGroupManager.create(osGroup);
                creatOsGroupRole(osGroup);
            } else {
                osGroupManager.update(osGroup);
            }
        }
    }

    /**
     * 新建角色时同时给创建人赋角色
     */
    private  void creatOsGroupRole(OsGroup osGroup){
        if(osGroup!=null && "2".equals(osGroup.getDimId())){
            String userId = ContextUtil.getCurrentUserId();
            //角色权限
            OsGradeRole role = new OsGradeRole();
            role.setName(osGroup.getName());
            role.setGroupId(osGroup.getGroupId());
            role.setCreateBy(userId);
            role.setTenantId(osGroup.getTenantId());
            List<OsGradeAdmin> osGradeAdminList = osGradeAdminManager.getAdminByUserIdAndTenantId(userId,ContextUtil.getCurrentTenantId());
            for (OsGradeAdmin osAdmin:osGradeAdminList) {
                role.setId(IdUtil.getId());
                role.setAdminId(osAdmin.getId());
                osGradeAdminManager.saveRole(role);
            }
        }
     }

    /**
     * 按维度查找用户组
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listByMyDimId")
    @ResponseBody
    public List<OsGroup> listByMyDimId(HttpServletRequest request,
                                       HttpServletResponse response) throws Exception {
        String dimId = request.getParameter("dimId");
        String userId = ContextUtil.getCurrentUserId();

        String parentId = request.getParameter("parentId");
        List<String> groupIdList = null;
        if (StringUtils.isEmpty(parentId)) {
            //若为超级管理机构下的超级管理员，即显示全部菜单
            IUser curUser=ContextUtil.getCurrentUser();

            if(curUser.isSuperAdmin() || curUser.isSaaSAdmin() || "2".equals(dimId)) {//管理员
                parentId = "0";
            }else{
                List<OsGradeAdmin> osGradeAdminList = osGradeAdminManager.getAdminByUserIdAndTenantId(userId,ContextUtil.getCurrentTenantId());
                if(osGradeAdminList!=null &&osGradeAdminList.size()>0){
                    groupIdList = new ArrayList<String>();
                    for (OsGradeAdmin oga:osGradeAdminList) {
                        groupIdList.add(oga.getGroupId());
                    }
                }else{
                   return new ArrayList<OsGroup>();
                }
            }
        }
        String tenantId = getCurTenantId(request);
        if (StringUtils.isEmpty(dimId)) {
            OsDimension osDimension = osDimensionManager.getByDimKeyTenantId(
                    OsDimension.DIM_ADMIN, ITenant.PUBLIC_TENANT_ID);
            dimId = osDimension.getDimId();
        }

        List<OsGroup> osGroups = null;

        if ("0".equals(parentId)) {
            osGroups = osGroupManager.getRoleByDimIdGroupIdTenantId(dimId,
                    parentId, tenantId);
        } else if(groupIdList != null){
            osGroups = new ArrayList<OsGroup>();
            List<OsGroup> osGroupList = osGroupManager.getByGroupId(groupIdList);
            if(osGroupList!=null){
                osGroups.addAll(osGroupList);
            }
        }else{
            osGroups = osGroupManager.getByParentId(parentId);
        }

        for (OsGroup osGroup : osGroups) {
            if(osGroup.getRankLevel()!=null){
                OsRankType type = osRankTypeManager.getByDimIdRankLevelTenantId(dimId, osGroup.getRankLevel(), tenantId);
                if(type!=null) {
                    osGroup.setRankLevelName(type.getName());
                }
            }
            if("1".equals(dimId)){
                Integer adminCount = osGradeAdminManager.getCountByGroupId(osGroup.getGroupId());
                osGroup.setIsSetAdmin(adminCount !=null &&adminCount>0?"是":"否");
            }
        }
        return osGroups;
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
        String groupId = request.getParameter("groupId");
        List<String> menuIdList = getMenuId(groupId);
        StringBuffer stb=new StringBuffer();

        for (String str: menuIdList ) {
            stb.append(str).append(",");
        }
        if(stb.length()>0){
            stb.deleteCharAt(stb.length()-1);
        }
        return new JsonResult(true,"成功查询",stb.toString());
    }

    private List<String> getMenuId(String groupId){
        List<String> menuIdList = new ArrayList<String >();
        List<Subsystem> sysesList=subsystemManager.getGrantSubsByGroupId(groupId);
        for (Subsystem subsysTem:sysesList) {
            menuIdList.add(subsysTem.getSysId());
        }
        List<SysMenu> menusList=sysMenuManager.getGrantMenusByGroupId(groupId);
        for (SysMenu sysMenu:menusList) {
            menuIdList.add(sysMenu.getMenuId());
        }
        return menuIdList;
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
    public List<JSONObject> getMenusByInstType(HttpServletRequest request, HttpServletResponse reponse) throws Exception{
        IUser curUser = ContextUtil.getCurrentUser();
        String instType = curUser.getTenant().getInstType();

        boolean isPlatformTenant= WebAppUtil.isSaasMgrUser();
        String tenantId=request.getParameter("tenantId");
        //只有平台机构才能传入机构Id进行菜单的授权
        if(StringUtils.isNotEmpty(tenantId)){
            if(!tenantId.equals(curUser.getTenant().getTenantId())&&isPlatformTenant){
                SysInst sysInst=sysInstManager.get(tenantId);
                if(sysInst!=null && StringUtils.isNotEmpty(sysInst.getInstType())){
                    instType=sysInst.getInstType();
                }
            }
        }else{
            SysInst sysInst=sysInstManager.get(curUser.getTenant().getTenantId());
            instType=sysInst.getInstType();
        }
        String instTypeId= SysInstType.INST_TYPE_MINI_ID;
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
            String menuId = topMenu.get("menuId").toString();
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
        if(!curUser.isSuperAdmin()){
            List<OsGradeRole> groupIdList = osGradeAdminManager.getGroupByUserId(ContextUtil.getCurrentUserId(),ContextUtil.getCurrentTenantId());
            List<String> menuIdList =new ArrayList<String>();
            for (OsGradeRole role:groupIdList) {
                List<String> newMenuIdList = getMenuId(role.getGroupId());
                if(newMenuIdList !=null){
                    menuIdList.addAll(newMenuIdList);
                }
            }
            HashSet has = new HashSet(menuIdList);
            menuIdList.clear();
            menuIdList.addAll(has);
            List<JSONObject> newSubMenus = new ArrayList<JSONObject>();
            for (String str:menuIdList) {
                for(int i=0;menus!=null&&i<menus.size();i++){
                    if(str.equals(menus.get(i).get("menuId").toString())){
                        newSubMenus.add(menus.get(i));
                        break;
                    }
                }
            }
            menus=newSubMenus;
        }
        return menus;
    }

    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "分级管理员表")
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String uId= RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                osGradeAdminManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    @RequestMapping("delRole")
    @ResponseBody
    public JsonResult delRole(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String uId= RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                osGradeAdminManager.deleteRole(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    @RequestMapping("listByGroupId")
    @ResponseBody
    public List listByGroupId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId = request.getParameter("groupId");
    	String parentId = request.getParameter("parentId");
    	if (StringUtils.isEmpty(parentId)) {
			parentId = "0";
		}

    	List<OsGradeAdmin> list = null;

		if ("0".equals(parentId)) {
			list = osGradeAdminManager.getByGroupId(groupId);
		} else {
			list = osGradeAdminManager.getByParentId(parentId);
		}

    	for(int i=0;list!=null&&i<list.size();i++){
            List<OsGradeRole> in_osGradeRoleList = osGradeAdminManager.getRoleByAdminId(list.get(i).getId());
            if(in_osGradeRoleList !=null){
                String roleName = "";
                list.get(i).setOsGradeRoles(in_osGradeRoleList);
                for(int j=0;j<in_osGradeRoleList.size();j++){
                    if(StringUtil.isEmpty(roleName)){
                        roleName=roleName+in_osGradeRoleList.get(j).getName();
                    }else {
                        roleName = roleName+","+in_osGradeRoleList.get(j).getName();
                    }

                }
                list.get(i).setRoleName(roleName);
            }
        }
    	return list;
    }



    @RequestMapping("getListRoleByAdminId")
    @ResponseBody
    public List<OsGradeRole> getListRoleByAdminId(HttpServletRequest request,HttpServletResponse response) throws Exception{
        return osGradeAdminManager.getRoleByAdminId( request.getParameter("adminId"));
    }

    @RequestMapping("listRoleByAdminId")
    @ResponseBody
    public List listRoleByAdminId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	QueryFilter filter = getQueryFilter(request);
    	List list = osGradeAdminManager.getRoleByAdminId(filter);
    	return list;
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
        String pkId= RequestUtil.getString(request, "pkId");
        OsGradeAdmin osGradeAdmin=null;
        if(StringUtils.isNotEmpty(pkId)){
           osGradeAdmin=osGradeAdminManager.get(pkId);
        }else{
        	osGradeAdmin=new OsGradeAdmin();
        }
        return getPathView(request).addObject("osGradeAdmin",osGradeAdmin);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId= RequestUtil.getString(request, "pkId");
    	OsGradeAdmin osGradeAdmin=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osGradeAdmin=osGradeAdminManager.get(pkId);
    	}else{
    		osGradeAdmin=new OsGradeAdmin();
    	}
    	return getPathView(request).addObject("osGradeAdmin",osGradeAdmin);
    }
    
    /**
     * 有子表的情况下编辑明细的json
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getJson")
    @ResponseBody
    public OsGradeAdmin getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId= RequestUtil.getString(request, "ids");
        OsGradeAdmin osGradeAdmin = osGradeAdminManager.getOsGradeAdmin(uId);
        return osGradeAdmin;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "分级管理员表")
    public JsonResult save(HttpServletRequest request, @RequestBody OsGradeAdmin osGradeAdmin, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(osGradeAdmin.getId())) {
            osGradeAdminManager.create(osGradeAdmin);
            msg = getMessage("osGradeAdmin.created", new Object[]{osGradeAdmin.getIdentifyLabel()}, "[分级管理员表]成功创建!");
        } else {
        	String id=osGradeAdmin.getId();
        	OsGradeAdmin oldEnt=osGradeAdminManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, osGradeAdmin);
            osGradeAdminManager.update(oldEnt);
       
            msg = getMessage("osGradeAdmin.updated", new Object[]{osGradeAdmin.getIdentifyLabel()}, "[分级管理员表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    @RequestMapping(value = "saveAll", method = RequestMethod.POST)
    @ResponseBody
   // public JsonResult saveAll(HttpServletRequest request, @RequestBody List<OsGradeAdmin> osGradeAdmin,
    public JsonResult saveAll(HttpServletRequest request, @RequestBody OsGradeAdminAndRole osGradeAdminAndRole,
                              BindingResult result) throws Exception  {
        String successName = "[分级管理员]";
        List<String> idList =osGradeAdminManager.saveAll(osGradeAdminAndRole.getOsGradeAdmin());
        if(idList !=null){
            List<OsGradeRole> osGradeRoleList = osGradeAdminAndRole.getOsGradeRole();
            List<OsGradeRole> newOsGradeRole = new ArrayList<OsGradeRole>();
            for(int i=0;osGradeRoleList!=null && i<osGradeRoleList.size();i++){
                for(int j=0;j<idList.size();j++){
                    OsGradeRole osGradeRole = new OsGradeRole();
                    osGradeRole.setAdminId(idList.get(j));
                    osGradeRole.setGroupId(osGradeRoleList.get(i).getGroupId());
                    osGradeRole.setName(osGradeRoleList.get(i).getName());
                    newOsGradeRole.add(osGradeRole);
                }
            }
            osGradeAdminManager.saveAllRole(newOsGradeRole);
            successName =successName+"和[分级管理员角色]";
        }
    	return new JsonResult(true,successName+"成功创建");
    }
    
    @RequestMapping(value = "updataRole", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult saveAllRole(HttpServletRequest request, @RequestBody OsGradeAdminAndRole osGradeAdminAndRole, BindingResult result) throws Exception  {
    	String adminId = osGradeAdminAndRole.getGradeAdminId();
        List<OsGradeRole> osGradeRoleList =osGradeAdminAndRole.getOsGradeRole();
    	List<OsGradeRole> osGradeAdminList = osGradeAdminManager.getRoleByAdminId(adminId);

        //如果查询列表为空，则全部为新增角色
        if(osGradeAdminList ==null || osGradeAdminList.size()==0){
            //saveRole(osGradeRoleList);
            osGradeAdminManager.saveAllRole(osGradeRoleList);
            return new JsonResult(true,"成功更新分级管理员角色！");
        }

    	//角色列表为空，则根据分级管理员id清空所有角色
    	if(osGradeRoleList==null || osGradeRoleList.size()==0){
            osGradeAdminManager.delByRoleId(osGradeAdminList);
            return new JsonResult(true,"成功更新分级管理员角色！");
        }

        //区分新增和删除的列表
        for(int i=0;i<osGradeRoleList.size();i++){
            for(int j=0;j<osGradeAdminList.size();j++){
                String roleGroupId = osGradeRoleList.get(i).getGroupId();
                String adminGroupId = osGradeAdminList.get(j).getGroupId();
                if(roleGroupId.equals(adminGroupId)){
                    osGradeRoleList.remove(i);
                    osGradeAdminList.remove(j);
                    i=0;
                    j=0;
                }
            }
        }

        if(osGradeRoleList.size()>0){
            osGradeAdminManager.saveAllRole(osGradeRoleList);
        }

        osGradeAdminManager.delByRoleId(osGradeAdminList);

    	return new JsonResult(true,"成功更新分级管理员角色！");
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return osGradeAdminManager;
	}
}
