



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：排班列表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_schedule_shift")
@TableDefine(title = "排班列表")
public class AtsScheduleShift extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "考勤用户ID")
	@Column(name = "FILE_ID")
	protected String fileId; 
	@FieldDefine(title = "考勤日期")
	@Column(name = "ATTENCE_TIME")
	protected java.util.Date attenceTime; 
	@FieldDefine(title = "日期类型")
	@Column(name = "DATE_TYPE")
	protected Short dateType; 
	@FieldDefine(title = "班次ID")
	@Column(name = "SHIFT_ID")
	protected String shiftId; 
	@FieldDefine(title = "标题")
	@Column(name = "TITLE")
	protected String title; 
	

	//姓名
	protected String fullName;
	//组织名
	protected String orgName;
	//日期类型
	protected String dateTypeName;
	//班次名称
	protected String shiftName;
	//考勤卡号
	protected String cardNumber;
	//考勤制度
	protected String attencePolicyName;
	//取卡规则
	protected String cardRuleName;
	//班次
	protected AtsShiftInfo atsShiftInfo;
	// 考勤制度ID
	protected String attencePolicy;
	
	public void setAtsShiftInfo(AtsShiftInfo atsShiftInfo) {
		this.atsShiftInfo = atsShiftInfo;
	}
	
	public AtsShiftInfo getAtsShiftInfo() {
		return atsShiftInfo;
	}
	
	public AtsScheduleShift() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsScheduleShift(String in_id) {
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
	 * 返回 考勤用户ID
	 * @return
	 */
	public String getFileId() {
		return this.fileId;
	}
	public void setAttenceTime(java.util.Date attenceTime) {
		this.attenceTime = attenceTime;
	}
	
	/**
	 * 返回 考勤日期
	 * @return
	 */
	public java.util.Date getAttenceTime() {
		return this.attenceTime;
	}
	public void setDateType(Short dateType) {
		this.dateType = dateType;
	}
	
	/**
	 * 返回 日期类型
	 * @return
	 */
	public Short getDateType() {
		return this.dateType;
	}
	public void setShiftId(String shiftId) {
		this.shiftId = shiftId;
	}
	
	/**
	 * 返回 班次ID
	 * @return
	 */
	public String getShiftId() {
		return this.shiftId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * 返回 标题
	 * @return
	 */
	public String getTitle() {
		return this.title;
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

	public String getDateTypeName() {
		return dateTypeName;
	}

	public void setDateTypeName(String dateTypeName) {
		this.dateTypeName = dateTypeName;
	}

	public String getShiftName() {
		return shiftName;
	}

	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getAttencePolicyName() {
		return attencePolicyName;
	}

	public void setAttencePolicyName(String attencePolicyName) {
		this.attencePolicyName = attencePolicyName;
	}

	public String getCardRuleName() {
		return cardRuleName;
	}

	public void setCardRuleName(String cardRuleName) {
		this.cardRuleName = cardRuleName;
	}
	
	public String getAttencePolicy() {
		return attencePolicy;
	}

	public void setAttencePolicy(String attencePolicy) {
		this.attencePolicy = attencePolicy;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsScheduleShift)) {
			return false;
		}
		AtsScheduleShift rhs = (AtsScheduleShift) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.fileId, rhs.fileId) 
		.append(this.attenceTime, rhs.attenceTime) 
		.append(this.dateType, rhs.dateType) 
		.append(this.shiftId, rhs.shiftId) 
		.append(this.title, rhs.title) 
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
		.append(this.attenceTime) 
		.append(this.dateType) 
		.append(this.shiftId) 
		.append(this.title) 
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
				.append("attenceTime", this.attenceTime) 
				.append("dateType", this.dateType) 
				.append("shiftId", this.shiftId) 
				.append("title", this.title) 
												.toString();
	}

}



