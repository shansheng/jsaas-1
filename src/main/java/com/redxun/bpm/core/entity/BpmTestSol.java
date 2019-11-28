package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmTestSol实体类定义
 * 流程测试方案
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_TEST_SOL")
@TableDefine(title = "流程测试方案")
@JsonIgnoreProperties("bpmTestCases")
public class BpmTestSol extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "TEST_SOL_ID_")
	protected String testSolId;
	/* 方案编号 */
	@FieldDefine(title = "方案编号")
	@Column(name = "TEST_NO_")
	@Size(max = 64)
	@NotEmpty
	protected String testNo;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String solId;
	
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 测试方案描述 */
	@FieldDefine(title = "测试方案描述")
	@Column(name = "MEMO_")
	@Size(max = 1024)
	protected String memo;

	

	/**
	 * Default Empty Constructor for class BpmTestSol
	 */
	public BpmTestSol() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmTestSol
	 */
	public BpmTestSol(String in_testSolId) {
		this.setTestSolId(in_testSolId);
	}

	

	/**
	 * 测试方案ID * @return String
	 */
	public String getTestSolId() {
		return this.testSolId;
	}

	/**
	 * 设置 测试方案ID
	 */
	public void setTestSolId(String aValue) {
		this.testSolId = aValue;
	}

	/**
	 * 方案编号 * @return String
	 */
	public String getTestNo() {
		return this.testNo;
	}

	/**
	 * 设置 方案编号
	 */
	public void setTestNo(String aValue) {
		this.testNo = aValue;
	}

	/**
	 * 解决方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 解决方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 测试方案描述 * @return String
	 */
	public String getMemo() {
		return this.memo;
	}

	/**
	 * 设置 测试方案描述
	 */
	public void setMemo(String aValue) {
		this.memo = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.testSolId;
	}

	@Override
	public Serializable getPkId() {
		return this.testSolId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.testSolId = (String) pkId;
	}

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmTestSol)) {
			return false;
		}
		BpmTestSol rhs = (BpmTestSol) object;
		return new EqualsBuilder().append(this.testSolId, rhs.testSolId).append(this.testNo, rhs.testNo).append(this.solId, rhs.solId).append(this.memo, rhs.memo)
				.append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.testSolId).append(this.testNo).append(this.solId).append(this.memo).append(this.tenantId)
				.append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("testSolId", this.testSolId).append("testNo", this.testNo).append("solId", this.solId).append("memo", this.memo)
				.append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
