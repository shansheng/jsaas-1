



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
 * 描述：巡店微信用户实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-10-18 10:04:32
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "巡店微信用户")
public class PatrolWechatUserinfo extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "OPENID")
	@Column(name = "F_OPENID")
	protected String openid; 
	@FieldDefine(title = "微信昵称")
	@Column(name = "F_NICKNAME")
	protected String nickname; 
	@FieldDefine(title = "真实姓名")
	@Column(name = "F_FULLNAME")
	protected String fullname; 
	@FieldDefine(title = "性别ID")
	@Column(name = "F_GENDER")
	protected String gender; 
	@FieldDefine(title = "性别")
	@Column(name = "F_GENDER_name")
	protected String genderName; 
	@FieldDefine(title = "手机号")
	@Column(name = "F_PHONE")
	protected String phone; 
	@FieldDefine(title = "地址")
	@Column(name = "F_ADDRESS")
	protected String address; 
	@FieldDefine(title = "头像")
	@Column(name = "F_AVATARURL")
	protected String avatarurl; 
	@FieldDefine(title = "UNIONID")
	@Column(name = "F_UNIONID")
	protected String unionid; 
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
	
	
	
	
	
	public PatrolWechatUserinfo() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolWechatUserinfo(String in_id) {
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
	 * 返回 OPENID
	 * @return
	 */
	public String getOpenid() {
		return this.openid;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	/**
	 * 返回 微信昵称
	 * @return
	 */
	public String getNickname() {
		return this.nickname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	/**
	 * 返回 真实姓名
	 * @return
	 */
	public String getFullname() {
		return this.fullname;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	/**
	 * 返回 性别ID
	 * @return
	 */
	public String getGender() {
		return this.gender;
	}
	public void setGenderName(String genderName) {
		this.genderName = genderName;
	}
	
	/**
	 * 返回 性别
	 * @return
	 */
	public String getGenderName() {
		return this.genderName;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	/**
	 * 返回 手机号
	 * @return
	 */
	public String getPhone() {
		return this.phone;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * 返回 地址
	 * @return
	 */
	public String getAddress() {
		return this.address;
	}
	public void setAvatarurl(String avatarurl) {
		this.avatarurl = avatarurl;
	}
	
	/**
	 * 返回 头像
	 * @return
	 */
	public String getAvatarurl() {
		return this.avatarurl;
	}
	public void setUnionid(String unionid) {
		this.unionid = unionid;
	}
	
	/**
	 * 返回 UNIONID
	 * @return
	 */
	public String getUnionid() {
		return this.unionid;
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
		if (!(object instanceof PatrolWechatUserinfo)) {
			return false;
		}
		PatrolWechatUserinfo rhs = (PatrolWechatUserinfo) object;
		return new EqualsBuilder()
		.append(this.openid, rhs.openid) 
		.append(this.nickname, rhs.nickname) 
		.append(this.fullname, rhs.fullname) 
		.append(this.gender, rhs.gender) 
		.append(this.genderName, rhs.genderName) 
		.append(this.phone, rhs.phone) 
		.append(this.address, rhs.address) 
		.append(this.avatarurl, rhs.avatarurl) 
		.append(this.unionid, rhs.unionid) 
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
		.append(this.nickname) 
		.append(this.fullname) 
		.append(this.gender) 
		.append(this.genderName) 
		.append(this.phone) 
		.append(this.address) 
		.append(this.avatarurl) 
		.append(this.unionid) 
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
				.append("nickname", this.nickname) 
				.append("fullname", this.fullname) 
				.append("gender", this.gender) 
				.append("genderName", this.genderName) 
				.append("phone", this.phone) 
				.append("address", this.address) 
				.append("avatarurl", this.avatarurl) 
				.append("unionid", this.unionid) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



