package com.redxun.bpm.core.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 * 描述：BpmInstCtl实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_INST_CTL")
@TableDefine(title = "")
public class BpmInstCtl extends BaseTenantEntity {
	
	public final static String CTL_TYPE_FILE="FILE";
	public final static String CTL_TYPE_READ="READ";
	
	public final static String CTL_RIGHT_EDIT="EDIT";
	public final static String CTL_RIGHT_DOWN="DOWN";
	public final static String CTL_RIGHT_PRINT="PRINT";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "CTL_ID")
	protected String ctlId;
	/* type */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "TYPE_")
	@Size(max = 50)
	protected String type;
	/* right */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "RIGHT_")
	@Size(max = 60)
	protected String right;
	/* allowAttend */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "ALLOW_ATTEND_")
	@Size(max = 20)
	protected String allowAttend;
	/* allowStartor */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "ALLOW_STARTOR_")
	@Size(max = 20)
	protected String allowStartor;
	/* groupIds */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "GROUP_IDS_")
	@Size(max = 4000)
	protected String groupIds;
	/* userIds */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "USER_IDS_")
	@Size(max = 4000)
	protected String userIds;
	@FieldDefine(title = "")
	@JoinColumn(name = "INST_ID_")
	protected String instId;

	/**
	 * Default Empty Constructor for class BpmInstCtl
	 */
	public BpmInstCtl() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstCtl
	 */
	public BpmInstCtl(String in_ctlId) {
		this.setCtlId(in_ctlId);
	}

	/**
	 * * @return String
	 */
	public String getCtlId() {
		return this.ctlId;
	}

	/**
	 * 设置 ctlId
	 */
	public void setCtlId(String aValue) {
		this.ctlId = aValue;
	}

	/**
	 * * @return String
	 */
	public String getInstId() {
		return this.instId;
	}

	/**
	 * 设置 instId
	 */
	public void setInstId(String instId) {
		this.instId = instId;
	}

	/**
	 * * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 type
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * * @return String
	 */
	public String getRight() {
		return this.right;
	}

	/**
	 * 设置 right
	 */
	public void setRight(String aValue) {
		this.right = aValue;
	}

	/**
	 * * @return String
	 */
	public String getAllowAttend() {
		return this.allowAttend;
	}

	/**
	 * 设置 allowAttend
	 */
	public void setAllowAttend(String aValue) {
		this.allowAttend = aValue;
	}

	/**
	 * * @return String
	 */
	public String getAllowStartor() {
		return this.allowStartor;
	}

	/**
	 * 设置 allowStartor
	 */
	public void setAllowStartor(String aValue) {
		this.allowStartor = aValue;
	}

	/**
	 * * @return String
	 */
	public String getGroupIds() {
		return this.groupIds;
	}

	/**
	 * 设置 groupIds
	 */
	public void setGroupIds(String aValue) {
		this.groupIds = aValue;
	}

	/**
	 * * @return String
	 */
	public String getUserIds() {
		return this.userIds;
	}

	/**
	 * 设置 userIds
	 */
	public void setUserIds(String aValue) {
		this.userIds = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.ctlId;
	}

	@Override
	public Serializable getPkId() {
		return this.ctlId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.ctlId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstCtl)) {
			return false;
		}
		BpmInstCtl rhs = (BpmInstCtl) object;
		return new EqualsBuilder().append(this.ctlId, rhs.ctlId)
				.append(this.type, rhs.type).append(this.right, rhs.right)
				.append(this.allowAttend, rhs.allowAttend)
				.append(this.allowStartor, rhs.allowStartor)
				.append(this.groupIds, rhs.groupIds)
				.append(this.userIds, rhs.userIds)
				.append(this.updateTime, rhs.updateTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.createTime, rhs.createTime)
				.append(this.createBy, rhs.createBy)
				.append(this.instId, rhs.instId)
				.append(this.tenantId, rhs.tenantId).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.ctlId)
				.append(this.type).append(this.right).append(this.allowAttend)
				.append(this.allowStartor).append(this.groupIds)
				.append(this.userIds).append(this.updateTime)
				.append(this.updateBy).append(this.createTime)
				.append(this.createBy).append(this.tenantId).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("ctlId", this.ctlId)
				.append("type", this.type).append("right", this.right)
				.append("allowAttend", this.allowAttend)
				.append("allowStartor", this.allowStartor)
				.append("groupIds", this.groupIds)
				.append("userIds", this.userIds)
				.append("updateTime", this.updateTime)
				.append("updateBy", this.updateBy)
				.append("createTime", this.createTime)
				.append("createBy", this.createBy)
				.append("instId", this.instId)
				.append("tenantId", this.tenantId).toString();
	}

}
