



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
 * 描述：轮班规则明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-26 16:50:46
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_shift_rule_detail")
@TableDefine(title = "轮班规则明细")
public class AtsShiftRuleDetail extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "日期类型")
	@Column(name = "DATE_TYPE")
	protected Short dateType; 
	@FieldDefine(title = "班次ID")
	@Column(name = "SHIFT_ID")
	protected String shiftId; 
	@FieldDefine(title = "上下班时间")
	@Column(name = "SHIFT_TIME")
	protected String shiftTime; 
	@FieldDefine(title = "排序")
	@Column(name = "SN")
	protected Integer sn; 
	
	
	@FieldDefine(title = "轮班规则")
	@ManyToOne
	@JoinColumn(name = "rule_id")
	protected  com.redxun.oa.ats.entity.AtsShiftRule atsShiftRule;	
	
	//班次名称
	protected String shiftName;
	
	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}
	
	public String getShiftName() {
		return shiftName;
	}
	
	public AtsShiftRuleDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsShiftRuleDetail(String in_id) {
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
	public void setShiftTime(String shiftTime) {
		this.shiftTime = shiftTime;
	}
	
	/**
	 * 返回 上下班时间
	 * @return
	 */
	public String getShiftTime() {
		return this.shiftTime;
	}
	public void setSn(Integer sn) {
		this.sn = sn;
	}
	
	/**
	 * 返回 排序
	 * @return
	 */
	public Integer getSn() {
		return this.sn;
	}
	
	
	
	public com.redxun.oa.ats.entity.AtsShiftRule getAtsShiftRule() {
		return atsShiftRule;
	}

	public void setAtsShiftRule(com.redxun.oa.ats.entity.AtsShiftRule in_atsShiftRule) {
		this.atsShiftRule = in_atsShiftRule;
	}
	
	/**
	 * 外键 
	 * @return String
	 */
	public String getRuleId() {
		return this.getAtsShiftRule() == null ? null : this.getAtsShiftRule().getId();
	}

	/**
	 * 设置 外键
	 */
	public void setRuleId(String aValue) {
		if (aValue == null) {
			atsShiftRule = null;
		} else if (atsShiftRule == null) {
			atsShiftRule = new com.redxun.oa.ats.entity.AtsShiftRule(aValue);
		} else {
			atsShiftRule.setId(aValue);
		}
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsShiftRuleDetail)) {
			return false;
		}
		AtsShiftRuleDetail rhs = (AtsShiftRuleDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.dateType, rhs.dateType) 
		.append(this.shiftId, rhs.shiftId) 
		.append(this.shiftTime, rhs.shiftTime) 
		.append(this.sn, rhs.sn) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.dateType) 
		.append(this.shiftId) 
		.append(this.shiftTime) 
		.append(this.sn) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
						.append("dateType", this.dateType) 
				.append("shiftId", this.shiftId) 
				.append("shiftTime", this.shiftTime) 
				.append("sn", this.sn) 
												.toString();
	}

}



