
package com.redxun.bpm.core.controller;

import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.bpm.core.manager.BpmHttpTaskManager;
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
 * 调用任务控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmHttpTask/")
public class BpmHttpTaskController extends MybatisListController {
    @Resource
    BpmHttpTaskManager bpmHttpTaskManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "调用任务")
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String uId= RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmHttpTaskManager.delete(id);
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
        BpmHttpTask bpmHttpTask=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmHttpTask=bpmHttpTaskManager.get(pkId);
        }else{
        	bpmHttpTask=new BpmHttpTask();
        }
        return getPathView(request).addObject("bpmHttpTask",bpmHttpTask);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId= RequestUtil.getString(request, "pkId");
    	BpmHttpTask bpmHttpTask=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmHttpTask=bpmHttpTaskManager.get(pkId);
    	}else{
    		bpmHttpTask=new BpmHttpTask();
    	}
    	return getPathView(request).addObject("bpmHttpTask",bpmHttpTask);
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
    public BpmHttpTask getJson(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	String uId= RequestUtil.getString(request, "ids");
        BpmHttpTask bpmHttpTask = bpmHttpTaskManager.getBpmHttpTask(uId);
        return bpmHttpTask;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "调用任务")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmHttpTask bpmHttpTask, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmHttpTask.getId())) {
            bpmHttpTaskManager.create(bpmHttpTask);
            msg = getMessage("bpmHttpTask.created", new Object[]{bpmHttpTask.getIdentifyLabel()}, "[调用任务]成功创建!");
        } else {
        	String id=bpmHttpTask.getId();
        	BpmHttpTask oldEnt=bpmHttpTaskManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmHttpTask);
            bpmHttpTaskManager.update(oldEnt);
       
            msg = getMessage("bpmHttpTask.updated", new Object[]{bpmHttpTask.getIdentifyLabel()}, "[调用任务]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmHttpTaskManager;
	}
}
