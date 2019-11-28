
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolWechatuserAccounts;
import com.airdrop.wxrepair.core.manager.PatrolWechatuserAccountsManager;
import com.alibaba.fastjson.JSONObject;
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
 * 微信用户与帐号关系表控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolWechatuserAccounts/")
public class PatrolWechatuserAccountsController extends MybatisListController{
    @Resource
    PatrolWechatuserAccountsManager patrolWechatuserAccountsManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "微信用户与帐号关系表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolWechatuserAccountsManager.delete(id);
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
        PatrolWechatuserAccounts patrolWechatuserAccounts=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolWechatuserAccounts=patrolWechatuserAccountsManager.get(pkId);
        }else{
        	patrolWechatuserAccounts=new PatrolWechatuserAccounts();
        }
        return getPathView(request).addObject("patrolWechatuserAccounts",patrolWechatuserAccounts);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolWechatuserAccounts patrolWechatuserAccounts=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolWechatuserAccounts=patrolWechatuserAccountsManager.get(pkId);
    	}else{
    		patrolWechatuserAccounts=new PatrolWechatuserAccounts();
    	}
    	return getPathView(request).addObject("patrolWechatuserAccounts",patrolWechatuserAccounts);
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
    public PatrolWechatuserAccounts getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolWechatuserAccounts patrolWechatuserAccounts = patrolWechatuserAccountsManager.getPatrolWechatuserAccounts(uId);
        return patrolWechatuserAccounts;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "微信用户与帐号关系表")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolWechatuserAccounts patrolWechatuserAccounts, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolWechatuserAccounts.getId())) {
            patrolWechatuserAccountsManager.create(patrolWechatuserAccounts);
            msg = getMessage("patrolWechatuserAccounts.created", new Object[]{patrolWechatuserAccounts.getIdentifyLabel()}, "[微信用户与帐号关系表]成功创建!");
        } else {
        	String id=patrolWechatuserAccounts.getId();
        	PatrolWechatuserAccounts oldEnt=patrolWechatuserAccountsManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolWechatuserAccounts);
            patrolWechatuserAccountsManager.update(oldEnt);
       
            msg = getMessage("patrolWechatuserAccounts.updated", new Object[]{patrolWechatuserAccounts.getIdentifyLabel()}, "[微信用户与帐号关系表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolWechatuserAccountsManager;
	}

    /**
     * 保存微信用户和员工账号关系
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping("saveWxUserAccount")
    @ResponseBody
    public ResResult saveWxUserAccount(@RequestBody JSONObject params) throws Exception{
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        String openid = params.getString("openid");
        String account = params.getString("account");
        String accountName = params.getString("accountName");
        if ( StringUtils.isEmpty(openid) || StringUtils.isEmpty(account)) {
            res.setData(null);
            res.setResCode(-1);
            res.setResMsg("数据有误,请检查请求参数");
        }else {
            Object wechatuserAccounts = patrolWechatuserAccountsManager.getWxUserAccount(openid);
            if ( wechatuserAccounts == null ) {
                PatrolWechatuserAccounts newUserAccount = new PatrolWechatuserAccounts();
                newUserAccount.setOpenid(openid);
                newUserAccount.setAccount(account);
                newUserAccount.setAccountName(accountName);
                patrolWechatuserAccountsManager.create(newUserAccount);
            }else {
                patrolWechatuserAccountsManager.updateWxUserAccount(openid,account,accountName);
            }
            res.setData(null);
            res.setResCode(0);
            res.setResMsg("保存成功");
        }
        result.setResCode(0);
        result.setResMsg("请求成功");
        result.setResult(res);
        return result;
    }
}
