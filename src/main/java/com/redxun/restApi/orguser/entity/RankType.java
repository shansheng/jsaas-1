package com.redxun.restApi.orguser.entity;

/**
 * 等级类型。
 * @author ray
 *
 */
public class RankType {
	
	/**
	 * 主键
	 */
	protected String id;
	/**
	 * 名称
	 */
	protected String name;
	/**
	 * 分类业务键
	 */
	protected String key;
	/**
	 * 级别数值
	 */
	protected Integer level;
	
	/**
	 * 所属维度
	 */
	protected String  dimId;
	

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

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getDimId() {
		return dimId;
	}

	public void setDimId(String dimId) {
		this.dimId = dimId;
	}
	
	

}
