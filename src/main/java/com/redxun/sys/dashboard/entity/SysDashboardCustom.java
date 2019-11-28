package com.redxun.sys.dashboard.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

@Entity
@Table(name = "SYS_DASHBOARD_CUSTOM")
@TableDefine(title = "自定义大屏管理")
public class SysDashboardCustom extends BaseTenantEntity {
	private static final long serialVersionUID = 1L;
	
	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;
	
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name;
	
	@FieldDefine(title = "标识或别名")
	@Column(name = "KEY_")
	protected String key;
	
	@FieldDefine(title = "所属树ID")
	@Column(name = "TREE_ID_")
	protected String treeId;
	
	@FieldDefine(title = "展示布局HTML")
	@Column(name = "LAYOUT_HTML_")
	protected String layoutHtml;
	
	@FieldDefine(title = "编辑布局HTML")
	@Column(name = "EDIT_HTML_")
	protected String editHtml;
	
	@FieldDefine(title = "过滤条件的JSON字符串")
	@Column(name = "QUERYFILTER_JSONSTR_")
	protected String queryFilterJsonStr;
	
	public SysDashboardCustom() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getTreeId() {
		return treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public String getLayoutHtml() {
		return layoutHtml;
	}

	public void setLayoutHtml(String layoutHtml) {
		this.layoutHtml = layoutHtml;
	}

	public String getEditHtml() {
		return editHtml;
	}

	public void setEditHtml(String editHtml) {
		this.editHtml = editHtml;
	}

	public String getQueryFilterJsonStr() {
		return queryFilterJsonStr;
	}

	public void setQueryFilterJsonStr(String queryFilterJsonStr) {
		this.queryFilterJsonStr = queryFilterJsonStr;
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
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysDashboardCustom)) {
			return false;
		}
		SysDashboardCustom rhs = (SysDashboardCustom) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.name, rhs.name).append(this.key, rhs.key)
				.append(this.treeId, rhs.treeId).append(this.layoutHtml, rhs.layoutHtml).append(this.editHtml, rhs.editHtml)
				.append(this.queryFilterJsonStr, rhs.queryFilterJsonStr).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.name).append(this.key)
				.append(this.treeId).append(this.layoutHtml).append(this.editHtml).append(this.queryFilterJsonStr).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("name", this.name).append("key", this.key)
				.append("treeId", this.treeId).append("layoutHtml", this.layoutHtml).append("editHtml", this.editHtml)
				.append("queryFilterJsonStr", this.queryFilterJsonStr).toString();
	}
}
