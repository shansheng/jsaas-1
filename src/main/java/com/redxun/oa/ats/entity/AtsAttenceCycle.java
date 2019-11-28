



package com.redxun.oa.ats.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：考勤周期实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-23 14:36:39
 * 版权：广州红迅软件
 * </pre>
 */
public class AtsAttenceCycle extends BaseTenantEntity {

	protected String id;

	protected String code; 
	protected String name; 
	protected String type; 
	protected Integer year; 
	protected Integer month; 
	protected Short startMonth; 
	protected Integer startDay; 
	protected Short endMonth; 
	protected Integer endDay; 
	protected Short isDefault; 
	protected String memo; 
	
	protected List<AtsAttenceCycleDetail> atsAttenceCycleDetails = new ArrayList<AtsAttenceCycleDetail>();
	
	//开始周期
	protected String startYear = "";
	
	public void setStartYear(String startYear) {
		this.startYear += startYear;
	}
	public String getStartYear() {
		return startYear;
	}
	
	public AtsAttenceCycle() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttenceCycle(String in_id) {
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
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 周期类型
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setYear(Integer year) {
		this.year = year;
		this.setStartYear(year + "年");
	}
	
	/**
	 * 返回 年
	 * @return
	 */
	public Integer getYear() {
		return this.year;
	}
	public void setMonth(Integer month) {
		this.month = month;
		this.setStartYear(month + "月");
	}
	
	/**
	 * 返回 月
	 * @return
	 */
	public Integer getMonth() {
		return this.month;
	}
	public void setStartMonth(Short startMonth) {
		this.startMonth = startMonth;
	}
	
	/**
	 * 返回 周期区间-开始月
	 * @return
	 */
	public Short getStartMonth() {
		return this.startMonth;
	}
	public void setStartDay(Integer startDay) {
		this.startDay = startDay;
	}
	
	/**
	 * 返回 周期区间-开始日
	 * @return
	 */
	public Integer getStartDay() {
		return this.startDay;
	}
	public void setEndMonth(Short endMonth) {
		this.endMonth = endMonth;
	}
	
	/**
	 * 返回 周期区间-结束月
	 * @return
	 */
	public Short getEndMonth() {
		return this.endMonth;
	}
	public void setEndDay(Integer endDay) {
		this.endDay = endDay;
	}
	
	/**
	 * 返回 周期区间-结束日
	 * @return
	 */
	public Integer getEndDay() {
		return this.endDay;
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
	
	public List<AtsAttenceCycleDetail> getAtsAttenceCycleDetails() {
		return atsAttenceCycleDetails;
	}

	public void setAtsAttenceCycleDetails(List<AtsAttenceCycleDetail> in_atsAttenceCycleDetail) {
		this.atsAttenceCycleDetails = in_atsAttenceCycleDetail;
	}
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttenceCycle)) {
			return false;
		}
		AtsAttenceCycle rhs = (AtsAttenceCycle) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.type, rhs.type) 
		.append(this.year, rhs.year) 
		.append(this.month, rhs.month) 
		.append(this.startMonth, rhs.startMonth) 
		.append(this.startDay, rhs.startDay) 
		.append(this.endMonth, rhs.endMonth) 
		.append(this.endDay, rhs.endDay) 
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
		.append(this.type) 
		.append(this.year) 
		.append(this.month) 
		.append(this.startMonth) 
		.append(this.startDay) 
		.append(this.endMonth) 
		.append(this.endDay) 
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
				.append("type", this.type) 
				.append("year", this.year) 
				.append("month", this.month) 
				.append("startMonth", this.startMonth) 
				.append("startDay", this.startDay) 
				.append("endMonth", this.endMonth) 
				.append("endDay", this.endDay) 
				.append("isDefault", this.isDefault) 
				.append("memo", this.memo) 
												.toString();
	}

}



