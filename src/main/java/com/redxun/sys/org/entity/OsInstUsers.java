package com.redxun.sys.org.entity;

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
 * 描述：os_inst_users实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-01-18 16:05:11
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "os_inst_users")
public class OsInstUsers extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID_")
	protected String userId; 
	@FieldDefine(title = "状态：APPLY=申请")
	@Column(name = "STATUS_")
	protected String status; 
	@FieldDefine(title = "域名")
	@Column(name = "DOMAIN_")
	protected String domain; 
	@FieldDefine(title = "审批人")
	@Column(name = "APPROVER_USER_")
	protected String approveUser; 
	@FieldDefine(title = "是否管理员")
	@Column(name = "IS_ADMIN_")
	protected Integer isAdmin;
	@FieldDefine(title = "创建类型   CREATE=创建（不可以删除） APPLY=申请加入（可以删除")
	@Column(name = "CREATE_TYPE_")
	protected String createType;
	@FieldDefine(title = "申请加入机构状态：APPLY:申请,DISABLED:禁止,DISCARD:丢弃,ENABLED,正常")
	@Column(name = "APPLY_STATUS_")
	protected String applyStatus;


	@FieldDefine(title = "申请人姓名")
	@Column(name = "US_FULL_NAME_")
	protected String usFullName;
	@FieldDefine(title = "审批结果：1：同意 0：拒绝")
	@Column(name = "US_FULL_NAME_")
	protected String isAgree;
	@FieldDefine(title = "备注")
	@Column(name = "NOTE_")
	protected String note;

	public String getIsAgree() {
		return isAgree;
	}

	public void setIsAgree(String isAgree) {
		this.isAgree = isAgree;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getUsFullName() {
		return usFullName;
	}

	public void setUsFullName(String usFullName) {
		this.usFullName = usFullName;
	}

	public OsInstUsers() {
	}

	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}

	public String getApplyStatus() {
		return applyStatus;
	}

	public void setApplyStatus(String applyStatus) {
		this.applyStatus = applyStatus;
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public OsInstUsers(String in_id) {
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
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 用户ID
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态：APPLY=申请

	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	
	/**
	 * 返回 域名
	 * @return
	 */
	public String getDomain() {
		return this.domain;
	}

	public String getApproveUser() {
		return approveUser;
	}

	public void setApproveUser(String approveUser) {
		this.approveUser = approveUser;
	}

	public Integer getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Integer isAdmin) {
		this.isAdmin = isAdmin;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof OsInstUsers)) {
			return false;
		}
		OsInstUsers rhs = (OsInstUsers) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.userId, rhs.userId) 
		.append(this.status, rhs.status) 
		.append(this.domain, rhs.domain) 
		.append(this.approveUser, rhs.approveUser) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.userId) 
		.append(this.status) 
		.append(this.domain) 
		.append(this.approveUser) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("userId", this.userId) 
						.append("status", this.status) 
				.append("domain", this.domain) 
				.append("approveUser", this.approveUser) 
		.toString();
	}

}



