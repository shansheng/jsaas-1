



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
 * 描述：问卷信息实体类定义
 * 作者：zpf
 * 邮箱: 1014485786@qq.com
 * 日期:2019-11-08 10:42:41
 * 版权：麦希影业
 * </pre>
 */
@TableDefine(title = "问卷信息")
public class PatrolQuestionnaireInfo extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "问卷名称")
	@Column(name = "F_QUESTIONNAIRE_NAME")
	protected String questionnaireName; 
	@FieldDefine(title = "问卷类型ID")
	@Column(name = "F_QUESTIONNAIRE_TYPE")
	protected String questionnaireType; 
	@FieldDefine(title = "问卷类型")
	@Column(name = "F_QUESTIONNAIRE_TYPE_name")
	protected String questionnaireTypeName; 
	@FieldDefine(title = "问卷主题")
	@Column(name = "F_QUESTIONNAIRE_THEME")
	protected String questionnaireTheme; 
	@FieldDefine(title = "开始时间")
	@Column(name = "F_STARTDATE")
	protected java.util.Date startdate; 
	@FieldDefine(title = "结束时间")
	@Column(name = "F_ENDDATE")
	protected java.util.Date enddate; 
	@FieldDefine(title = "创建人")
	@Column(name = "F_CREATOR")
	protected String creator; 
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
	@FieldDefine(title = "是否启用ID")
	@Column(name = "F_STATUS")
	protected String status; 
	@FieldDefine(title = "是否启用")
	@Column(name = "F_STATUS_name")
	protected String statusName; 
	
	
	
	
	
	public PatrolQuestionnaireInfo() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public PatrolQuestionnaireInfo(String in_id) {
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
	
	public void setQuestionnaireName(String questionnaireName) {
		this.questionnaireName = questionnaireName;
	}
	
	/**
	 * 返回 问卷名称
	 * @return
	 */
	public String getQuestionnaireName() {
		return this.questionnaireName;
	}
	public void setQuestionnaireType(String questionnaireType) {
		this.questionnaireType = questionnaireType;
	}
	
	/**
	 * 返回 问卷类型ID
	 * @return
	 */
	public String getQuestionnaireType() {
		return this.questionnaireType;
	}
	public void setQuestionnaireTypeName(String questionnaireTypeName) {
		this.questionnaireTypeName = questionnaireTypeName;
	}
	
	/**
	 * 返回 问卷类型
	 * @return
	 */
	public String getQuestionnaireTypeName() {
		return this.questionnaireTypeName;
	}
	public void setQuestionnaireTheme(String questionnaireTheme) {
		this.questionnaireTheme = questionnaireTheme;
	}
	
	/**
	 * 返回 问卷主题
	 * @return
	 */
	public String getQuestionnaireTheme() {
		return this.questionnaireTheme;
	}
	public void setStartdate(java.util.Date startdate) {
		this.startdate = startdate;
	}
	
	/**
	 * 返回 开始时间
	 * @return
	 */
	public java.util.Date getStartdate() {
		return this.startdate;
	}
	public void setEnddate(java.util.Date enddate) {
		this.enddate = enddate;
	}
	
	/**
	 * 返回 结束时间
	 * @return
	 */
	public java.util.Date getEnddate() {
		return this.enddate;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	/**
	 * 返回 创建人
	 * @return
	 */
	public String getCreator() {
		return this.creator;
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
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 是否启用ID
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
	/**
	 * 返回 是否启用
	 * @return
	 */
	public String getStatusName() {
		return this.statusName;
	}
	
	
	
	
		

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof PatrolQuestionnaireInfo)) {
			return false;
		}
		PatrolQuestionnaireInfo rhs = (PatrolQuestionnaireInfo) object;
		return new EqualsBuilder()
		.append(this.questionnaireName, rhs.questionnaireName) 
		.append(this.questionnaireType, rhs.questionnaireType) 
		.append(this.questionnaireTypeName, rhs.questionnaireTypeName) 
		.append(this.questionnaireTheme, rhs.questionnaireTheme) 
		.append(this.startdate, rhs.startdate) 
		.append(this.enddate, rhs.enddate) 
		.append(this.creator, rhs.creator) 
		.append(this.id, rhs.id) 
		.append(this.refId, rhs.refId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.append(this.groupId, rhs.groupId) 
		.append(this.status, rhs.status) 
		.append(this.statusName, rhs.statusName) 
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.questionnaireName) 
		.append(this.questionnaireType) 
		.append(this.questionnaireTypeName) 
		.append(this.questionnaireTheme) 
		.append(this.startdate) 
		.append(this.enddate) 
		.append(this.creator) 
		.append(this.id) 
		.append(this.refId) 
		.append(this.parentId) 
		.append(this.instId) 
		.append(this.instStatus) 
		.append(this.groupId) 
		.append(this.status) 
		.append(this.statusName) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("questionnaireName", this.questionnaireName) 
				.append("questionnaireType", this.questionnaireType) 
				.append("questionnaireTypeName", this.questionnaireTypeName) 
				.append("questionnaireTheme", this.questionnaireTheme) 
				.append("startdate", this.startdate) 
				.append("enddate", this.enddate) 
				.append("creator", this.creator) 
				.append("id", this.id) 
				.append("refId", this.refId) 
				.append("parentId", this.parentId) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
														.append("groupId", this.groupId) 
				.append("status", this.status) 
				.append("statusName", this.statusName) 
		.toString();
	}

}



