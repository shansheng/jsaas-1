



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
 * 描述：SYS_ES_LIST实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-01-19 15:01:59
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "SYS_ES_LIST")
public class SysEsList extends BaseTenantEntity {

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
	@FieldDefine(title = "主键字段")
	@Column(name = "ID_FIELD_")
	protected String idField; 
	@FieldDefine(title = "查询类型")
	@Column(name = "QUERY_TYPE_")
	protected Integer queryType; 
	@FieldDefine(title = "索引")
	@Column(name = "ES_TABLE_")
	protected String esTable; 
	@FieldDefine(title = "查询语句")
	@Column(name = "QUERY_")
	protected String query; 
	@FieldDefine(title = "返回字段")
	@Column(name = "RETURN_FIELDS_")
	protected String returnFields; 
	@FieldDefine(title = "条件字段")
	@Column(name = "CONDITION_FIELDS_")
	protected String conditionFields; 
	@FieldDefine(title = "排序字段")
	@Column(name = "SORT_FIELDS_")
	protected String sortFields; 
	@FieldDefine(title = "是否分页")
	@Column(name = "IS_PAGE")
	protected Integer isPage; 
	@FieldDefine(title = "HTML模板")
	@Column(name = "LIST_HTML_")
	protected String listHtml; 
	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId; 
	
	
	
	
	
	public SysEsList() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysEsList(String in_id) {
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
	public void setIdField(String idField) {
		this.idField = idField;
	}
	
	/**
	 * 返回 主键字段
	 * @return
	 */
	public String getIdField() {
		return this.idField;
	}
	public void setQueryType(Integer queryType) {
		this.queryType = queryType;
	}
	
	/**
	 * 返回 查询类型
	 * @return
	 */
	public Integer getQueryType() {
		return this.queryType;
	}
	public void setEsTable(String esTable) {
		this.esTable = esTable;
	}
	
	/**
	 * 返回 索引
	 * @return
	 */
	public String getEsTable() {
		return this.esTable;
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
	 * 返回 返回字段
	 * @return
	 */
	public String getReturnFields() {
		return this.returnFields;
	}
	public void setConditionFields(String conditionFields) {
		this.conditionFields = conditionFields;
	}
	
	/**
	 * 返回 条件字段
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
	public void setIsPage(Integer isPage) {
		this.isPage = isPage;
	}
	
	/**
	 * 返回 是否分页
	 * @return
	 */
	public Integer getIsPage() {
		return this.isPage;
	}
	public void setListHtml(String listHtml) {
		this.listHtml = listHtml;
	}
	
	/**
	 * 返回 HTML模板
	 * @return
	 */
	public String getListHtml() {
		return this.listHtml;
	}
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}
	
	/**
	 * 返回 分类ID
	 * @return
	 */
	public String getTreeId() {
		return this.treeId;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysEsList)) {
			return false;
		}
		SysEsList rhs = (SysEsList) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.alias, rhs.alias) 
		.append(this.idField, rhs.idField) 
		.append(this.queryType, rhs.queryType) 
		.append(this.esTable, rhs.esTable) 
		.append(this.query, rhs.query) 
		.append(this.returnFields, rhs.returnFields) 
		.append(this.conditionFields, rhs.conditionFields) 
		.append(this.sortFields, rhs.sortFields) 
		.append(this.isPage, rhs.isPage) 
		.append(this.listHtml, rhs.listHtml) 
		.append(this.treeId, rhs.treeId) 
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
		.append(this.idField) 
		.append(this.queryType) 
		.append(this.esTable) 
		.append(this.query) 
		.append(this.returnFields) 
		.append(this.conditionFields) 
		.append(this.sortFields) 
		.append(this.isPage) 
		.append(this.listHtml) 
		.append(this.treeId) 
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
				.append("idField", this.idField) 
				.append("queryType", this.queryType) 
				.append("esTable", this.esTable) 
				.append("query", this.query) 
				.append("returnFields", this.returnFields) 
				.append("conditionFields", this.conditionFields) 
				.append("sortFields", this.sortFields) 
				.append("isPage", this.isPage) 
				.append("listHtml", this.listHtml) 
				.append("treeId", this.treeId) 
												.toString();
	}

}



