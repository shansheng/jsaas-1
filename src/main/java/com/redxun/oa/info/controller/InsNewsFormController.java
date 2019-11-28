package com.redxun.oa.info.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.info.entity.InsNews;
import com.redxun.oa.info.entity.InsNewsCtl;
import com.redxun.oa.info.manager.InsColNewDefManager;
import com.redxun.oa.info.manager.InsNewsColumnManager;
import com.redxun.oa.info.manager.InsNewsCtlManager;
import com.redxun.oa.info.manager.InsNewsManager;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;

/**
 * 新闻公告管理
 * 
 * @author csx
 */
@Controller
@RequestMapping("/oa/info/insNews/")
public class InsNewsFormController extends BaseFormController {

	@Resource
	private InsNewsManager insNewsManager;
	@Resource
	InsColNewDefManager insColNewDefManager;
	@Resource
	InsNewsCtlManager insNewsCtlManager;
	@Resource
	InsNewsColumnManager insNewsColumnManager;

	/**
	 * 处理表单
	 * 
	 * @param request
	 * @return
	 */
	@ModelAttribute("insNews")
	public InsNews processForm(HttpServletRequest request) {
		String newId = request.getParameter("newId");
		InsNews insNews = null;
		if (StringUtils.isNotEmpty(newId)) {
			insNews = insNewsManager.get(newId);
		} else {
			insNews = new InsNews();
		}

		return insNews;
	}
	/**
	 * 保存实体数据
	 * 
	 * @param request
	 * @param insNews
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult save(HttpServletRequest request, @ModelAttribute("insNews") @Valid InsNews insNews, BindingResult result) {

		if (result.hasFieldErrors()) {
			return new JsonResult(false, getErrorMsg(result));
		}
		String columnId = RequestUtil.getString(request, "columnId");
		String isPublish=RequestUtil.getString(request,"isPublish", "false");
		String keywords = RequestUtil.getString(request, "keywords");
		String msg = null;
		
		//if(BeanUtil.isEmpty(insNewsColumnManager.get(insNews.getColumnId()))) return new JsonResult(false,"发布栏目不存在!");
		if (StringUtils.isEmpty(insNews.getNewId())) {
			insNews.setNewId(idGenerator.getSID());
			
			insNews.setAuthor(ContextUtil.getCurrentUser().getFullname());
			insNews.setKeywords(keywords);
			insNews.setReadTimes(0);
			insNews.setColumnId(columnId);
			if("true".equals(isPublish)){
				insNews.setStatus(InsNews.STATUS_ISSUED);
			}else{
				insNews.setStatus(InsNews.STATUS_DRAFT);
			}
			insNewsManager.create(insNews);
			
			createNewsCtl(insNews);
			msg = getMessage("insNews.created", new Object[] { insNews.getSubject() }, "新闻公告成功创建!");
		} else {
			if("true".equals(isPublish)){
				insNews.setStatus(InsNews.STATUS_ISSUED);
			}
			insNews.setColumnId(columnId);
			insNewsManager.update(insNews);
			msg = getMessage("insNews.updated", new Object[] { insNews.getSubject() }, "新闻公告成功更新!");
		}
		
		return new JsonResult(true, msg);
	}
	
	/**
	 * 生成新闻公告权限
	 * @param news
	 */
	private void createNewsCtl(InsNews news){
		InsNewsCtl checkctl = new InsNewsCtl();
		checkctl.setCtlId(IdUtil.getId());
		checkctl.setNewsId(news.getNewId());
		checkctl.setRight(InsNewsCtl.CTL_RIGHT_CHECK);
		checkctl.setType(InsNewsCtl.CTL_TYPE_ALL);
		insNewsCtlManager.create(checkctl);
		
		InsNewsCtl downctl = new InsNewsCtl();
		downctl.setCtlId(IdUtil.getId());
		downctl.setNewsId(news.getNewId());
		downctl.setRight(InsNewsCtl.CTL_RIGHT_DOWN);
		downctl.setType(InsNewsCtl.CTL_TYPE_ALL);
		insNewsCtlManager.create(downctl);
	}
}
