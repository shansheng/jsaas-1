
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.constant.AppConstant;
import com.airdrop.common.util.JsonUtils;
import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.common.util.WeChatUtil;
import com.airdrop.wxrepair.core.entity.PatrolWechatUserinfo;
import com.airdrop.wxrepair.core.manager.PatrolWechatUserinfoManager;
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
 * 巡店微信用户控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolWechatUserinfo/")
public class PatrolWechatUserinfoController extends MybatisListController{
    @Resource
    PatrolWechatUserinfoManager patrolWechatUserinfoManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "巡店微信用户")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolWechatUserinfoManager.delete(id);
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
        PatrolWechatUserinfo patrolWechatUserinfo=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolWechatUserinfo=patrolWechatUserinfoManager.get(pkId);
        }else{
        	patrolWechatUserinfo=new PatrolWechatUserinfo();
        }
        return getPathView(request).addObject("patrolWechatUserinfo",patrolWechatUserinfo);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolWechatUserinfo patrolWechatUserinfo=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolWechatUserinfo=patrolWechatUserinfoManager.get(pkId);
    	}else{
    		patrolWechatUserinfo=new PatrolWechatUserinfo();
    	}
    	return getPathView(request).addObject("patrolWechatUserinfo",patrolWechatUserinfo);
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
    public PatrolWechatUserinfo getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolWechatUserinfo patrolWechatUserinfo = patrolWechatUserinfoManager.getPatrolWechatUserinfo(uId);
        return patrolWechatUserinfo;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "巡店微信用户")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolWechatUserinfo patrolWechatUserinfo, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolWechatUserinfo.getId())) {
            patrolWechatUserinfoManager.create(patrolWechatUserinfo);
            msg = getMessage("patrolWechatUserinfo.created", new Object[]{patrolWechatUserinfo.getIdentifyLabel()}, "[巡店微信用户]成功创建!");
        } else {
        	String id=patrolWechatUserinfo.getId();
        	PatrolWechatUserinfo oldEnt=patrolWechatUserinfoManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolWechatUserinfo);
            patrolWechatUserinfoManager.update(oldEnt);
       
            msg = getMessage("patrolWechatUserinfo.updated", new Object[]{patrolWechatUserinfo.getIdentifyLabel()}, "[巡店微信用户]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolWechatUserinfoManager;
	}

    /**
     * 保存微信用户信息
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping("saveWxUser")
    @ResponseBody
    public ResResult saveWxUser(@RequestBody JSONObject params,HttpServletRequest request,HttpServletResponse response) throws Exception{
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        String jscode = params.getString("jscode");
        JSONObject code2Session = WeChatUtil.code2Session(AppConstant.WX_APPID, AppConstant.WX_APPSECRET, jscode);
        if ( code2Session != null && code2Session.getString("openid") != null ) {
            String openid = code2Session.getString("openid");
            Object user = patrolWechatUserinfoManager.getUserByOpenId(openid);
            if ( user == null ){
                params.remove("jscode");
                params.put("openid",openid);
                PatrolWechatUserinfo newUser = JsonUtils.json2Bean(params.toString(),PatrolWechatUserinfo.class);
                patrolWechatUserinfoManager.create(newUser);
                res.setResMsg("微信用户信息保存成功");
                res.setResCode(0);
                res.setData(newUser);
            }else {
                res.setData(user);
                res.setResCode(1);
                res.setResMsg("用户已存在");
            }
        }else {
            res.setResMsg("获取openid失败");
            res.setResCode(-1);
            res.setData(null);
        }
        result.setResMsg("请求成功");
        result.setResCode(0);
        result.setResult(res);
        return result;
    }
}
