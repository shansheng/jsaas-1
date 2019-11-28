



package com.redxun.oa.ats.entity;

import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：考勤周期明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-23 14:36:39
 * 版权：广州红迅软件
 * </pre>
 */
public class AtsAttenceCycleDetail extends BaseTenantEntity {

	protected String id;
	
	protected String name; 
	protected java.util.Date startTime; 
	protected java.util.Date endTime; 
	protected String memo; 
	
	
	//外键
	protected String cycleId;
	
	
	public AtsAttenceCycleDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttenceCycleDetail(String in_id) {
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
	public void setStartTime(java.util.Date startTime) {
		this.startTime = startTime;
	}
	
	/**
	 * 返回 开始时间
	 * @return
	 */
	public java.util.Date getStartTime() {
		return this.startTime;
	}
	public void setEndTime(java.util.Date endTime) {
		this.endTime = endTime;
	}
	
	/**
	 * 返回 结束时间
	 * @return
	 */
	public java.util.Date getEndTime() {
		return this.endTime;
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
	
	public void setCycleId(String cycleId) {
		this.cycleId = cycleId;
	}
	
	public String getCycleId() {
		return cycleId;
	}
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttenceCycleDetail)) {
			return false;
		}
		AtsAttenceCycleDetail rhs = (AtsAttenceCycleDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
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
		.append(this.name) 
		.append(this.startTime) 
		.append(this.endTime) 
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
						.append("name", this.name) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("memo", this.memo) 
												.toString();
	}

}



