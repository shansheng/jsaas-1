



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
 * 描述：假期制度实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-23 17:08:22
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_holiday_policy")
@TableDefine(title = "假期制度")
public class AtsHolidayPolicy extends BaseTenantEntity {

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
	@FieldDefine(title = "所属组织")
	@Column(name = "ORG_ID")
	protected Long orgId; 
	@FieldDefine(title = "是否默认")
	@Column(name = "IS_DEFAULT")
	protected Short isDefault; 
	@FieldDefine(title = "是否启动半天假")
	@Column(name = "IS_HALF_DAY_OFF")
	protected Short isHalfDayOff; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	
	@FieldDefine(title = "假期制度明细")
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "atsHolidayPolicy", fetch = FetchType.LAZY)
	protected List<AtsHolidayPolicyDetail> atsHolidayPolicyDetails = new ArrayList<AtsHolidayPolicyDetail>();
	
	//组织名称
	protected String orgName;
	
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	public String getOrgName() {
		return orgName;
	}
	
	public AtsHolidayPolicy() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsHolidayPolicy(String in_id) {
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
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	
	/**
	 * 返回 所属组织
	 * @return
	 */
	public Long getOrgId() {
		return this.orgId;
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
	public void setIsHalfDayOff(Short isHalfDayOff) {
		this.isHalfDayOff = isHalfDayOff;
	}
	
	/**
	 * 返回 是否启动半天假
	 * @return
	 */
	public Short getIsHalfDayOff() {
		return this.isHalfDayOff;
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
	
	public List<AtsHolidayPolicyDetail> getAtsHolidayPolicyDetails() {
		return atsHolidayPolicyDetails;
	}

	public void setAtsHolidayPolicyDetails(List<AtsHolidayPolicyDetail> in_atsHolidayPolicyDetail) {
		this.atsHolidayPolicyDetails = in_atsHolidayPolicyDetail;
	}
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsHolidayPolicy)) {
			return false;
		}
		AtsHolidayPolicy rhs = (AtsHolidayPolicy) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.orgId, rhs.orgId) 
		.append(this.isDefault, rhs.isDefault) 
		.append(this.isHalfDayOff, rhs.isHalfDayOff) 
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
		.append(this.orgId) 
		.append(this.isDefault) 
		.append(this.isHalfDayOff) 
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
				.append("orgId", this.orgId) 
				.append("isDefault", this.isDefault) 
				.append("isHalfDayOff", this.isHalfDayOff) 
				.append("memo", this.memo) 
												.toString();
	}

}



