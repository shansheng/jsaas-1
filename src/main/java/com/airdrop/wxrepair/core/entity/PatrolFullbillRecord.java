



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
 * 描述：巡检单填写记录实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-10-21 11:32:36
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "巡检单填写记录")
public class PatrolFullbillRecord extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "填单人ID")
	@Column(name = "F_STAFF")
	protected String staff; 
	@FieldDefine(title = "填单人")
	@Column(name = "F_STAFF_name")
	protected String staffName; 
	@FieldDefine(title = "巡检单ID")
	@Column(name = "F_QUESTIONNAIRE")
	protected String questionnaire; 
	@FieldDefine(title = "巡检单")
	@Column(name = "F_QUESTIONNAIRE_name")
	protected String questionnaireName; 
	@FieldDefine(title = "填单时间")
	@Column(name = "F_FULLDATE")
	protected java.util.Date fulldate; 
	@FieldDefine(title = "状态ID")
	@Column(name = "F_STATUS")
	protected String status; 
	@FieldDefine(title = "状态")
	@Column(name = "F_STATUS_name")
	protected String statusName; 
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
	@FieldDefine(title = "门店ID")
	@Column(name = "F_SHOP")
	protected String shop; 
	@FieldDefine(title = "门店")
	@Column(name = "F_SHOP_name")
	protected String shopName; 
	
	
	
	
	
	public PatrolFullbillRecord() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolFullbillRecord(String in_id) {
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
	
	public void setStaff(String staff) {
		this.staff = staff;
	}
	
	/**
	 * 返回 填单人ID
	 * @return
	 */
	public String getStaff() {
		return this.staff;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	
	/**
	 * 返回 填单人
	 * @return
	 */
	public String getStaffName() {
		return this.staffName;
	}
	public void setQuestionnaire(String questionnaire) {
		this.questionnaire = questionnaire;
	}
	
	/**
	 * 返回 巡检单ID
	 * @return
	 */
	public String getQuestionnaire() {
		return this.questionnaire;
	}
	public void setQuestionnaireName(String questionnaireName) {
		this.questionnaireName = questionnaireName;
	}
	
	/**
	 * 返回 巡检单
	 * @return
	 */
	public String getQuestionnaireName() {
		return this.questionnaireName;
	}
	public void setFulldate(java.util.Date fulldate) {
		this.fulldate = fulldate;
	}
	
	/**
	 * 返回 填单时间
	 * @return
	 */
	public java.util.Date getFulldate() {
		return this.fulldate;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态ID
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getStatusName() {
		return this.statusName;
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
	public void setShop(String shop) {
		this.shop = shop;
	}
	
	/**
	 * 返回 门店ID
	 * @return
	 */
	public String getShop() {
		return this.shop;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	
	/**
	 * 返回 门店
	 * @return
	 */
	public String getShopName() {
		return this.shopName;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof PatrolFullbillRecord)) {
			return false;
		}
		PatrolFullbillRecord rhs = (PatrolFullbillRecord) object;
		return new EqualsBuilder()
		.append(this.staff, rhs.staff) 
		.append(this.staffName, rhs.staffName) 
		.append(this.questionnaire, rhs.questionnaire) 
		.append(this.questionnaireName, rhs.questionnaireName) 
		.append(this.fulldate, rhs.fulldate) 
		.append(this.status, rhs.status) 
		.append(this.statusName, rhs.statusName) 
		.append(this.id, rhs.id) 
		.append(this.refId, rhs.refId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.append(this.groupId, rhs.groupId) 
		.append(this.shop, rhs.shop) 
		.append(this.shopName, rhs.shopName) 
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.staff) 
		.append(this.staffName) 
		.append(this.questionnaire) 
		.append(this.questionnaireName) 
		.append(this.fulldate) 
		.append(this.status) 
		.append(this.statusName) 
		.append(this.id) 
		.append(this.refId) 
		.append(this.parentId) 
		.append(this.instId) 
		.append(this.instStatus) 
		.append(this.groupId) 
		.append(this.shop) 
		.append(this.shopName) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("staff", this.staff) 
				.append("staffName", this.staffName) 
				.append("questionnaire", this.questionnaire) 
				.append("questionnaireName", this.questionnaireName) 
				.append("fulldate", this.fulldate) 
				.append("status", this.status) 
				.append("statusName", this.statusName) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
				.append("shop", this.shop) 
				.append("shopName", this.shopName) 
		.toString();
	}

}



