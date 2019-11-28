



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
 * 描述：流程超时节点表实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-03-27 18:50:23
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "流程超时节点表")
public class BpmOvertimeNode extends BaseTenantEntity {

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	protected String solId; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "流程节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "操作类型")
	@Column(name = "OP_TYPE_")
	protected String opType; 
	@FieldDefine(title = "操作内容")
	@Column(name = "OP_CONTENT_")
	protected String opContent; 
	@FieldDefine(title = "超时时间")
	@Column(name = "OVERTIME_")
	protected Integer overtime; 
	@FieldDefine(title = "节点状态")
	@Column(name = "STATUS_")
	protected String status = "0"; 
	
	
	
	
	
	public BpmOvertimeNode() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmOvertimeNode(String in_id) {
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
	 * 返回 解决方案ID
	 * @return
	 */
	public String getSolId() {
		return this.solId;
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
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	/**
	 * 返回 流程节点ID
	 * @return
	 */
	public String getNodeId() {
		return this.nodeId;
	}
	public void setOpType(String opType) {
		this.opType = opType;
	}
	
	/**
	 * 返回 操作类型
	 * @return
	 */
	public String getOpType() {
		return this.opType;
	}
	public void setOpContent(String opContent) {
		this.opContent = opContent;
	}
	
	/**
	 * 返回 操作内容
	 * @return
	 */
	public String getOpContent() {
		return this.opContent;
	}
	
	public Integer getOvertime() {
		return overtime;
	}

	public void setOvertime(Integer overtime) {
		this.overtime = overtime;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 节点状态
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmOvertimeNode)) {
			return false;
		}
		BpmOvertimeNode rhs = (BpmOvertimeNode) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.solId, rhs.solId) 
		.append(this.instId, rhs.instId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.opType, rhs.opType) 
		.append(this.opContent, rhs.opContent) 
		.append(this.overtime, rhs.overtime) 
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
		.append(this.instId) 
		.append(this.nodeId) 
		.append(this.opType) 
		.append(this.opContent) 
		.append(this.overtime) 
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
				.append("instId", this.instId) 
				.append("nodeId", this.nodeId) 
				.append("opType", this.opType) 
				.append("opContent", this.opContent) 
				.append("overtime", this.overtime) 
				.append("status", this.status) 
												.toString();
	}

}



