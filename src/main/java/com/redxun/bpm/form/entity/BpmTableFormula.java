



package com.redxun.bpm.form.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：表间公式实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-08-07 09:06:53
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "表间公式")
public class BpmTableFormula extends BaseTenantEntity {

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "公式名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "公式描述")
	@Column(name = "DESCP_")
	protected String descp; 
	@FieldDefine(title = "数据填充配置")
	@Column(name = "FILL_CONF_")
	protected String fillConf; 
	@FieldDefine(title = "数据模板ID")
	@Column(name = "BO_DEF_ID_")
	protected String boDefId; 
	@FieldDefine(title = "表单触发时机")
	@Column(name = "ACTION_")
	protected String action; 
	@FieldDefine(title = "是否开启调试模式")
	@Column(name = "IS_TEST_")
	protected String isTest;



	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId;



	public BpmTableFormula() {
		
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmTableFormula(String in_id) {
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
	 * 返回 公式名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setDescp(String descp) {
		this.descp = descp;
	}
	
	/**
	 * 返回 公式描述
	 * @return
	 */
	public String getDescp() {
		return this.descp;
	}
	
	public void setFillConf(String fillConf) {
		this.fillConf = fillConf;
	}
	
	/**
	 * 返回 数据填充配置
	 * [{
			"isMain": true,
			"name": "out_stock",
			"comment": "主表-出库单",
			"settings": {
				"opDescp": "wwww",
				"dsName": "",
				"setting": [{
					"condition": "name==''",
					"tableName": "demofield",
					"operator": "new",
					"filterSql": "NAME='{cur.F_name}'",
					"gridData": [{
						"comment": "主键",
						"fieldName": "ID",
						"mapType": "field",
						"mapTypeName": "从字段获取",
						"mapValue": "name"
					}]
				}, {
					"condition": "",
					"tableName": "demofield",
					"operator": "upd",
					"filterSql": "ID='{cur.F_name}'",
					"gridData": [{
						"comment": "主键",
						"isPk": true,
						"fieldName": "ID",
						"mapType": "mainPkId",
						"mapTypeName": "主表主键字段"
					}]
				}]
			}
		}, {
			"name": "out_stock_item",
			"comment": "从表-出库单明细",
			"settings": {
				"opDescp": "demofield",
				"dsName": "",
				"setting": [{
					"condition": "",
					"tableName": "demofield",
					"operator": "new",
					"filterSql": "",
					"gridData": [{
						"comment": "主键",
						"fieldName": "ID",
						"mapType": "srcPkId",
						"mapTypeName": "原主键字段值"
					}]
				}]
			}
		}]
	 * @return
	 */
	public String getFillConf() {
		return this.fillConf;
	}
	
	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}
	
	/**
	 * 返回 数据模板ID
	 * @return
	 */
	public String getBoDefId() {
		return this.boDefId;
	}
	public void setAction(String action) {
		this.action = action;
	}
	
	/**
	 * 返回 表单触发时机
	 * @return
	 */
	public String getAction() {
		return this.action;
	}
	
	public void setIsTest(String isTest) {
		this.isTest = isTest;
	}
	
	/**
	 * 返回 是否开启调试模式
	 * @return
	 */
	public String getIsTest() {
		return this.isTest;
	}
	
	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmTableFormula)) {
			return false;
		}
		BpmTableFormula rhs = (BpmTableFormula) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.descp, rhs.descp) 
		.append(this.fillConf, rhs.fillConf) 
		.append(this.boDefId, rhs.boDefId) 
		.append(this.action, rhs.action) 
		.append(this.isTest, rhs.isTest) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.descp) 
		.append(this.fillConf) 
		.append(this.boDefId) 
		.append(this.action) 
		.append(this.isTest) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
			.append("name", this.name) 
			.append("descp", this.descp) 
			.append("fillConf", this.fillConf) 
			.append("boDefId", this.boDefId) 
			.append("action", this.action) 
			.append("isTest", this.isTest) 
			.toString();
	}


	/**
	 * 分类Id * @return String
	 */
	public String getTreeId() {
		return this.treeId;
	}

	/**
	 * 设置 分类Id
	 */
	public void setTreeId(String aValue) {
		this.treeId=aValue;
	}
}



