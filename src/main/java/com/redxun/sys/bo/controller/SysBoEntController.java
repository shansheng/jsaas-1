
package com.redxun.sys.bo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;

/**
 * 表单实体对象控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/bo/sysBoEnt/")
public class SysBoEntController extends MybatisListController{
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
    SysBoDefManager sysBoDefManager;
    @Resource
    SysBoAttrManager sysBoAttrManager;
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysBoEntManager.delete(id);
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
        SysBoEnt sysBoEnt=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysBoEnt=sysBoEntManager.get(pkId);
        }else{
        	sysBoEnt=new SysBoEnt();
        }
        return getPathView(request).addObject("sysBoEnt",sysBoEnt);
    }
    
    /**
     * 获得业务实体方法
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getBoEntInfo")
    @ResponseBody
    public JsonResult getBoEntInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String entId=request.getParameter("entId");
    	SysBoEnt sysBoEnt=sysBoEntManager.get(entId);
    	List<SysBoAttr> attrList=sysBoAttrManager.getAttrsByEntId(entId);
    	String attJson=iJson.toJson(attrList);
    	sysBoEnt.setSysBoAttrsJson(attJson);
    	JsonResult result=new JsonResult(true);
    	result.setData(sysBoEnt);
    	return result;
    }

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=RequestUtil.getString(request, "pkId");
        String categoryId=RequestUtil.getString(request, "categoryId");
        boolean showFormDb=true;
		String entGenMode = null;
        if(StringUtil.isNotEmpty(pkId)){
        	SysBoEnt sysBoEnt=sysBoEntManager.get(pkId);
        	showFormDb=sysBoEnt.isDbMode();
			entGenMode = sysBoEnt.getGenMode();
        }
        return getPathView(request).addObject("pkId",pkId)
        		.addObject("showFormDb",showFormDb).addObject("entGenMode",entGenMode)
        		.addObject("categoryId",categoryId);
        		
    }
    
    
    @RequestMapping("getByEntId/{entId}")
    @ResponseBody
    public SysBoEnt getByEntId(@PathVariable(value="entId") String entId){
    	SysBoEnt boEnt=sysBoEntManager.getByEntId(entId);
    	return boEnt;
    }
    
        
    @RequestMapping("getTreeByBoDefId")
    @ResponseBody
    public JSONArray getTreeByBoDefId(HttpServletRequest request ){
    	String bodefId=RequestUtil.getString(request, "boDefId");
    	int needSub=RequestUtil.getInt(request, "needSub", 1);
    	
    	
    	JSONArray jsonAry=new JSONArray();
    	if(StringUtils.isEmpty(bodefId)){
    		return jsonAry;
    	}
    	if(bodefId.indexOf(",")!=-1){
    		bodefId=bodefId.substring(0, bodefId.indexOf(","));
    	}
    	SysBoEnt ent= sysBoEntManager.getByBoDefId(bodefId);
    	for(SysBoAttr attr:ent.getSysBoAttrs()){
    		JSONObject jsonField=new JSONObject();
    		jsonField.put("id", attr.getName());
    		jsonField.put("text", attr.getComment());
    		jsonField.put("dataType", attr.getDataType());
    		jsonField.put("pid", "");
    		jsonField.put("type", "field");
    		jsonAry.add(jsonField);
    	}
    	if(needSub==0) return jsonAry;
    	
    	for(SysBoEnt subEnt : ent.getBoEntList()){
    		JSONObject tb=new JSONObject();
    		tb.put("id", subEnt.getName());
    		tb.put("text", subEnt.getComment());
    		tb.put("pid", "");
    		tb.put("type", "table");
    		jsonAry.add(tb);
    		
    		for(SysBoAttr attr:subEnt.getSysBoAttrs()){
        		JSONObject jsonField=new JSONObject();
        		jsonField.put("id", attr.getName());
        		jsonField.put("text", attr.getComment());
        		jsonField.put("dataType", attr.getDataType());
        		jsonField.put("pid", subEnt.getName());
        		jsonField.put("type", "field");
        		jsonAry.add(jsonField);
        	}
    	}
    	return jsonAry;
    	
    }
    
    @RequestMapping("getBoEntByBoDefId")
    @ResponseBody
    public SysBoEnt getBoEntByBoDefId(HttpServletRequest request ){
    	String bodefId=RequestUtil.getString(request, "boDefId");
    	SysBoEnt sysBoEnt= sysBoEntManager.getByBoDefId(bodefId);
    	return sysBoEnt;
    }
    
    @RequestMapping("getFieldByBoDefId")
    @ResponseBody
    public List<SysBoAttr> getFieldBy(HttpServletRequest  request,HttpServletResponse response){
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	String entName=RequestUtil.getString(request, "tableName");
    	if(entName.equals("_main")){
    		SysBoEnt sysBoEnt= sysBoEntManager.getByBoDefId(boDefId);
    		entName=sysBoEnt.getName();
    	}
    	SysBoRelation sysBoRelation=sysBoDefManager.getEntByEntNameAndDefId(boDefId, entName);
    	String entId=sysBoRelation.getBoEntid();
    	List<SysBoAttr> sysBoAttrs=sysBoEntManager.getAttrsByEntId(entId);
    	return sysBoAttrs;
    }
    
    @RequestMapping("getCommonField")
    @ResponseBody
    public JSONArray getCommonField(HttpServletRequest request ){
    	
    	JSONArray jsonAry=new JSONArray();
    	
    	addCommonField(jsonAry,"");
    	
    	return jsonAry;
    	
    }
    
    
    
    private void addCommonField(JSONArray ary,String parentId){
    	JSONObject pk=new JSONObject();
		pk.put("id", SysBoEnt.SQL_PK);
		pk.put("text", "主键");
		pk.put("pid", parentId);
		pk.put("type", "common");
		
		JSONObject fk=new JSONObject();
		fk.put("id", SysBoEnt.SQL_FK);
		fk.put("text", "外键");
		fk.put("pid", parentId);
		fk.put("type", "common");
		
		JSONObject uid=new JSONObject();
		uid.put("id", SysBoEnt.FIELD_CREATE_BY);
		uid.put("text", "用户ID");
		uid.put("pid", parentId);
		uid.put("type", "common");
		
		JSONObject gid=new JSONObject();
		gid.put("id", SysBoEnt.FIELD_GROUP);
		gid.put("text", "组ID");
		gid.put("pid", parentId);
		gid.put("type", "common");
		
		JSONObject ctime=new JSONObject();
		ctime.put("id", SysBoEnt.FIELD_CREATE_TIME);
		ctime.put("text", "创建时间");
		ctime.put("pid", parentId);
		ctime.put("type", "common");
		
		JSONObject utime=new JSONObject();
		utime.put("id", SysBoEnt.FIELD_UPDATE_TIME);
		utime.put("text", "更新时间");
		utime.put("pid", parentId);
		utime.put("type", "common");
		
		ary.add(pk);
		ary.add(fk);
		ary.add(uid);
		ary.add(gid);
		ary.add(ctime);
		ary.add(utime);
		
    }
    
    @RequestMapping("saveBoEnt")
    @ResponseBody
    public JsonResult saveBoEnt(@RequestBody JSONObject jsonObj){
    	JsonResult jsonResult= sysBoEntManager.saveBoEnt(jsonObj);
		return jsonResult;
    }

	/**
	 * 根据实体id生成物理表
	 * @param request
	 * @return
	 */
	@RequestMapping("creatBoTable")
	@ResponseBody
	public JsonResult creatBoTable(HttpServletRequest request){
		String pkId=RequestUtil.getString(request, "pkId");
		JsonResult jsonResult= sysBoEntManager.creatBoTable(pkId);
		return jsonResult;
	}

	/**
	 * 根据表名删除物理表
	 * @param request
	 * @return
	 */
	@RequestMapping("deleteBoTable")
	@ResponseBody
	public JsonResult deleteBoTable(HttpServletRequest request){
		String pkId=RequestUtil.getString(request, "pkId");
		String tableName=RequestUtil.getString(request, "tableName");
		JsonResult jsonResult= sysBoEntManager.deleteBoTable(tableName,pkId);
		return jsonResult;
	}
    
    @RequestMapping("copy")
    public ModelAndView  copy(HttpServletRequest request){
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysBoEnt ent=sysBoEntManager.get(pkId);
    	ModelAndView mv=getPathView(request).addObject("pkId",pkId)
    			.addObject("ent", ent);
    	return mv;
    }
    
    @RequestMapping("copyNew")
    @ResponseBody
    public JsonResult  copyNew(@RequestBody SysBoEnt boEnt){
    	JsonResult jsonResult= sysBoEntManager.copyNew(boEnt);
		return jsonResult;
    }

	@Override
	public MybatisBaseManager getBaseManager() {
		return sysBoEntManager;
	}



}
