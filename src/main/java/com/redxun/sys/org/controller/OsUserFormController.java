package com.redxun.sys.org.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.alibaba.fastjson.JSON;
import com.redxun.sys.core.entity.SysTree;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.EncryptUtil;
import com.redxun.core.util.StringUtil;
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
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsAttributeValueManager;
import com.redxun.sys.org.manager.OsCustomAttributeManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsInstUsersManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;

/**
 * 用户管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/org/osUser/")
public class OsUserFormController extends BaseFormController {

    @Resource
    private OsUserManager osUserManager;
    @Resource
    private OsRelTypeManager osRelTypeManager;
    @Resource
    private OsRelInstManager osRelInstManager;
    @Resource
    private  SysInstManager sysInstManager;
    @Resource
    private OsGroupManager osGroupManager;
    @Resource
    private OsCustomAttributeManager osCustomAttributeManager;
    @Resource
    private OsAttributeValueManager osAttributeValueManager;


	@Resource
	OsInstUsersManager osInstUsersManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("osUser")
    public OsUser processForm(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        OsUser osUser = null;
        if (StringUtils.isNotEmpty(userId)) {
            osUser = osUserManager.get(userId);
        } else {
            osUser = new OsUser();
            osUser.setFrom(OsUser.FROM_ADDED);

        }
        return osUser;
    }
    /**
     * 保存实体数据
     * @param request
     * @param osUser
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "组织结构", submodule = "系统用户")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("osUser") @Valid OsUser osUser, BindingResult result) {
    	//saveUserAttributes(request);

        String password=request.getParameter("pwd");
    	String userName=request.getParameter("userName");
		String editTenantId=osUser.getEditTenantId();
    	//获得用户当前机构Id
    	String tenantId= getTenantId(osUser);
        if(StringUtils.isEmpty(osUser.getUserId())){
        	OsUser user= osUserManager.getByUserName(StringUtils.isNotEmpty(userName)?userName:osUser.getUserNo(), tenantId);
        	if(user!=null){
        		result.reject("", "账号"+userName+"已经存在");
        	}
        }
        boolean flag = osUserManager.isEmailExist(osUser.getEmail(),osUser.getUserId());
        if(flag) {
        	result.reject("", "邮箱"+osUser.getEmail()+"已经存在");
        }
        if (result.hasErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }

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

        IUser user=ContextUtil.getCurrentUser();
    	//创建用户账号
        if (StringUtils.isEmpty(osUser.getUserId())) {
        	osUser.setUserId(IdUtil.getId());
        	String pwd=EncryptUtil.encryptSha256(password);
        	osUser.setPwd(pwd);
        	osUser.setTenantId(tenantId);
			osUser.setEditTenantId(tenantId);
            osUserManager.create(osUser);
            SysInst sysInst=sysInstManager.get(tenantId);
			OsInstUsers osInstUsers = new OsInstUsers();

			osInstUsers.setId(IdUtil.getId());
			osInstUsers.setApproveUser(user.getUserId());
			osInstUsers.setUserId(osUser.getUserId());
			osInstUsers.setStatus(osUser.getStatus());
			osInstUsers.setIsAdmin(0);
			osInstUsers.setDomain(sysInst.getDomain());
			osInstUsers.setTenantId(osUser.getTenantId());
			osInstUsers.setStatus(osUser.getStatus());
			osInstUsers.setApplyStatus("ENABLED");
			osInstUsers.setCreateType("CREATE");
			osInstUsersManager.create(osInstUsers);
            msg = getMessage("osUser.created", new Object[]{osUser.getIdentifyLabel()}, "用户成功创建!");
        } else {
        	osUser.setSyncWx(0);
        	if(StringUtil.isNotEmpty(editTenantId)){
        	    osUser.setEditTenantId(editTenantId);
            }
            osUserManager.update(osUser);
            msg = getMessage("osUser.updated", new Object[]{osUser.getIdentifyLabel()}, "用户成功更新!");
        }

        //添加用户的其他关系
    	String relInsts=request.getParameter("relInsts");
    	JSONArray relInstArr=JSONArray.fromObject(relInsts);
    	String isMain=MBoolean.NO.name();
    	for(int i=0;i<relInstArr.size();i++){
    		JSONObject rowObj=relInstArr.getJSONObject(i);
    		OsRelInst originOsRelInst = (OsRelInst) JSONObject.toBean(rowObj, OsRelInst.class);
    		String party1=JSONUtil.getString(rowObj,"party1");
    		String osRelTypeId=rowObj.getString("relTypeId");
    		OsRelType osRelType=osRelTypeManager.get(osRelTypeId);
    		String path = "";
    		List<String> pathList =null;
    		if("0".equals(party1)) {
    			path = rowObj.getString("path");
    		}else {
				List<OsRelInst> temp = osRelInstManager.getByParty2RelTypeId(party1, osRelTypeId);
	    		path = "0."+party1+".";
	    		if(temp!=null && temp.size()>0) {
					pathList = new ArrayList<String>();
					for(int k=0;k<temp.size();k++){
						pathList.add(temp.get(k).getPath()+osUser.getUserId()+".");
					}
	    		}else {
	    			OsRelInst inst=new OsRelInst();
	        		inst.setInstId(IdUtil.getId());
	             	inst.setParty1("0");
	             	inst.setParty2(party1);
	             	inst.setPath(path);
	             	inst.setRelType(osRelType.getRelType());
	             	inst.setRelTypeKey(osRelType.getKey());
	             	inst.setDim1(osRelType.getDimId1());
	             	inst.setIsMain(isMain);
	             	inst.setRelTypeId(osRelType.getId());
	             	inst.setStatus(MBoolean.ENABLED.toString());
	             	inst.setInstId(IdUtil.getId());
	             	inst.setTenantId(osUser.getTenantId());
	             	osRelInstManager.create(inst);
	    		}
	    		path = path+osUser.getUserId()+".";
    		}
    		String instId = rowObj.getString("instId");
    		if(StringUtil.isEmpty(instId)){
        		OsRelInst inst=new OsRelInst();
             	inst.setParty1(party1);
             	inst.setParty2(osUser.getUserId());
             	inst.setRelType(osRelType.getRelType());
             	inst.setRelTypeKey(osRelType.getKey());
             	inst.setDim1(osRelType.getDimId1());
             	inst.setIsMain(isMain);
             	inst.setRelTypeId(osRelType.getId());
             	inst.setStatus(MBoolean.ENABLED.toString());
             	inst.setTenantId(osUser.getTenantId());
				if(pathList !=null){
					for(int j=0;j<pathList.size();j++){
						inst.setInstId(IdUtil.getId());
						inst.setPath(pathList.get(j));
						osRelInstManager.create(inst);
					}
				}else{
					inst.setInstId(IdUtil.getId());
					inst.setPath(path);
					osRelInstManager.create(inst);
				}
    		}else{
    			osRelInstManager.update(originOsRelInst);
    		}

    	}
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

    private void saveUserAttributes(HttpServletRequest request){
    	String currentUserId=ContextUtil.getCurrentUserId();

    	String userId=RequestUtil.getString(request, "userId");
		osAttributeValueManager.removeByTargetId(userId);

		String jsonValue=RequestUtil.getString(request, "attrValue");
		String comboboList=RequestUtil.getString(request, "comboboList");
		for (Map.Entry<String, Object> entry : JSON.parseObject(jsonValue).entrySet()) {
			if( entry.getValue() ==null ||StringUtil.isEmpty(entry.getValue().toString())){continue;}
			OsAttributeValue  osAttributeValue=new OsAttributeValue();
			osAttributeValue.setId(IdUtil.getId());
			osAttributeValue.setAttributeId(entry.getKey().split("_")[1]);
			osAttributeValue.setTargetId(userId);
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


	@RequestMapping(value = "saveAttr", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult saveAttr(HttpServletRequest request, HttpServletResponse response) throws Exception{

		saveUserAttributes(request);

		return new JsonResult(true, "成功");


	}

}

