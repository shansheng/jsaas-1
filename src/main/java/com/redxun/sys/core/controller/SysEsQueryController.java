
package com.redxun.sys.core.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.elastic.JestService;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysEsQuery;
import com.redxun.sys.core.manager.SysEsQueryManager;
import com.redxun.sys.log.LogEnt;

import io.searchbox.core.CatResult;

/**
 * ES自定义查询控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysEsQuery/")
public class SysEsQueryController extends MybatisListController{
    @Resource
    SysEsQueryManager sysEsQueryManager;
    @Resource
    JestService jestService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "ES自定义查询")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysEsQueryManager.delete(id);
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
        SysEsQuery sysEsQuery=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysEsQuery=sysEsQueryManager.get(pkId);
        }else{
        	sysEsQuery=new SysEsQuery();
        }
        return getPathView(request).addObject("sysEsQuery",sysEsQuery);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysEsQuery sysEsQuery=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysEsQuery=sysEsQueryManager.get(pkId);
    	}else{
    		sysEsQuery=new SysEsQuery();
    	}
    	return getPathView(request).addObject("sysEsQuery",sysEsQuery);
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
    public SysEsQuery getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysEsQuery sysEsQuery = sysEsQueryManager.getSysEsQuery(uId);
        return sysEsQuery;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "ES自定义查询")
    public JsonResult save(HttpServletRequest request, @RequestBody SysEsQuery sysEsQuery, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        try{
        	//自定义查询是否存在。
            sysEsQuery.setTenantId(ContextUtil.getCurrentTenantId());
            boolean rtn=sysEsQueryManager.isExist(sysEsQuery);
            if(rtn){
            	 return new JsonResult(false, "查询已经存在!");
            }
            
            String msg = null;
            if (StringUtils.isEmpty(sysEsQuery.getId())) {
            	sysEsQuery.setId(IdUtil.getId());
                sysEsQueryManager.create(sysEsQuery);
                msg = getMessage("sysEsQuery.created", new Object[]{sysEsQuery.getIdentifyLabel()}, "[ES自定义查询]成功创建!");
            } else {
            	String id=sysEsQuery.getId();
            	SysEsQuery oldEnt=sysEsQueryManager.get(id);
            	BeanUtil.copyNotNullProperties(oldEnt, sysEsQuery);
                sysEsQueryManager.update(oldEnt);
           
                msg = getMessage("sysEsQuery.updated", new Object[]{sysEsQuery.getIdentifyLabel()}, "[ES自定义查询]成功更新!");
            }
            return new JsonResult(true, msg);
        }
        catch(Exception ex){
        	JsonResult rtn= new JsonResult(false, "保存出错!");
        	rtn.setData(ExceptionUtil.getExceptionMessage(ex));
        	return rtn;
        }
        
        
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysEsQueryManager;
	}
	
	@ResponseBody
	@RequestMapping(value = "getIndexs")
	public JSONArray getIndexs(HttpServletRequest request) throws IOException{
		try{
			//String alias=RequestUtil.getString(request, "key");
			CatResult catResult= jestService.getCatIndexList("");
			JSONArray ary=JSONArray.parseArray(catResult.getJsonString());
			return ary;
		}
		catch(Exception ex){
			return new JSONArray();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "getMapping", method = RequestMethod.POST)
	public JsonResult getMapping(HttpServletRequest request) throws IOException{
		String alias=RequestUtil.getString(request, "alias");
		JsonResult result= jestService.getMapping(alias);
		return result;
	}
	
	
	/**
	 * 执行自定义查询。
	 * <pre>
	 *  如果做分页查询。
	 *  需要传入当前页数，页数从1开始计数。
	 * </pre>
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryEs_{alias}")
	@ResponseBody
	public JsonResult queryEs(HttpServletRequest request,@PathVariable(value="alias") String alias) {
		JsonResult rtn=null;
		try{
			String tenantId=ContextUtil.getCurrentTenantId();
			SysEsQuery query=sysEsQueryManager.getByAlias(alias, tenantId);
			String paramsJson=RequestUtil.getString(request, "params");
			
			Map<String,Object> params= getParams(query,paramsJson);
			
			if(query.getNeedPage()==1){
				Integer page=0;
				if(params.containsKey("pageIndex")){
					page=(Integer) params.get("pageIndex");
				}
				rtn=sysEsQueryManager.queryForPage(query, params, page);
			}
			else{
				rtn=sysEsQueryManager.queryForList(query, params);
			}
		}
		catch(Exception ex){
			rtn=new JsonResult<>(false, "查询出错" );
			rtn.setData(ExceptionUtil.getExceptionMessage(ex));
		}
		return rtn;
	}
	
	/**
	 * 根据配置的传入参数获取参数map对象。
	 * @param query
	 * @param request
	 * @return
	 */
	private Map<String,Object> getParams(SysEsQuery query,String paramsJson){
		Map<String,Object> params=new HashMap<String, Object>();
		JSONArray ary= sysEsQueryManager.getConditions(query);
		if(ary.size()==0) return params;
		JSONObject paramObj=JSONObject.parseObject(paramsJson);
		for(int i=0;i< ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String name=obj.getString("name");
			String val=paramObj.getString(name);
			if(StringUtil.isEmpty(val)) continue;
			params.put(name, val);
		}
		
		return params;
	}
	
	/**
	 * 获取帮助的描述信息。
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getHelper")
	@ResponseBody
	public JSONObject getHelper(HttpServletRequest request){
		String id=RequestUtil.getString(request, "id");
		SysEsQuery query=this.sysEsQueryManager.get(id);
		JSONObject json=new JSONObject();
		
		json.put("alias", query.getAlias());
		
		JSONObject params=new JSONObject();
		//获取查询条件
		JSONArray ary= sysEsQueryManager.getConditions(query);
		for(int i=0;i< ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String name=obj.getString("name");
			params.put(name, "");
		}
		json.put("params", params);
		
		//返回数据
		JSONArray aryRtn=JSONArray.parseArray(query.getReturnFields());
		JSONObject rtn=new JSONObject();
		for(int i=0;i<aryRtn.size();i++){
			JSONObject obj=aryRtn.getJSONObject(i);
			rtn.put(obj.getString("name"),"");
		}
		json.put("rtn", rtn);
		return json;
	}
	
	@RequestMapping(value = "preview")
	public ModelAndView preview(HttpServletRequest request){
		String id=RequestUtil.getString(request, "id");
		SysEsQuery query=this.sysEsQueryManager.get(id);
		
		ModelAndView mv= getPathView(request);
		
		JSONArray conditions=new JSONArray();
		//获取查询条件
		JSONArray ary= sysEsQueryManager.getConditions(query);
		for(int i=0;i< ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String src=obj.getString("valueSource");
			if(!"param".equals(src) ) continue;
			
			conditions.add(obj);
		}
		
		mv.addObject("conditions", conditions);
		mv.addObject("query", query);
		
		return mv;
	}
	
}
