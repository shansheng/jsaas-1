



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
 * 描述：流程批量审批设置表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-06-27 15:19:53
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "流程批量审批设置表")
public class BpmBatchApproval extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "流程方案ID")
	@Column(name = "SOL_ID_")
	protected String solId; 
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "实体表名称")
	@Column(name = "TABLE_NAME_")
	protected String tableName; 
	@FieldDefine(title = "字段设置")
	@Column(name = "FIELD_JSON_")
	protected String fieldJson; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	protected String status; 
	
	
	protected String solName;//流程方案
	protected String taskName;//节点名称
	
	protected String actDefId;//流程定义ID
	
	public BpmBatchApproval() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmBatchApproval(String in_id) {
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
	
	public void setSolId(String solId) {
		this.solId = solId;
	}
	
	/**
	 * 返回 流程方案ID
	 * @return
	 */
	public String getSolId() {
		return this.solId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	/**
	 * 返回 节点ID
	 * @return
	 */
	public String getNodeId() {
		return this.nodeId;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	/**
	 * 返回 实体表名称
	 * @return
	 */
	public String getTableName() {
		return this.tableName;
	}
	public void setFieldJson(String fieldJson) {
		this.fieldJson = fieldJson;
	}
	
	/**
	 * 返回 字段设置
	 * @return
	 */
	public String getFieldJson() {
		return this.fieldJson;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	

	public String getSolName() {
		return solName;
	}

	public void setSolName(String solName) {
		this.solName = solName;
	}
	
	

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actdefId) {
		this.actDefId = actdefId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmBatchApproval)) {
			return false;
		}
		BpmBatchApproval rhs = (BpmBatchApproval) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.solId, rhs.solId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.tableName, rhs.tableName) 
		.append(this.fieldJson, rhs.fieldJson) 
		.append(this.status, rhs.status) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.solId) 
		.append(this.nodeId) 
		.append(this.tableName) 
		.append(this.fieldJson) 
		.append(this.status) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("solId", this.solId) 
				.append("nodeId", this.nodeId) 
				.append("tableName", this.tableName) 
				.append("fieldJson", this.fieldJson) 
				.append("status", this.status) 
		.toString();
	}

}



