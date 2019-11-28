
package com.redxun.bpm.form.controller;

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

import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.log.LogEnt;

/**
 * 表间公式控制器
 * @author mansan
 */
@Controller
@RequestMapping("/bpm/form/bpmTableFormula/")
public class BpmTableFormulaController extends MybatisListController{
    @Resource
    BpmTableFormulaManager bpmTableFormulaManager;
    @Resource
    SysBoDefManager sysBoDefManager;

    
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "表间公式")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmTableFormulaManager.delete(id);
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
        BpmTableFormula bpmTableFormula=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmTableFormula=bpmTableFormulaManager.get(pkId);
        }else{
        	bpmTableFormula=new BpmTableFormula();
        }
        return getPathView(request).addObject("bpmTableFormula",bpmTableFormula);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	BpmTableFormula bpmTableFormula=null;
    	ModelAndView mv=getPathView(request);
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmTableFormula=bpmTableFormulaManager.get(pkId);
    		if(StringUtils.isNotEmpty(bpmTableFormula.getBoDefId())){
    			SysBoDef sysBoDef=sysBoDefManager.get(bpmTableFormula.getBoDefId());
    			mv.addObject("sysBoDef", sysBoDef);
    		}
    	}else{
    		bpmTableFormula=new BpmTableFormula();
    		bpmTableFormula.setAction("new");
    	}
    	return mv.addObject("bpmTableFormula",bpmTableFormula);
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
    public BpmTableFormula getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmTableFormula bpmTableFormula = bpmTableFormulaManager.get(uId);
        return bpmTableFormula;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "表间公式")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmTableFormula bpmTableFormula, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmTableFormula.getId())) {
        	bpmTableFormula.setId(IdUtil.getId());
            bpmTableFormulaManager.create(bpmTableFormula);
            msg = getMessage("bpmTableFormula.created", new Object[]{bpmTableFormula.getIdentifyLabel()}, "[表间公式]成功创建!");
        } else {
        	String id=bpmTableFormula.getId();
        	BpmTableFormula oldEnt=bpmTableFormulaManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmTableFormula);
            bpmTableFormulaManager.update(oldEnt);
       
            msg = getMessage("bpmTableFormula.updated", new Object[]{bpmTableFormula.getIdentifyLabel()}, "[表间公式]成功更新!");
        }
        return new JsonResult(true, msg);
    }
    
    
    @RequestMapping("dialog")
    public ModelAndView dialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	boolean single=RequestUtil.getBoolean(request, "single",true);
    	ModelAndView mv=getPathView(request);
    	
    	return mv.addObject("single",single);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmTableFormulaManager;
	}
}
