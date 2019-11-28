



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
 * 描述：流程实例用户设置实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-06-14 15:11:19
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "流程实例用户设置")
public class BpmInstUser extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "人员ID")
	@Column(name = "USER_IDS_")
	protected String userIds; 
	@FieldDefine(title = "人员名称")
	@Column(name = "USER_NAMES")
	protected String userNames; 
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	protected String actDefId; 
	@FieldDefine(title = "是否子实例")
	@Column(name = "IS_SUB_")
	protected Integer isSub; 
	
	
	
	
	
	public BpmInstUser() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmInstUser(String in_id) {
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
	 * 返回 节点ID
	 * @return
	 */
	public String getNodeId() {
		return this.nodeId;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
	/**
	 * 返回 人员ID
	 * @return
	 */
	public String getUserIds() {
		return this.userIds;
	}
	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}
	
	/**
	 * 返回 人员名称
	 * @return
	 */
	public String getUserNames() {
		return this.userNames;
	}
	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}
	
	/**
	 * 返回 流程定义ID
	 * @return
	 */
	public String getActDefId() {
		return this.actDefId;
	}
	public void setIsSub(Integer isSub) {
		this.isSub = isSub;
	}
	
	/**
	 * 返回 是否子实例
	 * @return
	 */
	public Integer getIsSub() {
		return this.isSub;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstUser)) {
			return false;
		}
		BpmInstUser rhs = (BpmInstUser) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.instId, rhs.instId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.userIds, rhs.userIds) 
		.append(this.userNames, rhs.userNames) 
		.append(this.actDefId, rhs.actDefId) 
		.append(this.isSub, rhs.isSub) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.instId) 
		.append(this.nodeId) 
		.append(this.userIds) 
		.append(this.userNames) 
		.append(this.actDefId) 
		.append(this.isSub) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("instId", this.instId) 
				.append("nodeId", this.nodeId) 
				.append("userIds", this.userIds) 
				.append("userNames", this.userNames) 
				.append("actDefId", this.actDefId) 
				.append("isSub", this.isSub) 
												.toString();
	}

}



