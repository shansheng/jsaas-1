



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 *  
 * 描述：流程跳转规则实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-04-10 13:44:42
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "BPM_JUMP_RULE")
@TableDefine(title = "流程跳转规则")
@JsonIgnoreProperties(value={"bpmSolution"})
@XStreamAlias("bpmJumpRule")
public class BpmJumpRule extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "规则名")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	protected String solId; 
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACTDEF_ID_")
	protected String actdefId; 
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "源节点名称")
	@Column(name = "NODE_NAME_")
	protected String nodeName; 
	@FieldDefine(title = "目标节点")
	@Column(name = "TARGET_")
	protected String target; 
	@FieldDefine(title = "目标节点名称")
	@Column(name = "TARGET_NAME_")
	protected String targetName; 
	@FieldDefine(title = "RULE_")
	@Column(name = "RULE_")
	protected String rule; 
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn; 
	@FieldDefine(title = "规则类型(0,配置,1,脚本)")
	@Column(name = "TYPE_")
	protected Integer type; 
	@FieldDefine(title = "描述")
	@Column(name = "DESCRIPTION_")
	protected String description; 
	
	
	
	
	public BpmJumpRule() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmJumpRule(String in_id) {
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
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 规则名
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setSolId(String solId) {
		this.solId = solId;
	}
	
	/**
	 * 返回 解决方案ID
	 * @return
	 */
	public String getSolId() {
		return this.solId;
	}
	public void setActdefId(String actdefId) {
		this.actdefId = actdefId;
	}
	
	/**
	 * 返回 流程定义ID
	 * @return
	 */
	public String getActdefId() {
		return this.actdefId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	/**
	 * 返回 节点ID
	 * @return
	 */
	public String getNodeId() {
		return this.nodeId;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	
	/**
	 * 返回 源节点名称
	 * @return
	 */
	public String getNodeName() {
		return this.nodeName;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	
	/**
	 * 返回 目标节点
	 * @return
	 */
	public String getTarget() {
		return this.target;
	}
	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
	
	/**
	 * 返回 目标节点名称
	 * @return
	 */
	public String getTargetName() {
		return this.targetName;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	
	/**
	 * 返回 RULE_
	 * @return
	 */
	public String getRule() {
		return this.rule;
	}
	public void setSn(Integer sn) {
		this.sn = sn;
	}
	
	/**
	 * 返回 序号
	 * @return
	 */
	public Integer getSn() {
		return this.sn;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	/**
	 * 返回 规则类型(0,配置,1,脚本)
	 * @return
	 */
	public Integer getType() {
		return this.type;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getDescription() {
		return this.description;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmJumpRule)) {
			return false;
		}
		BpmJumpRule rhs = (BpmJumpRule) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.solId, rhs.solId) 
		.append(this.actdefId, rhs.actdefId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.nodeName, rhs.nodeName) 
		.append(this.target, rhs.target) 
		.append(this.targetName, rhs.targetName) 
		.append(this.rule, rhs.rule) 
		.append(this.sn, rhs.sn) 
		.append(this.type, rhs.type) 
		.append(this.description, rhs.description) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.solId) 
		.append(this.actdefId) 
		.append(this.nodeId) 
		.append(this.nodeName) 
		.append(this.target) 
		.append(this.targetName) 
		.append(this.rule) 
		.append(this.sn) 
		.append(this.type) 
		.append(this.description) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("solId", this.solId) 
				.append("actdefId", this.actdefId) 
				.append("nodeId", this.nodeId) 
				.append("nodeName", this.nodeName) 
				.append("target", this.target) 
				.append("targetName", this.targetName) 
				.append("rule", this.rule) 
				.append("sn", this.sn) 
				.append("type", this.type) 
				.append("description", this.description) 
												.toString();
	}

}



