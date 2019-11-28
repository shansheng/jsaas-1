



package com.airdrop.wxrepair.core.entity;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * <pre>
 *  
 * 描述：微信用户与帐号关系表实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-10-18 11:39:41
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "微信用户与帐号关系表")
public class PatrolWechatuserAccounts extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "用户OPENID")
	@Column(name = "F_OPENID")
	protected String openid; 
	@FieldDefine(title = "账户ID")
	@Column(name = "F_ACCOUNT")
	protected String account; 
	@FieldDefine(title = "账户")
	@Column(name = "F_ACCOUNT_name")
	protected String accountName; 
	@FieldDefine(title = "外键")
	@Column(name = "REF_ID_")
	protected String refId; 
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	protected String parentId; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "状态")
	@Column(name = "INST_STATUS_")
	protected String instStatus; 
	@FieldDefine(title = "组ID")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	
	
	
	
	
	public PatrolWechatuserAccounts() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolWechatuserAccounts(String in_id) {
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
	
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	/**
	 * 返回 用户OPENID
	 * @return
	 */
	public String getOpenid() {
		return this.openid;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	
	/**
	 * 返回 账户ID
	 * @return
	 */
	public String getAccount() {
		return this.account;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	
	/**
	 * 返回 账户
	 * @return
	 */
	public String getAccountName() {
		return this.accountName;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	
	/**
	 * 返回 外键
	 * @return
	 */
	public String getRefId() {
		return this.refId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	/**
	 * 返回 父ID
	 * @return
	 */
	public String getParentId() {
		return this.parentId;
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
	public void setInstStatus(String instStatus) {
		this.instStatus = instStatus;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getInstStatus() {
		return this.instStatus;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 组ID
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof PatrolWechatuserAccounts)) {
			return false;
		}
		PatrolWechatuserAccounts rhs = (PatrolWechatuserAccounts) object;
		return new EqualsBuilder()
		.append(this.openid, rhs.openid) 
		.append(this.account, rhs.account) 
		.append(this.accountName, rhs.accountName) 
		.append(this.id, rhs.id) 
		.append(this.refId, rhs.refId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.append(this.groupId, rhs.groupId) 
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.openid) 
		.append(this.account) 
		.append(this.accountName) 
		.append(this.id) 
		.append(this.refId) 
		.append(this.parentId) 
		.append(this.instId) 
		.append(this.instStatus) 
		.append(this.groupId) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("openid", this.openid) 
				.append("account", this.account) 
				.append("accountName", this.accountName) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



