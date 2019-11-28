



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：考勤组明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-27 11:27:43
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_attence_group_detail")
@TableDefine(title = "考勤组明细")
public class AtsAttenceGroupDetail extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "考勤档案")
	@Column(name = "FILE_ID")
	protected String fileId; 
	
	
	@FieldDefine(title = "考勤组")
	@ManyToOne
	@JoinColumn(name = "group_id")
	protected  com.redxun.oa.ats.entity.AtsAttenceGroup atsAttenceGroup;	
	
	//员工id
	protected String userId;
	//员工编号
	protected String userNo;
	//员工姓名
	protected String fullName;
	//所属组织
	protected String orgName;
	
	
	
	public AtsAttenceGroupDetail() {
	}
	

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttenceGroupDetail(String in_id) {
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
	
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	/**
	 * 返回 考勤档案
	 * @return
	 */
	public String getFileId() {
		return this.fileId;
	}
	
	
	
	public com.redxun.oa.ats.entity.AtsAttenceGroup getAtsAttenceGroup() {
		return atsAttenceGroup;
	}

	public void setAtsAttenceGroup(com.redxun.oa.ats.entity.AtsAttenceGroup in_atsAttenceGroup) {
		this.atsAttenceGroup = in_atsAttenceGroup;
	}
	
	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	

	/**
	 * 外键 
	 * @return String
	 */
	public String getGroupId() {
		return this.getAtsAttenceGroup() == null ? null : this.getAtsAttenceGroup().getId();
	}

	/**
	 * 设置 外键
	 */
	public void setGroupId(String aValue) {
		if (aValue == null) {
			atsAttenceGroup = null;
		} else if (atsAttenceGroup == null) {
			atsAttenceGroup = new com.redxun.oa.ats.entity.AtsAttenceGroup(aValue);
		} else {
			atsAttenceGroup.setId(aValue);
		}
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttenceGroupDetail)) {
			return false;
		}
		AtsAttenceGroupDetail rhs = (AtsAttenceGroupDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.fileId, rhs.fileId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.fileId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
						.append("fileId", this.fileId) 
												.toString();
	}

}



