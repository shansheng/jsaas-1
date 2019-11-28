



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
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
 * 描述：BPM_OPINION_TEMP实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2017-09-26 18:02:24
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_OPINION_TEMP")
@TableDefine(title = "BPM_OPINION_TEMP")
public class BpmOpinionTemp extends BaseTenantEntity {
	
	public static final String TYPE_INST = "instId";
	public static final String TYPE_TASK = "taskId";

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "类型(inst,task)")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "任务或实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "意见")
	@Column(name = "OPINION_")
	protected String opinion; 
	@FieldDefine(title = "附件")
	@Column(name = "ATTACHMENT_")
	protected String attachment; 
	
	
	
	
	public BpmOpinionTemp() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmOpinionTemp(String in_id) {
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
	
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 类型(inst,task)
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	/**
	 * 返回 任务或实例ID
	 * @return
	 */
	public String getInstId() {
		return this.instId;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	/**
	 * 返回 意见
	 * @return
	 */
	public String getOpinion() {
		return this.opinion;
	}
	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
	/**
	 * 返回 附件
	 * @return
	 */
	public String getAttachment() {
		return this.attachment;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmOpinionTemp)) {
			return false;
		}
		BpmOpinionTemp rhs = (BpmOpinionTemp) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.type, rhs.type) 
		.append(this.instId, rhs.instId) 
		.append(this.opinion, rhs.opinion) 
		.append(this.attachment, rhs.attachment) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.type) 
		.append(this.instId) 
		.append(this.opinion) 
		.append(this.attachment) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("type", this.type) 
				.append("instId", this.instId) 
				.append("opinion", this.opinion) 
				.append("attachment", this.attachment) 
												.toString();
	}

}



