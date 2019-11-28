package com.redxun.bpm.core.entity.config;

import java.io.Serializable;

/**
 * 流程及任务的通知配置
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class NoticeInfoConfig implements Serializable{
	/**
	 * 短信=MSG
	 */
	public final String NOTICE_TYPE_MSG="MSG";
	/**
	 * 邮箱=MAIL
	 */
	public final String NOTICE_TYPE_MAIL="MAIL";
	/**
	 * 微信=WEIXIN
	 */
	public final String NOTICE_TYPE_WEIXIN="WEIXIN";
	/**
	 * 内部消息=IN_MSG
	 */
	public final String NOTICE_TYPE_IN_MSG="IN_MSG";
	
	//通知的方式，如短信、邮件、微信等
	private String type;
	
	//模板名称
	private String templateName;
	//模板ID
	private String templateId;
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getTemplateName() {
		return templateName;
	}
	
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	public String getTemplateId() {
		return templateId;
	}
	
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
}
