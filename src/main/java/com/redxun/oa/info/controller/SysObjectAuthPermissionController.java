package com.redxun.oa.info.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.oa.info.dao.SysObjectAuthPermissionDao;
import com.redxun.oa.info.entity.InsPortalPermission;
import com.redxun.oa.info.entity.SysObjectAuthPermission;
import com.redxun.oa.info.manager.SysObjectAuthPermissionManager;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 系统对象授权表控制器
 * 
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/sysObjectAuthPermission/")
public class SysObjectAuthPermissionController extends
		BaseMybatisListController {
	@Resource
	SysObjectAuthPermissionManager sysObjectAuthPermissionManager;
	@Resource
	SysObjectAuthPermissionDao sysObjectAuthPermissionDao;
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}

	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "oa", submodule = "系统对象授权表")
	public JsonResult del(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String uId = RequestUtil.getString(request, "ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				sysObjectAuthPermissionManager.delete(id);
			}
		}
		return new JsonResult(true, "成功删除!");
	}

	/**
	 * 查看明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	public ModelAndView get(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		SysObjectAuthPermission sysObjectAuthPermission = null;
		if (StringUtils.isNotEmpty(pkId)) {
			sysObjectAuthPermission = sysObjectAuthPermissionManager.get(pkId);
		} else {
			sysObjectAuthPermission = new SysObjectAuthPermission();
		}
		return getPathView(request).addObject("sysObjectAuthPermission",
				sysObjectAuthPermission);
	}

	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		JSONObject typeJson = ProfileUtil.getProfileTypeJson();
		// List<SysObjectAuthPermission> lists =
		// sysObjectAuthPermissionManager.getByLayoutId(pkId);
		SysObjectAuthPermission sysObjectAuthPermission = null;
		if (StringUtils.isNotEmpty(pkId)) {
			sysObjectAuthPermission = sysObjectAuthPermissionManager.get(pkId);
		} else {
			sysObjectAuthPermission = new SysObjectAuthPermission();
		}
		return getPathView(request).addObject("sysObjectAuthPermission",
				sysObjectAuthPermission).addObject("typeJson", typeJson);
	}

	/**
	 * 有子表的情况下编辑明细的json
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getJson")
	@ResponseBody
	public SysObjectAuthPermission getJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String uId = RequestUtil.getString(request, "ids");
		SysObjectAuthPermission sysObjectAuthPermission = sysObjectAuthPermissionManager
				.getSysObjectAuthPermission(uId);
		return sysObjectAuthPermission;
	}

	

	@SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return sysObjectAuthPermissionManager;
	}


	
	/**
	 * 获取对应消息的权限
	 * @param request
	 * @return
	 */
	@RequestMapping("getPermissionByObjectId")
	@ResponseBody
	public List<JSONObject> profileDialog(HttpServletRequest request){
		String id = RequestUtil.getString(request, "pkId");
		String authType=RequestUtil.getString(request, "authType");
		List<JSONObject> list = sysObjectAuthPermissionManager.getAuthPermission(id,authType);
		return list;
		
	}

}
