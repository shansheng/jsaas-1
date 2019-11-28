package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmSolCtl实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_SOL_CTL")
@TableDefine(title = "")
public class BpmSolCtl extends BaseTenantEntity {

	public final static String CTL_TYPE_FILE="FILE";
	public final static String CTL_TYPE_READ="READ";
	
	public final static String CTL_RIGHT_EDIT="EDIT";
	public final static String CTL_RIGHT_DOWN="DOWN";
	public final static String CTL_RIGHT_PRINT="PRINT";
	
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "RIGHT_ID_")
	protected String rightId;
	/* userIds */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "USER_IDS_")
	@Size(max = 4000)
	protected String userIds;
	/* groupIds */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "GROUP_IDS_")
	@Size(max = 4000)
	protected String groupIds;
	/* allowStartor */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "ALLOW_STARTOR_")
	@Size(max = 20)
	protected String allowStartor;
	/* allowAttend */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "ALLOW_ATTEND_")
	@Size(max = 20)
	protected String allowAttend;
	/* right */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "RIGHT_")
	@Size(max = 60)
	protected String right;
	/* type */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "TYPE_")
	@Size(max = 50)
	protected String type;
	@FieldDefine(title = "solId")
	@ManyToOne
	@JoinColumn(name = "SOL_ID_")
	protected String solId;

	/**
	 * Default Empty Constructor for class BpmSolCtl
	 */
	public BpmSolCtl() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSolCtl
	 */
	public BpmSolCtl(String in_rightId) {
		this.setRightId(in_rightId);
	}

	

	/**
	 * * @return String
	 */
	public String getRightId() {
		return this.rightId;
	}

	/**
	 * 设置 rightId
	 */
	public void setRightId(String aValue) {
		this.rightId = aValue;
	}

	/**
	 * * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 solId
	 */
	public void setSolId(String aValue) {
		this.solId=aValue;
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
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 type
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.rightId;
	}

	@Override
	public Serializable getPkId() {
		return this.rightId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.rightId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolCtl)) {
			return false;
		}
		BpmSolCtl rhs = (BpmSolCtl) object;
		return new EqualsBuilder().append(this.rightId, rhs.rightId)
				.append(this.userIds, rhs.userIds)
				.append(this.groupIds, rhs.groupIds)
				.append(this.allowStartor, rhs.allowStartor)
				.append(this.allowAttend, rhs.allowAttend)
				.append(this.right, rhs.right).append(this.type, rhs.type)
				.append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.rightId)
				.append(this.userIds).append(this.groupIds)
				.append(this.allowStartor).append(this.allowAttend)
				.append(this.right).append(this.type).append(this.tenantId)
				.append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("rightId", this.rightId)
				.append("userIds", this.userIds)
				.append("groupIds", this.groupIds)
				.append("allowStartor", this.allowStartor)
				.append("allowAttend", this.allowAttend)
				.append("right", this.right).append("type", this.type)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
