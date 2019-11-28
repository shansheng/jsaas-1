package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmInst实体类定义
 * 流程实例
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_INST")
@TableDefine(title = "流程实例")
public class BpmInst extends BaseTenantEntity implements IRightModel {
	/**
	 * 实例状态-运行中状态=RUNNING
	 */
	public final static String STATUS_RUNNING="RUNNING";
	/**
	 * 实例状态-成功结束状态=SUCCESS_END
	 */
	public final static String STATUS_SUCCESS_END="SUCCESS_END";
	/**
	 * 实例状态-草稿=DRAFTED
	 */
	public final static String STATUS_DRAFTED="DRAFTED";
	
	/**
	 * 实例状态-挂起状态=PENDING
	 */
	public final static String STATUS_PENDING="PENDING";
	
	/**
	 * 实例状态-异常中止结束状态=ABORT_END
	 */
	public final static String STATUS_ABORT_END="ABORT_END";
	/**
	 * 实例状态-取消结束状态=CANCEL_END
	 */
	public final static String STATUS_CANCEL_END="CANCEL_END";
	/**
	 * 实例状态-作废结束状态=DISCARD_END
	 */
	public final static String STATUS_DISCARD="DISCARD_END";
	
	
	public final static String BO_DEF_ID="bo_Def_Id_";
	
	

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "INST_ID_")
	protected String instId;
	/* 流程定义ID */
	@FieldDefine(title = "流程定义ID")
	@Column(name = "DEF_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String defId;
	/* Activiti实例ID */
	@FieldDefine(title = "Activiti实例ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 64)
	protected String actInstId;
	/* Activiti定义ID */
	@FieldDefine(title = "Activiti定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String actDefId;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	protected String solId;
	
	/* 解决方案KEY */
	@FieldDefine(title = "解决方案KEY")
	@Column(name = "SOL_KEY_")
	@Size(max = 100)
	protected String solKey;
	
	/* 标题 */
	@FieldDefine(title = "标题")
	@Column(name = "SUBJECT_")
	@Size(max = 350)
	protected String subject;
	/* 运行状态 */
	@FieldDefine(title = "运行状态")
	@Column(name = "STATUS_")
	@Size(max = 20)
	protected String status;
	/* 版本 */
	@FieldDefine(title = "版本")
	@Column(name = "VERSION_")
	protected Integer version;
	/* 业务键ID */
	@FieldDefine(title = "业务键ID")
	@Column(name = "BUS_KEY_")
	@Size(max = 64)
	protected String busKey;
	
	/* 单号 */
	@FieldDefine(title = "单号")
	@Column(name = "BILL_NO_")
	@Size(max = 64)
	protected String billNo;
	
//	/* 单号 */
//	@FieldDefine(title = "单号")
//	@Column(name = "BILL_NO_")
//	@Size(max = 64)
//	protected String billNo;
	

	/* 业务键ID */
	@FieldDefine(title = "业务编号")
	@Column(name = "INST_NO_")
	@Size(max = 64)
	protected String instNo;
	
	/**
	 * 业务数据保存模式
	 * db,json,all
	 * 参考ProcessConfig 中定义的常量。
	 */
	@FieldDefine(title = "业务数据保存方式")
	@Column(name = "DATA_SAVE_MODE_")
	@Size(max = 64)
	protected String dataSaveMode="";
	
	/**
	 * 业务模型定义ID
	 */
	@FieldDefine(title = "业务模型定义ID")
	@Column(name = "BO_DEF_ID_")
	protected String boDefId="";
	
	
	/* 业务键ID */
//	@FieldDefine(title = "业务实例ID")
//	@Column(name = "FORM_INST_ID_")
//	@Size(max = 64)
//	protected String formInstId;
	
	
	@FieldDefine(title = "业务审批依据文件ID")
	@Column(name = "CHECK_FILE_ID_")
	@Size(max = 64)
	protected String checkFileId;
	
	/* 是否为测试 */
	@FieldDefine(title = "是否为测试")
	@Column(name = "IS_TEST_")
	@Size(max = 20)
	protected String isTest;
	/* 结束时间 */
	@FieldDefine(title = "结束时间")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
	@Column(name = "END_TIME_")
	protected java.util.Date endTime;

	@FieldDefine(title = "单独使用业务模型")
	@Column(name = "IS_USE_BMODEL_")
	@Size(max = 30)
	protected String isUseBmodel;

	@FieldDefine(title = "是否支持手机端")
	@Column(name = "SUPPORT_MOBILE_")
	protected int supportMobile=0;

	/* 发起部门ID */
	@FieldDefine(title = "发起部门ID")
	@Column(name = "START_DEP_ID_")
	@Size(max = 64)
	protected String startDepId;
	
	
	/* 发起部门ID */
	@FieldDefine(title = "发起部门全名")
	@Column(name = "START_DEP_FULL_")
	@Size(max = 300)
	protected String startDepFull;
	
	
	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	/**
	 * 流程实例错误
	 */
	@Column(name = "ERRORS_")
	@Size(max = 2147483647)
	protected String errors;
	
	@Transient
	protected JSONObject rightJson;
	
	/**
	 * 当前节点
	 */
	@Transient
	protected String taskNodes;	
	/**
	 * 当前节点人员
	 */
	@Transient
	protected String taskNodeUsers;	
	
	/**
	 * 树分类名称
	 */
	@Transient
	protected String treeName;
	
	@Transient
	protected String solName;
	
	@Transient
	protected String icon;
	
	@Transient
	protected String color;

	/**
	 * Default Empty Constructor for class BpmInst
	 */
	public BpmInst() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInst
	 */
	public BpmInst(String in_instId) {
		this.setInstId(in_instId);
	}
	
	public void setColor(String color) {
		this.color = color;
	}
	
	public String getColor() {
		return color;
	}
	
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	public String getIcon() {
		return icon;
	}
	
	public String getSolName() {
		return solName;
	}
	
	public void setSolName(String solName) {
		this.solName = solName;
	}

	public String getInstNo() {
		return instNo;
	}

	public void setInstNo(String instNo) {
		this.instNo = instNo;
	}

	/**
	 * * @return String
	 */
	public String getInstId() {
		return this.instId;
	}

	/**
	 * 设置
	 */
	public void setInstId(String aValue) {
		this.instId = aValue;
	}

	/**
	 * 流程定义ID * @return String
	 */
	public String getDefId() {
		return this.defId;
	}

	/**
	 * 设置 流程定义ID
	 */
	public void setDefId(String aValue) {
		this.defId = aValue;
	}

	/**
	 * Activiti实例ID * @return String
	 */
	public String getActInstId() {
		return this.actInstId;
	}

	/**
	 * 设置 Activiti实例ID
	 */
	public void setActInstId(String aValue) {
		this.actInstId = aValue;
	}

	/**
	 * Activiti定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 Activiti定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	/**
	 * 解决方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 解决方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 标题 * @return String
	 */
	public String getSubject() {
		return this.subject;
	}

	/**
	 * 设置 标题
	 */
	public void setSubject(String aValue) {
		this.subject = aValue;
	}

	/**
	 * 运行状态 * @return String
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * 设置 运行状态
	 */
	public void setStatus(String aValue) {
		this.status = aValue;
	}

	/**
	 * 版本 * @return Integer
	 */
	public Integer getVersion() {
		return this.version;
	}

	/**
	 * 设置 版本
	 */
	public void setVersion(Integer aValue) {
		this.version = aValue;
	}

	/**
	 * 业务键ID * @return String
	 */
	public String getBusKey() {
		return this.busKey;
	}

	/**
	 * 设置 业务键ID
	 */
	public void setBusKey(String aValue) {
		this.busKey = aValue;
	}
	
	public String getStatusLabel(){
		
		if("RUNNING".equals(status)){
    		return "运行中";
    	}
		
		if("DRAFTED".equals(status)){
    		return "草稿";
    	}
		
		if("SUCCESS_END".equals(status)){
    		return "成功结束";
    	}
		
		if("DISCARD_END".equals(status)){
    		return "作废";
    	}
		if("ABORT_END".equals(status)){
    		return "异常中止结束";
    	}
		if("PENDING".equals(status)){
    		return "挂起";
    	}
		
		return "";
	}
	
	public String getStatusLabelHtml(){
		
		if("RUNNING".equals(status)){
    		return "<span style='color:blue'>运行中</span>";
    	}
		
		if("DRAFTED".equals(status)){
    		return "<span style='color:gray'>草稿</span>";
    	}
		
		if("SUCCESS_END".equals(status)){
    		return "<span style='color:green'>成功结束</span>";
    	}
		
		if("DISCARD_END".equals(status)){
    		return "<span style='color:red'>作废</span>";
    	}
		if("ABORT_END".equals(status)){
    		return "<span style='color:red'>异常中止结束</span>";
    	}
		if("PENDING".equals(status)){
    		return "<span style='color:gray'>挂起</span>";
    	}
		return "";
	}

	/**
	 * 是否为测试 * @return String
	 */
	public String getIsTest() {
		return this.isTest;
	}

	/**
	 * 设置 是否为测试
	 */
	public void setIsTest(String aValue) {
		this.isTest = aValue;
	}

	/**
	 * 结束时间 * @return java.util.Date
	 */
	public java.util.Date getEndTime() {
		return this.endTime;
	}

	/**
	 * 设置 结束时间
	 */
	public void setEndTime(java.util.Date aValue) {
		this.endTime = aValue;
	}

	public String getCheckFileId() {
		return checkFileId;
	}

	public void setCheckFileId(String checkFileId) {
		this.checkFileId = checkFileId;
	}

	@Override
	public String getIdentifyLabel() {
		return this.instId;
	}

	@Override
	public Serializable getPkId() {
		return this.instId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.instId = (String) pkId;
	}

	public String getIsUseBmodel() {
		return isUseBmodel;
	}

	public void setIsUseBmodel(String isUseBmodel) {
		this.isUseBmodel = isUseBmodel;
	}

//	public String getFormInstId() {
//		return formInstId;
//	}

//	public String getBoDefId() {
//		return boDefId;
//	}

	public String getDataSaveMode() {
		return dataSaveMode;
	}

	public String getStartDepId() {
		return startDepId;
	}

	public void setStartDepId(String startDepId) {
		this.startDepId = startDepId;
	}

	public String getStartDepFull() {
		return startDepFull;
	}

	public void setStartDepFull(String startDepFull) {
		this.startDepFull = startDepFull;
	}

	public void setDataSaveMode(String dataSaveMode) {
		this.dataSaveMode = dataSaveMode;
	}

//	public void setBoDefId(String boDefId) {
//		this.boDefId = boDefId;
//	}

//	public void setFormInstId(String formInstId) {
//		this.formInstId = formInstId;
//	}

	public String getErrors() {
		return errors;
	}

	public void setErrors(String errors) {
		this.errors = errors;
	}

	public JSONObject getRightJson() {
		return rightJson;
	}

	public void setRightJson(JSONObject rightJson) {
		this.rightJson = rightJson;
	}

	public String getTaskNodes() {
		return taskNodes;
	}

	public void setTaskNodes(String taskNodes) {
		this.taskNodes = taskNodes;
	}

	public String getTaskNodeUsers() {
		return taskNodeUsers;
	}

	public void setTaskNodeUsers(String taskNodeUsers) {
		this.taskNodeUsers = taskNodeUsers;
	}

	public String getTreeName() {
		return treeName;
	}

	public void setTreeName(String treeName) {
		this.treeName = treeName;
	}

	public int getSupportMobile() {
		return supportMobile;
	}

	public void setSupportMobile(int supportMobile) {
		this.supportMobile = supportMobile;
	}
	
	public String getSolKey() {
		return solKey;
	}

	public void setSolKey(String solKey) {
		this.solKey = solKey;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInst)) {
			return false;
		}
		BpmInst rhs = (BpmInst) object;
		return new EqualsBuilder().append(this.instId, rhs.instId)
				.append(this.defId, rhs.defId)
				.append(this.actInstId, rhs.actInstId)
				.append(this.actDefId, rhs.actDefId)
				.append(this.solId, rhs.solId)
				.append(this.subject, rhs.subject)
				.append(this.status, rhs.status)
				.append(this.version, rhs.version)
				.append(this.busKey, rhs.busKey)
				.append(this.isTest, rhs.isTest)
				.append(this.endTime, rhs.endTime)
				.append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.instId)
				.append(this.defId).append(this.actInstId)
				.append(this.actDefId).append(this.solId).append(this.subject)
				.append(this.status).append(this.version).append(this.busKey)
				.append(this.isTest).append(this.endTime).append(this.tenantId)
				.append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("instId", this.instId)
				.append("defId", this.defId)
				.append("actInstId", this.actInstId)
				.append("actDefId", this.actDefId).append("solId", this.solId)
				.append("subject", this.subject).append("status", this.status)
				.append("version", this.version).append("busKey", this.busKey)
				.append("isTest", this.isTest).append("endTime", this.endTime)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
