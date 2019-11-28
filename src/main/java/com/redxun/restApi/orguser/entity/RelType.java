package com.redxun.restApi.orguser.entity;

/**
 * 关系类型。
 * @author ray
 *
 */
public class RelType {
	
	/**
	 * 主键
	 */
	protected String id;
	/**
	 * 关系名 
	 */
	protected String name;
	/**
	 *关系业务主键 
	 */
	protected String key;
	/**
	 * 关系归属
	 */
	protected String relType;
	/**
	 * 关系约束类型
	 */
	protected String constType;
	
	/**
	 * 关系当前方名称
	 */
	protected String party1;
	/**
	 * 关系关联方名称
	 */
	protected String party2;
	
	/**
	 * 关系当前方维度
	 */
	protected String dimId1;
	
	/**
	 * 关联方维度ID
	 */
	protected String dimId2;
	
	/**
	 * 状态
	 */
	protected String status;
	/**
	 * 是否系统预设
	 */
	protected String isSystem;
	/**
	 * 是否默认 
	 */
	protected String isDefault;
	/**
	 *  是否是双向 
	 */
	protected String isTwoWay;
	/**
	 *  关系备注 
	 */
	protected String memo;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getRelType() {
		return relType;
	}
	public void setRelType(String relType) {
		this.relType = relType;
	}
	public String getConstType() {
		return constType;
	}
	public void setConstType(String constType) {
		this.constType = constType;
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
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsSystem() {
		return isSystem;
	}
	public void setIsSystem(String isSystem) {
		this.isSystem = isSystem;
	}
	public String getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	public String getIsTwoWay() {
		return isTwoWay;
	}
	public void setIsTwoWay(String isTwoWay) {
		this.isTwoWay = isTwoWay;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	public String getDimId1() {
		return dimId1;
	}
	public void setDimId1(String dimId1) {
		this.dimId1 = dimId1;
	}
	public String getDimId2() {
		return dimId2;
	}
	public void setDimId2(String dimId2) {
		this.dimId2 = dimId2;
	}
	
	
	
	
	

}
