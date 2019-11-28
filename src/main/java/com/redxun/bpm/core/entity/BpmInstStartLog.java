



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
 * 描述：启动流程日志实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-06-29 17:37:16
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "启动流程日志")
public class BpmInstStartLog extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "启动方案")
	@Column(name = "FROM_SOL_ID_")
	protected String fromSolId; 
	@FieldDefine(title = "启动节点")
	@Column(name = "FROM_NODE_ID_")
	protected String fromNodeId; 
	@FieldDefine(title = "启动实例")
	@Column(name = "FROM_INST_ID_")
	protected String fromInstId; 
	@FieldDefine(title = "节点名称")
	@Column(name = "FROM_NODE_NAME_")
	protected String fromNodeName; 
	@FieldDefine(title = "启动主题")
	@Column(name = "FROM_SUBJECT_")
	protected String fromSubject; 
	@FieldDefine(title = "启动流程定义ID")
	@Column(name = "FROM_ACT_DEF_ID_")
	protected String fromActDefId; 
	@FieldDefine(title = "被启动方案")
	@Column(name = "TO_SOL_ID_")
	protected String toSolId; 
	@FieldDefine(title = "被启动主题")
	@Column(name = "TO_SUBJECT_")
	protected String toSubject; 
	@FieldDefine(title = "被启动定义ID")
	@Column(name = "TO_ACT_DEF_ID_")
	protected String toActDefId; 
	@FieldDefine(title = "创建人")
	@Column(name = "CREATE_USER_")
	protected String createUser; 
	
	@FieldDefine(title = "被启动实例")
	@Column(name = "TO_INST_ID_")
	protected String toInstId; 
	
	@FieldDefine(title = "ACT流程实例ID")
	@Column(name = "TO_ACT_INST_ID_")
	protected String toActInstId; 
	
	
	
	
	
	public BpmInstStartLog() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmInstStartLog(String in_id) {
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
	
	public void setFromSolId(String fromSolId) {
		this.fromSolId = fromSolId;
	}
	
	/**
	 * 返回 启动方案
	 * @return
	 */
	public String getFromSolId() {
		return this.fromSolId;
	}
	public void setFromNodeId(String fromNodeId) {
		this.fromNodeId = fromNodeId;
	}
	
	/**
	 * 返回 启动节点
	 * @return
	 */
	public String getFromNodeId() {
		return this.fromNodeId;
	}
	public void setFromInstId(String fromInstId) {
		this.fromInstId = fromInstId;
	}
	
	/**
	 * 返回 启动实例
	 * @return
	 */
	public String getFromInstId() {
		return this.fromInstId;
	}
	public void setFromNodeName(String fromNodeName) {
		this.fromNodeName = fromNodeName;
	}
	
	/**
	 * 返回 节点名称
	 * @return
	 */
	public String getFromNodeName() {
		return this.fromNodeName;
	}
	public void setFromSubject(String fromSubject) {
		this.fromSubject = fromSubject;
	}
	
	/**
	 * 返回 启动主题
	 * @return
	 */
	public String getFromSubject() {
		return this.fromSubject;
	}
	public void setFromActDefId(String fromActDefId) {
		this.fromActDefId = fromActDefId;
	}
	
	/**
	 * 返回 启动流程定义ID
	 * @return
	 */
	public String getFromActDefId() {
		return this.fromActDefId;
	}
	public void setToSolId(String toSolId) {
		this.toSolId = toSolId;
	}
	
	/**
	 * 返回 被启动方案
	 * @return
	 */
	public String getToSolId() {
		return this.toSolId;
	}
	public void setToSubject(String toSubject) {
		this.toSubject = toSubject;
	}
	
	/**
	 * 返回 被启动主题
	 * @return
	 */
	public String getToSubject() {
		return this.toSubject;
	}
	public void setToActDefId(String toActDefId) {
		this.toActDefId = toActDefId;
	}
	
	/**
	 * 返回 被启动定义ID
	 * @return
	 */
	public String getToActDefId() {
		return this.toActDefId;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	
	/**
	 * 返回 创建人
	 * @return
	 */
	public String getCreateUser() {
		return this.createUser;
	}
	
	
	
	
		

	public String getToInstId() {
		return toInstId;
	}

	public void setToInstId(String toInstId) {
		this.toInstId = toInstId;
	}

	public String getToActInstId() {
		return toActInstId;
	}

	public void setToActInstId(String toActInstId) {
		this.toActInstId = toActInstId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstStartLog)) {
			return false;
		}
		BpmInstStartLog rhs = (BpmInstStartLog) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.fromSolId, rhs.fromSolId) 
		.append(this.fromNodeId, rhs.fromNodeId) 
		.append(this.fromInstId, rhs.fromInstId) 
		.append(this.fromNodeName, rhs.fromNodeName) 
		.append(this.fromSubject, rhs.fromSubject) 
		.append(this.fromActDefId, rhs.fromActDefId) 
		.append(this.toSolId, rhs.toSolId) 
		.append(this.toSubject, rhs.toSubject) 
		.append(this.toActDefId, rhs.toActDefId) 
		.append(this.createUser, rhs.createUser) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.fromSolId) 
		.append(this.fromNodeId) 
		.append(this.fromInstId) 
		.append(this.fromNodeName) 
		.append(this.fromSubject) 
		.append(this.fromActDefId) 
		.append(this.toSolId) 
		.append(this.toSubject) 
		.append(this.toActDefId) 
		.append(this.createUser) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("fromSolId", this.fromSolId) 
				.append("fromNodeId", this.fromNodeId) 
				.append("fromInstId", this.fromInstId) 
				.append("fromNodeName", this.fromNodeName) 
				.append("fromSubject", this.fromSubject) 
				.append("fromActDefId", this.fromActDefId) 
				.append("toSolId", this.toSolId) 
				.append("toSubject", this.toSubject) 
				.append("toActDefId", this.toActDefId) 
				.append("createUser", this.createUser) 
												.toString();
	}

}



