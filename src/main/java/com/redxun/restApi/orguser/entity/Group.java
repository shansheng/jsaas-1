package com.redxun.restApi.orguser.entity;
/**
 * 用户组对象。
 * @author ray
 *
 */
public class Group {
	
	/**
	 * 组ID
	 */
	protected String groupId="";
	
	/**
	 * 父ID
	 */
	protected String parentId="";
	
	/**
	 * 组名
	 */
	protected String name="";
	
	/**
	 * 组编码
	 */
	protected String key="";
	
	/**
	 * 维度ID
	 */
	private String dimId="";
	
	/**
	 * 等级
	 */
	protected Integer rankLevel=0;
	
	/**
	 * 状态数据。
	 */
	protected String status="";
	
	/**
	 * 描述
	 */
	protected String descp="";
	
	/**
	 * 是否默认
	 */
	protected String isDefault="";
	
	/**
	 * 区域代码。
	 */
	protected String areaCode;
	
	/**
	 * 来自
	 */
	protected String form="";
	
	/**
	 * 序号
	 */
	protected Integer sn=0;
	
	/**
	 * 租户ID
	 */
	private String tenantId="";
	

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getDimId() {
		return dimId;
	}

	public void setDimId(String dimId) {
		this.dimId = dimId;
	}

	public Integer getRankLevel() {
		return rankLevel;
	}

	public void setRankLevel(Integer rankLevel) {
		this.rankLevel = rankLevel;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescp() {
		return descp;
	}

	public void setDescp(String descp) {
		this.descp = descp;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getForm() {
		return form;
	}

	public void setForm(String form) {
		this.form = form;
	}

	public Integer getSn() {
		return sn;
	}

	public void setSn(Integer sn) {
		this.sn = sn;
	}

	public String getTenantId() {
		return tenantId;
	}

	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}

}
