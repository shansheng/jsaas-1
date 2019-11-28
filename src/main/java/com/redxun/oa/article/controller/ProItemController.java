
package com.redxun.oa.article.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.core.util.ZipUtil;
import com.redxun.oa.article.entity.ProArticle;
import com.redxun.oa.article.entity.ProItem;
import com.redxun.oa.article.manager.ProArticleManager;
import com.redxun.oa.article.manager.ProItemManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 项目控制器
 * @author 陈茂昌
 */
@Controller
@RequestMapping("/oa/article/proItem/")
public class ProItemController extends MybatisListController{
    @Resource
    ProItemManager proItemManager;
    @Resource
    ProArticleManager proArticleManager;
    @Resource
    FreemarkEngine freemarkEngine;
    @Resource
    SysFileManager sysFileManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
	
	@RequestMapping("shareOnLine")
	public ModelAndView shareOnline(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String requestUrl =SysPropertiesUtil.getGlobalProperty("install.host") ;
		String pkId = RequestUtil.getString(request, "pkId");
		String projectId=RequestUtil.getString(request, "proId");
		ProItem proItem = null;
		String genSrc = null;
		if(StringUtil.isNotEmpty(projectId)){
			proItem = proItemManager.get(projectId);
			genSrc = requestUrl + "/doc/" + proItem.getAlias() + "/index.html";
			return getPathView(request).addObject("genSrc",genSrc);
		}
		else{
			ProArticle proArticle = proArticleManager.get(pkId);
			proItem = proItemManager.get(proArticle.getBelongProId());
			genSrc = requestUrl + "/doc/" + proItem.getAlias() + "/html/" + pkId + ".html";
	        return getPathView(request).addObject("genSrc",genSrc);
		}
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "项目")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                proItemManager.delete(id);
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
        ProItem proItem=null;
        if(StringUtils.isNotEmpty(pkId)){
           proItem=proItemManager.get(pkId);
        }else{
        	proItem=new ProItem();
        }
        return getPathView(request).addObject("proItem",proItem);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	ProItem proItem=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		proItem=proItemManager.get(pkId);
    		if("true".equals(forCopy)){
    			proItem.setID(null);
    		}
    	}else{
    		proItem=new ProItem();
    	}
    	return getPathView(request).addObject("proItem",proItem);
    }
    
    @RequestMapping("mylist")
    @ResponseBody
    public JsonPageResult<ProItem> mylist(HttpServletRequest request,HttpServletResponse response){
    	String tenantId=ContextUtil.getCurrentTenantId();
    	
    	QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    	queryFilter.addFieldParam("TENANT_ID_", tenantId);
    	List<ProItem> proItems=proItemManager.getAll(queryFilter);
    	JsonPageResult<ProItem> jsonPageResult=new JsonPageResult<ProItem>(proItems, queryFilter.getPage().getTotalItems());
    	return jsonPageResult;
    }


	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return proItemManager;
	}
	
	
	
	@RequestMapping("exportArticle")
	public void exportArticle(HttpServletRequest request,HttpServletResponse response) throws IOException, Exception{
		String pkId=RequestUtil.getString(request, "pkId");
		ProItem proItem=proItemManager.get(pkId);
		JsonResult<String> result= proArticleManager.genArticleByProId(pkId);
        
        response.setContentType("application/zip");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode( proItem.getName(),"utf-8") + ".zip\"");
		
		ZipUtil.toZip(result.getData(), response.getOutputStream());
	}
	

}
