package com.redxun.restApi.orguser.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 用户对象。
 * @author ray
 *
 */
public class User {
	
	/**
	 * 用户ID
	 */
	protected String userId="";
	
	/**
	 * 帐号
	 */
	protected String account="";
	
	/**
	 * 密码
	 */
	protected String password="";
	
	/**
	 * 姓名
	 */
	protected String fullname="";
	
	/**
	 * 用户编号
	 */
	protected String userNo="";
	
	/**
	 * 性别
	 */
	protected String sex="";
	
	/**
	 * 手机
	 */
	protected String mobile="";
	
	/**
	 * 邮件
	 */
	protected String email="";
	
	/**
	 * qq
	 */
	protected String qq="";
	/**
	 * 地址
	 */
	protected String address="";
	
	/**
	 * 租户
	 */
	protected String tenantId="";
	
	/**
	 * 入职时间
	 */
	protected Date entryTime;
	
	/**
	 * 离职时间 
	 */
	protected Date quitTime;
	
	/**
	 *  生日 
	 */
	protected java.util.Date birthday;
	/**
	 *  状态 
	 */
	protected String status;
	/**
	 *  来源 
	 */
	protected String from;

	/**
	 *  紧急联系人 
	 */
	protected String urgent;
	/**
	*  紧急联系人手机
	*/
	protected String urgentMobile;
	
	/**
	 * 照片
	 */
	protected String photo;
	
	/**
	 * 同步微信
	 */
	protected Integer syncWx=0;
	

	
	
	private Group mainGroup;
	
	
	List<Group> groups=new ArrayList<Group>();


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	


	public String getAccount() {
		return account;
	}


	public void setAccount(String account) {
		this.account = account;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}


	public String getUserNo() {
		return userNo;
	}


	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getQq() {
		return qq;
	}


	public void setQq(String qq) {
		this.qq = qq;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public List<Group> getGroups() {
		return groups;
	}


	public void setGroups(List<Group> groups) {
		this.groups = groups;
	}
	
	
	public void addGroup(Group group){
		this.groups.add(group);
	}


	public String getTenantId() {
		return tenantId;
	}


	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}


	public Group getMainGroup() {
		return mainGroup;
	}


	public void setMainGroup(Group mainGroup) {
		this.mainGroup = mainGroup;
	}


	public Date getEntryTime() {
		return entryTime;
	}


	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}


	public Date getQuitTime() {
		return quitTime;
	}


	public void setQuitTime(Date quitTime) {
		this.quitTime = quitTime;
	}


	public java.util.Date getBirthday() {
		return birthday;
	}


	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getFrom() {
		return from;
	}


	public void setFrom(String from) {
		this.from = from;
	}


	public String getUrgent() {
		return urgent;
	}


	public void setUrgent(String urgent) {
		this.urgent = urgent;
	}


	public String getUrgentMobile() {
		return urgentMobile;
	}


	public void setUrgentMobile(String urgentMobile) {
		this.urgentMobile = urgentMobile;
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public Integer getSyncWx() {
		return syncWx;
	}


	public void setSyncWx(Integer syncWx) {
		this.syncWx = syncWx;
	}


	public String getFullname() {
		return fullname;
	}


	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	

}
