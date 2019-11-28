//package com.redxun.bpm.core.entity;
//
//import java.io.Serializable;
//
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.Table;
//import javax.validation.constraints.Size;
//
//import org.apache.commons.lang.builder.EqualsBuilder;
//import org.apache.commons.lang.builder.HashCodeBuilder;
//import org.apache.commons.lang.builder.ToStringBuilder;
//import org.hibernate.validator.constraints.NotEmpty;
//
//import com.redxun.core.annotion.table.FieldDefine;
//import com.redxun.core.annotion.table.TableDefine;
//import com.redxun.core.entity.BaseTenantEntity;
//
///**
// * <pre>
// * 描述：BpmSolRight实体类定义
// * 流程解决方案的权限
// * 构建组：miweb
// * 作者：keith
// * 邮箱: chshxuan@163.com
// * 日期:2014-2-1-上午12:52:41
// * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
// * </pre>
// */
//@Entity
//@Table(name = "BPM_SOL_RIGHT")
//@TableDefine(title = "流程解决方案的权限")
//public class BpmSolRight extends BaseTenantEntity {
//	
//	/**
//	 * USER=用户
//	 */
//	public final static String ID_TYPE_USER="user";
//	/**
//	 * GROUP=用户组
//	 */
//	public final static String ID_TYPE_GROUP="group";
//	
//	@FieldDefine(title = "PKID")
//	@Id
//	@Column(name = "RIGHT_ID_")
//	protected String rightId;
//	/* 授权类型 */
//	@FieldDefine(title = "授权类型")
//	@Column(name = "IDENTITY_TYPE_")
//	@Size(max = 20)
//	@NotEmpty
//	protected String identityType;
//	/* 用户或组ID */
//	@FieldDefine(title = "用户或组ID")
//	@Column(name = "IDENTITY_ID_")
//	@Size(max = 64)
//	@NotEmpty
//	protected String identityId;
//	/* 权限 */
//	@FieldDefine(title = "权限")
//	@Column(name = "RIGHT_")
//	@Size(max = 60)
//	protected String right;
//	@FieldDefine(title = "系统分类树\r\n用于显示树层次结构的分类\r\n可以允许任何层次结构")
//	@ManyToOne
//	@JoinColumn(name = "TREE_ID_")
//	protected com.redxun.sys.core.entity.SysTree sysTree;
//	@FieldDefine(title = "业务流程方案定义")
//	@ManyToOne
//	@JoinColumn(name = "SOL_ID_")
//	protected com.redxun.bpm.core.entity.BpmSolution bpmSolution;
//
//	/**
//	 * Default Empty Constructor for class BpmSolRight
//	 */
//	public BpmSolRight() {
//		super();
//	}
//
//	/**
//	 * Default Key Fields Constructor for class BpmSolRight
//	 */
//	public BpmSolRight(String in_rightId) {
//		this.setRightId(in_rightId);
//	}
//
//	public com.redxun.sys.core.entity.SysTree getSysTree() {
//		return sysTree;
//	}
//
//	public void setSysTree(com.redxun.sys.core.entity.SysTree in_sysTree) {
//		this.sysTree = in_sysTree;
//	}
//
//	public BpmSolution getBpmSolution() {
//		return bpmSolution;
//	}
//
//	public void setBpmSolution(BpmSolution in_bpmSolution) {
//		this.bpmSolution = in_bpmSolution;
//	}
//
//	/**
//	 * * @return String
//	 */
//	public String getRightId() {
//		return this.rightId;
//	}
//
//	/**
//	 * 设置
//	 */
//	public void setRightId(String aValue) {
//		this.rightId = aValue;
//	}
//
//	/**
//	 * 解决方案ID * @return String
//	 */
//	public String getSolId() {
//		return this.getBpmSolution() == null ? null : this.getBpmSolution().getSolId();
//	}
//
//	/**
//	 * 设置 解决方案ID
//	 */
//	public void setSolId(String aValue) {
//		if (aValue == null) {
//			bpmSolution = null;
//		} else if (bpmSolution == null) {
//			bpmSolution = new BpmSolution(aValue);
//		} else {
//			bpmSolution.setSolId(aValue);
//		}
//	}
//
//	/**
//	 * 分类树ID * @return String
//	 */
//	public String getTreeId() {
//		return this.getSysTree() == null ? null : this.getSysTree().getTreeId();
//	}
//
//	/**
//	 * 设置 分类树ID
//	 */
//	public void setTreeId(String aValue) {
//		if (aValue == null) {
//			sysTree = null;
//		} else if (sysTree == null) {
//			sysTree = new com.redxun.sys.core.entity.SysTree(aValue);
//		} else {
//			sysTree.setTreeId(aValue);
//		}
//	}
//
//	/**
//	 * 授权类型 * @return String
//	 */
//	public String getIdentityType() {
//		return this.identityType;
//	}
//
//	/**
//	 * 设置 授权类型
//	 */
//	public void setIdentityType(String aValue) {
//		this.identityType = aValue;
//	}
//
//	/**
//	 * 用户或组ID * @return String
//	 */
//	public String getIdentityId() {
//		return this.identityId;
//	}
//
//	/**
//	 * 设置 用户或组ID
//	 */
//	public void setIdentityId(String aValue) {
//		this.identityId = aValue;
//	}
//
//	/**
//	 * 权限 * @return String
//	 */
//	public String getRight() {
//		return this.right;
//	}
//
//	/**
//	 * 设置 权限
//	 */
//	public void setRight(String aValue) {
//		this.right = aValue;
//	}
//
//	@Override
//	public String getIdentifyLabel() {
//		return this.rightId;
//	}
//
//	@Override
//	public Serializable getPkId() {
//		return this.rightId;
//	}
//
//	@Override
//	public void setPkId(Serializable pkId) {
//		this.rightId = (String) pkId;
//	}
//
//	/**
//	 * @see java.lang.Object#equals(Object)
//	 */
//	public boolean equals(Object object) {
//		if (!(object instanceof BpmSolRight)) {
//			return false;
//		}
//		BpmSolRight rhs = (BpmSolRight) object;
//		return new EqualsBuilder().append(this.rightId, rhs.rightId).append(this.identityType, rhs.identityType).append(this.identityId, rhs.identityId)
//				.append(this.right, rhs.right).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime)
//				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
//	}
//
//	/**
//	 * @see java.lang.Object#hashCode()
//	 */
//	public int hashCode() {
//		return new HashCodeBuilder(-82280557, -700257973).append(this.rightId).append(this.identityType).append(this.identityId).append(this.right).append(this.tenantId)
//				.append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
//	}
//
//	/**
//	 * @see java.lang.Object#toString()
//	 */
//	public String toString() {
//		return new ToStringBuilder(this).append("rightId", this.rightId).append("identityType", this.identityType).append("identityId", this.identityId)
//				.append("right", this.right).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime)
//				.append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
//	}
//
//}
