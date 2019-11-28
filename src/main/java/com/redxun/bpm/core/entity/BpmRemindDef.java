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
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 *  
 * 描述：BpmRemindDef实体类定义
 * 催办定义
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_REMIND_DEF")
@TableDefine(title = "催办定义")
@XStreamAlias("bpmRemindDef")
public class BpmRemindDef extends BaseTenantEntity {
	
	public static String GLOBAL_DEF_NAME="global_remind_";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 方案ID */
	@FieldDefine(title = "方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 50)
	protected String solId;
	
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 50)
	protected String actDefId="";
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 50)
	protected String nodeId;
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
	/* 相对节点 */
	@FieldDefine(title = "相对节点")
	@Column(name = "REL_NODE_")
	@Size(max = 50)
	protected String relNode;
	/* 事件 */
	@FieldDefine(title = "事件")
	@Column(name = "EVENT_")
	@Size(max = 50)
	protected String event;
	/**
	 * 日期类型 
	 * calendar :使用日历
	 * common   :不使用日历
	 */
	@FieldDefine(title = "日期类型")
	@Column(name = "DATE_TYPE_")
	@Size(max = 50)
	protected String dateType;
	/* 期限 */
	@FieldDefine(title = "期限")
	@Column(name = "EXPIRE_DATE_")
	protected String expireDate;
	
	@FieldDefine(title = "时间计算处理器")
	@Column(name = "TIME_LIMIT_HANDLER_")
	protected String timeLimitHandler="";
	/* 条件 */
	@FieldDefine(title = "条件")
	@Column(name = "CONDITION_")
	@Size(max = 1000)
	protected String condition;
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
	@FieldDefine(title = "开始发送消息时间点")
	@Column(name = "TIME_TO_SEND_")
	protected String timeToSend;
	/* 发送次数 */
	@FieldDefine(title = "发送次数")
	@Column(name = "SEND_TIMES_")
	protected Integer sendTimes;
	/* 发送时间间隔 */
	@FieldDefine(title = "发送时间间隔")
	@Column(name = "SEND_INTERVAL_")
	protected String sendInterval;
	@FieldDefine(title = "解决方案名")
	@Column(name = "SOLUTION_NAME_")
	protected String solutionName;
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	protected String nodeName;

	/**
	 * Default Empty Constructor for class BpmRemindDef
	 */
	public BpmRemindDef() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmRemindDef
	 */
	public BpmRemindDef(String in_id) {
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
	 * 到期动作 * @return String
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
	 * 相对节点 * @return String
	 */
	public String getRelNode() {
		return this.relNode;
	}

	/**
	 * 设置 相对节点
	 */
	public void setRelNode(String aValue) {
		this.relNode = aValue;
	}

	/**
	 * 事件 * @return String
	 */
	public String getEvent() {
		return this.event;
	}

	/**
	 * 设置 事件
	 */
	public void setEvent(String aValue) {
		this.event = aValue;
	}

	/**
	 * 日期类型 * @return String
	 */
	public String getDateType() {
		return this.dateType;
	}

	/**
	 * 设置 日期类型
	 */
	public void setDateType(String aValue) {
		this.dateType = aValue;
	}

	/**
	 * 期限 
	 * @return String
	 */
	public String getExpireDate() {
		return this.expireDate;
	}

	/**
	 * 设置 期限
	 */
	public void setExpireDate(String aValue) {
		this.expireDate = aValue;
	}

	/**
	 * 条件 * @return String
	 */
	public String getCondition() {
		return this.condition;
	}

	/**
	 * 设置 条件
	 */
	public void setCondition(String aValue) {
		this.condition = aValue;
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


	/**
	 * 开始发送消息时间点 * 
	 * @return String
	 */
	public String getTimeToSend() {
		return this.timeToSend;
	}

	/**
	 * 设置 开始发送消息时间点
	 */
	public void setTimeToSend(String aValue) {
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
	 * 发送时间间隔 * @return String
	 */
	public String getSendInterval() {
		return this.sendInterval;
	}

	/**
	 * 设置 发送时间间隔
	 */
	public void setSendInterval(String aValue) {
		this.sendInterval = aValue;
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

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	public String getTimeLimitHandler() {
		return timeLimitHandler;
	}

	public void setTimeLimitHandler(String timeLimitHandler) {
		this.timeLimitHandler = timeLimitHandler;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmRemindDef)) {
			return false;
		}
		BpmRemindDef rhs = (BpmRemindDef) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.solId, rhs.solId).append(this.nodeId, rhs.nodeId)
				.append(this.name, rhs.name).append(this.action, rhs.action).append(this.relNode, rhs.relNode)
				.append(this.event, rhs.event).append(this.dateType, rhs.dateType)
				.append(this.expireDate, rhs.expireDate).append(this.condition, rhs.condition)
				.append(this.script, rhs.script).append(this.notifyType, rhs.notifyType)
				
				.append(this.timeToSend, rhs.timeToSend).append(this.sendTimes, rhs.sendTimes)
				.append(this.sendInterval, rhs.sendInterval).append(this.tenantId, rhs.tenantId)
				.append(this.createTime, rhs.createTime).append(this.createBy, rhs.createBy)
				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.solId).append(this.nodeId)
				.append(this.name).append(this.action).append(this.relNode).append(this.event).append(this.dateType)
				.append(this.expireDate).append(this.condition).append(this.script).append(this.notifyType)
				.append(this.timeToSend).append(this.sendTimes)
				.append(this.sendInterval).append(this.tenantId).append(this.createTime).append(this.createBy)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("solId", this.solId).append("nodeId", this.nodeId)
				.append("name", this.name).append("action", this.action).append("relNode", this.relNode)
				.append("event", this.event).append("dateType", this.dateType).append("expireDate", this.expireDate)
				.append("condition", this.condition).append("script", this.script).append("notifyType", this.notifyType)
				.append("timeToSend", this.timeToSend).append("sendTimes", this.sendTimes)
				.append("sendInterval", this.sendInterval).append("tenantId", this.tenantId)
				.append("createTime", this.createTime).append("createBy", this.createBy)
				.append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
