package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmLog实体类定义
 * 流程更新日志
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_LOG")
@TableDefine(title = "流程更新日志")
public class BpmLog extends BaseTenantEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3765776304928989972L;
	/**
	 * 日志类型-解决方案=SOLUTION
	 */
	public final static String LOG_TYPE_SOLUTION="SOLUTION";
	/**
	 * 日志类型-解决方案的实例=INSTANCE
	 */
	public final static String LOG_TYPE_INSTANCE="INSTANCE";
	/**
	 * 日志类型-解决方案的实例=TASK
	 */
	public final static String LOG_TYPE_TASK="TASK";

	
	/**
	 * 操作类型-删除=DEL
	 */
	public final static String OP_TYPE_DEL="DEL";
	/**
	 * 操作类型-备注=NOTE
	 */
	public final static String OP_TYPE_NOTE="NOTE";
	
	/**
	 * 提交催办
	 */
	public final static String OP_TYPE_URGE="URGE";
	
	
	/**
	 * 实例结束
	 */
	public final static String OP_TYPE_INST_END="INST_END";
	
	/**
	 * 启动流程
	 */
	public final static String OP_TYPE_INST_START="INST_START";
	
	/**
	 * 保存草稿
	 */
	public final static String OP_TYPE_INST_DRAFT="INST_DRAFT";
	
	/**
	 * 流程挂起
	 */
	public final static String OP_TYPE_INST_PEND="INST_PEND";
	
	/**
	 * 实例激活
	 */
	public final static String OP_TYPE_INST_ACTIVE="INST_ACTIVE";
	
	/**
	 * 实例作废
	 */
	public final static String OP_TYPE_INST_DISCARD="INST_DISCARD";
	
	
	/**
	 * 回复沟通日志。
	 */
	public final static String OP_TYPE_TASK_REPLY="TASK_REPLY";
	
	/**
	 * 回复沟通日志。
	 */
	public final static String OP_TYPE_TASK_ADDSIGN="TASK_ADDSIGN";
	
	/**
	 * 撤销沟通
	 */
	public final static String OP_TYPE_TASK_REVOKE="TASK_REVOKE";
	
	/**
	 * 操作类型-沟通=沟通
	 */
	public final static String OP_TYPE_TASK_COMMUTE="COMMUTE";
	
	/**
	 * 任务转办
	 */
	public final static String OP_TYPE_TASK_TRANSFER="TASK_TRANSFER";
	
	
	

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "LOG_ID_")
	protected String logId;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	protected String solId;
	/* 流程实例ID */
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	@Size(max = 64)
	protected String instId;
	/* 流程任务ID */
	@FieldDefine(title = "流程任务ID")
	@Column(name = "TASK_ID_")
	@Size(max = 64)
	protected String taskId;
	/* 日志分类 */
	@FieldDefine(title = "日志分类")
	@Column(name = "LOG_TYPE_")
	@Size(max = 50)
	@NotEmpty
	protected String logType;
	/* 操作类型 */
	@FieldDefine(title = "操作类型")
	@Column(name = "OP_TYPE_")
	@Size(max = 50)
	@NotEmpty
	protected String opType;
	/* 操作内容 */
	@FieldDefine(title = "操作内容")
	@Column(name = "OP_CONTENT_")
	@Size(max = 512)
	@NotEmpty
	protected String opContent;

	/**
	 * Default Empty Constructor for class BpmLog
	 */
	public BpmLog() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmLog
	 */
	public BpmLog(String in_logId) {
		this.setLogId(in_logId);
	}

	/**
	 * * @return String
	 */
	public String getLogId() {
		return this.logId;
	}

	/**
	 * 设置
	 */
	public void setLogId(String aValue) {
		this.logId = aValue;
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
	 * 流程任务ID * @return String
	 */
	public String getTaskId() {
		return this.taskId;
	}

	/**
	 * 设置 流程任务ID
	 */
	public void setTaskId(String aValue) {
		this.taskId = aValue;
	}

	/**
	 * 日志分类 * @return String
	 */
	public String getLogType() {
		return this.logType;
	}

	/**
	 * 设置 日志分类
	 */
	public void setLogType(String aValue) {
		this.logType = aValue;
	}

	/**
	 * 操作类型 * @return String
	 */
	public String getOpType() {
		return this.opType;
	}

	/**
	 * 设置 操作类型
	 */
	public void setOpType(String aValue) {
		this.opType = aValue;
	}

	/**
	 * 操作内容 * @return String
	 */
	public String getOpContent() {
		return this.opContent;
	}

	/**
	 * 设置 操作内容
	 */
	public void setOpContent(String aValue) {
		this.opContent = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.logId;
	}

	@Override
	public Serializable getPkId() {
		return this.logId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.logId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmLog)) {
			return false;
		}
		BpmLog rhs = (BpmLog) object;
		return new EqualsBuilder().append(this.logId, rhs.logId).append(this.solId, rhs.solId).append(this.instId, rhs.instId).append(this.taskId, rhs.taskId).append(this.logType, rhs.logType).append(this.opType, rhs.opType).append(this.opContent, rhs.opContent).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.logId).append(this.solId).append(this.instId).append(this.taskId).append(this.logType).append(this.opType).append(this.opContent).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("logId", this.logId).append("solId", this.solId).append("instId", this.instId).append("taskId", this.taskId).append("logType", this.logType).append("opType", this.opType).append("opContent", this.opContent).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime)
				.append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
