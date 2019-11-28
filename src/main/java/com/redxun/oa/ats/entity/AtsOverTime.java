



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
 * 描述：考勤加班单实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_over_time")
@TableDefine(title = "考勤加班单")
public class AtsOverTime extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID")
	protected String userId; 
	@FieldDefine(title = "加班类型")
	@Column(name = "OT_TYPE")
	protected String otType; 
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME")
	protected java.util.Date startTime; 
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME")
	protected java.util.Date endTime; 
	@FieldDefine(title = "加班时间")
	@Column(name = "OT_TIME")
	protected Double otTime; 
	@FieldDefine(title = "加班补偿方式")
	@Column(name = "OT_COMPENS")
	protected Short otCompens; 
	@FieldDefine(title = "流程运行ID")
	@Column(name = "RUN_ID")
	protected String runId; 
	
	
	
	
	public AtsOverTime() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsOverTime(String in_id) {
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
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 用户ID
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setOtType(String otType) {
		this.otType = otType;
	}
	
	/**
	 * 返回 加班类型
	 * @return
	 */
	public String getOtType() {
		return this.otType;
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
	public void setOtTime(Double otTime) {
		this.otTime = otTime;
	}
	
	/**
	 * 返回 加班时间
	 * @return
	 */
	public Double getOtTime() {
		return this.otTime;
	}
	public void setOtCompens(Short otCompens) {
		this.otCompens = otCompens;
	}
	
	/**
	 * 返回 加班补偿方式
	 * @return
	 */
	public Short getOtCompens() {
		return this.otCompens;
	}
	public void setRunId(String runId) {
		this.runId = runId;
	}
	
	/**
	 * 返回 流程运行ID
	 * @return
	 */
	public String getRunId() {
		return this.runId;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsOverTime)) {
			return false;
		}
		AtsOverTime rhs = (AtsOverTime) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.userId, rhs.userId) 
		.append(this.otType, rhs.otType) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.otTime, rhs.otTime) 
		.append(this.otCompens, rhs.otCompens) 
		.append(this.runId, rhs.runId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.userId) 
		.append(this.otType) 
		.append(this.startTime) 
		.append(this.endTime) 
		.append(this.otTime) 
		.append(this.otCompens) 
		.append(this.runId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("userId", this.userId) 
				.append("otType", this.otType) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("otTime", this.otTime) 
				.append("otCompens", this.otCompens) 
				.append("runId", this.runId) 
												.toString();
	}

}



