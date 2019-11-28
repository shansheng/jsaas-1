
package com.redxun.bpm.core.controller;

import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.bpm.core.manager.BpmHttpInvokeResultManager;
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
 * 调用结果控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmHttpInvokeResult/")
public class BpmHttpInvokeResultController extends MybatisListController {
    @Resource
    BpmHttpInvokeResultManager bpmHttpInvokeResultManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "调用结果")
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String uId= RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmHttpInvokeResultManager.delete(id);
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
        String pkId= RequestUtil.getString(request, "pkId");
        BpmHttpInvokeResult bpmHttpInvokeResult=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmHttpInvokeResult=bpmHttpInvokeResultManager.get(pkId);
        }else{
        	bpmHttpInvokeResult=new BpmHttpInvokeResult();
        }
        return getPathView(request).addObject("bpmHttpInvokeResult",bpmHttpInvokeResult);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId= RequestUtil.getString(request, "pkId");
    	BpmHttpInvokeResult bpmHttpInvokeResult=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmHttpInvokeResult=bpmHttpInvokeResultManager.get(pkId);
    	}else{
    		bpmHttpInvokeResult=new BpmHttpInvokeResult();
    	}
    	return getPathView(request).addObject("bpmHttpInvokeResult",bpmHttpInvokeResult);
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
    public BpmHttpInvokeResult getJson(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	String uId= RequestUtil.getString(request, "ids");
        BpmHttpInvokeResult bpmHttpInvokeResult = bpmHttpInvokeResultManager.getBpmHttpInvokeResult(uId);
        return bpmHttpInvokeResult;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "调用结果")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmHttpInvokeResult bpmHttpInvokeResult, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmHttpInvokeResult.getId())) {
            bpmHttpInvokeResultManager.create(bpmHttpInvokeResult);
            msg = getMessage("bpmHttpInvokeResult.created", new Object[]{bpmHttpInvokeResult.getIdentifyLabel()}, "[调用结果]成功创建!");
        } else {
        	String id=bpmHttpInvokeResult.getId();
        	BpmHttpInvokeResult oldEnt=bpmHttpInvokeResultManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmHttpInvokeResult);
            bpmHttpInvokeResultManager.update(oldEnt);
       
            msg = getMessage("bpmHttpInvokeResult.updated", new Object[]{bpmHttpInvokeResult.getIdentifyLabel()}, "[调用结果]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmHttpInvokeResultManager;
	}
}
