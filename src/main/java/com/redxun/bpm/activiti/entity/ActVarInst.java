package com.redxun.bpm.activiti.entity;

/**
 * 流程变量实例
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActVarInst {
	//变量名
	private String key;
	//类型
	private String type;
	//值
	private Object val;
	
	public ActVarInst() {
	
	}
	
	public ActVarInst(String key,String type,Object val){
		this.key=key;
		this.type=type;
		this.val=val;
	}
	
	
	public String getKey() {
		return key;
	}
	
	public void setKey(String key) {
		this.key = key;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Object getVal() {
		return val;
	}
	public void setVal(Object val) {
		this.val = val;
	}
}
