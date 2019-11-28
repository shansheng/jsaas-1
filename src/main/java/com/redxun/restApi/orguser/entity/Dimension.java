package com.redxun.restApi.orguser.entity;

/**
 * 维度对象
 * @author ray
 *
 */
public class Dimension {
	
	/**
	 * 维度ID
	 */
	protected String dimId="";
	/**
	 * 名称
	 */
	protected String name="";
	/**
	 * 维度KEY
	 */
	protected String dimKey="";
	/**
	 * 是否组合
	 */
	protected String isCompose="";
	/**
	 * 是否系统默认
	 */
	protected String isSystem="";
	/**
	 * 状态 。
	 * ENABLED 已激活；DISABLED 锁定（禁用）；DELETED 已删除 
	 */
	protected String status="";
	/**
	 * 显示类型
	 * TREE=树型数据。FLAT=平铺数据 
	 */
	protected String showType="";
	/**
	 * 是否授权
	 */
	protected String isGrant="";
	/**
	 * 描述
	 */
	protected String desc="";
	
	
	
	
	public Dimension(){}
	
	
	public Dimension(String id, String name, String key) {
		this.dimId = id;
		this.name = name;
		this.dimKey = key;
	}


	public String getDimId() {
		return dimId;
	}


	public void setDimId(String dimId) {
		this.dimId = dimId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDimKey() {
		return dimKey;
	}


	public void setDimKey(String dimKey) {
		this.dimKey = dimKey;
	}


	public String getIsCompose() {
		return isCompose;
	}


	public void setIsCompose(String isCompose) {
		this.isCompose = isCompose;
	}


	public String getIsSystem() {
		return isSystem;
	}


	public void setIsSystem(String isSystem) {
		this.isSystem = isSystem;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getShowType() {
		return showType;
	}


	public void setShowType(String showType) {
		this.showType = showType;
	}


	public String getIsGrant() {
		return isGrant;
	}


	public void setIsGrant(String isGrant) {
		this.isGrant = isGrant;
	}


	public String getDesc() {
		return desc;
	}


	public void setDesc(String desc) {
		this.desc = desc;
	}

	


	
}
