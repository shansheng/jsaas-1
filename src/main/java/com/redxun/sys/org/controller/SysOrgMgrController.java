package com.redxun.sys.org.controller;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.org.entity.*;
import com.redxun.sys.org.manager.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 组织用户实例管理
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/org/sysOrg/")
public class SysOrgMgrController extends BaseController {
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private OsDimensionManager osDimensionManager;
	@Resource
	private OsRelTypeManager osRelTypeManager;
	@Resource
	private OsRelInstManager osRelInstManager;
	@Resource
	private SysInstManager sysInstManager;
	@Resource
	private CommonDao commonDao;
	@Resource
	private OsRankTypeManager osRankTypeManager;
	
	@Resource
	private OsUserManager osUserManager;
	@Resource
	OsGradeAdminManager osGradeAdminManager;
    @Resource
    private OsCustomAttributeManager osCustomAttributeManager;
    @Resource
    private SysTreeManager sysTreeManager;
    @Resource
    private OsAttributeValueManager osAttributeValueManager;

    @RequestMapping("editOrgAttr")
    public ModelAndView editOrgAttr(HttpServletRequest request,HttpServletResponse response) throws Exception{
        ModelAndView mv=getPathView(request);

        String groupId=request.getParameter(OsGroup.GROUPID);
        String tenantId=ContextUtil.getCurrentTenantId();

		List<SysTree> treeList =  sysTreeManager.getByCatKeyTenantId("CAT_CUSTOMATTRIBUTE_GROUP",ContextUtil.getCurrentTenantId());
        List<OsCustomAttribute> osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTenantId(tenantId,OsGroup.GROUP);
		if(osCustomAttributes!=null){
			setAttributes(osCustomAttributes,groupId);
		}
        mv.addObject(OsGroup.OS_OGROUP_ATTR, osCustomAttributes).addObject("treeList",treeList);
        return mv;
    }
    private void setAttributes(List<OsCustomAttribute> osCustomAttributes,String groupId){
		for (int i = 0; i < osCustomAttributes.size(); i++) {
			OsCustomAttribute osCustomAttribute=osCustomAttributes.get(i);
			String attributeId=osCustomAttribute.getID();
			OsAttributeValue osAttributeValue=osAttributeValueManager.getSpecialValueByUser(attributeId,groupId);//根据userId获取属性值
			if(osAttributeValue!=null){
				osCustomAttribute.setValue(osAttributeValue.getValue());
			}
		}
	}

	@RequestMapping("listAttributes")
	@ResponseBody
	public List<OsCustomAttribute> listAttributes(HttpServletRequest request,
										HttpServletResponse response) throws Exception {
        String groupId=request.getParameter(OsGroup.GROUPID);
        String isEdit =request.getParameter("isEdit");
        String tenantId=ContextUtil.getCurrentTenantId();

        List<OsCustomAttribute> osCustomAttributes= null;
        if("true".equals(isEdit)){
			osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTenantId(tenantId,OsGroup.GROUP);
			if(osCustomAttributes!=null){
				setAttributes(osCustomAttributes,groupId);
			}
        }else{
            osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTarGetId(tenantId,groupId,OsGroup.GROUP);
        }
		return osCustomAttributes;
	}


	@RequestMapping(value = "saveAttr", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult saveAttr(HttpServletRequest request, HttpServletResponse response) throws Exception{
		saveUserAttributes(request);
		return new JsonResult(true, "成功");
	}

	private void saveUserAttributes(HttpServletRequest request){
		String currentUserId=ContextUtil.getCurrentUserId();

		String groupId=RequestUtil.getString(request, OsGroup.GROUPID);
		osAttributeValueManager.removeByTargetId(groupId);

		String jsonValue=RequestUtil.getString(request, "attrValue");
		String comboboList=RequestUtil.getString(request, "comboboList");
		for (Map.Entry<String, Object> entry : JSON.parseObject(jsonValue).entrySet()) {
			if( entry.getValue() ==null ||StringUtil.isEmpty(entry.getValue().toString())){continue;}
			OsAttributeValue  osAttributeValue=new OsAttributeValue();
			osAttributeValue.setId(IdUtil.getId());
			osAttributeValue.setAttributeId(entry.getKey().split("_")[1]);
			osAttributeValue.setTargetId(groupId);
			osAttributeValue.setValue(entry.getValue().toString());
			osAttributeValue.setCreateBy(currentUserId);
			osAttributeValue.setCreateTime(new Date());
			osAttributeValue.setComboboxName(entry.getValue().toString());
			for (Map.Entry<String, Object> comboboxName : JSON.parseObject(comboboList).entrySet()) {
				if(StringUtil.isNotEmpty(entry.getKey()) && entry.getKey().equals(comboboxName.getKey())){
					osAttributeValue.setComboboxName(comboboxName.getValue().toString());
					break;
				}
			}
			osAttributeValueManager.create(osAttributeValue);

		}

	}

	@RequestMapping("listByMyConfig")
	@ResponseBody
	public List<OsGroup> listByMyConfig(HttpServletRequest request,
										HttpServletResponse response) throws Exception {
		String userId = ContextUtil.getCurrentUserId();

		String parentId = request.getParameter(OsGroup.PARENTID);
		if (StringUtils.isEmpty(parentId)) {
			parentId = "0";
		}

		List<OsGroup> osGroups = null;
		if ("0".equals(parentId)) {
			osGroups = osGroupManager.getByUserIdConfig(userId);
		} else {
			osGroups = osGroupManager.getByMyParentId(parentId);
		}

		return osGroups;
	}

	/**
	 * 分级配置
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mgrConfig")
	public ModelAndView mgrConfig(HttpServletRequest request,
								  HttpServletResponse response) throws Exception {
		String instId = request.getParameter(OsGroup.TENANTID);
		String groupId = request.getParameter(OsGroup.GROUPID);
		String groupName = request.getParameter("groupName");
		String nodeDimId = request.getParameter("nodeDimId");


		SysInst sysInst = null;
		if (StringUtils.isNotEmpty(instId) && !"null".equals(instId)) {
			// 当前用户为指定的管理机构下的用户才可以查询到指定的租用机构下的数据
			sysInst = sysInstManager.get(instId);
		}
		if (sysInst == null) {
			sysInst = sysInstManager.get(ContextUtil.getCurrentTenantId());
		}
		ModelAndView view = getPathView(request);
		view.addObject(OsGroup.SYSINST, sysInst);
		if(StringUtil.isNotEmpty(groupId)){
			view.addObject(OsGroup.GROUPID, groupId);
		}
		if(StringUtil.isNotEmpty(groupName)){
			view.addObject("groupName", groupName);
		}
		if(StringUtil.isNotEmpty(nodeDimId)){
			view.addObject("nodeDimId", nodeDimId);
		}
		IUser oUser = ContextUtil.getCurrentUser();
		view.addObject("isSuperAdmin", oUser.isSaaSAdmin());
		return view;
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
		String dimId = request.getParameter(OsGroup.DIMID);

		String parentId = request.getParameter(OsGroup.PARENTID);
		if (StringUtils.isEmpty(parentId)) {
			parentId = "0";
		}
		String tenantId = getCurTenantId(request);
		if (StringUtils.isEmpty(dimId)) {
			OsDimension osDimension = osDimensionManager.getByDimKeyTenantId(
					OsDimension.DIM_ADMIN, ITenant.PUBLIC_TENANT_ID);
			dimId = osDimension.getDimId();
		}

		List<OsGroup> osGroups = null;

		if ("0".equals(parentId)) {
			osGroups = osGroupManager.getByDimIdGroupIdTenantId(dimId,
					parentId, tenantId);
		} else {
			osGroups = osGroupManager.getByParentId(parentId);
		}

		if("1,2".contains(dimId)){
			tenantId = ITenant.ADMIN_TENANT_ID;
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
	 * 进入权限分级管理
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mgrGrade")
	public ModelAndView mgrGrade(HttpServletRequest request,
								 HttpServletResponse response) throws Exception {
		String instId = request.getParameter(OsGroup.TENANTID);
		SysInst sysInst = null;
		if (StringUtils.isNotEmpty(instId) && !"null".equals(instId)) {
			// 当前用户为指定的管理机构下的用户才可以查询到指定的租用机构下的数据
			sysInst = sysInstManager.get(instId);
		}
		if (sysInst == null) {
			sysInst = sysInstManager.get(ContextUtil.getCurrentTenantId());
		}
		//若为超级管理机构下的超级管理员，即显示全部菜单
		IUser curUser=ContextUtil.getCurrentUser();
		return getPathView(request).addObject(OsGroup.SYSINST, sysInst).addObject("userId", ContextUtil.getCurrentUserId()).addObject("isSuperAdmin", curUser.isSaaSAdmin());
	}

	/**
	 * 进入组织架构管理页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mgr")
	public ModelAndView mgr(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String instId = request.getParameter(OsGroup.TENANTID);
		SysInst sysInst = null;
		if (StringUtils.isNotEmpty(instId) && !"null".equals(instId)) {
			// 当前用户为指定的管理机构下的用户才可以查询到指定的租用机构下的数据
			sysInst = sysInstManager.get(instId);
		}
		if (sysInst == null) {
			sysInst = sysInstManager.get(ContextUtil.getCurrentTenantId());
		}
		
		return getPathView(request).addObject(OsGroup.SYSINST, sysInst);
	}

	@RequestMapping("delGroup")
	@ResponseBody
	@LogEnt(action = "delGroup", module = "组织结构", submodule = "系统用户组")
	public JsonResult delGroup(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String groupId = request.getParameter(OsGroup.GROUPID);
		OsGroup osGroup = osGroupManager.get(groupId);
		if (osGroup != null) {
			osGroupManager.delAndUpdateChilds(groupId);
			return new JsonResult(true, "成功删除用户组-" + osGroup.getName());
		}
		return new JsonResult(false, "删除失败！");
	}

	@RequestMapping("saveGroup")
	@ResponseBody
	@LogEnt(action = "savfeGroup", module = "组织结构", submodule = "系统用户组")
	public JsonResult saveGroup(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String dimId = request.getParameter(OsGroup.DIMID);
		OsDimension osDimension = osDimensionManager.get(dimId);
		String data = request.getParameter("data");
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "children" });
		JSONObject jsonObj = JSONObject.fromObject(data, jsonConfig);
		OsGroup osGroup = (OsGroup) JSONObject.toBean(jsonObj, OsGroup.class);
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
			if(!canCreateOsGroup(osGroup)){
				return new JsonResult(false, "用户组创建失败：组key【" + osGroup.getKey()+"】已经存在！");
			}
			osGroupManager.create(osGroup);
		} else {
			OsGroup tmpGroup = osGroupManager.get(osGroup.getGroupId());
			BeanUtil.copyNotNullProperties(tmpGroup, osGroup);
			osGroupManager.update(tmpGroup);
		}
		return new JsonResult(true, "成功保存用户组-" + osGroup.getName(), osGroup);
	}

	/**
	 * 按用户id查找用户组
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByGroupId")
	@ResponseBody
	public List<OsGroup> listByGroupId(HttpServletRequest request,
									 HttpServletResponse response) throws Exception {
		String groupId = request.getParameter(OsGroup.GROUPID);
		//懒加载点击树控件
		String clickNodeId = request.getParameter("clickNode");
		if(StringUtil.isNotEmpty(clickNodeId)){
			return osGroupManager.getByParentId(clickNodeId);
		}
		OsGroup osGroup = osGroupManager.get(groupId);
		List<OsGroup> osGroups=new ArrayList<>();
		osGroups.add(osGroup);
		return osGroups;
	}

	/**
	 * 按维度查找用户组
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByDimId")
	@ResponseBody
	public List<OsGroup> listByDimId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		//懒加载点击树控件
		String clickNodeId = request.getParameter("clickNode");
		// 默认进入行政维度
		String dimId = request.getParameter(OsGroup.DIMID);
		//指定了维度等级
		String initRankLevel = request.getParameter("initRankLevel");
		String currentUserId = ContextUtil.getCurrentUserId();

		List<OsGroup> osGroups=new ArrayList<>();
		if("topContacts".equals(dimId)){//如果是展示常用联系人则采用自定义查询返回常用联系人
			List<?> contactTypes=commonDao.query("select F_LXRFL from w_topcontacts where CREATE_USER_ID_="+ContextUtil.getCurrentUserId()+" group by F_LXRFL");
			for (int i = 0; i < contactTypes.size(); i++) {
				Map<String, Object> map=(Map<String, Object>) contactTypes.get(i);
				String contactType=(String) map.get("F_LXRFL");
				OsGroup osGroup=new OsGroup();
				osGroup.setGroupId(contactType);
				osGroup.setName(contactType);
				osGroups.add(osGroup);
			}
			return osGroups;
		}else{//不显示常用联系人时

			String tenantId =getCurTenantId(request);
			OsDimension dimension = osDimensionManager.get(dimId);
			Boolean adminDim = "_ADMIN".equals(dimension.getDimKey());
			//懒加载
			if(StringUtil.isNotEmpty(clickNodeId)){
				//是否为行政维度
				if(!adminDim){
					return osGroupManager.getByParentIdBelongs(clickNodeId,tenantId,currentUserId);
				}else{
					return osGroupManager.getByParentId(clickNodeId);
				}
			}
			//指定了等级，返回对应等级和维度的组织数据
			if(StringUtil.isNotEmpty(initRankLevel)){
				//是否为行政维度
				if(!adminDim){
					return osGroupManager.getByDimAndLevel(dimId,initRankLevel);
				}else{
					return osGroupManager.getByDimAndLevelBelongs(dimId,initRankLevel,currentUserId,tenantId);
				}

			}
			String parentId = request.getParameter(OsGroup.PARENTID);
			String initParentId = request.getParameter("initParentId");
			if (StringUtils.isEmpty(parentId)) {
				parentId = "0";
			}

			if (StringUtils.isEmpty(dimId)) {
				OsDimension osDimension = osDimensionManager.getByDimKeyTenantId(
						OsDimension.DIM_ADMIN, ITenant.PUBLIC_TENANT_ID);
				dimId = osDimension.getDimId();
			}

			if(StringUtils.isNotEmpty(initParentId) && "0".equals(parentId)){
				List<String> groupIdList = Arrays.asList(initParentId.split(","));
				osGroups = osGroupManager.getByGroupId(groupIdList);
			} else if ("0".equals(parentId)) {
				osGroups = osGroupManager.getByDimIdGroupIdTenantId(dimId,
						parentId, tenantId);
			} else {
				osGroups = osGroupManager.getByParentId(parentId);
			}
			for (OsGroup osGroup : osGroups) {
				OsRankType type = osRankTypeManager.getByDimIdRankLevelTenantId(dimId, osGroup.getRankLevel(), tenantId);
				if(type!=null) {
					osGroup.setRankLevelName(type.getName());
				}
			}
			
			return osGroups;
		}
		
	}

	/**
	 * 用户组对话框的搜索
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("search")
	@ResponseBody
	public List<OsGroup> search(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String dimId = request.getParameter(OsGroup.DIMID);
		String showDimId = request.getParameter("showDimId");
		String tempDimId = null;
		String tenantId = getCurTenantId(request);
		// 排队了行政维度
		String excludeAdmin = request.getParameter("excludeAdmin");
		// 优先使用页面参数中指定显示的维度下的用户组
		if ("true".equals(excludeAdmin)) {// 显示角色维度
			OsDimension osDimension = osDimensionManager
					.get(OsDimension.DIM_ROLE_ID);
			tempDimId = osDimension.getDimId();
		} else if (StringUtils.isNotEmpty(showDimId)) {
			tempDimId = showDimId;
		} else if (StringUtils.isNotEmpty(dimId)) {// 当点击维度树时显示的用户组
			tempDimId = dimId;
		} else {// 默认显示行政维度下的用户组
			OsDimension osDimension = osDimensionManager
					.get(OsDimension.DIM_ADMIN_ID);
			tempDimId = osDimension.getDimId();
		}
		String name = request.getParameter("name");
		String key = request.getParameter("key");
		String parentId = request.getParameter(OsGroup.PARENTID);

		List list = null;

		if ((StringUtils.isNotEmpty(name) || StringUtils.isNotEmpty(key))
				&& StringUtils.isEmpty(parentId)) {
			list = osGroupManager.getByDimIdNameKey(tenantId, tempDimId, name,
					key);
		} else if (StringUtils.isEmpty(parentId)) {
			list = osGroupManager.getByDimIdGroupIdTenantId(tempDimId, "0",
					tenantId);
		} else {
			list = osGroupManager.getByParentId(parentId);
		}
		return list;
	}
	/**
	 * 用户组对话框的搜索
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("searchQY")
	@ResponseBody
	public List<OsGroup> searchQY(HttpServletRequest request,
								  HttpServletResponse response) throws Exception {
		String dimId = request.getParameter(OsGroup.DIMID);
		String showDimId = request.getParameter("showDimId");
		String tempDimId = null;
		String tenantId = getCurTenantId(request);
		// 排队了行政维度
		String excludeAdmin = request.getParameter("excludeAdmin");
		// 优先使用页面参数中指定显示的维度下的用户组
		if ("true".equals(excludeAdmin)) {// 显示角色维度
			OsDimension osDimension = osDimensionManager
					.get(OsDimension.DIM_ROLE_ID);
			tempDimId = osDimension.getDimId();
		} else if (StringUtils.isNotEmpty(showDimId)) {
			tempDimId = showDimId;
		} else if (StringUtils.isNotEmpty(dimId)) {// 当点击维度树时显示的用户组
			tempDimId = dimId;
		} else {// 默认显示行政维度下的用户组
			OsDimension osDimension = osDimensionManager
					.get(OsDimension.DIM_ADMIN_ID);
			tempDimId = osDimension.getDimId();
		}
		String name = request.getParameter("name");
		String key = request.getParameter("key");
		String parentId = request.getParameter(OsGroup.PARENTID);

		List list = null;

		if ((StringUtils.isNotEmpty(name) || StringUtils.isNotEmpty(key))
				&& StringUtils.isEmpty(parentId)) {
			list = osGroupManager.getByDimIdNameKey(tenantId, tempDimId, name,
					key);
		} else if (StringUtils.isEmpty(parentId)) {
			list = osGroupManager.getByDimIdGroupIdTenantId(tempDimId, "0",
					tenantId);
		} else {
			list = osGroupManager.getByParentId(parentId);
		}
		return list;
	}
	/**
	 * 查找有某种的关系的用户组列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByGroupIdRelTypeId")
	@ResponseBody
	public JsonPageResult listByGroupIdRelTypeId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String groupId = request.getParameter(OsGroup.GROUPID);
		String relTypeId = request.getParameter("relTypeId");
		SqlQueryFilter filter = QueryFilterBuilder
				.createSqlQueryFilter(request);
		List<OsRelInst> list = osRelInstManager.getByGroupIdRelTypeId(groupId,
				relTypeId, filter);
		return new JsonPageResult(list, filter.getPage().getTotalItems());
	}

	/**
	 * 保存用户组实例数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveGroupRelInst")
	@ResponseBody
	@LogEnt(action = "saveGroupRelInst", module = "组织结构", submodule = "系统用户组")
	public JsonResult saveGroupRelInst(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String insts = request.getParameter("insts");
		JSONArray arrs = JSONArray.fromObject(insts);
		for (int i = 0; i < arrs.size(); i++) {
			JSONObject obj = arrs.getJSONObject(i);
			OsRelInst inst = (OsRelInst) JSONObject
					.toBean(obj, OsRelInst.class);
			OsRelInst tempInst = osRelInstManager.get(inst.getInstId());
			tempInst.setAlias(inst.getAlias());
			osRelInstManager.update(tempInst);
		}
		return new JsonResult(true, "成功保存！");
	}

	/**
	 * 批量删除用户组间的某种关系
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("removeOsRelInst")
	@ResponseBody
	@LogEnt(action = "removeOsRelInst", module = "组织结构", submodule = "系统用户组")
	public JsonResult removeOsRelInst(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String instIds = request.getParameter("instIds");

		String[] ids = instIds.split("[,]");
		for (String id : ids) {
			osRelInstManager.delete(id);
		}
		return new JsonResult(true, "成功删除！");
	}

	/**
	 * 为用户组按关系关联用户组
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("joinGroups")
	@ResponseBody
	@LogEnt(action = "joinGroups", module = "组织结构", submodule = "系统用户组")
	public JsonResult joinGroups(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String groupId = request.getParameter(OsGroup.GROUPID);
		String groupIds = request.getParameter("groupIds");
		String relTypeId = request.getParameter("relTypeId");
		String tenantId=getCurTenantId(request);
		String[] gIds = groupIds.split("[,]");
		OsRelType osRelType = osRelTypeManager.get(relTypeId);
		for (String gId : gIds) {
			OsRelInst inst1 = osRelInstManager.getByParty1Party2RelTypeId( groupId, gId, relTypeId);
			if (inst1 != null) {
				continue;
			}
			OsRelInst inst = new OsRelInst();
			inst.setInstId(IdUtil.getId());
			inst.setParty1(groupId);
			inst.setParty2(gId);
			inst.setRelTypeKey(osRelType.getKey());
			inst.setRelTypeId(relTypeId);
			inst.setRelType(osRelType.getRelType());
			inst.setStatus(MBoolean.ENABLED.toString());
			inst.setIsMain(MBoolean.NO.name());
			
			inst.setTenantId(tenantId);

			OsGroup mainGroup = osGroupManager.get(groupId);
			OsGroup subGroup = osGroupManager.get(gId);

			if (mainGroup != null && subGroup != null) {
				inst.setAlias(mainGroup.getName() + "-" + subGroup.getName());
			}

			osRelInstManager.create(inst);
		}
		return new JsonResult(true, "成功加入！");
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
		String dimId = request.getParameter(OsGroup.DIMID);
		OsDimension osDimension = osDimensionManager.get(dimId);
		String gridData = request.getParameter("gridData");
		String tenantId = getCurTenantId(request);
		String repeatTokeyList =genGroupsBefore(gridData,tenantId,dimId);
		if(StringUtil.isNotEmpty(repeatTokeyList)){
			return new JsonResult(false, "用户组创建失败！以下组key已经存在："+repeatTokeyList);
		}
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
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			Object groupId = jsonObj.get(OsGroup.GROUPID);
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
			} else {
				osGroupManager.update(osGroup);
			}
		}
	}
	/**
	 * 产生用户组的上下级之前的key重复校验
	 *
	 * @param parentGroup
	 * @param tenantId
	 * @param osDimension
	 */
	private String genGroupsBefore(String groupJson,String tenantId,String dimId) {
		JSONArray jsonArray = JSONArray.fromObject(groupJson);
		String keyList ="";
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			Object groupId = jsonObj.get(OsGroup.GROUPID);
			if (groupId ==null) {
				OsGroup osGroup =  new OsGroup();
				osGroup.setGroupId(idGenerator.getSID());
				osGroup.setTenantId(tenantId);
				osGroup.setDimId(dimId);
				String key = jsonObj.getString("key");
				osGroup.setKey(key);
				boolean isCanCreat =canCreateOsGroup(osGroup);
				if(!isCanCreat && StringUtil.isEmpty(keyList)){
					keyList=key;
					continue;
				}
				if(!isCanCreat && StringUtil.isNotEmpty(keyList)){
					keyList+=","+key;
					continue;
				}
			}
		}
		return keyList;
	}
	private boolean canCreateOsGroup(OsGroup osGroup){
		return osGroupManager.getByDimIAndkey(osGroup.getDimId(),osGroup.getKey(),osGroup.getTenantId());
	}

	/**
	 * config:
	 * 结构:
	 * {
	 * 	type:"specific",
	 * 	groupId:"指定的组",
	 * 	grouplevel:"当type 为 level 时指定"
	 * }
	 * type:
	 * all:"打开对话框时没有指定父组织,默认为all"
	 * specific:指定组 
	 * current:当前组织作为根节点
	 * level:"指定级别,需要指定 grouplevel 级别"
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getInitData")
	@ResponseBody
	public List<OsGroup> getInitData(HttpServletRequest request,HttpServletResponse response){
		String parentId =  RequestUtil.getString(request, OsGroup.PARENTID, "0");
		
		//打开窗口初始化参数
		String config = request.getParameter("config");
		com.alibaba.fastjson.JSONObject configJson = null;
		String type = "all";
		if(StringUtils.isNotBlank(config)&&!("undefined".equals(config))){
			configJson = com.alibaba.fastjson.JSONObject.parseObject(config);
			type = configJson.getString("type");
			if(StringUtil.isEmpty(type)){
				type="all";
			}
		}
		
		List<OsGroup> result = null;
		IUser user = ContextUtil.getCurrentUser();		
		
		String groupId="";
		//全局范围
		if("all".equals(type)){
			groupId=parentId;
		}
		//当前组织
		else if("current".equals(type)){
			groupId=user.getMainGroupId();
			if(!"0".equals(parentId)){
				groupId=parentId;
			}
		}
		//指定组织
		else if("specific".equals(type)){
			groupId = configJson.getString(OsGroup.GROUPID);
			if(!"0".equals(parentId)){
				groupId=parentId;
			}
		}
		//指定级别
		else if("level".equals(type)){
			String rankLevel = configJson.getString("grouplevel");
			groupId =getByLevel( user, rankLevel);
			if(!"0".equals(parentId)){
				groupId=parentId;
			}
		}
		String tenantId=getCurTenantId(request);
		
		result = osGroupManager.getByDimAndParent(tenantId,OsDimension.DIM_ADMIN_ID,groupId);
		if(!"0".equals(groupId) && "0".equals(parentId)){
			result.add(osGroupManager.get(groupId));
		}
		
		return result;
	}
	
	private String getByLevel(IUser user,String rankLevel){
		Integer rank = Integer.parseInt(rankLevel);
		OsGroup group=osGroupManager.get(user.getMainGroupId());
		String groupId=user.getMainGroupId();
		//当前当前人所在的组织级别大于指定的组织。
		if(group.getRankLevel()>rank){
			String pid=group.getParentId();
			OsGroup pGroup=osGroupManager.get(pid);
			while(pGroup!=null && pGroup.getRankLevel()!=rank){
				pGroup=osGroupManager.get(pGroup.getParentId());
			}
			groupId=pGroup.getGroupId();
		}
		return groupId;
	}
		

}
