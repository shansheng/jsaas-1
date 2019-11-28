
package com.redxun.oa.ats.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsShiftType;
import com.redxun.oa.ats.manager.AtsShiftTypeManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 班次类型控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftType/")
public class AtsShiftTypeController extends MybatisListController{
    @Resource
    AtsShiftTypeManager atsShiftTypeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "班次类型")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
        	boolean flag = false;
            String[] ids=uId.split(",");
            for(String id:ids){
            	AtsShiftType type = atsShiftTypeManager.get(id);
            	if(AtsConstant.YES==type.getIsSys()) {
            		flag = true;
            		continue;
            	}
            	atsShiftTypeManager.delete(id);
            }
            if(flag) {
            	return new JsonResult(false,"此为系统预置数据，不能删除");
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
        AtsShiftType atsShiftType=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsShiftType=atsShiftTypeManager.get(pkId);
        }else{
        	atsShiftType=new AtsShiftType();
        }
        return getPathView(request).addObject("atsShiftType",atsShiftType);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsShiftType atsShiftType=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsShiftType=atsShiftTypeManager.get(pkId);
    	}else{
    		atsShiftType=new AtsShiftType();
    	}
    	return getPathView(request).addObject("atsShiftType",atsShiftType);
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
    public String getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        AtsShiftType atsShiftType = atsShiftTypeManager.getAtsShiftType(uId);
        String json = JSON.toJSONString(atsShiftType);
        return json;
    }
    
    /**
     * 查询所有的班次类型
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getJsonData")
    @ResponseBody
    public String getJsonData(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	List<AtsShiftType> types = atsShiftTypeManager.getAll();
    	JSONArray array = new JSONArray();
    	for (AtsShiftType type : types) {
    		JSONObject obj = new JSONObject();
			obj.put("id", type.getId());
			obj.put("text", type.getName());
			array.add(obj);
		}
        return array.toString();
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsShiftTypeManager;
	}

}
