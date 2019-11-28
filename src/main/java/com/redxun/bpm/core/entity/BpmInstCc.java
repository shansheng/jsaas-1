package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
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
 * 描述：BpmInstCc实体类定义
 * 流程抄送
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_INST_CC")
@TableDefine(title = "流程抄送")
public class BpmInstCc extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "CC_ID_")
	protected String ccId;
	/* 抄送标题 */
	@FieldDefine(title = "抄送标题")
	@Column(name = "SUBJECT_")
	@Size(max = 255)
	@NotEmpty
	protected String subject;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 255)
	protected String nodeName;
	/* 抄送人ID */
	@FieldDefine(title = "抄送人ID")
	@Column(name = "FROM_USER_ID_")
	@Size(max = 255)
	protected String fromUserId;
	
	@FieldDefine(title = "抄送人")
	@Column(name = "FROM_USER_")
	@Size(max = 255)
	protected String fromUser;
	
	
	@FieldDefine(title = "方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 255)
	protected String solId;
	
	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	@Size(max = 255)
	protected String treeId;
	
	@FieldDefine(title = "流程实例")
    //@ManyToOne
    @JoinColumn(name = "INST_ID_")
    protected String instId;
	
	

	@FieldDefine(title = "流程抄送人员")
	protected java.util.Set<BpmInstCp> bpmInstCps = new java.util.HashSet<BpmInstCp>();
	
	@Transient
	protected String isRead="NO";
	
	@Transient
	protected String cpId="";

	/**
	 * Default Empty Constructor for class BpmInstCc
	 */
	public BpmInstCc() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstCc
	 */
	public BpmInstCc(String in_ccId) {
		this.setCcId(in_ccId);
	}

	public String getInstId() {
		return this.instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
	}

	public java.util.Set<BpmInstCp> getBpmInstCps() {
		return bpmInstCps;
	}

	public void setBpmInstCps(java.util.Set<BpmInstCp> in_bpmInstCps) {
		this.bpmInstCps = in_bpmInstCps;
	}

	/**
	 * * @return String
	 */
	public String getCcId() {
		return this.ccId;
	}

	/**
	 * 设置
	 */
	public void setCcId(String aValue) {
		this.ccId = aValue;
	}

	/**
	 * 抄送标题 * @return String
	 */
	public String getSubject() {
		return this.subject;
	}

	/**
	 * 设置 抄送标题
	 */
	public void setSubject(String aValue) {
		this.subject = aValue;
	}

	/**
	 * 节点ID * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点ID
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 节点名称 * @return String
	 */
	public String getNodeName() {
		return this.nodeName;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeName(String aValue) {
		this.nodeName = aValue;
	}

	/**
	 * 抄送人ID * @return String
	 */
	public String getFromUserId() {
		return this.fromUserId;
	}

	/**
	 * 设置 抄送人ID
	 */
	public void setFromUserId(String aValue) {
		this.fromUserId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.ccId;
	}

	@Override
	public Serializable getPkId() {
		return this.ccId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.ccId = (String) pkId;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}

	public String getCpId() {
		return cpId;
	}

	public void setCpId(String cpId) {
		this.cpId = cpId;
	}
	
	
	/**
	 * 解决方案ID * @return String
	 */
	public String getSolId() {
		return solId;
	}

	/**
	 * 设置 解决方案ID
	 */
	public void setSolId(String solId) {
		this.solId = solId;
	}

	/**
	 * 分类ID * @return String
	 */
	public String getTreeId() {
		return treeId;
	}
	
	/**
	 * 设置 分类ID
	 */
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstCc)) {
			return false;
		}
		BpmInstCc rhs = (BpmInstCc) object;
		return new EqualsBuilder().append(this.ccId, rhs.ccId)
				.append(this.subject, rhs.subject)
				.append(this.nodeId, rhs.nodeId)
				.append(this.nodeName, rhs.nodeName)
				.append(this.fromUserId, rhs.fromUserId)
				.append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.solId, rhs.solId)
				.append(this.treeId, rhs.treeId)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.ccId)
				.append(this.subject).append(this.nodeId).append(this.nodeName)
				.append(this.fromUserId).append(this.tenantId).append(this.solId).append(this.treeId)
				.append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("ccId", this.ccId)
				.append("subject", this.subject).append("nodeId", this.nodeId)
				.append("nodeName", this.nodeName)
				.append("fromUserId", this.fromUserId)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("solId",this.solId)
				.append("treeId",this.treeId)
				.append("updateTime", this.updateTime).toString();
	}

}
