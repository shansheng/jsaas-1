



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：act_ru_identitylink实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-10-26 17:26:32
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "act_ru_identitylink")
public class TaskCandidate extends BaseTenantEntity {

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "REV_")
	@Column(name = "REV_")
	protected Integer rev; 
	@FieldDefine(title = "GROUP_ID_")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	@FieldDefine(title = "TYPE_")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "USER_ID_")
	@Column(name = "USER_ID_")
	protected String userId; 
	@FieldDefine(title = "TASK_ID_")
	@Column(name = "TASK_ID_")
	protected String taskId; 
	@FieldDefine(title = "PROC_INST_ID_")
	@Column(name = "PROC_INST_ID_")
	protected String procInstId; 
	@FieldDefine(title = "PROC_DEF_ID_")
	@Column(name = "PROC_DEF_ID_")
	protected String procDefId; 
	
	
	
	
	
	public TaskCandidate() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public TaskCandidate(String in_id) {
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
	
	public void setRev(Integer rev) {
		this.rev = rev;
	}
	
	/**
	 * 返回 REV_
	 * @return
	 */
	public Integer getRev() {
		return this.rev;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 GROUP_ID_
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 TYPE_
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 USER_ID_
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	/**
	 * 返回 TASK_ID_
	 * @return
	 */
	public String getTaskId() {
		return this.taskId;
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
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof TaskCandidate)) {
			return false;
		}
		TaskCandidate rhs = (TaskCandidate) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.rev, rhs.rev) 
		.append(this.groupId, rhs.groupId) 
		.append(this.type, rhs.type) 
		.append(this.userId, rhs.userId) 
		.append(this.taskId, rhs.taskId) 
		.append(this.procInstId, rhs.procInstId) 
		.append(this.procDefId, rhs.procDefId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.rev) 
		.append(this.groupId) 
		.append(this.type) 
		.append(this.userId) 
		.append(this.taskId) 
		.append(this.procInstId) 
		.append(this.procDefId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("rev", this.rev) 
				.append("groupId", this.groupId) 
				.append("type", this.type) 
				.append("userId", this.userId) 
				.append("taskId", this.taskId) 
				.append("procInstId", this.procInstId) 
				.append("procDefId", this.procDefId) 
		.toString();
	}

}



