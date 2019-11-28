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
 * 描述：流程沟通留言板实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2017-10-27 16:51:41
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_MESSAGE_BOARD")
@TableDefine(title = "流程沟通留言板")
public class BpmMessageBoard extends BaseTenantEntity {

	@FieldDefine(title = "留言ID")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "留言用户")
	@Column(name = "MESSAGE_AUTHOR_")
	protected String messageAuthor; 
	@FieldDefine(title = "留言消息")
	@Column(name = "MESSAGE_CONTENT_")
	protected String messageContent; 
	@FieldDefine(title = "附件ID")
	@Column(name = "FILE_ID_")
	protected String fileId; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "MESSAGE_AUTHOR_ID_")
	protected String messageAuthorId; 
	
	
	
	public BpmMessageBoard() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmMessageBoard(String in_id) {
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
	
	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	/**
	 * 返回 流程实例ID
	 * @return
	 */
	public String getInstId() {
		return this.instId;
	}
	public void setMessageAuthor(String messageAuthor) {
		this.messageAuthor = messageAuthor;
	}
	
	/**
	 * 返回 留言用户
	 * @return
	 */
	public String getMessageAuthor() {
		return this.messageAuthor;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	
	/**
	 * 返回 留言消息
	 * @return
	 */
	public String getMessageContent() {
		return this.messageContent;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	/**
	 * 返回 附件ID
	 * @return
	 */
	public String getFileId() {
		return this.fileId;
	}
	
	
	
		

	public String getMessageAuthorId() {
		return messageAuthorId;
	}

	public void setMessageAuthorId(String messageAuthorId) {
		this.messageAuthorId = messageAuthorId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmMessageBoard)) {
			return false;
		}
		BpmMessageBoard rhs = (BpmMessageBoard) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.instId, rhs.instId) 
		.append(this.messageAuthor, rhs.messageAuthor) 
		.append(this.messageContent, rhs.messageContent) 
		.append(this.fileId, rhs.fileId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.instId) 
		.append(this.messageAuthor) 
		.append(this.messageContent) 
		.append(this.fileId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("instId", this.instId) 
				.append("messageAuthor", this.messageAuthor) 
				.append("messageContent", this.messageContent) 
				.append("fileId", this.fileId) 
												.toString();
	}

}



