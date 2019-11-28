
package com.redxun.bpm.core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmRegLib;
import com.redxun.bpm.core.manager.BpmRegLibManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * BPM_REG_LIB控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmRegLib/")
public class BpmRegLibController extends MybatisListController{
    @Resource
    BpmRegLibManager bpmRegLibManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "BPM_REG_LIB")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmRegLibManager.delete(id);
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
        BpmRegLib bpmRegLib=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmRegLib=bpmRegLibManager.get(pkId);
        }else{
        	bpmRegLib=new BpmRegLib();
        }
        return getPathView(request).addObject("bpmRegLib",bpmRegLib);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	BpmRegLib bpmRegLib=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmRegLib=bpmRegLibManager.get(pkId);
    	}else{
    		bpmRegLib=new BpmRegLib();
    	}
    	return getPathView(request).addObject("bpmRegLib",bpmRegLib);
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
    public BpmRegLib getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmRegLib bpmRegLib = bpmRegLibManager.getBpmRegLib(uId);
        return bpmRegLib;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "BPM_REG_LIB")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmRegLib bpmRegLib, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        
        if(bpmRegLibManager.isExistKey(bpmRegLib)){
			return new JsonResult(false, "别名已经存在!");
		}
        String msg = null;
        if (StringUtils.isEmpty(bpmRegLib.getRegId())) {
            bpmRegLibManager.create(bpmRegLib);
            msg = getMessage("bpmRegLib.created", new Object[]{bpmRegLib.getIdentifyLabel()}, "[BPM_REG_LIB]成功创建!");
        } else {
        	String id=bpmRegLib.getRegId();
        	BpmRegLib oldEnt=bpmRegLibManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmRegLib);
            bpmRegLibManager.update(oldEnt);
       
            msg = getMessage("bpmRegLib.updated", new Object[]{bpmRegLib.getIdentifyLabel()}, "[BPM_REG_LIB]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    @RequestMapping("getRegByType")
    @ResponseBody
    public List<BpmRegLib> getRegByType(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String type=RequestUtil.getString(request, "type");
    	return bpmRegLibManager.getRegByType(type);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmRegLibManager;
	}
}
