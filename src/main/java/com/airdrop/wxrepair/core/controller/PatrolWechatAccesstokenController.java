
package com.airdrop.wxrepair.core.controller;

import com.airdrop.wxrepair.core.entity.PatrolWechatAccesstoken;
import com.airdrop.wxrepair.core.manager.PatrolWechatAccesstokenManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微信接口调用凭证控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolWechatAccesstoken/")
public class PatrolWechatAccesstokenController extends MybatisListController{
    @Resource
    PatrolWechatAccesstokenManager patrolWechatAccesstokenManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "微信接口调用凭证")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolWechatAccesstokenManager.delete(id);
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
        PatrolWechatAccesstoken patrolWechatAccesstoken=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolWechatAccesstoken=patrolWechatAccesstokenManager.get(pkId);
        }else{
        	patrolWechatAccesstoken=new PatrolWechatAccesstoken();
        }
        return getPathView(request).addObject("patrolWechatAccesstoken",patrolWechatAccesstoken);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolWechatAccesstoken patrolWechatAccesstoken=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolWechatAccesstoken=patrolWechatAccesstokenManager.get(pkId);
    	}else{
    		patrolWechatAccesstoken=new PatrolWechatAccesstoken();
    	}
    	return getPathView(request).addObject("patrolWechatAccesstoken",patrolWechatAccesstoken);
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
    public PatrolWechatAccesstoken getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolWechatAccesstoken patrolWechatAccesstoken = patrolWechatAccesstokenManager.getPatrolWechatAccesstoken(uId);
        return patrolWechatAccesstoken;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "微信接口调用凭证")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolWechatAccesstoken patrolWechatAccesstoken, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolWechatAccesstoken.getId())) {
            patrolWechatAccesstokenManager.create(patrolWechatAccesstoken);
            msg = getMessage("patrolWechatAccesstoken.created", new Object[]{patrolWechatAccesstoken.getIdentifyLabel()}, "[微信接口调用凭证]成功创建!");
        } else {
        	String id=patrolWechatAccesstoken.getId();
        	PatrolWechatAccesstoken oldEnt=patrolWechatAccesstokenManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolWechatAccesstoken);
            patrolWechatAccesstokenManager.update(oldEnt);
       
            msg = getMessage("patrolWechatAccesstoken.updated", new Object[]{patrolWechatAccesstoken.getIdentifyLabel()}, "[微信接口调用凭证]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolWechatAccesstokenManager;
	}
}
