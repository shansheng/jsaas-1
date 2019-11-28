package com.redxun.bpm.core.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmLog;
import com.redxun.bpm.core.manager.BpmLogManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmLog]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmLog/")
public class BpmLogController extends MybatisListController{
    @Resource
    BpmLogManager bpmLogManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程更新日志")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmLogManager.delete(id);
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
        BpmLog bpmLog=null;
        if(StringUtils.isNotBlank(pkId)){
           bpmLog=bpmLogManager.get(pkId);
        }else{
        	bpmLog=new BpmLog();
        }
        return getPathView(request).addObject("bpmLog",bpmLog);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmLog bpmLog=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmLog=bpmLogManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmLog.setLogId(null);
    		}
    	}else{
    		bpmLog=new BpmLog();
    	}
    	return getPathView(request).addObject("bpmLog",bpmLog);
    }

	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmLogManager;
	}



}
