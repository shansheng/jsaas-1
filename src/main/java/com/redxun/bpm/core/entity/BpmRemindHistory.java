package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：BpmRemindHistory实体类定义
 * 催办历史
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_REMIND_HISTORY")
@TableDefine(title = "催办历史")
public class BpmRemindHistory extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 催办实例ID */
	@FieldDefine(title = "催办实例ID")
	@Column(name = "REMINDER_INST_ID_")
	@Size(max = 50)
	protected String reminderInstId;
	
	/* 催办类型 
	 * remind 提醒
	 * expire 到期
	 */
	@FieldDefine(title = "催办类型")
	@Column(name = "REMIND_TYPE_")
	@Size(max = 50)
	protected String remindType;
	
	
	

	/**
	 * Default Empty Constructor for class BpmRemindHistory
	 */
	public BpmRemindHistory() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmRemindHistory
	 */
	public BpmRemindHistory(String in_id) {
		this.setId(in_id);
	}

	/**
	 * 主键 * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 主键
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 催办实例ID * @return String
	 */
	public String getReminderInstId() {
		return this.reminderInstId;
	}

	/**
	 * 设置 催办实例ID
	 */
	public void setReminderInstId(String aValue) {
		this.reminderInstId = aValue;
	}

	

	/**
	 * 催办类型 * @return String
	 */
	public String getRemindType() {
		return this.remindType;
	}

	/**
	 * 设置 催办类型
	 */
	public void setRemindType(String aValue) {
		this.remindType = aValue;
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

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmRemindHistory)) {
			return false;
		}
		BpmRemindHistory rhs = (BpmRemindHistory) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.reminderInstId, rhs.reminderInstId)
				.append(this.remindType, rhs.remindType)
				.append(this.createTime, rhs.createTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.reminderInstId)
				.append(this.remindType).append(this.createTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("reminderInstId", this.reminderInstId)
				.append("remindType", this.remindType)
				.append("createTime", this.createTime).toString();
	}

}
