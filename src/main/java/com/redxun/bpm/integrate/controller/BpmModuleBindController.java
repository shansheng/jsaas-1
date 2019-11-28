package com.redxun.bpm.integrate.controller;

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
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.integrate.entity.BpmModuleBind;
import com.redxun.bpm.integrate.manager.BpmModuleBindManager;

/**
 * 业务流程模块绑定管理
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/integrate/bpmModuleBind/")
public class BpmModuleBindController extends BaseListController{
    @Resource
    BpmModuleBindManager bpmModuleBindManager;
   

   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程模块方案绑定")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmModuleBindManager.delete(id);
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
        BpmModuleBind bpmModuleBind=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmModuleBind=bpmModuleBindManager.get(pkId);
        }else{
        	bpmModuleBind=new BpmModuleBind();
        }
        return getPathView(request).addObject("bpmModuleBind",bpmModuleBind);
    }
    
    /**
     * 批量保存业务绑定数据
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("batchSave")
    @ResponseBody
    @LogEnt(action = "batchSave", module = "流程", submodule = "流程模块方案绑定")
    public JsonResult batchSave(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String gridJson=request.getParameter("gridData");
    	if(StringUtils.isNotEmpty(gridJson)){
    		List<BpmModuleBind> binds=JSON.parseArray(gridJson, BpmModuleBind.class);
    		for(BpmModuleBind mb:binds){
    			if(StringUtils.isNotBlank(mb.getBindId())){
    				BpmModuleBind tmp=bpmModuleBindManager.get(mb.getBindId());
    				BeanUtil.copyProperties(tmp, mb);
    				bpmModuleBindManager.update(tmp);
    			}else{
    				bpmModuleBindManager.create(mb);
    			}
    		}
    	}
    	return new JsonResult(true,"成功保存！");
    }
    /**
     * 通过模块Key获得流程
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getSolByModuleKey")
    @ResponseBody
    public JsonResult getSolByModuleKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String moduleKey=request.getParameter("moduleKey");
    	if(StringUtils.isEmpty(moduleKey)){
    		return new JsonResult(false,"没有指定对应的ModuleKey！");
    	}
    	BpmModuleBind bind=bpmModuleBindManager.getByModuleKey(moduleKey);
    	if(bind==null){
    		return new JsonResult(false,"没有找到对应的模块Key["+moduleKey+"]的流程绑定配置！");
    	}
    	
    	return new JsonResult(true,"",bind);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmModuleBind bpmModuleBind=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmModuleBind=bpmModuleBindManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmModuleBind.setBindId(null);
    		}
    	}else{
    		bpmModuleBind=new BpmModuleBind();
    	}
    	return getPathView(request).addObject("bpmModuleBind",bpmModuleBind);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmModuleBindManager;
	}

}
