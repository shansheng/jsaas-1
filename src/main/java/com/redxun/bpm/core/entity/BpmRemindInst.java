package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：BpmRemindInst实体类定义
 * 催办实例表
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_REMIND_INST")
@TableDefine(title = "催办实例表")
public class BpmRemindInst extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 方案ID */
	@FieldDefine(title = "方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 50)
	protected String solId;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 50)
	protected String nodeId;
	/* 任务ID */
	@FieldDefine(title = "任务ID")
	@Column(name = "TASK_ID_")
	@Size(max = 50)
	protected String taskId;
	/* 名称 */
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	@Size(max = 50)
	protected String name;
	/* 到期动作 */
	@FieldDefine(title = "到期动作")
	@Column(name = "ACTION_")
	@Size(max = 50)
	protected String action;
	/* 期限 */
	@FieldDefine(title = "期限")
	@Column(name = "EXPIRE_DATE_")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
	protected java.util.Date expireDate;
	/* 到期执行脚本 */
	@FieldDefine(title = "到期执行脚本")
	@Column(name = "SCRIPT_")
	@Size(max = 1000)
	protected String script;
	/* 通知类型 */
	@FieldDefine(title = "通知类型")
	@Column(name = "NOTIFY_TYPE_")
	@Size(max = 50)
	protected String notifyType;
	
	/* 开始发送消息时间点 */
	@FieldDefine(title = "催办时间点")
	@Column(name = "TIME_TO_SEND_")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
	protected java.util.Date timeToSend;
	/* 发送次数 */
	@FieldDefine(title = "发送次数")
	@Column(name = "SEND_TIMES_")
	protected Integer sendTimes;
	/* 发送时间间隔 */
	@FieldDefine(title = "发送时间间隔")
	@Column(name = "SEND_INTERVAL_")
	protected Integer sendInterval;
	/* 状态(create,创建,run,进行中) */
	@FieldDefine(title = "状态(create,创建,run,进行中,finish,已经完成)")
	@Column(name = "STATUS_")
	@Size(max = 10)
	protected String status;
	
	@FieldDefine(title = "解决方案名")
	@Column(name = "SOLUTION_NAME_")
	protected String solutionName;
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	protected String nodeName;
	
	@FieldDefine(title = "任务ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 50)
	protected String actInstId;


	/**
	 * Default Empty Constructor for class BpmRemindInst
	 */
	public BpmRemindInst() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmRemindInst
	 */
	public BpmRemindInst(String in_id) {
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
	 * 方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 节点ID * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点ID
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 任务ID * @return String
	 */
	public String getTaskId() {
		return this.taskId;
	}

	/**
	 * 设置 任务ID
	 */
	public void setTaskId(String aValue) {
		this.taskId = aValue;
	}

	/**
	 * 名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 到期动作 
	 * none: 无动作
	 * approve : 审批
	 * script : 执行脚本
	 * @return String
	 */
	public String getAction() {
		return this.action;
	}

	/**
	 * 设置 到期动作
	 */
	public void setAction(String aValue) {
		this.action = aValue;
	}

	/**
	 * 期限 * @return java.util.Date
	 */
	public java.util.Date getExpireDate() {
		return this.expireDate;
	}

	/**
	 * 设置 期限
	 */
	public void setExpireDate(java.util.Date aValue) {
		this.expireDate = aValue;
	}

	/**
	 * 到期执行脚本 * @return String
	 */
	public String getScript() {
		return this.script;
	}

	/**
	 * 设置 到期执行脚本
	 */
	public void setScript(String aValue) {
		this.script = aValue;
	}

	/**
	 * 通知类型 * @return String
	 */
	public String getNotifyType() {
		return this.notifyType;
	}

	/**
	 * 设置 通知类型
	 */
	public void setNotifyType(String aValue) {
		this.notifyType = aValue;
	}

	

	/**
	 * 开始发送消息时间点 * @return java.util.Date
	 */
	public java.util.Date getTimeToSend() {
		return this.timeToSend;
	}

	/**
	 * 设置 开始发送消息时间点
	 */
	public void setTimeToSend(java.util.Date aValue) {
		this.timeToSend = aValue;
	}

	/**
	 * 发送次数 * @return Integer
	 */
	public Integer getSendTimes() {
		return this.sendTimes;
	}

	/**
	 * 设置 发送次数
	 */
	public void setSendTimes(Integer aValue) {
		this.sendTimes = aValue;
	}

	/**
	 * 发送时间间隔 * @return Integer
	 */
	public Integer getSendInterval() {
		return this.sendInterval;
	}

	/**
	 * 设置 发送时间间隔
	 */
	public void setSendInterval(Integer aValue) {
		this.sendInterval = aValue;
	}

	/**
	 * 状态(2,完成,0,创建,1,进行中) * @return String
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * 设置 状态(2,完成,0,创建,1,进行中)
	 */
	public void setStatus(String aValue) {
		this.status = aValue;
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
	 * 获取催办结束时间点。
	 * @return
	 */
	
//	public Date getEndRemindTime(){
//		int amount=sendInterval * (sendTimes-1);
//		return DateUtil.add(timeToSend, Calendar.MINUTE, amount) ;
//		
//	}

	

	public String getSolutionName() {
		return solutionName;
	}

	public void setSolutionName(String solutionName) {
		this.solutionName = solutionName;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getActInstId() {
		return actInstId;
	}

	public void setActInstId(String actInstId) {
		this.actInstId = actInstId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmRemindInst)) {
			return false;
		}
		BpmRemindInst rhs = (BpmRemindInst) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.solId, rhs.solId).append(this.nodeId, rhs.nodeId)
				.append(this.taskId, rhs.taskId).append(this.name, rhs.name).append(this.action, rhs.action)
				.append(this.expireDate, rhs.expireDate).append(this.script, rhs.script)
				.append(this.notifyType, rhs.notifyType).append(this.timeToSend, rhs.timeToSend)
				.append(this.sendTimes, rhs.sendTimes).append(this.sendInterval, rhs.sendInterval)
				.append(this.status, rhs.status).append(this.tenantId, rhs.tenantId)
				.append(this.createTime, rhs.createTime).append(this.createBy, rhs.createBy)
				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.solId).append(this.nodeId)
				.append(this.taskId).append(this.name).append(this.action).append(this.expireDate).append(this.script)
				.append(this.notifyType).append(this.timeToSend)
				.append(this.sendTimes).append(this.sendInterval).append(this.status).append(this.tenantId)
				.append(this.createTime).append(this.createBy).append(this.updateBy).append(this.updateTime)
				.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("solId", this.solId).append("nodeId", this.nodeId)
				.append("taskId", this.taskId).append("name", this.name).append("action", this.action)
				.append("expireDate", this.expireDate).append("script", this.script)
				.append("notifyType", this.notifyType).append("timeToSend", this.timeToSend)
				.append("sendTimes", this.sendTimes).append("sendInterval", this.sendInterval)
				.append("status", this.status).append("tenantId", this.tenantId).append("createTime", this.createTime)
				.append("createBy", this.createBy).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
