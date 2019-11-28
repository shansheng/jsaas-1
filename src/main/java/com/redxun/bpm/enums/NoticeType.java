package com.redxun.bpm.enums;
/**
 * 通知类型
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public enum NoticeType {
	MSG("短信"),
	MAIL("邮件"),
	WEIXIN("微信"),
	IN_MSG("内部消息");
	
	private String typeName;
	
	NoticeType(String typeName){
		this.typeName=typeName;
	}

	public String getTypeName() {
		return typeName;
	}
	
}
