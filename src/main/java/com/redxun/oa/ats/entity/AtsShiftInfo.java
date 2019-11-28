



package com.redxun.oa.ats.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：班次设置实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-26 13:55:50
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_shift_info")
@TableDefine(title = "班次设置")
public class AtsShiftInfo extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "编码")
	@Column(name = "CODE")
	protected String code; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME")
	protected String name; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS")
	protected Short status; 
	@FieldDefine(title = "班次类型")
	@Column(name = "SHIFT_TYPE")
	protected String shiftType; 
	@FieldDefine(title = "加班补偿方式")
	@Column(name = "OT_COMPENS")
	protected String otCompens; 
	@FieldDefine(title = "所属组织")
	@Column(name = "ORG_ID")
	protected String orgId; 
	@FieldDefine(title = "取卡规则")
	@Column(name = "CARD_RULE")
	protected String cardRule; 
	@FieldDefine(title = "标准工时")
	@Column(name = "STANDARD_HOUR")
	protected Double standardHour; 
	@FieldDefine(title = "是否默认")
	@Column(name = "IS_DEFAULT")
	protected Short isDefault; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	
	@FieldDefine(title = "班次时间设置")
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "atsShiftInfo", fetch = FetchType.LAZY)
	protected List<AtsShiftTime> atsShiftTimes = new ArrayList<AtsShiftTime>();
	
	//组织名
	protected String orgName;
	//班次类型名
	protected String shiftTypeName;
	//取卡规则名
	protected String cardRuleName;
	//取卡规则
	protected AtsCardRule atsCardRule;
	
	public void setAtsCardRule(AtsCardRule atsCardRule) {
		this.atsCardRule = atsCardRule;
	}
	
	public AtsCardRule getAtsCardRule() {
		return atsCardRule;
	}
	
	public AtsShiftInfo() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsShiftInfo(String in_id) {
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
	
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * 返回 编码
	 * @return
	 */
	public String getCode() {
		return this.code;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setStatus(Short status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public Short getStatus() {
		return this.status;
	}
	public void setShiftType(String shiftType) {
		this.shiftType = shiftType;
	}
	
	/**
	 * 返回 班次类型
	 * @return
	 */
	public String getShiftType() {
		return this.shiftType;
	}
	public void setOtCompens(String otCompens) {
		this.otCompens = otCompens;
	}
	
	/**
	 * 返回 加班补偿方式
	 * @return
	 */
	public String getOtCompens() {
		return this.otCompens;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	/**
	 * 返回 所属组织
	 * @return
	 */
	public String getOrgId() {
		return this.orgId;
	}
	public void setCardRule(String cardRule) {
		this.cardRule = cardRule;
	}
	
	/**
	 * 返回 取卡规则
	 * @return
	 */
	public String getCardRule() {
		return this.cardRule;
	}
	public void setStandardHour(Double standardHour) {
		this.standardHour = standardHour;
	}
	
	/**
	 * 返回 标准工时
	 * @return
	 */
	public Double getStandardHour() {
		return this.standardHour;
	}
	public void setIsDefault(Short isDefault) {
		this.isDefault = isDefault;
	}
	
	/**
	 * 返回 是否默认
	 * @return
	 */
	public Short getIsDefault() {
		return this.isDefault;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getMemo() {
		return this.memo;
	}
	
	public List<AtsShiftTime> getAtsShiftTimes() {
		return atsShiftTimes;
	}

	public void setAtsShiftTimes(List<AtsShiftTime> in_atsShiftTime) {
		this.atsShiftTimes = in_atsShiftTime;
	}
	
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getShiftTypeName() {
		return shiftTypeName;
	}

	public void setShiftTypeName(String shiftTypeName) {
		this.shiftTypeName = shiftTypeName;
	}

	public String getCardRuleName() {
		return cardRuleName;
	}

	public void setCardRuleName(String cardRuleName) {
		this.cardRuleName = cardRuleName;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsShiftInfo)) {
			return false;
		}
		AtsShiftInfo rhs = (AtsShiftInfo) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.status, rhs.status) 
		.append(this.shiftType, rhs.shiftType) 
		.append(this.otCompens, rhs.otCompens) 
		.append(this.orgId, rhs.orgId) 
		.append(this.cardRule, rhs.cardRule) 
		.append(this.standardHour, rhs.standardHour) 
		.append(this.isDefault, rhs.isDefault) 
		.append(this.memo, rhs.memo) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.code) 
		.append(this.name) 
		.append(this.status) 
		.append(this.shiftType) 
		.append(this.otCompens) 
		.append(this.orgId) 
		.append(this.cardRule) 
		.append(this.standardHour) 
		.append(this.isDefault) 
		.append(this.memo) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("code", this.code) 
				.append("name", this.name) 
				.append("status", this.status) 
				.append("shiftType", this.shiftType) 
				.append("otCompens", this.otCompens) 
				.append("orgId", this.orgId) 
				.append("cardRule", this.cardRule) 
				.append("standardHour", this.standardHour) 
				.append("isDefault", this.isDefault) 
				.append("memo", this.memo) 
												.toString();
	}

}



