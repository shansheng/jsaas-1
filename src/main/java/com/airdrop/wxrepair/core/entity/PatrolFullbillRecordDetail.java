



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
 * 描述：巡检单填写详情实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-10-14 10:55:26
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "巡检单填写详情")
public class PatrolFullbillRecordDetail extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "题目ID")
	@Column(name = "F_QUESTION")
	protected String question; 
	@FieldDefine(title = "题目")
	@Column(name = "F_QUESTION_name")
	protected String questionName; 
	@FieldDefine(title = "题型ID")
	@Column(name = "F_QUESTION_TYPE")
	protected String questionType; 
	@FieldDefine(title = "题型")
	@Column(name = "F_QUESTION_TYPE_name")
	protected String questionTypeName; 
	@FieldDefine(title = "回答")
	@Column(name = "F_ANSWER")
	protected String answer; 
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
	
	
	
	
	
	public PatrolFullbillRecordDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolFullbillRecordDetail(String in_id) {
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
	
	public void setQuestion(String question) {
		this.question = question;
	}
	
	/**
	 * 返回 题目ID
	 * @return
	 */
	public String getQuestion() {
		return this.question;
	}
	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}
	
	/**
	 * 返回 题目
	 * @return
	 */
	public String getQuestionName() {
		return this.questionName;
	}
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	
	/**
	 * 返回 题型ID
	 * @return
	 */
	public String getQuestionType() {
		return this.questionType;
	}
	public void setQuestionTypeName(String questionTypeName) {
		this.questionTypeName = questionTypeName;
	}
	
	/**
	 * 返回 题型
	 * @return
	 */
	public String getQuestionTypeName() {
		return this.questionTypeName;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	/**
	 * 返回 回答
	 * @return
	 */
	public String getAnswer() {
		return this.answer;
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
		if (!(object instanceof PatrolFullbillRecordDetail)) {
			return false;
		}
		PatrolFullbillRecordDetail rhs = (PatrolFullbillRecordDetail) object;
		return new EqualsBuilder()
		.append(this.question, rhs.question) 
		.append(this.questionName, rhs.questionName) 
		.append(this.questionType, rhs.questionType) 
		.append(this.questionTypeName, rhs.questionTypeName) 
		.append(this.answer, rhs.answer) 
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
		.append(this.question) 
		.append(this.questionName) 
		.append(this.questionType) 
		.append(this.questionTypeName) 
		.append(this.answer) 
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
		.append("question", this.question) 
				.append("questionName", this.questionName) 
				.append("questionType", this.questionType) 
				.append("questionTypeName", this.questionTypeName) 
				.append("answer", this.answer) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
		.toString();
	}

}



