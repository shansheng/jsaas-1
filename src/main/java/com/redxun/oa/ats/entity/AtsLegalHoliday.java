



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
 * 描述：法定节假日实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-22 16:48:35
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_legal_holiday")
@TableDefine(title = "法定节假日")
public class AtsLegalHoliday extends BaseTenantEntity {

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
	@FieldDefine(title = "年度")
	@Column(name = "YEAR")
	protected Integer year; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	
	@FieldDefine(title = "法定节假日明细")
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "atsLegalHoliday", fetch = FetchType.LAZY)
	protected List<AtsLegalHolidayDetail> atsLegalHolidayDetails = new ArrayList<AtsLegalHolidayDetail>();
	
	
	
	public AtsLegalHoliday() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsLegalHoliday(String in_id) {
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
	public void setYear(Integer year) {
		this.year = year;
	}
	
	/**
	 * 返回 年度
	 * @return
	 */
	public Integer getYear() {
		return this.year;
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
	
	public List<AtsLegalHolidayDetail> getAtsLegalHolidayDetails() {
		return atsLegalHolidayDetails;
	}

	public void setAtsLegalHolidayDetails(List<AtsLegalHolidayDetail> in_atsLegalHolidayDetail) {
		this.atsLegalHolidayDetails = in_atsLegalHolidayDetail;
	}
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsLegalHoliday)) {
			return false;
		}
		AtsLegalHoliday rhs = (AtsLegalHoliday) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.year, rhs.year) 
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
		.append(this.year) 
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
				.append("year", this.year) 
				.append("memo", this.memo) 
												.toString();
	}

}



