package com.redxun.bpm.core.entity;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * 流程处理中的消息
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessMessage {
	//提示的消息
	private Set<String> messages=new HashSet<String>();
	//提示的错误消息
	private Set<String> errorMsges=new HashSet<String>();
	//提示的差异性消息
	private LinkedHashSet<String> differMsgs = new LinkedHashSet<String>();
	
	public Set<String> getMessages() {
		return messages;
	}

	public void setMessages(Set<String> messages) {
		this.messages = messages;
	}

	public Set<String> getErrorMsges() {
		return errorMsges;
	}
	
	public void addMsg(String str){
		messages.add(str);
	}
	
	public void addErrorMsg(String str){
		errorMsges.add(str);
	}

	public void setErrorMsges(Set<String> errorMsges) {
		this.errorMsges = errorMsges;
	}
	
	public LinkedHashSet<String> getDifferMsgs() {
		return differMsgs;
	}

	public void setDifferMsgs(LinkedHashSet<String> differMsgs) {
		this.differMsgs = differMsgs;
	}
	
	public void addDifferMsgs(String str) {
		differMsgs.add(str);
	}

	public String getErrors(){
		StringBuffer sb=new StringBuffer();
		for(String err:errorMsges){
			sb.append(err).append("\n");
		}
		return sb.toString();
	}
	
}
