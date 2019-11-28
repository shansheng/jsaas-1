



package com.redxun.bpm.core.entity;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * <pre>
 *  
 * 描述：调用结果实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-02-15 14:34:23
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "调用结果")
public class BpmHttpInvokeResult extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "任务ID")
	@Column(name = "TASK_ID_")
	protected String taskId; 
	@FieldDefine(title = "返回结果")
	@Column(name = "CONTENT_")
	protected String content; 
	
	
	
	
	
	public BpmHttpInvokeResult() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmHttpInvokeResult(String in_id) {
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
	
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	/**
	 * 返回 任务ID
	 * @return
	 */
	public String getTaskId() {
		return this.taskId;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 返回 返回结果
	 * @return
	 */
	public String getContent() {
		return this.content;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmHttpInvokeResult)) {
			return false;
		}
		BpmHttpInvokeResult rhs = (BpmHttpInvokeResult) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.taskId, rhs.taskId)
		.append(this.content, rhs.content)
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id)
		.append(this.taskId)
		.append(this.content)
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("taskId", this.taskId) 
				.append("content", this.content) 
												.toString();
	}

}



