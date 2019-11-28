package com.redxun.restApi.orguser.entity;

/**
 * 关系类型。
 * @author ray
 *
 */
public class RelInst {
	
	/**
	 * 主键
	 */
	protected String instId;
	
	/**
	 * 关系类型
	 */
	protected String relType;
	
	/**
	 * 关系类型
	 */
	protected String relTypeKey;
	
	/**
	 * 是否为主关系
	 */
	protected String isMain;
	
	/**
	 * 当前方ID
	 */
	protected String party1;
	/**
	 * 关联方ID
	 */
	protected String party2;
	/**
	 * 当前方维度ID
	 */
	protected String dim1;
	/**
	 * 关联方维度ID
	 */
	protected String dim2;
	/**
	 * 状态
	 */
	protected String status;
	
	/**
	 * 关系定义类型
	 */
	protected String  relTypeId="";

	public String getInstId() {
		return instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
	}

	public String getRelType() {
		return relType;
	}

	public void setRelType(String relType) {
		this.relType = relType;
	}

	public String getRelTypeKey() {
		return relTypeKey;
	}

	public void setRelTypeKey(String relTypeKey) {
		this.relTypeKey = relTypeKey;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	public String getParty1() {
		return party1;
	}

	public void setParty1(String party1) {
		this.party1 = party1;
	}

	public String getParty2() {
		return party2;
	}

	public void setParty2(String party2) {
		this.party2 = party2;
	}

	public String getDim1() {
		return dim1;
	}

	public void setDim1(String dim1) {
		this.dim1 = dim1;
	}

	public String getDim2() {
		return dim2;
	}

	public void setDim2(String dim2) {
		this.dim2 = dim2;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRelTypeId() {
		return relTypeId;
	}

	public void setRelTypeId(String relTypeId) {
		this.relTypeId = relTypeId;
	}
	
	
	
	

}
