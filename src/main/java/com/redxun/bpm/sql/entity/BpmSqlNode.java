package com.redxun.bpm.sql.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmSqlNode实体类定义
 * BPM_SQL_NODE中间表
 * @author cjx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * </pre>
 */
@Table(name = "BPM_SQL_NODE")
@TableDefine(title = "BPM_SQL_NODE中间表")
public class BpmSqlNode extends BaseTenantEntity {

	/**
	 * sql类型(自定义)
	 */
	public final static Integer SQL_TYPE_CUSTOM = 1;
	/**
	 * sql类型(流程数据映射到第三方物理表)
	 */
	public final static Integer SQL_TYPE_PH = 2;

	/* 解决方案ID */

	@FieldDefine(title = "业务流程方案定义")
	@ManyToOne
	@JoinColumn(name = "SOL_ID_")
	protected String  solId;

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "BPM_SQL_NODE_ID_")
	protected String bpmSqlNodeId;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 64)
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_TEXT_")
	@Size(max = 256)
	protected String nodeText;
	/* SQL语句 */
	@FieldDefine(title = "SQL语句")
	@Column(name = "SQL_")
	@Size(max = 65535)
	protected String sql;

	/* SQL类型 */
	@FieldDefine(title = "SQL类型")
	@Column(name = "SQL_TYPE_")
	protected Integer sqlType;
	/* 数据JSON */
	@FieldDefine(title = "数据JSON")
	@Column(name = "JSON_DATA_")
	@Size(max = 2147483647)
	protected String jsonData;

	/* 表数据JSON */
	@FieldDefine(title = "表数据JSON")
	@Column(name = "JSON_TABLE_")
	@Size(max = 2147483647)
	protected String jsonTable;

	/* 数据源ID */
	@FieldDefine(title = "数据源ID")
	@Column(name = "DS_ID_")
	@Size(max = 64)
	protected String dsId;
	/* 数据源名称 */
	@FieldDefine(title = "数据源名称")
	@Column(name = "DS_NAME_")
	@Size(max = 256)
	protected String dsName;

	/**
	 * Default Empty Constructor for class BpmSqlNode
	 */
	public BpmSqlNode() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSqlNode
	 */
	public BpmSqlNode(String in_bpmSqlNodeId) {
		this.setBpmSqlNodeId(in_bpmSqlNodeId);
	}

	/**
	 * 主键 * @return String
	 */
	public String getBpmSqlNodeId() {
		return this.bpmSqlNodeId;
	}

	/**
	 * 设置 主键
	 */
	public void setBpmSqlNodeId(String aValue) {
		this.bpmSqlNodeId = aValue;
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
	 * 节点名称 * @return String
	 */
	public String getNodeText() {
		return this.nodeText;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeText(String aValue) {
		this.nodeText = aValue;
	}

	/**
	 * SQL语句 * @return String
	 */
	public String getSql() {
		return this.sql;
	}

	/**
	 * 设置 SQL语句
	 */
	public void setSql(String aValue) {
		this.sql = aValue;
	}

	/**
	 * 数据源ID * @return String
	 */
	public String getDsId() {
		return this.dsId;
	}

	/**
	 * 设置 数据源ID
	 */
	public void setDsId(String aValue) {
		this.dsId = aValue;
	}

	/**
	 * 数据源名称 * @return String
	 */
	public String getDsName() {
		return this.dsName;
	}

	/**
	 * 设置 数据源名称
	 */
	public void setDsName(String aValue) {
		this.dsName = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.bpmSqlNodeId;
	}

	@Override
	public Serializable getPkId() {
		return this.bpmSqlNodeId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.bpmSqlNodeId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSqlNode)) {
			return false;
		}
		BpmSqlNode rhs = (BpmSqlNode) object;
		return new EqualsBuilder()
				.append(this.bpmSqlNodeId, rhs.bpmSqlNodeId)
				.append(this.nodeId, rhs.nodeId)
				.append(this.nodeText, rhs.nodeText)
				.append(this.sql, rhs.sql)
				.append(this.dsId, rhs.dsId)
				.append(this.dsName, rhs.dsName)
				.append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime)
				.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
				.append(this.bpmSqlNodeId)
				.append(this.nodeId)
				.append(this.nodeText)
				.append(this.sql)
				.append(this.dsId)
				.append(this.dsName)
				.append(this.tenantId)
				.append(this.createBy)
				.append(this.createTime)
				.append(this.updateBy)
				.append(this.updateTime)
				.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
				.append("bpmSqlNodeId", this.bpmSqlNodeId)
				.append("nodeId", this.nodeId)
				.append("nodeText", this.nodeText)
				.append("sql", this.sql)
				.append("dsId", this.dsId)
				.append("dsName", this.dsName)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime)
				.toString();
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
		this.solId=aValue;
	}

	

	public Integer getSqlType() {
		return sqlType;
	}

	public void setSqlType(Integer sqlType) {
		this.sqlType = sqlType;
	}

	public String getJsonData() {
		return jsonData;
	}

	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}

	public String getJsonTable() {
		return jsonTable;
	}

	public void setJsonTable(String jsonTable) {
		this.jsonTable = jsonTable;
	}

}
