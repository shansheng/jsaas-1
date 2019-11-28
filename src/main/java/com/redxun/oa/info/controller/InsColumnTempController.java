
package com.redxun.oa.info.controller;

import java.util.List;

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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.info.entity.InsColumnTemp;
import com.redxun.oa.info.manager.InsColumnTempManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 栏目模板管理表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/insColumnTemp/")
public class InsColumnTempController extends MybatisListController{
    @Resource
    InsColumnTempManager insColumnTempManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "栏目模板管理表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        StringBuffer msg = new StringBuffer();
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	InsColumnTemp temp = insColumnTempManager.get(id);
            	if(insColumnTempManager.ISSYS.equals(temp.getIsSys())) {
            		msg.append(temp.getName()+"为系统预设模板，不能删除<br>");
            		continue;
            	}
                insColumnTempManager.delete(id);
            }
        }
        if(msg.length()>0) {
        	return new JsonResult(false,msg.toString());
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
        InsColumnTemp insColumnTemp=null;
        if(StringUtils.isNotEmpty(pkId)){
           insColumnTemp=insColumnTempManager.get(pkId);
        }else{
        	insColumnTemp=new InsColumnTemp();
        }
        return getPathView(request).addObject("insColumnTemp",insColumnTemp);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	InsColumnTemp insColumnTemp=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		insColumnTemp=insColumnTempManager.get(pkId);
    	}else{
    		insColumnTemp=new InsColumnTemp();
    	}
    	return getPathView(request).addObject("insColumnTemp",insColumnTemp);
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
    public InsColumnTemp getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        InsColumnTemp insColumnTemp = insColumnTempManager.getInsColumnTemp(uId);
        return insColumnTemp;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "oa", submodule = "栏目模板管理表")
    public JsonResult save(HttpServletRequest request, @RequestBody InsColumnTemp insColumnTemp, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        
        boolean rtn=insColumnTempManager.isKeyExist(insColumnTemp);
        if(rtn){
        	return new JsonResult(false, "栏目模板key重复!");
        }
        String msg = null;
        if (StringUtils.isEmpty(insColumnTemp.getId())) {
            insColumnTempManager.create(insColumnTemp);
            msg = getMessage("insColumnTemp.created", new Object[]{insColumnTemp.getIdentifyLabel()}, "[栏目模板管理表]成功创建!");
        } else {
        	String id=insColumnTemp.getId();
        	InsColumnTemp oldEnt=insColumnTempManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, insColumnTemp);
            insColumnTempManager.update(oldEnt);
       
            msg = getMessage("insColumnTemp.updated", new Object[]{insColumnTemp.getIdentifyLabel()}, "[栏目模板管理表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@RequestMapping("getJsonData")
    @ResponseBody
    public JSONArray getJsonData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		List<InsColumnTemp> list = insColumnTempManager.getAll();
        JSONArray array = new JSONArray();
		
        for (InsColumnTemp temp : list) {
        	if(!"1".equals(temp.getStatus())) {
        		continue;
        	}
        	JSONObject obj = new JSONObject();
        	obj.put("id", temp.getKey());
        	obj.put("text", temp.getName());
        	array.add(obj);
		}
        return array;
    }
	
	@RequestMapping("getKey")
    @ResponseBody
    public InsColumnTemp getKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String key=RequestUtil.getString(request, "key");    	
        InsColumnTemp insColumnTemp = insColumnTempManager.getKey(key);
        return insColumnTemp;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return insColumnTempManager;
	}
}
