



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.ExceptionUtil;

/**
 * <pre>
 *  
 * 描述：act_hi_taskinst实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-04-02 09:26:35
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "act_hi_taskinst")
public class ActHiTaskinst extends BaseTenantEntity implements Cloneable{
	
	private static Logger logger= LogManager.getLogger(ActHiTaskinst.class);

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "PROC_DEF_ID_")
	@Column(name = "PROC_DEF_ID_")
	protected String procDefId; 
	@FieldDefine(title = "TASK_DEF_KEY_")
	@Column(name = "TASK_DEF_KEY_")
	protected String taskDefKey; 
	@FieldDefine(title = "PROC_INST_ID_")
	@Column(name = "PROC_INST_ID_")
	protected String procInstId; 
	@FieldDefine(title = "EXECUTION_ID_")
	@Column(name = "EXECUTION_ID_")
	protected String executionId; 
	@FieldDefine(title = "NAME_")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "PARENT_TASK_ID_")
	@Column(name = "PARENT_TASK_ID_")
	protected String parentTaskId; 
	@FieldDefine(title = "DESCRIPTION_")
	@Column(name = "DESCRIPTION_")
	protected String description; 
	@FieldDefine(title = "OWNER_")
	@Column(name = "OWNER_")
	protected String owner; 
	@FieldDefine(title = "ASSIGNEE_")
	@Column(name = "ASSIGNEE_")
	protected String assignee; 
	@FieldDefine(title = "START_TIME_")
	@Column(name = "START_TIME_")
	protected java.util.Date startTime; 
	@FieldDefine(title = "CLAIM_TIME_")
	@Column(name = "CLAIM_TIME_")
	protected java.util.Date claimTime; 
	@FieldDefine(title = "END_TIME_")
	@Column(name = "END_TIME_")
	protected java.util.Date endTime; 
	@FieldDefine(title = "DURATION_")
	@Column(name = "DURATION_")
	protected Long duration; 
	@FieldDefine(title = "DELETE_REASON_")
	@Column(name = "DELETE_REASON_")
	protected String deleteReason; 
	@FieldDefine(title = "PRIORITY_")
	@Column(name = "PRIORITY_")
	protected Integer priority; 
	@FieldDefine(title = "DUE_DATE_")
	@Column(name = "DUE_DATE_")
	protected java.util.Date dueDate; 
	@FieldDefine(title = "FORM_KEY_")
	@Column(name = "FORM_KEY_")
	protected String formKey; 
	@FieldDefine(title = "CATEGORY_")
	@Column(name = "CATEGORY_")
	protected String category; 
	
	
	
	
	
	public ActHiTaskinst() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public ActHiTaskinst(String in_id) {
		this.setPkId(in_id);
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
	
	public String getId() {
		return this.id;
	}

	
	public void setId(String aValue) {
		this.id = aValue;
	}
	
	public void setProcDefId(String procDefId) {
		this.procDefId = procDefId;
	}
	
	/**
	 * 返回 PROC_DEF_ID_
	 * @return
	 */
	public String getProcDefId() {
		return this.procDefId;
	}
	public void setTaskDefKey(String taskDefKey) {
		this.taskDefKey = taskDefKey;
	}
	
	/**
	 * 返回 TASK_DEF_KEY_
	 * @return
	 */
	public String getTaskDefKey() {
		return this.taskDefKey;
	}
	public void setProcInstId(String procInstId) {
		this.procInstId = procInstId;
	}
	
	/**
	 * 返回 PROC_INST_ID_
	 * @return
	 */
	public String getProcInstId() {
		return this.procInstId;
	}
	public void setExecutionId(String executionId) {
		this.executionId = executionId;
	}
	
	/**
	 * 返回 EXECUTION_ID_
	 * @return
	 */
	public String getExecutionId() {
		return this.executionId;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 NAME_
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setParentTaskId(String parentTaskId) {
		this.parentTaskId = parentTaskId;
	}
	
	/**
	 * 返回 PARENT_TASK_ID_
	 * @return
	 */
	public String getParentTaskId() {
		return this.parentTaskId;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * 返回 DESCRIPTION_
	 * @return
	 */
	public String getDescription() {
		return this.description;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	
	/**
	 * 返回 OWNER_
	 * @return
	 */
	public String getOwner() {
		return this.owner;
	}
	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}
	
	/**
	 * 返回 ASSIGNEE_
	 * @return
	 */
	public String getAssignee() {
		return this.assignee;
	}
	public void setStartTime(java.util.Date startTime) {
		this.startTime = startTime;
	}
	
	/**
	 * 返回 START_TIME_
	 * @return
	 */
	public java.util.Date getStartTime() {
		return this.startTime;
	}
	public void setClaimTime(java.util.Date claimTime) {
		this.claimTime = claimTime;
	}
	
	/**
	 * 返回 CLAIM_TIME_
	 * @return
	 */
	public java.util.Date getClaimTime() {
		return this.claimTime;
	}
	public void setEndTime(java.util.Date endTime) {
		this.endTime = endTime;
	}
	
	/**
	 * 返回 END_TIME_
	 * @return
	 */
	public java.util.Date getEndTime() {
		return this.endTime;
	}
	public void setDuration(Long duration) {
		this.duration = duration;
	}
	
	/**
	 * 返回 DURATION_
	 * @return
	 */
	public Long getDuration() {
		return this.duration;
	}
	public void setDeleteReason(String deleteReason) {
		this.deleteReason = deleteReason;
	}
	
	/**
	 * 返回 DELETE_REASON_
	 * @return
	 */
	public String getDeleteReason() {
		return this.deleteReason;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	
	/**
	 * 返回 PRIORITY_
	 * @return
	 */
	public Integer getPriority() {
		return this.priority;
	}
	public void setDueDate(java.util.Date dueDate) {
		this.dueDate = dueDate;
	}
	
	/**
	 * 返回 DUE_DATE_
	 * @return
	 */
	public java.util.Date getDueDate() {
		return this.dueDate;
	}
	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}
	
	/**
	 * 返回 FORM_KEY_
	 * @return
	 */
	public String getFormKey() {
		return this.formKey;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	/**
	 * 返回 CATEGORY_
	 * @return
	 */
	public String getCategory() {
		return this.category;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof ActHiTaskinst)) {
			return false;
		}
		ActHiTaskinst rhs = (ActHiTaskinst) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.procDefId, rhs.procDefId) 
		.append(this.taskDefKey, rhs.taskDefKey) 
		.append(this.procInstId, rhs.procInstId) 
		.append(this.executionId, rhs.executionId) 
		.append(this.name, rhs.name) 
		.append(this.parentTaskId, rhs.parentTaskId) 
		.append(this.description, rhs.description) 
		.append(this.owner, rhs.owner) 
		.append(this.assignee, rhs.assignee) 
		.append(this.startTime, rhs.startTime) 
		.append(this.claimTime, rhs.claimTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.duration, rhs.duration) 
		.append(this.deleteReason, rhs.deleteReason) 
		.append(this.priority, rhs.priority) 
		.append(this.dueDate, rhs.dueDate) 
		.append(this.formKey, rhs.formKey) 
		.append(this.category, rhs.category) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.procDefId) 
		.append(this.taskDefKey) 
		.append(this.procInstId) 
		.append(this.executionId) 
		.append(this.name) 
		.append(this.parentTaskId) 
		.append(this.description) 
		.append(this.owner) 
		.append(this.assignee) 
		.append(this.startTime) 
		.append(this.claimTime) 
		.append(this.endTime) 
		.append(this.duration) 
		.append(this.deleteReason) 
		.append(this.priority) 
		.append(this.dueDate) 
		.append(this.formKey) 
		.append(this.category) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("procDefId", this.procDefId) 
				.append("taskDefKey", this.taskDefKey) 
				.append("procInstId", this.procInstId) 
				.append("executionId", this.executionId) 
				.append("name", this.name) 
				.append("parentTaskId", this.parentTaskId) 
				.append("description", this.description) 
				.append("owner", this.owner) 
				.append("assignee", this.assignee) 
				.append("startTime", this.startTime) 
				.append("claimTime", this.claimTime) 
				.append("endTime", this.endTime) 
				.append("duration", this.duration) 
				.append("deleteReason", this.deleteReason) 
				.append("priority", this.priority) 
				.append("dueDate", this.dueDate) 
				.append("formKey", this.formKey) 
				.append("category", this.category) 
				.toString();
	}

	
	@Override
	public Object clone()  {
		ActHiTaskinst o = null;
		try{
			o = (ActHiTaskinst)super.clone();
		}catch(CloneNotSupportedException e){
			logger.error(ExceptionUtil.getExceptionMessage(e));
		}
		return o;
	}
}



