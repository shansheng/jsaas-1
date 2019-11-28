<#import "function.ftl" as func>
<#assign package=model.variables.package>
<#assign class=model.variables.class>
<#assign classVar=model.variables.classVar>
<#assign comment=model.tabComment>
<#assign pk=func.getPk(model) >
<#assign pkModel=model.pkModel >
<#assign pkVar=func.convertUnderLine(pk) >
<#assign pkType=func.getPkType(model)>
<#assign fkType=func.getFkType(model)>
<#assign system=vars.system>
<#assign domain=vars.domain>
<#assign tableName=model.tableName>
<#assign colList=model.columnList>
<#assign commonList=model.commonList>

package ${domain}.${system}.${package}.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import ${domain}.${system}.${package}.entity.${class};
import ${domain}.${system}.${package}.manager.${class}Manager;
import com.redxun.sys.log.LogEnt;
import com.redxun.core.util.BeanUtil;

/**
 * ${comment}控制器
 * @author ${vars.developer}
 */
@Controller
@RequestMapping("/${system}/${package}/${classVar}/")
public class ${class}Controller extends MybatisListController{
    @Resource
    ${class}Manager ${classVar}Manager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "${system}", submodule = "${comment}")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                ${classVar}Manager.delete(id);
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
        ${class} ${classVar}=null;
        if(StringUtils.isNotEmpty(pkId)){
           ${classVar}=${classVar}Manager.get(pkId);
        }else{
        	${classVar}=new ${class}();
        }
        return getPathView(request).addObject("${classVar}",${classVar});
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	${class} ${classVar}=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		${classVar}=${classVar}Manager.get(pkId);
    	}else{
    		${classVar}=new ${class}();
    	}
    	return getPathView(request).addObject("${classVar}",${classVar});
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
    public ${class} getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        ${class} ${classVar} = ${classVar}Manager.get${class}(uId);
        return ${classVar};
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "${system}", submodule = "${comment}")
    public JsonResult save(HttpServletRequest request, @RequestBody ${class} ${classVar}, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(${classVar}.get${func.convertUnderLine(pkModel.columnName)?cap_first}())) {
            ${classVar}Manager.create(${classVar});
            msg = getMessage("${classVar}.created", new Object[]{${classVar}.getIdentifyLabel()}, "[${comment}]成功创建!");
        } else {
        	String id=${classVar}.get${func.convertUnderLine(pkModel.columnName)?cap_first}();
        	${class} oldEnt=${classVar}Manager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, ${classVar});
            ${classVar}Manager.update(oldEnt);
       
            msg = getMessage("${classVar}.updated", new Object[]{${classVar}.getIdentifyLabel()}, "[${comment}]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return ${classVar}Manager;
	}
}
