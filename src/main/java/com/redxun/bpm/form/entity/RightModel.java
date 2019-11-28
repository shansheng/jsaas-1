package com.redxun.bpm.form.entity;


public class RightModel {

	/**
	 * ALL,USER,GROUP
	 */
	private String permissionType="all";
	
	/**
	 * 存储ID使用逗号分隔
	 */
	private String ids="";
	
	/**
	 * 存储名称使用逗号分隔.
	 */
	private String names="";
	

	public String getPermissionType() {
		return permissionType;
	}

	public void setPermissionType(String permissionType) {
		this.permissionType = permissionType;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getNames() {
		return names;
	}

	public void setNames(String names) {
		this.names = names;
	}
	
	
	
	
}
