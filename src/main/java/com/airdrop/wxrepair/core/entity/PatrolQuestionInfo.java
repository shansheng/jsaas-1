



package com.airdrop.wxrepair.core.entity;

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
 * 描述：问题信息实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-11-19 12:06:17
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "问题信息")
public class PatrolQuestionInfo extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "题目类型ID")
	@Column(name = "F_QUESTION_TYPE")
	protected String questionType; 
	@FieldDefine(title = "题目类型")
	@Column(name = "F_QUESTION_TYPE_name")
	protected String questionTypeName; 
	@FieldDefine(title = "题目内容")
	@Column(name = "F_QUESTION_CONTENT")
	protected String questionContent; 
	@FieldDefine(title = "题目序号")
	@Column(name = "F_SEQUENCE")
	protected Integer sequence; 
	@FieldDefine(title = "外键")
	@Column(name = "REF_ID_")
	protected String refId; 
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	protected String parentId; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "状态")
	@Column(name = "INST_STATUS_")
	protected String instStatus; 
	@FieldDefine(title = "组ID")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	
	
	
	
	
	public PatrolQuestionInfo() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolQuestionInfo(String in_id) {
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
	
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	
	/**
	 * 返回 题目类型ID
	 * @return
	 */
	public String getQuestionType() {
		return this.questionType;
	}
	public void setQuestionTypeName(String questionTypeName) {
		this.questionTypeName = questionTypeName;
	}
	
	/**
	 * 返回 题目类型
	 * @return
	 */
	public String getQuestionTypeName() {
		return this.questionTypeName;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	
	/**
	 * 返回 题目内容
	 * @return
	 */
	public String getQuestionContent() {
		return this.questionContent;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}
	
	/**
	 * 返回 题目序号
	 * @return
	 */
	public Integer getSequence() {
		return this.sequence;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	
	/**
	 * 返回 外键
	 * @return
	 */
	public String getRefId() {
		return this.refId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	/**
	 * 返回 父ID
	 * @return
	 */
	public String getParentId() {
		return this.parentId;
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
	public void setInstStatus(String instStatus) {
		this.instStatus = instStatus;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getInstStatus() {
		return this.instStatus;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 组ID
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof PatrolQuestionInfo)) {
			return false;
		}
		PatrolQuestionInfo rhs = (PatrolQuestionInfo) object;
		return new EqualsBuilder()
		.append(this.questionType, rhs.questionType) 
		.append(this.questionTypeName, rhs.questionTypeName) 
		.append(this.questionContent, rhs.questionContent) 
		.append(this.sequence, rhs.sequence) 
		.append(this.id, rhs.id) 
		.append(this.refId, rhs.refId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.append(this.groupId, rhs.groupId) 
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.questionType) 
		.append(this.questionTypeName) 
		.append(this.questionContent) 
		.append(this.sequence) 
		.append(this.id) 
		.append(this.refId) 
		.append(this.parentId) 
		.append(this.instId) 
		.append(this.instStatus) 
		.append(this.groupId) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("questionType", this.questionType) 
				.append("questionTypeName", this.questionTypeName) 
				.append("questionContent", this.questionContent) 
				.append("sequence", this.sequence) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



