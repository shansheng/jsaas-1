



package com.redxun.sys.core.entity;

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
 * 描述：ES自定义查询实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-28 14:21:52
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "ES自定义查询")
public class SysEsQuery extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "别名")
	@Column(name = "ALIAS_")
	protected String alias; 
	@FieldDefine(title = "查询类型 1.索引,2.编写SQL语句")
	@Column(name = "QUERY_TYPE_")
	protected Integer queryType; 
	@FieldDefine(title = "索引")
	@Column(name = "ES_TABLE_")
	protected String esTable; 
	@FieldDefine(title = "查询语句")
	@Column(name = "QUERY_")
	protected String query; 
	@FieldDefine(title = "定义返回字段")
	@Column(name = "RETURN_FIELDS_")
	protected String returnFields; 
	@FieldDefine(title = "条件字段定义")
	@Column(name = "CONDITION_FIELDS_")
	protected String conditionFields; 
	@FieldDefine(title = "排序字段")
	@Column(name = "SORT_FIELDS_")
	protected String sortFields; 
	@FieldDefine(title = "是否分页")
	@Column(name = "NEED_PAGE_")
	protected Integer needPage; 
	@FieldDefine(title = "是否分页")
	@Column(name = "PAGE_SIZE_")
	protected Integer pageSize; 
	
	
	
	
	
	public SysEsQuery() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysEsQuery(String in_id) {
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
	 * 返回 名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	/**
	 * 返回 别名
	 * @return
	 */
	public String getAlias() {
		return this.alias;
	}
	public void setQueryType(Integer queryType) {
		this.queryType = queryType;
	}
	
	/**
	 * 返回 查询类型 1.索引,2.编写SQL语句
	 * @return
	 */
	public Integer getQueryType() {
		return this.queryType;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	
	/**
	 * 返回 查询语句
	 * @return
	 */
	public String getQuery() {
		return this.query;
	}
	public void setReturnFields(String returnFields) {
		this.returnFields = returnFields;
	}
	
	/**
	 * 返回 定义返回字段
	 * @return
	 */
	public String getReturnFields() {
		return this.returnFields;
	}
	public void setConditionFields(String conditionFields) {
		this.conditionFields = conditionFields;
	}
	
	/**
	 * 返回 条件字段定义
	 * @return
	 */
	public String getConditionFields() {
		return this.conditionFields;
	}
	public void setSortFields(String sortFields) {
		this.sortFields = sortFields;
	}
	
	/**
	 * 返回 排序字段
	 * @return
	 */
	public String getSortFields() {
		return this.sortFields;
	}
	public void setNeedPage(Integer needPage) {
		this.needPage = needPage;
	}
	
	/**
	 * 返回 是否分页
	 * @return
	 */
	public Integer getNeedPage() {
		return this.needPage;
	}
		

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	

	public String getEsTable() {
		return esTable;
	}

	public void setEsTable(String esTable) {
		this.esTable = esTable;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysEsQuery)) {
			return false;
		}
		SysEsQuery rhs = (SysEsQuery) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.alias, rhs.alias) 
		.append(this.queryType, rhs.queryType) 
		.append(this.query, rhs.query) 
		.append(this.returnFields, rhs.returnFields) 
		.append(this.conditionFields, rhs.conditionFields) 
		.append(this.sortFields, rhs.sortFields) 
		.append(this.needPage, rhs.needPage) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.alias) 
		.append(this.queryType) 
		.append(this.query) 
		.append(this.returnFields) 
		.append(this.conditionFields) 
		.append(this.sortFields) 
		.append(this.needPage) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("alias", this.alias) 
				.append("queryType", this.queryType) 
				.append("query", this.query) 
				.append("returnFields", this.returnFields) 
				.append("conditionFields", this.conditionFields) 
				.append("sortFields", this.sortFields) 
				.append("needPage", this.needPage) 
												.toString();
	}

}



