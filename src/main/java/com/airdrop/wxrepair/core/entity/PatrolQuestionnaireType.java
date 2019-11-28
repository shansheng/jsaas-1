



package com.airdrop.wxrepair.core.entity;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * <pre>
 *  
 * 描述：问卷类型实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-11-20 15:28:18
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "问卷类型")
public class PatrolQuestionnaireType extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "类型编码")
	@Column(name = "F_TYPE_CODE")
	protected String typeCode; 
	@FieldDefine(title = "类型名称")
	@Column(name = "F_TYPE_NAME")
	protected String typeName; 
	@FieldDefine(title = "是否启用ID")
	@Column(name = "F_STATUS")
	protected String status; 
	@FieldDefine(title = "是否启用")
	@Column(name = "F_STATUS_name")
	protected String statusName; 
	@FieldDefine(title = "外键")
	@Column(name = "REF_ID_")
	protected String refId; 
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	protected String parentId; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "状态")
	@Column(name = "INST_STATUS_")
	protected String instStatus; 
	@FieldDefine(title = "组ID")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	
	
	
	
	
	public PatrolQuestionnaireType() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolQuestionnaireType(String in_id) {
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
	
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	
	/**
	 * 返回 类型编码
	 * @return
	 */
	public String getTypeCode() {
		return this.typeCode;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	/**
	 * 返回 类型名称
	 * @return
	 */
	public String getTypeName() {
		return this.typeName;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 是否启用ID
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
	/**
	 * 返回 是否启用
	 * @return
	 */
	public String getStatusName() {
		return this.statusName;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	
	/**
	 * 返回 外键
	 * @return
	 */
	public String getRefId() {
		return this.refId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	/**
	 * 返回 父ID
	 * @return
	 */
	public String getParentId() {
		return this.parentId;
	}
	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	/**
	 * 返回 流程实例ID
	 * @return
	 */
	public String getInstId() {
		return this.instId;
	}
	public void setInstStatus(String instStatus) {
		this.instStatus = instStatus;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getInstStatus() {
		return this.instStatus;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 组ID
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof PatrolQuestionnaireType)) {
			return false;
		}
		PatrolQuestionnaireType rhs = (PatrolQuestionnaireType) object;
		return new EqualsBuilder()
		.append(this.typeCode, rhs.typeCode) 
		.append(this.typeName, rhs.typeName) 
		.append(this.status, rhs.status) 
		.append(this.statusName, rhs.statusName) 
		.append(this.id, rhs.id) 
		.append(this.refId, rhs.refId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.append(this.groupId, rhs.groupId) 
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.typeCode) 
		.append(this.typeName) 
		.append(this.status) 
		.append(this.statusName) 
		.append(this.id) 
		.append(this.refId) 
		.append(this.parentId) 
		.append(this.instId) 
		.append(this.instStatus) 
		.append(this.groupId) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("typeCode", this.typeCode) 
				.append("typeName", this.typeName) 
				.append("status", this.status) 
				.append("statusName", this.statusName) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



