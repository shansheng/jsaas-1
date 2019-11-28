package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
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
 * 描述：BpmTestCase实体类定义
 * 测试用例
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_TEST_CASE")
@TableDefine(title = "测试用例")
@JsonIgnoreProperties("bpmTestSol")
public class BpmTestCase extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "TEST_ID_")
	protected String testId;
	/* 用例名称 */
	@FieldDefine(title = "用例名称")
	@Column(name = "CASE_NAME_")
	@Size(max = 20)
	@NotEmpty
	protected String caseName;
	/* 参数配置 */
	@FieldDefine(title = "参数配置")
	@Column(name = "PARAMS_CONF_")
	@Size(max = 65535)
	protected String paramsConf;
	/* 启动用户ID */
	@FieldDefine(title = "启动用户ID")
	@Column(name = "START_USER_ID_")
	@Size(max = 64)
	protected String startUserId;
	
	/* 用户干预配置 */
	@FieldDefine(title = "用户干预配置")
	@Column(name = "USER_CONF_")
	@Size(max = 65535)
	protected String userConf;
	/* 流程实例ID */
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	@Size(max = 64)
	protected String instId;
	
	@FieldDefine(title = "ACT流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 执行最终状态 */
	@FieldDefine(title = "执行最终状态")
	@Column(name = "LAST_STATUS_")
	@Size(max = 20)
	protected String lastStatus;
	/* 执行异常 */
	@FieldDefine(title = "执行异常")
	@Column(name = "EXE_EXCEPTIONS_")
	@Size(max = 65535)
	protected String exeExceptions;
	@FieldDefine(title = "流程测试方案")
	//@ManyToOne
	@JoinColumn(name = "TEST_SOL_ID_")
	protected String testSolId;

	/**
	 * Default Empty Constructor for class BpmTestCase
	 */
	public BpmTestCase() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmTestCase
	 */
	public BpmTestCase(String in_testId) {
		this.setTestId(in_testId);
	}


	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * 测试用例ID * @return String
	 */
	public String getTestId() {
		return this.testId;
	}

	/**
	 * 设置 测试用例ID
	 */
	public void setTestId(String aValue) {
		this.testId = aValue;
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
	 * 用例名称 * @return String
	 */
	public String getCaseName() {
		return this.caseName;
	}

	/**
	 * 设置 用例名称
	 */
	public void setCaseName(String aValue) {
		this.caseName = aValue;
	}

	/**
	 * 参数配置 * @return String
	 */
	public String getParamsConf() {
		return this.paramsConf;
	}

	/**
	 * 设置 参数配置
	 */
	public void setParamsConf(String aValue) {
		this.paramsConf = aValue;
	}

	/**
	 * 用户干预配置 * @return String
	 */
	public String getUserConf() {
		return this.userConf;
	}

	/**
	 * 设置 用户干预配置
	 */
	public void setUserConf(String aValue) {
		this.userConf = aValue;
	}

	/**
	 * 流程实例ID * @return String
	 */
	public String getInstId() {
		return this.instId;
	}

	/**
	 * 设置 流程实例ID
	 */
	public void setInstId(String aValue) {
		this.instId = aValue;
	}

	/**
	 * 执行最终状态 * @return String
	 */
	public String getLastStatus() {
		return this.lastStatus;
	}

	/**
	 * 设置 执行最终状态
	 */
	public void setLastStatus(String aValue) {
		this.lastStatus = aValue;
	}

	/**
	 * 执行异常 * @return String
	 */
	public String getExeExceptions() {
		return this.exeExceptions;
	}

	/**
	 * 设置 执行异常
	 */
	public void setExeExceptions(String aValue) {
		this.exeExceptions = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.testId;
	}

	@Override
	public Serializable getPkId() {
		return this.testId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.testId = (String) pkId;
	}

	public String getStartUserId() {
		return startUserId;
	}

	public void setStartUserId(String startUserId) {
		this.startUserId = startUserId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmTestCase)) {
			return false;
		}
		BpmTestCase rhs = (BpmTestCase) object;
		return new EqualsBuilder().append(this.testId, rhs.testId).append(this.caseName, rhs.caseName).append(this.paramsConf, rhs.paramsConf).append(this.userConf, rhs.userConf)
				.append(this.instId, rhs.instId).append(this.lastStatus, rhs.lastStatus).append(this.exeExceptions, rhs.exeExceptions).append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.testId).append(this.caseName).append(this.paramsConf).append(this.userConf).append(this.instId)
				.append(this.lastStatus).append(this.exeExceptions).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy)
				.append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("testId", this.testId).append("caseName", this.caseName).append("paramsConf", this.paramsConf).append("userConf", this.userConf)
				.append("instId", this.instId).append("lastStatus", this.lastStatus).append("exeExceptions", this.exeExceptions).append("tenantId", this.tenantId)
				.append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
