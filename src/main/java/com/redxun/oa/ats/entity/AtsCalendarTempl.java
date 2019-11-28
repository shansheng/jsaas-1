



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
 * 描述：日历模版实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-22 09:49:46
 * 版权：广州红迅软件
 * </pre>
 */
public class AtsCalendarTempl extends BaseTenantEntity {

	
	protected String id;


	protected String code; 

	protected String name; 
	protected Short isSys; 
	protected Short status; 
	protected String memo; 
	
	
	protected List<AtsCalendarTemplDetail> atsCalendarTemplDetails = new ArrayList<AtsCalendarTemplDetail>();
	
	
	
	public AtsCalendarTempl() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsCalendarTempl(String in_id) {
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
	public void setIsSys(Short isSys) {
		this.isSys = isSys;
	}
	
	/**
	 * 返回 是否系统预置
	 * @return
	 */
	public Short getIsSys() {
		return this.isSys;
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
	
	public List<AtsCalendarTemplDetail> getAtsCalendarTemplDetails() {
		return atsCalendarTemplDetails;
	}

	public void setAtsCalendarTemplDetails(List<AtsCalendarTemplDetail> in_atsCalendarTemplDetail) {
		this.atsCalendarTemplDetails = in_atsCalendarTemplDetail;
	}
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsCalendarTempl)) {
			return false;
		}
		AtsCalendarTempl rhs = (AtsCalendarTempl) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.isSys, rhs.isSys) 
		.append(this.status, rhs.status) 
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
		.append(this.isSys) 
		.append(this.status) 
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
				.append("isSys", this.isSys) 
				.append("status", this.status) 
				.append("memo", this.memo) 
												.toString();
	}

}



