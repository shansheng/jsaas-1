package com.redxun.sys.org.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.constants.MStatus;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

/**
 * 关系类型管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/org/osRelType/")
public class OsRelTypeController extends BaseListController{
    @Resource
    OsRelTypeManager osRelTypeManager;
    
    @Resource
    OsDimensionManager osDimensionManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String tenantId=getCurTenantId(request);
		
		if(StringUtils.isNotEmpty(tenantId)){
			queryFilter.addFieldParam("TENANT_ID_",QueryParam.OP_IN, "'" + tenantId+"','"+ITenant.PUBLIC_TENANT_ID +"'");
		}else{
			queryFilter.addFieldParam("TENANT_ID_",QueryParam.OP_EQUAL,ContextUtil.getCurrentTenantId());
		}
		return queryFilter;
	}

	/**
	 * 取得该维度下的用户组的与用户的关系类型列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("getRelTypesOfGroupUserId")
//	@ResponseBody
//	public List<OsRelType> getRelTypesOfGroupUserId(HttpServletRequest request,HttpServletResponse response) throws Exception{
//		String groupId=request.getParameter("groupId");
//		String tenantId=getCurTenantId(request);
//		return osRelTypeManager.getRelTypesOfGroupUserId(groupId,tenantId);
//	}

    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "组织架构", submodule = "关系类型")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        StringBuffer sbBuffer=new StringBuffer();
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            
            for(String id:ids){
            	OsRelType osRelType=osRelTypeManager.get(id);
            	if(osRelType!=null && "YES".equals(osRelType.getIsSystem())){
            		sbBuffer.append("系统默认关系（"+osRelType.getName()+"）不允许删除!");
            		continue;
            	}
            	osRelTypeManager.deleteCacade(id);
            }
        }
        return new JsonResult(true,"成功删除！" + sbBuffer.toString());
    }
    
    /**
     * 取得用户的关系类型，除掉belong的关系
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listUserRelsExcludeBelong")
    @ResponseBody
    public List<OsRelType> listUserRelsExcludeBelong(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	return osRelTypeManager.getUserRelTypeExcludeBelong();
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
    	ModelAndView mv = getPathView(request);
        String pkId=request.getParameter("pkId");
        OsRelType osRelType=null;
        if(StringUtils.isNotBlank(pkId)){
           osRelType=osRelTypeManager.get(pkId);
           String dimId1 = osRelType.getDimId1();
           if(StringUtils.isNotBlank(dimId1)) {
        	   OsDimension dim1 = osDimensionManager.get(dimId1);
        	   if(BeanUtil.isNotEmpty(dim1)) {
        		   mv.addObject("dim1Name", dim1.getName());
        	   }
           }
           String dimId2 = osRelType.getDimId2();
           if(StringUtils.isNotBlank(dimId2)) {
        	   OsDimension dim2 = osDimensionManager.get(dimId2);
        	   if(BeanUtil.isNotEmpty(dim2)) {
        		   mv.addObject("dim2Name", dim2.getName());
        	   }
           }
        }else{
        	osRelType=new OsRelType();
        }
        return mv.addObject("osRelType",osRelType);
    }
    
    /**
     * 获得单条记录
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("getRecord")
    @ResponseBody
    public OsRelType getRecord(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("pkId");
        OsRelType osRelType=null;
        if(StringUtils.isNotBlank(pkId)){
           osRelType=osRelTypeManager.get(pkId);
        }
        return osRelType;
    }
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	OsRelType osRelType=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osRelType=osRelTypeManager.get(pkId);
    	}else{
    		osRelType=new OsRelType();
    		osRelType.setIsTwoWay(MBoolean.YES.name());
        	osRelType.setStatus(MStatus.ENABLED.name());
    	}
    	return getPathView(request).addObject("osRelType",osRelType);
    }
    
    /**
     * 用户组间的关系定义
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("group")
    public ModelAndView group(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	
    	String dimId=request.getParameter("dimId");
    	String id=request.getParameter("id");
    	OsDimension osDimension=null;
    	
    	OsRelType osRelType=null;
    	if(StringUtils.isNotEmpty(id)){
    		osRelType=osRelTypeManager.get(id);
    		dimId=osRelType.getDimId1();
    		osDimension=osDimensionManager.get(dimId);
    	}else{
    		osDimension=osDimensionManager.get(dimId);
    		osRelType=new OsRelType();
    		osRelType.setDimId1(dimId);
    		osRelType.setConstType(OsRelType.CONST_TYPE_ONE_ONE);
    		osRelType.setIsDefault(MBoolean.NO.name());
    		osRelType.setIsTwoWay(MBoolean.NO.name());
    		osRelType.setIsSystem(MBoolean.NO.name());
    		osRelType.setRelType(OsRelType.REL_TYPE_GROUP_GROUP);
    	}
    	
    	return getPathView(request).addObject("osRelType",osRelType).addObject("osDimension",osDimension);
    }
    
    /**
     * 获得用户间的关系类型定义
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getUserRels")
    @ResponseBody
    public List<OsRelType> getUserRels(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	return osRelTypeManager.getUserRelType(ContextUtil.getCurrentTenantId());
    }
    
    /**
     * 取得该维度下的用户组的与用户的关系类型列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getRelTypesOfGroupUser")
    @ResponseBody
    public List<OsRelType> getRelTypesOfGroupUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String dimId=request.getParameter("dimId");
    	int level=RequestUtil.getInt(request, "level", -1) ;
    	String tenantId=getCurTenantId(request);
    	return osRelTypeManager.getRelTypesOfGroupUser(dimId,tenantId,level);
    }
    
    /**
     * 取得该维度下的用户组的与用户组的关系类型列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getRelTypesOfGroupGroup")
    @ResponseBody
    public List<OsRelType> getRelTypesOfGroupGroup(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String dimId=request.getParameter("dimId");
    	int level=RequestUtil.getInt(request, "level", -1) ;
    	String tenantId=getCurTenantId(request);
    	return osRelTypeManager.getRelTypesOfGroupGroup(dimId,tenantId,level);
    }
    

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return osRelTypeManager;
	}
	/**
	 * 获得用户组与用户的关系
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getGroupUserRelations")
	@ResponseBody
	public List<OsRelType> getGroupUserRelations(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String instId=getCurTenantId(request);
		String dimId=RequestUtil.getString(request, "dimId","1");
		
		return osRelTypeManager.getGroupUserRelations(instId,dimId);
	}
	/**
	 * 获得用户组间的关系
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getGroupGroupRelations")
	@ResponseBody
	public List<OsRelType> getGroupGroupRelations(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String instId=getCurTenantId(request);
		return osRelTypeManager.getGroupGroupRelations(instId);
	}
	
}
