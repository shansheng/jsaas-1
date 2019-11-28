package com.redxun.wx.portal.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsUser;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.info.entity.InsColumnDef;
import com.redxun.oa.info.entity.InsPortalDef;
import com.redxun.oa.info.manager.InsColumnDefManager;
import com.redxun.oa.info.manager.InsPortalDefManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.wx.portal.entity.WxMobilePortal;
import com.redxun.wx.portal.manager.WxMobilePortalManager;

/**
 * @author Louis 
 * for 移动门户
 */
@Controller
@RequestMapping("/wx/portal/wxPortal/")
public class WxMobilePortalController extends MybatisListController {
	
	@Resource
    CommonDao commonDao;
	
	@Resource
	protected WxMobilePortalManager wxPortalManager;
	
	@Resource
    InsPortalDefManager insPortalDefManager;
	
	@Resource
	InsColumnDefManager insColumnDefManager;
	
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
	
	@RequestMapping("editMobileTmp")
	public ModelAndView index(HttpServletRequest req, HttpServletResponse res) throws Exception {
		List<InsColumnDef> list = insColumnDefManager.getMobileColumnDef();
		String pkId=RequestUtil.getString(req, "portId");
		IUser currentUser = ContextUtil.getCurrentUser();
    	//复制添加
    	InsPortalDef insPortalDef=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		insPortalDef=insPortalDefManager.get(pkId);
    	}else{
    		insPortalDef=new InsPortalDef();
    	}
		return getPathView(req)
				.addObject("list", list)
				.addObject("insPortalDef",insPortalDef)
				.addObject("portId", pkId)
				.addObject("currentUser",currentUser.getFullname());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("listData")
	public void listData(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//Map<String, String[]> map = req.getParameterMap();
		QueryFilter filter = getQueryFilter(req);
		List list = getPage(filter);
		JsonPageResult<?> result = new JsonPageResult(list, filter.getPage().getTotalItems());
		String jsonResult = iJson.toJson(result);
		PrintWriter pw = res.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult save(HttpServletRequest request, @RequestBody WxMobilePortal wxPortal, BindingResult result) throws Exception  {
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(wxPortal.getId())) {
        	wxPortalManager.create(wxPortal);
            msg = getMessage("wxMobilePortal.created", new Object[]{wxPortal.getIdentifyLabel()}, "["+wxPortal.getName()+"]成功创建!");
        } else {
        	String id = wxPortal.getId();
        	WxMobilePortal portal = wxPortalManager.get(id);
        	BeanUtil.copyNotNullProperties(portal, wxPortal);
        	wxPortalManager.update(portal);
       
            msg = getMessage("wxMobilePortal.updated", new Object[]{wxPortal.getIdentifyLabel()}, "["+wxPortal.getName()+"]成功更新!");
        }
        return new JsonResult(true, msg);
    }
	
	@RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	String pkId = RequestUtil.getString(request, "pkId");
    	WxMobilePortal wxPortal = null;
    	if(StringUtils.isNotEmpty(pkId)){
    		wxPortal = wxPortalManager.get(pkId);
    	}else{
    		wxPortal = new WxMobilePortal();
    	}
    	return getPathView(request).addObject("wxPortal", wxPortal);
    }
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                wxPortalManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
	
	@RequestMapping("checkTypeRepeat")
	public void checkTypeidIsRepeat(HttpServletRequest req, HttpServletResponse res, WxMobilePortal wxPortal) throws Exception {
		int num = wxPortalManager.checkTypeRepeat(wxPortal.getId(), wxPortal.getTypeId());
		PrintWriter ps = res.getWriter();
		ps.println(num);
		ps.close();
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return wxPortalManager;
	}
}
