package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.json.JsonDateSerializer;

/**
 * <pre>
 * 描述：BpmTask实体类定义
 * 流程任务
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "ACT_RU_TASK")
@TableDefine(title = "流程任务")
public class BpmTask extends BaseTenantEntity implements IRightModel ,Cloneable{
	
	/**
	 * 任务类型-沟通任务=CMM
	 */
	public final static String TASK_TYPE_CMM="CMM";
	
	/**
	 * 任务类型-沟通任务=USER
	 */
	public final static String TASK_TYPE_USER="USER";

    /**
     * 任务类型-代理任务=AGENT
     */
    public final static String TASK_TYPE_AGENT="AGENT";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 修正号 */
	@FieldDefine(title = "修正号")
	@Column(name = "REV_")
	protected Integer rev;
	/* 执行ID */
	@FieldDefine(title = "执行ID")
	@Column(name = "EXECUTION_ID_")
	@Size(max = 64)
	protected String executionId;
	/* 任务名称 */
	@FieldDefine(title = "任务名称")
	@Column(name = "NAME_")
	@Size(max = 255)
	protected String name;
	/* 父任务ID */
	@FieldDefine(title = "父任务ID")
	@Column(name = "PARENT_TASK_ID_")
	@Size(max = 64)
	protected String parentTaskId;
	/* 任务描述 */
	@FieldDefine(title = "任务描述")
	@Column(name = "DESCRIPTION_")
	@Size(max = 4000)
	protected String description;
	/* 任务定义Key */
	@FieldDefine(title = "任务定义Key")
	@Column(name = "TASK_DEF_KEY_")
	@Size(max = 255)
	protected String taskDefKey;
	/* 任务所属人 */
	@FieldDefine(title = "任务所属人")
	@Column(name = "OWNER_")
	@Size(max = 255)
	protected String owner;
	/* 任务执行人 */
	@FieldDefine(title = "任务执行人")
	@Column(name = "ASSIGNEE_")
	@Size(max = 255)
	protected String assignee;
	/* 代理状态 */
	@FieldDefine(title = "代理状态")
	@Column(name = "DELEGATION_")
	@Size(max = 64)
	protected String delegation;
	/* 优先级 */
	@FieldDefine(title = "优先级")
	@Column(name = "PRIORITY_")
	protected Integer priority;
	/* 到期时间 */
	@FieldDefine(title = "到期时间")
	@Column(name = "DUE_DATE_")
	protected java.util.Date dueDate;
	/* 分类 */
	@FieldDefine(title = "分类")
	@Column(name = "CATEGORY_")
	@Size(max = 255)
	protected String category;
	/* 挂起状态 */
	@FieldDefine(title = "挂起状态")
	@Column(name = "SUSPENSION_STATE_")
	protected Integer suspensionState;
	/* 表单Key */
	@FieldDefine(title = "表单Key")
	@Column(name = "FORM_KEY_")
	@Size(max = 255)
	protected String formKey;

	@FieldDefine(title="代理用户ID")
	@Column(name="AGENT_USER_ID_")
	@Size(max=64)
	protected String agentUserId;
	
	@FieldDefine(title="业务流程解决方案ID")
	@Column(name="SOL_ID_")
	@Size(max=64)
	protected String solId;
	
	@FieldDefine(title="业务流程解决方案KEY")
	@Column(name="SOL_KEY_")
	@Size(max=64)
	protected String solKey;
	
	@FieldDefine(title = "流程实例ID")
	@Column(name = "PROC_INST_ID_")
	@Size(max = 255)
	protected String procInstId;
	
	@FieldDefine(title = "流程定义ID")
	@Column(name = "PROC_DEF_ID_")
	@Size(max = 255)
	protected String procDefId;
	
	//是否产生了沟通任务 YES/NO
	@Column(name="GEN_CM_TASK_")
	@Size(max=20)
	protected String genCmTask;
	//沟通任务对应的主任务Id
	@Column(name="RC_TASK_ID_")
	@Size(max=64)
	protected String rcTaskId;
	/**
	 * 沟通任务的层次（一级沟通或二级沟通）
	 */
	@Column(name="CM_LEVEL_")
	protected Integer cmLevel;
	
	/**
	 * 运行路径Id
	 */
	@Column(name="RUN_PATH_ID_")
	protected String runPathId;
	
	/**
	 * 任务类型，如沟通任务CMM或审批任务UESR
	 */
	@Column(name="TASK_TYPE_")
	@Size(max=20)
	protected String taskType;
	
	/**
	 * 沟通任务的发起人
	 */
	@Column(name="CM_FUSRID_")
	@Size(max=64)
	protected String cmFuserId;
	
	/**
	 * 沟通任务的发起人
	 */
	@Column(name="TOKEN_")
	@Size(max=64)
	protected String token;
	
	@Column(name="URGENT_TIMES_")
	protected Integer urgentTimes;
	
	@Column(name="ENABLE_MOBILE_")
	protected Integer enableMobile=0;
	

	/* 超时状态 0 正常 1 提前 2 超时 */
	@FieldDefine(title = "超时状态")
	@Column(name = "TIMEOUT_STATUS_")
	@Size(max = 20)
	protected String timeoutStatus;
	
	/**
	 * 超时时间
	 */
	@Column(name="OVERTIME_")
	protected String overtime;
	
	@Column(name="LOCKED_")
	protected Integer locked=0;
	
	@Transient
	protected JSONObject rightJson;
	
	@Transient
	protected String instId="";
	
	//分配人员名称列表
	protected String assigneeNames="";
	
	@Transient
	protected String bpmTypeName = "";
	
	@Transient
	protected String status = "";
	
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBpmTypeName() {
		return bpmTypeName;
	}

	public void setBpmTypeName(String bpmTypeName) {
		this.bpmTypeName = bpmTypeName;
	}
	

	/**
	 * Default Empty Constructor for class BpmTask
	 */
	public BpmTask() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmTask
	 */
	public BpmTask(String in_id) {
		this.setId(in_id);
	}


	public String getAssigneeNames() {
		return assigneeNames;
	}

	public void setAssigneeNames(String assigneeNames) {
		this.assigneeNames = assigneeNames;
	}

	/**
	 * ID * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 ID
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 修正号 * @return Integer
	 */
	public Integer getRev() {
		return this.rev;
	}

	/**
	 * 设置 修正号
	 */
	public void setRev(Integer aValue) {
		this.rev = aValue;
	}

	/**
	 * 执行ID * @return String
	 */
	public String getExecutionId() {
		return this.executionId;
	}

	/**
	 * 设置 执行ID
	 */
	public void setExecutionId(String aValue) {
		this.executionId = aValue;
	}

	/**
	 * 任务名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 任务名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 父任务ID * @return String
	 */
	public String getParentTaskId() {
		return this.parentTaskId;
	}

	public String getSolId() {
		return solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
	}

	/**
	 * 设置 父任务ID
	 */
	public void setParentTaskId(String aValue) {
		this.parentTaskId = aValue;
	}

	/**
	 * 任务描述 * @return String
	 */
	public String getDescription() {
		return this.description;
	}

	/**
	 * 设置 任务描述
	 */
	public void setDescription(String aValue) {
		this.description = aValue;
	}

	/**
	 * 任务定义Key * @return String
	 */
	public String getTaskDefKey() {
		return this.taskDefKey;
	}

	/**
	 * 设置 任务定义Key
	 */
	public void setTaskDefKey(String aValue) {
		this.taskDefKey = aValue;
	}

	/**
	 * 任务所属人 * @return String
	 */
	public String getOwner() {
		return this.owner;
	}

	/**
	 * 设置 任务所属人
	 */
	public void setOwner(String aValue) {
		this.owner = aValue;
	}

	/**
	 * 任务执行人 * @return String
	 */
	public String getAssignee() {
		return this.assignee;
	}

	/**
	 * 设置 任务执行人
	 */
	public void setAssignee(String aValue) {
		this.assignee = aValue;
	}

	/**
	 * 代理状态 * @return String
	 */
	public String getDelegation() {
		return this.delegation;
	}

	/**
	 * 设置 代理状态
	 */
	public void setDelegation(String aValue) {
		this.delegation = aValue;
	}

	/**
	 * 优先级 * @return Integer
	 */
	public Integer getPriority() {
		return this.priority;
	}

	/**
	 * 设置 优先级
	 */
	public void setPriority(Integer aValue) {
		this.priority = aValue;
	}

	/**
	 * 到期时间 * @return java.util.Date
	 */
	@JsonSerialize(using=JsonDateSerializer.class)
	public java.util.Date getDueDate() {
		return this.dueDate;
	}

	/**
	 * 设置 到期时间
	 */
	public void setDueDate(java.util.Date aValue) {
		this.dueDate = aValue;
	}

	/**
	 * 分类 * @return String
	 */
	public String getCategory() {
		return this.category;
	}

	/**
	 * 设置 分类
	 */
	public void setCategory(String aValue) {
		this.category = aValue;
	}

	/**
	 * 挂起状态 * @return Integer
	 */
	public Integer getSuspensionState() {
		return this.suspensionState;
	}

	/**
	 * 设置 挂起状态
	 */
	public void setSuspensionState(Integer aValue) {
		this.suspensionState = aValue;
	}

	/**
	 * 表单Key * @return String
	 */
	public String getFormKey() {
		return this.formKey;
	}

	public String getAgentUserId() {
		return agentUserId;
	}

	public void setAgentUserId(String agentUserId) {
		this.agentUserId = agentUserId;
	}

	/**
	 * 设置 表单Key
	 */
	public void setFormKey(String aValue) {
		this.formKey = aValue;
	}

	public String getGenCmTask() {
		return genCmTask;
	}

	public void setGenCmTask(String genCmTask) {
		this.genCmTask = genCmTask;
	}

	public String getRcTaskId() {
		return rcTaskId;
	}

	public void setRcTaskId(String rcTaskId) {
		this.rcTaskId = rcTaskId;
	}

	public Integer getCmLevel() {
		return cmLevel;
	}

	public void setCmLevel(Integer cmLevel) {
		this.cmLevel = cmLevel;
	}

	@Override
	public String getIdentifyLabel() {
		return this.id;
	}

	@Override
	public Serializable getPkId() {
		return this.id;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.id = (String) pkId;
	}

	public String getProcInstId() {
		return procInstId;
	}

	public void setProcInstId(String procInstId) {
		this.procInstId = procInstId;
	}

	public String getProcDefId() {
		return procDefId;
	}

	public void setProcDefId(String procDefId) {
		this.procDefId = procDefId;
	}
	
	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public String getCmFuserId() {
		return cmFuserId;
	}

	public void setCmFuserId(String cmFuserId) {
		this.cmFuserId = cmFuserId;
	}
	
	@Override
	public void setRightJson(JSONObject rightJson) {
		this.rightJson=rightJson;
	}

	@Override
	public JSONObject getRightJson() {
		return this.rightJson;
	}

	public String getInstId() {
		return instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
	}

	public String getSolKey() {
		return solKey;
	}

	public void setSolKey(String solKey) {
		this.solKey = solKey;
	}

	public String getStayTime() {
		if(this.createTime==null){
			return "";
		}
		Date now = new Date();
		long stayHours = (now.getTime()-this.createTime.getTime())/(60*60*1000);
		int days = new Long(stayHours/24).intValue();
		int hours = new Long(stayHours%24).intValue();
		return days +"天" +hours+"小时";
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Integer getUrgentTimes() {
		return urgentTimes;
	}

	public void setUrgentTimes(Integer urgentTimes) {
		this.urgentTimes = urgentTimes;
	}

	public Integer getEnableMobile() {
		return enableMobile;
	}

	public void setEnableMobile(Integer enableMobile) {
		this.enableMobile = enableMobile;
	}

	public String getRunPathId() {
		return runPathId;
	}

	public void setRunPathId(String runPathId) {
		this.runPathId = runPathId;
	}

	public String getTimeoutStatus() {
		return timeoutStatus;
	}



	public String getOvertime() {
		return overtime;
	}

	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}


	public void setTimeoutStatus(String timeoutStatus) {
		this.timeoutStatus = timeoutStatus;
	}

	public Integer getLocked() {
		return locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmTask)) {
			return false;
		}
		BpmTask rhs = (BpmTask) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.rev, rhs.rev).append(this.executionId, rhs.executionId)
				.append(this.name, rhs.name).append(this.parentTaskId, rhs.parentTaskId).append(this.description, rhs.description)
				.append(this.taskDefKey, rhs.taskDefKey).append(this.owner, rhs.owner).append(this.assignee, rhs.assignee)
				.append(this.delegation, rhs.delegation).append(this.priority, rhs.priority).append(this.createTime, rhs.createTime)
				.append(this.dueDate, rhs.dueDate).append(this.category, rhs.category).append(this.suspensionState, rhs.suspensionState)
				.append(this.tenantId, rhs.tenantId).append(this.formKey, rhs.formKey).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.rev).append(this.executionId).append(this.name)
				.append(this.parentTaskId).append(this.description).append(this.taskDefKey).append(this.owner).append(this.assignee)
				.append(this.delegation).append(this.priority).append(this.createTime).append(this.dueDate).append(this.category)
				.append(this.suspensionState).append(this.tenantId).append(this.formKey).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("rev", this.rev).append("executionId", this.executionId)
				.append("name", this.name).append("parentTaskId", this.parentTaskId).append("description", this.description)
				.append("taskDefKey", this.taskDefKey).append("owner", this.owner).append("assignee", this.assignee)
				.append("delegation", this.delegation).append("priority", this.priority).append("createTime", this.createTime)
				.append("dueDate", this.dueDate).append("category", this.category).append("suspensionState", this.suspensionState)
				.append("tenantId", this.tenantId).append("formKey", this.formKey).toString();
	}

	@Override
	public Object clone()  {
		BpmTask o = null;
		try{
			o = (BpmTask)super.clone();
		}catch(CloneNotSupportedException e){
			e.printStackTrace();
		}
		return o;
	}

}
