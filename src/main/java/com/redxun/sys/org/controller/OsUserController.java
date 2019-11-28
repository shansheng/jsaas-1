package com.redxun.sys.org.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.core.cache.CacheUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.EncryptUtil;
import com.redxun.sys.core.dao.SysTreeDao;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsAttributeValue;
import com.redxun.sys.org.entity.OsCustomAttribute;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsInstUsers;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsAttributeValueManager;
import com.redxun.sys.org.manager.OsCustomAttributeManager;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsInstUsersManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.wx.ent.manager.WxEntCorpManager;

/**
 * [OsUser]管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/org/osUser/")
public class OsUserController extends TenantListController{
    @Resource
    private OsUserManager osUserManager;
    @Resource
    OsGroupManager osGroupManager;
    @Resource
    private OsDimensionManager osDimensionManager;
    @Resource
    private OsRelTypeManager osRelTypeManager;
    @Resource
    private OsRelInstManager osRelInstManager;

    @Resource
    private SysInstManager sysInstManager;
    @Resource
    private WxEntCorpManager wxEntCorpManager;
    @Resource
    private OsCustomAttributeManager osCustomAttributeManager;
	@Resource
	private OsAttributeValueManager osAttributeValueManager;
	@Resource
	private CommonDao commonDao;
	@Resource
	private SysTreeManager sysTreeManager;
	@Resource
	private OsInstUsersManager osInstUsersManager;
	
    @Override
    protected QueryFilter getQueryFilter(HttpServletRequest request) {
    	QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    	String tenantId=getCurTenantId(request);
    	queryFilter.addFieldParam("iu.TENANT_ID_", tenantId);
    	queryFilter.addWhereClause(new QueryParam("iu.STATUS_",QueryParam.FIELD_TYPE_STRING,QueryParam.OP_IN,"'"+OsUser.STATUS_IN_JOB+"','"+OsUser.STATUS_OUT_JOB+"'"));
    	return queryFilter;
    }
    
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "组织结构", submodule = "系统用户")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        boolean hasAdmin=false;
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            
            for(String id:ids){
            	//超级管理员下不能更新为删除状态
            	OsUser user = osUserManager.get(id);
            	if(user.isSaaSAdmin()) {
            		hasAdmin=true;
            		continue;
            	}
	            user.setStatus(OsUser.STATUS_DEL_JOB);
	            osUserManager.update(user);

            }
        }
        String msg=hasAdmin?"操作成功,管理员不能删除!":"成功删除!";
        return new JsonResult(true,msg);
    }
 
    @RequestMapping("modifyPassword")
    @ResponseBody
    @LogEnt(action = "modifyPassword", module = "系统内核", submodule = "子系统")
    public JsonResult modifyPassword(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=request.getParameter("userId");
    	String password=request.getParameter("password");
    	
    	osUserManager.updPassword(userId, password);
    	
    	return new JsonResult(true,"成功修改密码！");
    }
  
    @RequestMapping("modifyMyPassword")
    @ResponseBody
    @LogEnt(action = "修改自己的密码!", module = "系统内核", submodule = "子系统")
    public JsonResult modifyMyPassword(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=ContextUtil.getCurrentUserId();
    	String password=request.getParameter("password");
    	osUserManager.updPassword(userId, password);
    	return new JsonResult(true,"成功修改密码！");
    }


	/**
	 * 用户修改用户密码
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("editForgetPwd")
	@ResponseBody
	public JsonResult editForgetPwd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String validCode=request.getParameter("validCode");
		//检查验证码
		String code = (String)request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_CONFIG_KEY);
		if(code==null || !code.equals(validCode)){
			return new JsonResult(false,"验证码不正确！");
		}
		String password=request.getParameter("newPwd");
		String newPwdRe=request.getParameter("newPwdRe");
		String emailOrAccount=request.getParameter("emailOrAccount");
		OsUser user = null;
		if(!StringUtil.vaildEmail(emailOrAccount)) {
			user= osUserManager.getByUserName(emailOrAccount);
		}else {
			user = osUserManager.getByEmail(emailOrAccount);
		}
		if(BeanUtil.isEmpty(user)) {
			return new JsonResult(false,"不存在此账户!");
		}
		if(user.getPwd().equals(EncryptUtil.hexToBase64(password.trim()))){
			return new JsonResult(false, "新密码和原始密码不能一样！");
		}
		osUserManager.updPassword(user.getUserId(), newPwdRe.trim());
		return new JsonResult(true,"成功修改密码！");
	}

    /**
     * 对话框的用户搜索
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("search")
    @ResponseBody
    public JsonPageResult<OsUser> search(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId=request.getParameter("groupId");
    	String instId=request.getParameter("instId");
    	String initDim=request.getParameter("initDim");
    	String initRankLevel=request.getParameter("initRankLevel");
    	String orgId=request.getParameter("orgId");
    	String orgconfig=request.getParameter("orgconfig");
    	String fullname=request.getParameter("fullname");
    	String email=request.getParameter("email");
    	String userNo=request.getParameter("userNo");
    	String tenantId=getCurTenantId(request);
    	if(StringUtil.isNotEmpty(instId)) {
    		tenantId = instId;
    	}
    	//用户组Id 需要关联用户关系实例来查找用户
    	if(StringUtils.isNotEmpty(groupId)){
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		//取得从属关系
    		OsRelType belongRelType=osRelTypeManager.getBelongRelType();
    		queryFilter.getParams().put("relTypeId",belongRelType.getId());
    		
    		OsGroup osGroup=osGroupManager.get(groupId);
    		if(osGroup!=null){
    			queryFilter.addParam("PATH_", osGroup.getPath()+"%");
    		}
    		if(StringUtils.isNotEmpty(fullname)){
    			queryFilter.addParam("FULLNAME_", "%" + fullname + "%");
    		}
    		if(StringUtils.isNotEmpty(email)){
    			queryFilter.addParam("EMAIL_", "%" +email + "%");
    		}
    		if(StringUtils.isNotEmpty(userNo)){
    			queryFilter.addParam("USER_NO_", "%" +userNo + "%");
    		}
    		queryFilter.addParam("iu.TENANT_ID_", tenantId);
    		
    		List<OsUser> list=osUserManager.getByGroupPathRelTypeId(queryFilter);
    		return new JsonPageResult<OsUser>(list, queryFilter.getPage().getTotalItems());
    	}else{
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		
    		queryFilter.getOrderByList().clear();
    	    
    		queryFilter.addFieldParam("iu.STATUS_", OsUser.STATUS_IN_JOB );
    		if(StringUtils.isNotEmpty(fullname)){
    			queryFilter.addLikeFieldParam("FULLNAME_", "%" +fullname + "%");
    		}
    		if(StringUtils.isNotEmpty(email)){
    			queryFilter.addLikeFieldParam("EMAIL_", "%" +email + "%");
    		}
    		if(StringUtils.isNotEmpty(userNo)){
    			queryFilter.addLikeFieldParam("USER_NO_", "%" +userNo+ "%");
    		}
    		if(StringUtils.isNotEmpty(orgconfig)) {
    			if("curOrg".equals(orgconfig)) {
    				queryFilter.addParam("userId", ContextUtil.getCurrentUserId());
    			}
    			if("selOrg".equals(orgconfig)) {
    				queryFilter.addParam("orgId", orgId);
    			}
    		}
    		queryFilter.addParam("initDim", initDim);
    		queryFilter.addParam("initRankLevel", initRankLevel);
    		queryFilter.addFieldParam("iu.TENANT_ID_", tenantId);
			List list=osUserManager.getAll(queryFilter);
    		return new JsonPageResult<OsUser>(list, queryFilter.getPage().getTotalItems());
    	}
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
        OsUser osUser=osUserManager.get(pkId);
        setUserStatus(osUser,getCurTenantId(request));
        return getPathView(request).addObject("osUser",osUser);
    }
    
    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	ModelAndView mv=getPathView(request);
    	boolean isWxEanble= wxEntCorpManager.isWxEnable();
    	mv.addObject("isWxEanble",isWxEanble);
    	return mv;
    }

	@RequestMapping("editAttr")
	public ModelAndView editAttr(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ModelAndView mv=getPathView(request);

		String userId=request.getParameter("userId");
		String tenantId=ContextUtil.getCurrentTenantId();

		List<SysTree> treeList =  sysTreeManager.getByCatKeyTenantId("CAT_CUSTOMATTRIBUTE",ContextUtil.getCurrentTenantId());
		List<OsCustomAttribute> osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTenantId(tenantId,OsUser.ATTR_USER);
		if(osCustomAttributes!=null){
			setAttributes(osCustomAttributes,userId);
		}

		mv.addObject("osCustomAttributes", osCustomAttributes).addObject("treeList",treeList);
		 return mv;
	}
	private void setAttributes(List<OsCustomAttribute> osCustomAttributes,String userId){
		for (int i = 0; i < osCustomAttributes.size(); i++) {
			OsCustomAttribute osCustomAttribute=osCustomAttributes.get(i);
			String attributeId=osCustomAttribute.getID();
			OsAttributeValue osAttributeValue=osAttributeValueManager.getSpecialValueByUser(attributeId,userId);//根据userId获取属性值
			if(osAttributeValue!=null){
				osCustomAttribute.setValue(osAttributeValue.getValue());
			}
		}
	}
	@RequestMapping("listAttributes")
	@ResponseBody
	public List<OsCustomAttribute> listAttributes(HttpServletRequest request,
												  HttpServletResponse response) throws Exception {
		String userId=request.getParameter("userId");
		String tenantId=ContextUtil.getCurrentTenantId();

		List<OsCustomAttribute> osCustomAttributes=null;
		osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTenantId(tenantId,OsUser.ATTR_USER);
		if(osCustomAttributes!=null){
			setAttributes(osCustomAttributes,userId);
		}
		return osCustomAttributes;
	}

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	String groupId=request.getParameter("groupId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	//绑定的用户账号列表
        //用户机构
        String editTenantId=request.getParameter("editTenantId");
        if(StringUtil.isNotEmpty(editTenantId) && "undefined".equals(editTenantId)){
            editTenantId=null;
        }

    	String tenantId=request.getParameter("tenantId");
    	OsGroup mainDep=null;
    	List<OsGroup> canDeps=null;
		List<OsInstUsers> osInstUsersList=null;
    	List<OsGroup> canGroups=null;
    	ModelAndView mv=getPathView(request);
    	osCustomAttributeManager.addCustomAttribute(mv);
    	OsUser osUser=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUser=osUserManager.get(pkId);
    		//tenantId=osUser.getTenantId();
    		if("true".equals(forCopy)){
    			osUser.setUserId(null);
    		}
			setUserStatus(osUser,(StringUtil.isNotEmpty(editTenantId)?editTenantId:ContextUtil.getCurrentTenantId()));
			
    		//获得主部门
    		mainDep=osGroupManager.getMainDeps(pkId,(StringUtil.isNotEmpty(editTenantId)?editTenantId:ContextUtil.getCurrentTenantId()));
    		if(mainDep!=null){
        		mv.addObject("mainDepId", mainDep.getGroupId());
        		mv.addObject("mainDepName",mainDep.getName());
        	}
    		
    		//获得其他用户组
    		canDeps=osGroupManager.getCanDeps(pkId,(StringUtil.isNotEmpty(editTenantId)?editTenantId:ContextUtil.getCurrentTenantId()));
    		if(canDeps!=null){
        		StringBuffer canDepIds=new StringBuffer();
        		StringBuffer canDepNames=new StringBuffer();
        		for(OsGroup g:canDeps){
        			canDepIds.append(g.getGroupId()).append(",");
        			canDepNames.append(g.getName()).append(",");
        		}
        		if(canDepIds.length()>0){
        			canDepIds.deleteCharAt(canDepIds.length()-1);
        			canDepNames.deleteCharAt(canDepNames.length()-1);
        		}
        		//构建其他部门选项
        		mv.addObject("canDepIds",canDepIds.toString()).addObject("canDepNames",canDepNames.toString());
        	}
    		
    		canGroups=osGroupManager.getCanGroups(pkId,editTenantId);
    	}else{
    		osUser=new OsUser();
    		osUser.setSex("Male");
    		osUser.setStatus(OsUser.STATUS_IN_JOB);
    	}
    	
    	
    	//传入了用户组
    	if(StringUtils.isNotEmpty(groupId) ){
    		mainDep=osGroupManager.get(groupId);
    		//为行程维度
    		if(mainDep!=null && mainDep.getDimId()!=null){
    			OsDimension dim = osDimensionManager.get(mainDep.getDimId());
	    		if(OsDimension.DIM_ADMIN.equals(dim.getDimKey())){
	    			//主部门
    	    		mv.addObject("mainDepId", mainDep.getGroupId());
    	    		mv.addObject("mainDepName",mainDep.getName());
	    	    
	    		}else{//为其他
	    			canGroups=new ArrayList<OsGroup>();
	    			canGroups.add(mainDep);
	    		}
    		}
    		//获取租户的tenantId
    		if(mainDep != null && mainDep.getTenantId() != null){
    			tenantId = mainDep.getTenantId();
    		}
    	}
    	//
    	if(canGroups!=null){
    		StringBuffer canGroupIds=new StringBuffer();
    		StringBuffer canGroupNames=new StringBuffer();
    		for(OsGroup g:canGroups){
    			canGroupIds.append(g.getGroupId()).append(",");
    			canGroupNames.append(g.getName()).append(",");
    		}
    		if(canGroupIds.length()>0){
    			canGroupIds.deleteCharAt(canGroupIds.length()-1);
    			canGroupNames.deleteCharAt(canGroupNames.length()-1);
    		}
    		//构建其他组选项
    		mv.addObject("canGroupIds",canGroupIds.toString()).addObject("canGroupNames",canGroupNames.toString());
    	}
    	
    	
    	String domain=null;
    	if(StringUtils.isNotEmpty(tenantId)){
    		SysInst sysInst=sysInstManager.get(tenantId);
    		if(sysInst!=null){
    			domain=sysInst.getDomain();
    		}
    	}else{
    		domain=ContextUtil.getTenant().getDomain();
    	}
    	buildCustomAttribute(mv, osUser);

    	if(StringUtil.isNotEmpty(editTenantId)){
            osUser.setEditTenantId(editTenantId);
        }

    	return mv.addObject("osUser",osUser).addObject("domain",domain).addObject("isSaasMode",WebAppUtil.getIsSaasMode())
    			.addObject("tenantId",tenantId);
    			
    }
    
	/**
	 * 构建自定义属性到edit页面
	 * @param modelAndView
	 * @param osUser
	 */
	private void  buildCustomAttribute(ModelAndView modelAndView,OsUser osUser){
		String userId=osUser.getUserId();

		List<SysTree> treeList = new ArrayList<SysTree>();
		List<OsCustomAttribute> osCustomAttributes = new ArrayList<OsCustomAttribute>();
		if(StringUtil.isNotEmpty(userId)){
			treeList = sysTreeManager.getByAttributeValueTargetId(userId);

			osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByUserId(userId);

			for (int i = 0; i < osCustomAttributes.size(); i++) {
				OsCustomAttribute osCustomAttribute=osCustomAttributes.get(i);
				String attributeId=osCustomAttribute.getID();
				OsAttributeValue osAttributeValue=osAttributeValueManager.getSpecialValueByUser(attributeId,userId);//根据userId获取属性值
				if(osAttributeValue!=null){
					osCustomAttribute.setValue(osAttributeValue.getValue());
				}
			}
		}
		modelAndView.addObject("osCustomAttributes", osCustomAttributes).addObject("treeList",treeList);
	}
    /**
     * 按用户组及关系类型查找用户
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("listByGroupIdRelTypeId")
    @ResponseBody
    public JsonPageResult listByGroupIdRelTypeId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId=request.getParameter("groupId");
    	String relTypeId=request.getParameter("relTypeId");

    	String instId=getCurTenantId(request);
    	QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    	queryFilter.addParam("groupId", groupId);
    	queryFilter.addParam("relTypeId", relTypeId);
    	queryFilter.addParam("tenantId", instId);

		Map<String,Object> params=queryFilter.getParams();
		String fullname=(String)params.get("FULLNAME_");
		if(StringUtils.isEmpty(fullname)){
			fullname=request.getParameter("fullname");
			if(StringUtils.isNotEmpty(fullname)){
				fullname="%"+fullname+"%";
			}
		}
		String userNo=(String)params.get("USER_NO_");
		if(StringUtils.isEmpty(userNo)){
			userNo=request.getParameter("userNo");
		}
		String sex=(String)params.get("SEX_");
		String userType=(String)params.get("USER_TYPE_");
		//用于组织机构下的条件查询
		if(StringUtils.isNotEmpty(fullname)){
    		queryFilter.addParam("fullname", fullname);
    	}
		
    	if(StringUtils.isNotEmpty(userNo)){
    		queryFilter.addParam("userNo", userNo);
    	}
    	if(StringUtils.isNotEmpty(sex)){
    		queryFilter.addParam("sex", sex);
    	}
    	if(StringUtils.isNotEmpty(userType)){
    		queryFilter.addParam("userType", userType);
    	}
    	List list =osUserManager.getByGroupIdRelTypeId(queryFilter);

    	return new JsonPageResult (list, queryFilter.getPage().getTotalItems());
    }
    
    /**
     * 取得用户下的用户组列表
     * @param request
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping("listByUserId")
    @ResponseBody
    public JsonPageResult listByUserId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=request.getParameter("userId");
    	List<OsGroup> osGroups=osGroupManager.getByUserId(userId);
    	JsonPageResult result=new JsonPageResult(osGroups,osGroups.size());
    	return result;
    }
    
    /**
     * 取得用户下所属的用户组
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getBelongGroups")
    @ResponseBody
    public JsonPageResult<OsGroup> getBelongGroups(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=request.getParameter("userId");
    	List<OsGroup> osGroups=osGroupManager.getBelongGroups(userId);
    	JsonPageResult<OsGroup> result=new JsonPageResult<OsGroup>(osGroups,osGroups.size());
    	return result;
    }
    
    /**
     * 加入用户
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("joinUser")
    @ResponseBody
    @LogEnt(action = "joinUser", module = "组织结构", submodule = "系统用户")
    public JsonResult joinUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	
    	String groupId=request.getParameter("groupId");
    	String relTypeId=request.getParameter("relTypeId");
    	String userIds=request.getParameter("userIds");
    	String tenantId=getCurTenantId(request);
    	
    	String dimId=  osGroupManager.get(groupId).getDimId();
    	if(StringUtil.isEmpty(groupId) || StringUtil.isEmpty(relTypeId) ) {
    		return new JsonResult(false,"请选择用户组和关系类型!");
    	}
    	
     	OsRelType osRelType=osRelTypeManager.get(relTypeId);
     	String[] uIds=userIds.split("[,]");
     	for(String userId:uIds){
     		OsRelInst inst1=osRelInstManager.getByParty1Party2RelTypeId(groupId, userId, relTypeId);
     		
     		if(inst1!=null) continue;
     		
     		String isMain=MBoolean.NO.name();
     		List<OsRelInst> instList=  osRelInstManager.getByRelTypeIdParty2(relTypeId, userId);
     		if(instList.size()==0){
     			isMain=MBoolean.YES.name();
     		}
     		
         	OsRelInst inst=new OsRelInst();
         	inst.setInstId(IdUtil.getId());
         	inst.setDim1(dimId);
         	inst.setParty1(groupId);
         	inst.setParty2(userId);
         	inst.setRelTypeKey(osRelType.getKey());
         	inst.setRelType(osRelType.getRelType());
         	inst.setRelTypeId(relTypeId);
         	inst.setIsMain(isMain);
         	inst.setTenantId(tenantId);
         	inst.setStatus(MBoolean.ENABLED.toString());
         	osRelInstManager.create(inst);
     	}
    	 
    	 return new JsonResult(true,"成功加入!");
    }
    
    
    /**
     * 添加用户组
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("addGroup")
    @ResponseBody
    @LogEnt(action = "addGroup", module = "组织结构", submodule = "系统用户")
    public JsonResult addGroup(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=request.getParameter("userId");
    	String groupIds=request.getParameter("groupIds");
    	String[]gIds=groupIds.split("[,]");
    	
    	//取得从属关系
    	OsRelType osRelType=osRelTypeManager.getBelongRelType();
    	for(String groupId:gIds){
    		OsRelInst inst1=osRelInstManager.getByParty1Party2RelTypeId(groupId, userId, osRelType.getId());
     		if(inst1!=null) continue;
     		
         	OsRelInst inst=new OsRelInst();
         	inst.setInstId(IdUtil.getId());
         	inst.setParty1(groupId);
         	inst.setParty2(userId);
         	inst.setRelTypeKey(osRelType.getKey());
         	inst.setDim1(OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
         	inst.setRelTypeId(osRelType.getId());

         	inst.setStatus(MBoolean.ENABLED.toString());
         	osRelInstManager.create(inst);
    	}
    	
    	return new JsonResult(true,"成功加入!");
    }
    
    /**
     * 移除关系的用户
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("unjoinUser")
    @ResponseBody
    @LogEnt(action = "unjoinUser", module = "组织结构", submodule = "系统用户")
    public JsonResult unjoinUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId=request.getParameter("groupId");
    	String relTypeId=request.getParameter("relTypeId");
    	String userIds=request.getParameter("userIds");
    	 if(StringUtils.isNotEmpty(groupId)&& StringUtils.isNotEmpty(relTypeId)){
         	String[] uIds=userIds.split("[,]");
         	for(String userId:uIds){
         		OsRelInst inst1=osRelInstManager.getByParty1Party2RelTypeId(groupId, userId, relTypeId);
	         	osRelInstManager.delete(inst1.getInstId());
         	}
         }
    	 return new JsonResult(true,"成功移除!");
    }
    /**
     * 移除用户的从属关系类型
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("removeBelongRelType")
    @ResponseBody
    @LogEnt(action = "removeBelongRelType", module = "组织结构", submodule = "系统用户")
    public JsonResult removeBelongRelType(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId=request.getParameter("groupId");
    	String userId=request.getParameter("userId");
    	OsRelInst inst1=osRelInstManager.getByParty1Party2RelTypeId(groupId, userId, OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
    	if(inst1!=null){
    		osRelInstManager.delete(inst1.getInstId());
    	}
    	return new JsonResult(true, "成功删除用户的从属关系");
    }
    
    /**
     * 用户对话框
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("dialog")
    @ResponseBody
    public ModelAndView dialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String tenantId=getCurTenantId(request);
    	//取得默认的行政维度
    	OsDimension adminDim=osDimensionManager.getByDimKeyTenantId(OsDimension.DIM_ADMIN, tenantId);
    	return getPathView(request).addObject("adminDim", adminDim);
    }


	/**
	 * 指定范围的用户对话框
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("rangeDialog")
	@ResponseBody
	public ModelAndView rangeDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String tenantId=getCurTenantId(request);
		String initDim = RequestUtil.getString(request,"initDim");
		String initRankLevel = RequestUtil.getString(request,"initRankLevel");

		//取得默认的行政维度
		OsDimension adminDim=osDimensionManager.getByDimKeyTenantId(OsDimension.DIM_ADMIN, tenantId);

		//指定了维度
		if(StringUtil.isNotEmpty(initDim)){
			adminDim= osDimensionManager.getByDimIdTenantId(initDim,tenantId);
		}

		return getPathView(request).addObject("adminDim", adminDim).addObject("initRankLevel",initRankLevel);
	}



	/**
	 * 用户编辑、查看明细，个人编辑等加入状态
	 */
	private void setUserStatus(OsUser osUser,String tenantId){
		if(osUser==null)return;;
		OsInstUsers osInstUsers= osInstUsersManager.getByUserIdAndTenantId(osUser.getUserId(),tenantId);
		if(osInstUsers!=null){
			osUser.setStatus(osInstUsers.getStatus());
		}
	}

    /**
     * 用户编辑个人信息
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("infoEdit")
    @ResponseBody
    public ModelAndView infoEdit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=ContextUtil.getCurrentUserId();
    	String groupId=request.getParameter("groupId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    
    	
    	OsGroup mainDep=null;
    	List<OsGroup> canDeps=null;
    	List<OsGroup> canGroups=null;
    	ModelAndView mv=getPathView(request);
    	OsUser osUser=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUser=osUserManager.get(pkId);
    		if("true".equals(forCopy)){
    			osUser.setUserId(null);
    		}
			setUserStatus(osUser,getCurTenantId(request));
			IUser curUser=ContextUtil.getCurrentUser();
			String logTenantId = curUser.getTenant().getTenantId();
    		//获得主部门
    		mainDep=osGroupManager.getMainDeps(pkId,logTenantId);
    		if(mainDep!=null){
        		mv.addObject("mainDepId", mainDep.getGroupId());
        		mv.addObject("mainDepName",mainDep.getName());
        	}
    		
    		//获得其他用户组
    		canDeps=osGroupManager.getCanDeps(pkId,logTenantId);
    		if(canDeps!=null){
        		StringBuffer canDepIds=new StringBuffer();
        		StringBuffer canDepNames=new StringBuffer();
        		for(OsGroup g:canDeps){
        			canDepIds.append(g.getGroupId()).append(",");
        			canDepNames.append(g.getName()).append(",");
        		}
        		if(canDepIds.length()>0){
        			canDepIds.deleteCharAt(canDepIds.length()-1);
        			canDepNames.deleteCharAt(canDepNames.length()-1);
        		}
        		//构建其他部门选项
        		mv.addObject("canDepIds",canDepIds.toString()).addObject("canDepNames",canDepNames.toString());
        	}
    		
    		canGroups=osGroupManager.getCanGroups(pkId,"");
    	}else{
    		osUser=new OsUser();
    		osUser.setSex("Male");
    		osUser.setStatus(OsUser.STATUS_IN_JOB);
    	}
    	//传入了用户组
    	if(StringUtils.isNotEmpty(groupId) ){
    		mainDep=osGroupManager.get(groupId);
    		//为行程维度
    		if(mainDep.getDimId()!=null){
        		OsDimension dim = osDimensionManager.get(mainDep.getDimId());
	    		if(OsDimension.DIM_ADMIN.equals(dim.getDimKey())){
	    			//主部门
    	    		mv.addObject("mainDepId", mainDep.getGroupId());
    	    		mv.addObject("mainDepName",mainDep.getName());
	    	    
	    		}else{//为其他
	    			canGroups=new ArrayList<OsGroup>();
	    			canGroups.add(mainDep);
	    		}
    		}
    	}
    	//
    	if(canGroups!=null){
    		StringBuffer canGroupIds=new StringBuffer();
    		StringBuffer canGroupNames=new StringBuffer();
    		for(OsGroup g:canGroups){
    			canGroupIds.append(g.getGroupId()).append(",");
    			canGroupNames.append(g.getName()).append(",");
    		}
    		if(canGroupIds.length()>0){
    			canGroupIds.deleteCharAt(canGroupIds.length()-1);
    			canGroupNames.deleteCharAt(canGroupNames.length()-1);
    		}
    		//构建其他组选项
    		mv.addObject("canGroupIds",canGroupIds.toString()).addObject("canGroupNames",canGroupNames.toString());
    	}
    	
    	String tenantId=request.getParameter("tenantId");
    	String domain=null;
    	if(StringUtils.isNotEmpty(tenantId)){
    		SysInst sysInst=sysInstManager.get(tenantId);
    		if(sysInst!=null){
    			domain=sysInst.getDomain();
    		}
    	}else{
    		domain=ContextUtil.getTenant().getDomain();
    	}
    	
    	return mv.addObject("osUser",osUser).addObject("domain",domain);
    }
    
    /**
     * 用户编辑个人信息
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("info")
    @ResponseBody
    public ModelAndView info(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=ContextUtil.getCurrentUserId();
    	String groupId=request.getParameter("groupId");
    	String relTypeId=request.getParameter("relTypeId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	
    	
    	OsGroup mainDep=null;
    	List<OsGroup> canDeps=null;
    	List<OsGroup> canGroups=null;
    	ModelAndView mv=getPathView(request);
    	OsUser osUser=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUser=osUserManager.get(pkId);
    		if("true".equals(forCopy)){
    			osUser.setUserId(null);
    		}
			IUser curUser=ContextUtil.getCurrentUser();
			String logTenantId = curUser.getTenant().getTenantId();
    		//获得主部门
    		mainDep=osGroupManager.getMainDeps(pkId,logTenantId);
    		if(mainDep!=null){
        		mv.addObject("mainDepId", mainDep.getGroupId());
        		mv.addObject("mainDepName",mainDep.getName());
        	}
    		
    		//获得其他用户组
    		canDeps=osGroupManager.getCanDeps(pkId,logTenantId);
    		if(canDeps!=null){
        		StringBuffer canDepIds=new StringBuffer();
        		StringBuffer canDepNames=new StringBuffer();
        		for(OsGroup g:canDeps){
        			canDepIds.append(g.getGroupId()).append(",");
        			canDepNames.append(g.getName()).append(",");
        		}
        		if(canDepIds.length()>0){
        			canDepIds.deleteCharAt(canDepIds.length()-1);
        			canDepNames.deleteCharAt(canDepNames.length()-1);
        		}
        		//构建其他部门选项
        		mv.addObject("canDepIds",canDepIds.toString()).addObject("canDepNames",canDepNames.toString());
        	}
    		
    		canGroups=osGroupManager.getCanGroups(pkId,"");
    	}else{
    		osUser=new OsUser();
    		osUser.setSex("Male");
    		osUser.setStatus(OsUser.STATUS_IN_JOB);
    	}
    	//传入了用户组
    	if(StringUtils.isNotEmpty(groupId) ){
    		mainDep=osGroupManager.get(groupId);
    		//为行程维度
    		if(mainDep.getDimId()!=null){
        		OsDimension dim = osDimensionManager.get(mainDep.getDimId());
	    		if(OsDimension.DIM_ADMIN.equals(dim.getDimKey())){
	    			//主部门
    	    		mv.addObject("mainDepId", mainDep.getGroupId());
    	    		mv.addObject("mainDepName",mainDep.getName());
	    	    
	    		}else{//为其他
	    			canGroups=new ArrayList<OsGroup>();
	    			canGroups.add(mainDep);
	    		}
    		}
    	}
    	//
    	if(canGroups!=null){
    		StringBuffer canGroupIds=new StringBuffer();
    		StringBuffer canGroupNames=new StringBuffer();
    		for(OsGroup g:canGroups){
    			canGroupIds.append(g.getGroupId()).append(",");
    			canGroupNames.append(g.getName()).append(",");
    		}
    		if(canGroupIds.length()>0){
    			canGroupIds.deleteCharAt(canGroupIds.length()-1);
    			canGroupNames.deleteCharAt(canGroupNames.length()-1);
    		}
    		//构建其他组选项
    		mv.addObject("canGroupIds",canGroupIds.toString()).addObject("canGroupNames",canGroupNames.toString());
    	}
    	
    	String tenantId=request.getParameter("tenantId");
    	String domain=null;
    	if(StringUtils.isNotEmpty(tenantId)){
    		SysInst sysInst=sysInstManager.get(tenantId);
    		if(sysInst!=null){
    			domain=sysInst.getDomain();
    		}
    	}else{
    		domain=ContextUtil.getTenant().getDomain();
    	}
    	
    	return mv.addObject("osUser",osUser).addObject("domain",domain);
    }
    
	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return osUserManager;
	}
	
	@RequestMapping("listTenantUser")
	@ResponseBody
	public List<OsUser> listTenantUser(HttpServletRequest request,HttpServletResponse response){
		String tenantId=ContextUtil.getCurrentTenantId();
		List<OsUser> osUsers=osUserManager.getAllByTenantId(tenantId);
		return osUsers;
	}
	
	
	
	@RequestMapping("updateIsAdmin")
	@ResponseBody
	public JsonResult updateIsAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Integer isAdmin=RequestUtil.getInt(request, "flag", 0);
		String userId=RequestUtil.getString(request, "userId");
		String tenantId=RequestUtil.getString(request, "tenantId");
		osInstUsersManager.updateIsAdmin(userId, isAdmin, tenantId);
		return new JsonResult(true,"设置成功");
	}
	
	@RequestMapping("getSaasAdmin")
	@ResponseBody
	public JsonPageResult<OsUser> getSaasAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		List<OsUser> users =osUserManager.getAll(queryFilter);
		return new JsonPageResult<OsUser>(true, users, queryFilter.getPage().getTotalItems(),"获取成功");
	}
	
	
	@RequestMapping("getInstAdmin")
    @ResponseBody
    public JsonPageResult<OsUser> getInstAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("iu.IS_ADMIN_", 1);
		String tenantId=RequestUtil.getString(request, "tenantId");
		if(StringUtil.isNotEmpty(tenantId)){
			queryFilter.addFieldParam("iu.TENANT_ID_", tenantId);
		}
		List<OsUser> list=osUserManager.getAll(queryFilter);
		return new JsonPageResult<OsUser>(list, queryFilter.getPage().getTotalItems());
    }

}
