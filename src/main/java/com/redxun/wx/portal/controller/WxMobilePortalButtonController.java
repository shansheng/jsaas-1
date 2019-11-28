package com.redxun.wx.portal.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.oa.info.manager.SysObjectAuthPermissionManager;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.wx.portal.entity.WxMobilePortal;
import com.redxun.wx.portal.entity.WxMobilePortalButton;
import com.redxun.wx.portal.manager.WxMobilePortalButtonManager;
import com.redxun.wx.portal.manager.WxMobilePortalManager;

/**
 * @author Louis
 * for 移动门户
 */
@Controller
@RequestMapping("/wx/portal/wxPortalBtn/")
public class WxMobilePortalButtonController extends MybatisListController {
	@Resource
	private CommonDao commonDao;

	@Resource
	private WxMobilePortalButtonManager wxPortalBtnManager;

	@Resource
	private SysFileManager sysFileManager;

	@Resource
	protected WxMobilePortalManager wxPortalManager;

	@Resource
	private SysObjectAuthPermissionManager sysObjectAuthPermissionManager;

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}



	@RequestMapping("querySysFile")
	public void querySysFileById(HttpServletRequest req, HttpServletResponse res, String id) throws Exception {
		SysFile sysFile = sysFileManager.get(id);
		String iconPath = WebAppUtil.getUploadPath() + "/" + sysFile.getPath();
		PrintWriter pw = res.getWriter();
		pw.println(iconPath);
		pw.close();
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult save(HttpServletRequest request, @RequestBody WxMobilePortalButton wxPortalBtn, BindingResult result) throws Exception  {
		if (result.hasFieldErrors()) {
			return new JsonResult(false, getErrorMsg(result));
		}
		String msg = null;
		if (StringUtils.isEmpty(wxPortalBtn.getId())) {
			wxPortalBtnManager.create(wxPortalBtn);
			msg = getMessage("wxMobilePortalBtn.created", new Object[]{wxPortalBtn.getIdentifyLabel()}, "["+wxPortalBtn.getName()+"]成功创建!");
		} else {
			String id = wxPortalBtn.getId();
			WxMobilePortalButton portalBtn = wxPortalBtnManager.get(id);
			BeanUtil.copyNotNullProperties(portalBtn, wxPortalBtn);
			wxPortalBtnManager.update(portalBtn);

			msg = getMessage("wxMobilePortal.updated", new Object[]{portalBtn.getIdentifyLabel()}, "["+portalBtn.getName()+"]成功更新!");
		}
		return new JsonResult(true, msg);
	}

	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String pkId = RequestUtil.getString(request, "pkId");
		WxMobilePortalButton wxPortalBtn = null;
		if(StringUtils.isNotEmpty(pkId)){
			wxPortalBtn = wxPortalBtnManager.get(pkId);
		}else{
			wxPortalBtn = new WxMobilePortalButton();
		}
		return getPathView(request).addObject("wxPortalBtn", wxPortalBtn);
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping("del")
	@ResponseBody
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String uId=RequestUtil.getString(request, "ids");
		if(StringUtils.isNotEmpty(uId)){
			String[] ids=uId.split(",");
			for(String id:ids){
				wxPortalBtnManager.delete(id);
			}
		}
		return new JsonResult(true,"成功删除!");
	}

	@RequestMapping("listDataByType_{alias}")
	@ResponseBody
	public void listDataByType(HttpServletRequest req, HttpServletResponse res, @PathVariable(value="alias")String alias) throws Exception {
		List<WxMobilePortalButton> list = wxPortalBtnManager.getByType(alias);
		for(WxMobilePortalButton wpb : list) {
			JSONObject json = new JSONObject();
			JSONArray jArr = JSON.parseArray(wpb.getIcon());
			if(jArr != null && jArr.size() > 0) {
				json = JSON.parseObject(JSON.toJSONString(jArr.get(0)));
				SysFile sysFile = sysFileManager.get(json.getString("fileId"));
				String iconPath = WebAppUtil.getUploadPath() + "/" + sysFile.getPath();
				wpb.setIcon(iconPath);
			}
		}
		PrintWriter pw = res.getWriter();
		JSONArray jArr = new JSONArray();
		jArr.addAll(list);
		pw.println(jArr);
		pw.close();
	}



	@RequestMapping("appTypePage")
	public ModelAndView appTypePage(HttpServletRequest req, HttpServletResponse res) throws Exception{
		String appType = RequestUtil.getString(req,"appType");
		return new ModelAndView("/wx/portal/"+appType+".jsp");

	}

	@RequestMapping("saveRight")
	@ResponseBody
	public JsonResult saveRight(@RequestBody JSONObject mobileAppJson) {
		JsonResult jsonResult=sysObjectAuthPermissionManager.saveRight(mobileAppJson);
		return jsonResult;
	}


	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return wxPortalBtnManager;
	}

}
