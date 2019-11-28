
package com.redxun.sys.transset.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.sys.transset.entity.SysTransferSetting;
import com.redxun.sys.transset.manager.SysTransferSettingManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * 权限转移设置表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/transset/sysTransferSetting/")
public class SysTransferSettingController extends MybatisListController{
    @Resource
    SysTransferSettingManager sysTransferSettingManager;
    @Resource
    OsUserManager osUserManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "权限转移设置表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysTransferSettingManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
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
        String pkId=RequestUtil.getString(request, "pkId");
        SysTransferSetting sysTransferSetting=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysTransferSetting=sysTransferSettingManager.get(pkId);
        }else{
        	sysTransferSetting=new SysTransferSetting();
        }
        return getPathView(request).addObject("sysTransferSetting",sysTransferSetting);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysTransferSetting sysTransferSetting=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysTransferSetting=sysTransferSettingManager.get(pkId);
    	}else{
    		sysTransferSetting=new SysTransferSetting();
    	}
    	 List<KeyValEnt> constantItem = sysTransferSettingManager.getHandlers();
    	return getPathView(request).addObject("sysTransferSetting",sysTransferSetting).addObject("constantItem", constantItem);
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
    public SysTransferSetting getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysTransferSetting sysTransferSetting = sysTransferSettingManager.getSysTransferSetting(uId);
        return sysTransferSetting;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "权限转移设置表")
    public JsonResult save(HttpServletRequest request, @RequestBody SysTransferSetting sysTransferSetting, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysTransferSetting.getId())) {
            sysTransferSettingManager.create(sysTransferSetting);
            msg = getMessage("sysTransferSetting.created", new Object[]{sysTransferSetting.getIdentifyLabel()}, "[权限转移设置表]成功创建!");
        } else {
        	String id=sysTransferSetting.getId();
        	SysTransferSetting oldEnt=sysTransferSettingManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysTransferSetting);
            sysTransferSettingManager.update(oldEnt);
       
            msg = getMessage("sysTransferSetting.updated", new Object[]{sysTransferSetting.getIdentifyLabel()}, "[权限转移设置表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

    @RequestMapping("getConstantItem")
	@ResponseBody
	public List<KeyValEnt> getConstantItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<KeyValEnt> values=sysTransferSettingManager.getHandlers();
		return values;
	}
    
    @RequestMapping("mgr")
    public ModelAndView mgr(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysTransferSetting sysTransferSetting=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysTransferSetting=sysTransferSettingManager.get(pkId);
    	}else{
    		sysTransferSetting=new SysTransferSetting();
    	}
    	return getPathView(request).addObject("sysTransferSetting",sysTransferSetting).addObject("osUser", ContextUtil.getCurrentUser()).addObject("tenantId", ContextUtil.getCurrentTenantId());
    }
    
    @RequestMapping("jsonAll")
	@ResponseBody
	public List<SysTransferSetting> jsonAll(HttpServletRequest request,HttpServletResponse response){
		List<SysTransferSetting> setList=sysTransferSettingManager.getInvailAll();
		return setList;
	}
    
    @RequestMapping("excuteSelectSql")
	@ResponseBody
	public JSONObject excuteSelectSql(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = RequestUtil.getString(request, "id");
		if (id == null) {
			return null;
		}
		String authorId = RequestUtil.getString(request, "authorId");
		SysTransferSetting sysTransDef = sysTransferSettingManager.get(id);
		
		List<Map<String, Object>> list = sysTransferSettingManager.excuteSelectSql(sysTransDef, authorId);
		
		Map<String, Object> mapList = null;
		if(BeanUtil.isEmpty(list)) {
			mapList = new HashMap<String,Object>();
		}else {
			mapList = list.get(0);
		}
		JSONObject json = new JSONObject();
		json.put("id", sysTransDef.getId());
		json.put("name", sysTransDef.getName());
		
		JSONArray resultList = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("type", "checkcolumn");
		obj.put("width", "20");
		resultList.add(obj);
		for (String dataMap : mapList.keySet()) {
			if("id".equals(dataMap) || "name".equals(dataMap)) {
				continue;
			}
			obj = new JSONObject();
			obj.put("field", dataMap.toLowerCase());
			obj.put("header", dataMap.toLowerCase());
			obj.put("width", "120");
			obj.put("sortField", dataMap);
			obj.put("headerAlign", "center");
			resultList.add(obj);
		}
		json.put("columns", resultList);
		return json;
	}
    
    @RequestMapping("excuteSelectSqlData")
   	public void excuteSelectSqlData(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String id = RequestUtil.getString(request, "id");
		if (id == null) {
			return;
		}
		String authorId = RequestUtil.getString(request, "authorId");
		SysTransferSetting sysTransDef = sysTransferSettingManager.get(id);
    	List<Map<String, Object>> list = sysTransferSettingManager.excuteSelectSql(sysTransDef, authorId);
		/**oracle 字段改成小写 */
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> dataMap : list) {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			for (String key : dataMap.keySet()) {
				resultMap.put(key.toLowerCase(),dataMap.get(key)==null?"":dataMap.get(key));
			}
			result.add(resultMap);
		}
		
		response.setContentType("application/json");
		QueryFilter queryFilter=getQueryFilter(request);
		
		JsonPageResult<?> result1=new JsonPageResult(result,result.size());
		String jsonResult=iJson.toJson(result1);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
    }
   	

	@RequestMapping("excuteUpdateSql")
	@ResponseBody
	public JsonResult excuteUpdateSql(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = RequestUtil.getString(request, "id");
		String authorId = RequestUtil.getString(request, "authorId");
		String targetPersonId = RequestUtil.getString(request, "targetPersonId");
		String selectedItem = RequestUtil.getString(request, "selectedItem");

		OsUser author = osUserManager.get(authorId);
		OsUser targetPerson = osUserManager.get(targetPersonId);
		
		SysTransferSetting sysTransDef = sysTransferSettingManager.get(id);
		try {
			sysTransferSettingManager.excuteUpdateSql(sysTransDef, author, targetPerson, selectedItem);
			return new JsonResult(true, "操作成功!");
		} catch (Exception e) {
			return new JsonResult(false, "操作失败："+e.getMessage());
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysTransferSettingManager;
	}
}
