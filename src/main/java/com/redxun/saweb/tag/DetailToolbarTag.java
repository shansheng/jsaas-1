package com.redxun.saweb.tag;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.redxun.core.engine.FreemarkEngine;
import com.redxun.saweb.util.WebAppUtil;
/**
 * 明细页的工具栏
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
public class DetailToolbarTag extends BodyTagSupport{

	/**
	 * 显示查询按钮
	 */
	private static Map<String,String> allButtonMap=new HashMap<String,String>();
	
	static{
		allButtonMap.put(ToolbarButtonType.remove.name(), "true");
		allButtonMap.put(ToolbarButtonType.prevRecord.name(), "true");
		allButtonMap.put(ToolbarButtonType.nextRecord.name(), "true");
	}
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 工具栏ID
	 */
	private String toolbarId;
	
	/**
	 * 是否隐藏上下行记录
	 */
	private String hideRecordNav="false";
	
	//排除的按钮，用,分割标识列表
	private String excludeButtons="";

	public String getExcludeButtons() {
		return excludeButtons;
	}
	
	public void setExcludeButtons(String excludeButtons) {
		this.excludeButtons = excludeButtons;
	}
	
	public String getToolbarId() {
		return toolbarId;
	}


	public void setToolbarId(String toolbarId) {
		this.toolbarId = toolbarId;
	}

	public String getHideRecordNav() {
		return hideRecordNav;
	}


	public void setHideRecordNav(String hideRecordNav) {
		this.hideRecordNav = hideRecordNav;
	}
	
	@Override
	public void setBodyContent(BodyContent b) {
		this.bodyContent=b;
	}

	@Override
	public int doStartTag() throws JspException {
		return EVAL_BODY_BUFFERED;
	}
	
	@Override
	public int doAfterBody() throws JspException {
		return SKIP_BODY;
	}
	
	@Override
	public int doEndTag() throws JspException {
		
		 JspWriter out=pageContext.getOut();
		 HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			 try{
				 	FreemarkEngine freemarkEngine=WebAppUtil.getBean(FreemarkEngine.class);
					Map<String,Object> model=new HashMap<String,Object>();
					model.put("rootPath", request.getContextPath());
					model.put("toolbarId", toolbarId);
					model.put("hideRecordNav", hideRecordNav);
					model.put("toolbarId", toolbarId);
					model.putAll(allButtonMap);
					if(StringUtils.isNotEmpty(excludeButtons)){
						String[]excludes=excludeButtons.split("[,]");
						for(String ex:excludes){
							model.put(ex, "false");
						}
					}
					BodyContent content=getBodyContent();
					
					if(content!=null){
						String bodyContent=content.getString();
						if(StringUtils.isNotEmpty(bodyContent)){
							Document doc = Jsoup.parse(bodyContent);
							//查找有该样式的控件
							Elements selfToobar=doc.select(".self-toolbar");
							model.put("extToolbars",selfToobar.html());
						}
					}
					
					String html=freemarkEngine.mergeTemplateIntoString("detailToolbar.ftl", model);
					out.println(html);
			 }catch(Exception ex){
				 ex.printStackTrace();
			 }
		 return EVAL_PAGE;
	}
	
}
