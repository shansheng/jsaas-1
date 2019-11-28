



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
 * 描述：微信接口调用凭证实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-10-21 15:00:28
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "微信接口调用凭证")
public class PatrolWechatAccesstoken extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "TOKEN")
	@Column(name = "F_TOKEN")
	protected String token; 
	@FieldDefine(title = "小程序ID")
	@Column(name = "F_APPID")
	protected String appid; 
	@FieldDefine(title = "小程序秘钥")
	@Column(name = "F_APPSECRET")
	protected String appsecret; 
	@FieldDefine(title = "有效时长")
	@Column(name = "F_EXPIRES_IN")
	protected Long expiresIn; 
	@FieldDefine(title = "创建时间")
	@Column(name = "F_CREATETIME")
	protected java.util.Date createtime; 
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
	
	
	
	
	
	public PatrolWechatAccesstoken() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolWechatAccesstoken(String in_id) {
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
	
	public void setToken(String token) {
		this.token = token;
	}
	
	/**
	 * 返回 TOKEN
	 * @return
	 */
	public String getToken() {
		return this.token;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	
	/**
	 * 返回 小程序ID
	 * @return
	 */
	public String getAppid() {
		return this.appid;
	}
	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}
	
	/**
	 * 返回 小程序秘钥
	 * @return
	 */
	public String getAppsecret() {
		return this.appsecret;
	}
	public void setExpiresIn(Long expiresIn) {
		this.expiresIn = expiresIn;
	}
	
	/**
	 * 返回 有效时长
	 * @return
	 */
	public Long getExpiresIn() {
		return this.expiresIn;
	}
	public void setCreatetime(java.util.Date createtime) {
		this.createtime = createtime;
	}
	
	/**
	 * 返回 创建时间
	 * @return
	 */
	public java.util.Date getCreatetime() {
		return this.createtime;
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
		if (!(object instanceof PatrolWechatAccesstoken)) {
			return false;
		}
		PatrolWechatAccesstoken rhs = (PatrolWechatAccesstoken) object;
		return new EqualsBuilder()
		.append(this.token, rhs.token) 
		.append(this.appid, rhs.appid) 
		.append(this.appsecret, rhs.appsecret) 
		.append(this.expiresIn, rhs.expiresIn) 
		.append(this.createtime, rhs.createtime) 
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
		.append(this.token) 
		.append(this.appid) 
		.append(this.appsecret) 
		.append(this.expiresIn) 
		.append(this.createtime) 
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
		.append("token", this.token) 
				.append("appid", this.appid) 
				.append("appsecret", this.appsecret) 
				.append("expiresIn", this.expiresIn) 
				.append("createtime", this.createtime) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



