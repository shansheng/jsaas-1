package com.redxun.mobile.core.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonResult;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsAttributeValue;
import com.redxun.sys.org.entity.OsCustomAttribute;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsInstUsers;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsAttributeValueManager;
import com.redxun.sys.org.manager.OsCustomAttributeManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsInstUsersManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 手机端登录控制器
 * 
 * @author csx
 * @Email keitch@redxun.cn
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/mobile/oa/personalInfo/")
public class PersonalInfoController extends BaseFormController {

    @Resource
    private OsUserManager osUserManager;
    @Resource
    OsGroupManager osGroupManager;
    @Resource
    private SysInstManager sysInstManager;
	@Resource
	private OsInstUsersManager osInstUsersManager;
    @Resource
    private OsCustomAttributeManager osCustomAttributeManager;
    @Resource
    private OsAttributeValueManager osAttributeValueManager;
	@Resource
	OsRelInstManager osRelInstManager;
	
	@Resource
	OsRelTypeManager osRelTypeManager;
	
    @SuppressWarnings("rawtypes")
    @RequestMapping("getUser")
	@ResponseBody
	public Map<String,Object> getUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String, Object>();

    	String pkId=ContextUtil.getCurrentUserId();
    
    	OsGroup mainDep=null;
    	List<OsGroup> canDeps=null;
    	List<OsGroup> canGroups=null;
    	ModelAndView mv=getPathView(request);
    	OsUser osUser=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUser=osUserManager.get(pkId);
			setUserStatus(osUser,getCurTenantId(request));
			IUser curUser=ContextUtil.getCurrentUser();
			String logTenantId = curUser.getTenant().getTenantId();
    		//获得主部门
    		mainDep=osGroupManager.getMainDeps(pkId,logTenantId);
    		if(mainDep!=null){
    			resultMap.put("mainDepId", mainDep.getGroupId());
    			resultMap.put("mainDepName",mainDep.getName());
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
    			resultMap.put("canDepIds", canDepIds.toString());
    			resultMap.put("canDepNames",canDepNames.toString());
        	}
    		
    		canGroups=osGroupManager.getCanGroups(pkId,"");
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
    		resultMap.put("canGroupIds",canGroupIds.toString());
    		resultMap.put("canGroupNames",canGroupNames.toString());
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
    	resultMap.put("osUser",osUser);
    	resultMap.put("domain",domain);
    	return resultMap;
    
    
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
    
    @RequestMapping(value = "editUser", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "editUser", module = "组织结构", submodule = "系统用户")
    public JsonResult editUser(HttpServletRequest request, @ModelAttribute("osUser") @Valid OsUser osUser, BindingResult result) {  
    	saveUserAttributes(request);

    	//获得用户当前机构Id
        String mainDepId=request.getParameter("mainDepId");
        String canDepIds=request.getParameter("canDepIds");	
        String canGroupIds=request.getParameter("canGroupIds");
        //主部门
        if(StringUtils.isNotEmpty(mainDepId)){
        	OsGroup osGroup=osGroupManager.get(mainDepId);
        	osUser.setMainDep(osGroup);
        }
        //从部门
        if(StringUtils.isNotEmpty(canDepIds)){
        	String[] canIds=canDepIds.split("[,]");
        	List<OsGroup> canDeps=new ArrayList<OsGroup>();
        	for(String cId:canIds){
        		OsGroup osGroup=osGroupManager.get(cId);
        		canDeps.add(osGroup);
        	}
        	osUser.setCanDeps(canDeps);
        }
        //其他用户组
        if(StringUtils.isNotEmpty(canGroupIds)){
        	String[] canIds=canGroupIds.split("[,]");
        	List<OsGroup> canGroups=new ArrayList<OsGroup>();
        	for(String cId:canIds){
        		OsGroup osGroup=osGroupManager.get(cId);
        		canGroups.add(osGroup);
        	}
        	osUser.setCanGroups(canGroups);
        }
        String msg = null;
       
    	//创建用户账号
    	osUser.setSyncWx(0);
        osUserManager.saveOrUpdate(osUser);
        msg = getMessage("osUser.updated", new Object[]{osUser.getIdentifyLabel()}, "用户成功更新!");
        
        return new JsonResult(true, msg);
    }
    
    /**
     * 获得用户的机构Id
     * @param osUser
     * @return
     */
    private String getTenantId(OsUser osUser){
    	String tenantId=osUser.getTenantId();
    	if(StringUtils.isEmpty(tenantId)){
    		tenantId=ContextUtil.getCurrentTenantId();
    	}
    	return tenantId;
    }
    
    @SuppressWarnings("rawtypes")
	@RequestMapping("editPassword")
    @ResponseBody
    public JsonResult editPassword(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String password=request.getParameter("password");
    	String userId=ContextUtil.getCurrentUserId();
    	osUserManager.updPassword(userId, password);
    	return new JsonResult(true,"成功修改密码！");
    }
    
    private void saveUserAttributes(HttpServletRequest request){
    	String currentUserId=ContextUtil.getCurrentUserId();
    	
    	String tenantId=ContextUtil.getCurrentTenantId();
    	String userId=RequestUtil.getString(request, "userId");
    	List<OsCustomAttribute> osCustomAttributes=osCustomAttributeManager.getUserTypeAttributeByTenantId(tenantId,OsUser.ATTR_USER);
    	for (int i = 0; i < osCustomAttributes.size(); i++) {
			OsCustomAttribute osCustomAttribute=osCustomAttributes.get(i);
			String attributeId=osCustomAttribute.getID();
			String value=RequestUtil.getString(request, "widgetType_"+attributeId);
			OsAttributeValue osAttributeValue=osAttributeValueManager.getSpecialValueByUser(attributeId, userId);
			if(osAttributeValue!=null){
				osAttributeValue.setValue(value);
				osAttributeValueManager.update(osAttributeValue);
			}else{
				osAttributeValue=new OsAttributeValue();
				osAttributeValue.setId(IdUtil.getId());
				osAttributeValue.setAttributeId(attributeId);
				osAttributeValue.setTargetId(userId);
				osAttributeValue.setValue(value);
				osAttributeValue.setCreateBy(currentUserId);
				osAttributeValue.setCreateTime(new Date());
				osAttributeValueManager.create(osAttributeValue);
			}
		}
    }
    
    
    
}
