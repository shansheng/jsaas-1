package com.redxun.bpm.core.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONObject;

/**
 * [BpmSolFv]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolFv/")
public class BpmSolFvController extends BaseListController{
    @Resource
    BpmSolFvManager bpmSolFvManager;
    @Resource
    BpmFormViewManager bpmFormViewManager;
    @Resource
    SysBoDefManager sysBoDefManager;
    @Resource
    BpmSolutionManager bpmSolutionManager;
   
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
    ContextHandlerFactory contextHandlerFactory;
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "方案的表单视图")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmSolFvManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        BpmSolFv bpmSolFv=null;
        if(StringUtils.isNotBlank(pkId)){
           bpmSolFv=bpmSolFvManager.get(pkId);
        }else{
        	bpmSolFv=new BpmSolFv();
        }
        return getPathView(request).addObject("bpmSolFv",bpmSolFv);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	BpmSolFv bpmSolFv=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmSolFv=bpmSolFvManager.get(pkId);
    	}else{
    		bpmSolFv=new BpmSolFv();
    	}
    	return getPathView(request).addObject("bpmSolFv",bpmSolFv);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmSolFvManager;
	}
	
	@RequestMapping("formViewTabRights")
	public ModelAndView formViewTabRights(HttpServletRequest request,HttpServletResponse response){
		String tenantId = ContextUtil.getCurrentTenantId();
		com.alibaba.fastjson.JSONObject typeJson = ProfileUtil.getProfileTypeJson();
		String pkId = request.getParameter("pkId");
		BpmSolFv bpmSolFv = bpmSolFvManager.get(pkId);
		String tabRight = bpmSolFv.getTabRights();
		String formUrl = bpmSolFv.getFormUri();
		if (StringUtils.isBlank(formUrl) || StringUtils.isBlank(tabRight)) {// 如果本节点没有设置表单并且没有设置权限
			if (!BpmFormView.SCOPE_PROCESS.equals(bpmSolFv.getNodeId())) {// 如果不是设置在流程
				bpmSolFv = bpmSolFvManager.getBySolIdActDefIdNodeId(bpmSolFv.getSolId(), bpmSolFv.getActDefId(), "_PROCESS");
				formUrl = bpmSolFv.getFormUri();
			}
		}
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(formUrl, tenantId);
		String title = bpmFormView.getTitle();
		JSONObject jsonObject;
		if (StringUtils.isNotBlank(tabRight) && !"\"\"".equals(tabRight)) {
			jsonObject = JSONObject.fromObject(tabRight);
		} else {
			jsonObject = null;
		}
		String[] titleArray = title.split("#page#");
		String tabTitle = "";
		for (int i = 0; i < titleArray.length; i++) {
			tabTitle = tabTitle + titleArray[i] + ",";
		}
		tabTitle = tabTitle.substring(0, tabTitle.length() - 1);
		return this.getPathView(request).addObject("titleArray", tabTitle).addObject("jsonObject", jsonObject).addObject("pkId", pkId).addObject("typeJson", typeJson);

	}
	
	@RequestMapping("boSetting")
	public ModelAndView boSetting(HttpServletRequest request,HttpServletResponse response){
		//多个boDefId,用,分割
		String boDefId=request.getParameter("boDefId");
		String actDefId=request.getParameter("actDefId");
		String nodeId=request.getParameter("nodeId");
		String solId=request.getParameter("solId");
		
		BpmSolFv bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
		//查找是不是全局的表单实体
//		if(bpmSolFv==null && !"_PROCESS".equals(nodeId)){
//			bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId,actDefId,"_PROCESS");
//		}
		List<SysBoEnt> sysBoEntList=new ArrayList<SysBoEnt>();
		String[]boDefIds=boDefId.split("[,]");
		
		for(String bDefId:boDefIds){
			List boEntList=sysBoEntManager.getListByBoDefId(bDefId, true);
			sysBoEntList.addAll(boEntList);
		}
		String initScript="";
		String saveScript="";
		String boAttSettings="";
		if(bpmSolFv!=null && StringUtils.isNotEmpty(bpmSolFv.getDataConfs())){
			com.alibaba.fastjson.JSONObject data=com.alibaba.fastjson.JSONObject.parseObject(bpmSolFv.getDataConfs());
			if(data!=null){
				initScript=data.getString("initScript");
				saveScript=data.getString("saveScript");
				boAttSettings=data.getString("boAttSettings");
			}
		}
		return this.getPathView(request).addObject("bpmSolFv",bpmSolFv)
				.addObject("sysBoEntList", sysBoEntList)
				.addObject("boAttSettings",boAttSettings)
				.addObject("initScript", initScript)
				.addObject("saveScript", saveScript);
	}
	
	@RequestMapping("boSettingData")
	@ResponseBody
	public List<SysBoEnt> boSettingData(HttpServletRequest request,HttpServletResponse response){
		String boDefId = RequestUtil.getString(request, "boDefId");
		SysBoEnt boEnt = sysBoEntManager.getByBoDefId(boDefId);
		
		List<SysBoEnt> sysBoEnts = sysBoEntManager.getListByBoEnt(boEnt, true);
		return sysBoEnts;
	}
	
	/**
	 * 保存的json结构如下
	 * maintb,subtb是bo实体名
	 * name,user是字段名
	 * 注意其中的user的属性比name的属性要多一个val_name,是多值属性的显示值
	 * 
	 * {
    "maintb": {
        "name": {
            "valType": "constant",
            "val": "[USERNAME]"
        },
        "user": {
            "valType": "constant",
            "val": "[USERID]",
            "val_name": "[USERNAME]"
        }
    },
    "subtb": {
        "name": {
            "valType": "script",
            "val": "111111111"
        }
    }
	}
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("saveBoSetting")
	@ResponseBody
	@LogEnt(action = "saveBoSetting", module = "流程", submodule = "方案的表单视图")
	public JSONObject saveBoSetting(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		String postData=RequestUtil.getString(request, "postData");
		String solId=RequestUtil.getString(request, "solId");
		String nodeId=RequestUtil.getString(request, "nodeId");
		String actDefId=RequestUtil.getString(request, "actDefId");

		BpmSolFv bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
		if(bpmSolFv==null){
			bpmSolFv=new BpmSolFv();
			bpmSolFv.setId(IdUtil.getId());
			bpmSolFv.setActDefId(actDefId);
			bpmSolFv.setSolId(solId);
			bpmSolFv.setNodeId(nodeId);
		}
		
		bpmSolFv.setDataConfs(postData);
		bpmSolFvManager.saveOrUpdate(bpmSolFv);
		result.put("success",true);
		return result;
	} 
	
	/**
	 * true   false 代表权限有无
	 * 
白  有
黑  无     true

白  有
黑  有     false


白  无
黑  有     false

白  无
黑  无     true
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("saveTabRight")
	@ResponseBody
	@LogEnt(action = "saveTabRight", module = "流程", submodule = "方案的表单视图")
	public JSONObject saveTabRight(HttpServletRequest request,HttpServletResponse response){
		String data=request.getParameter("data");
		String pkId=request.getParameter("pkId");
		BpmSolFv bpmSolFv=bpmSolFvManager.get(pkId);
		bpmSolFv.setTabRights(data);
		bpmSolFvManager.saveOrUpdate(bpmSolFv);
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("success", true);
		return jsonObject;
	}
	
	/**
	 * 返回bosetting的值来源的数据类型
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getContextConstant")
	@ResponseBody
	public List<KeyValEnt> getContextConstant(HttpServletRequest request,HttpServletResponse response){
		return contextHandlerFactory.getHandlers();
	}

}
