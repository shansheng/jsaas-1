package com.redxun.oa.info.entity;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：ins_column_def实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2017-08-16 11:39:47
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ins_column_def")
@TableDefine(title = "ins_column_def")
@XStreamAlias("insColumnDef")
public class InsColumnDef extends BaseTenantEntity {

	@FieldDefine(title = "COL_ID_")
	@Id
	@Column(name = "COL_ID_")
	protected String colId;

	@FieldDefine(title = "NAME_")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "KEY_")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "DATA_URL_")
	@Column(name = "DATA_URL_")
	protected String dataUrl; 
	@FieldDefine(title = "IS_DEFAULT_")
	@Column(name = "IS_DEFAULT_")
	protected String isDefault; 
	@FieldDefine(title = "TEMPLET_")
	@Column(name = "TEMPLET_")
	protected String templet; 
	@FieldDefine(title = "FUNCTION_")
	@Column(name = "FUNCTION_")
	protected String function;
	@FieldDefine(title = "是否是新闻公告")
	@Column(name = "IS_NEWS_")
	protected String isNews;
	
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	protected String type;
	@FieldDefine(title = "tab标签组")
	@Column(name = "TABGROUPS_")
	protected String tabGroups;
	
	@FieldDefine(title = "是否是公共")
	@Column(name = "IS_PUBLIC_")
	protected String isPublic;

	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId;

	@FieldDefine(title = "新闻类型")
	@Column(name = "NEW_TYPE_")
	protected String newType;

	/**
	 * append by Louis
	 */
	@FieldDefine(title = "是否自定义移动栏目")
	@Column(name = "IS_MOBILE_")
	protected String isMobile;
	
	@Transient
	protected int count;


	public String getNewType() {
		return newType;
	}

	public void setNewType(String newType) {
		this.newType = newType;
	}


	@Transient
	protected List<SysEchartsCustom> chartList = new ArrayList<>();

	@Transient
	protected List<SysSqlCustomQuery> customQueryList = new ArrayList<>();

	@Transient
	protected List<InsColumnDef> tabColumnList = new ArrayList<>();

	public int getCount() {
		return count;
	}
	
	public void setCount(int count) {
		this.count = count;
	}

	public List<SysEchartsCustom> getChartList() {
		return chartList;
	}

	public void setChartList(List<SysEchartsCustom> chartList) {
		this.chartList = chartList;
	}

	public List<SysSqlCustomQuery> getCustomQueryList() {
		return customQueryList;
	}

	public void setCustomQueryList(List<SysSqlCustomQuery> customQueryList) {
		this.customQueryList = customQueryList;
	}

	public List<InsColumnDef> getTabColumnList() {
		return tabColumnList;
	}

	public void setTabColumnList(List<InsColumnDef> tabColumnList) {
		this.tabColumnList = tabColumnList;
	}

	public InsColumnDef() {
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getTabGroups() {
		return tabGroups;
	}

	public void setTabGroups(String tabGroups) {
		this.tabGroups = tabGroups;
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public InsColumnDef(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.colId;
	}

	@Override
	public Serializable getPkId() {
		return this.colId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.colId = (String) pkId;
	}
	
	public String getColId() {
		return this.colId;
	}

	
	public void setColId(String aValue) {
		this.colId = aValue;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 NAME_
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 KEY_
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	public void setDataUrl(String dataUrl) {
		this.dataUrl = dataUrl;
	}
	
	/**
	 * 返回 DATA_URL_
	 * @return
	 */
	public String getDataUrl() {
		return this.dataUrl;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	
	/**
	 * 返回 IS_DEFAULT_
	 * @return
	 */
	public String getIsDefault() {
		return this.isDefault;
	}
	public void setTemplet(String templet) {
		this.templet = templet;
	}
	
	/**
	 * 返回 TEMPLET_
	 * @return
	 */
	public String getTemplet() {
		return this.templet;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	
	/**
	 * 返回 FUNCTION_
	 * @return
	 */
	public String getFunction() {
		return this.function;
	}


	/**
	 * 分类ID * @return String
	 */
	public String getTreeId() {
		return treeId;
	}

	/**
	 * 设置 分类ID
	 */
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public String getIsNews() {
		return isNews;
	}

	public void setIsNews(String isNews) {
		this.isNews = isNews;
	}
	
	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}

public void addChart(SysEchartsCustom chart){
		this.chartList.add(chart);
	}

	public void addTabColumn(List<InsColumnDef> columnDefList) {
		this.tabColumnList.addAll(columnDefList);
	}

	public void addCustomQuery(SysSqlCustomQuery customQuery) {
		this.customQueryList.add(customQuery);
	}
public void setIsMobile(String isMobile) {
		this.isMobile = isMobile;
	}public String getIsMobile() {
		return this.isMobile;
	}	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof InsColumnDef)) {
			return false;
		}
		InsColumnDef rhs = (InsColumnDef) object;
		return new EqualsBuilder()
		.append(this.colId, rhs.colId) 
		.append(this.name, rhs.name) 
		.append(this.key, rhs.key) 
		.append(this.dataUrl, rhs.dataUrl) 
		.append(this.isDefault, rhs.isDefault) 
		.append(this.templet, rhs.templet) 
		.append(this.function, rhs.function) 
		.append(this.treeId, rhs.treeId)
		.append(this.isMobile, rhs.isMobile)
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.colId) 
		.append(this.name) 
		.append(this.key) 
		.append(this.dataUrl) 
		.append(this.isDefault) 
		.append(this.templet) 
		.append(this.function) 
		.append(this.treeId)
		.append(this.isMobile)
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("colId", this.colId) 
				.append("name", this.name) 
				.append("key", this.key) 
				.append("dataUrl", this.dataUrl) 
				.append("isDefault", this.isDefault) 
				.append("templet", this.templet) 
				.append("treeId", this.treeId)
				.append("function", this.function)
				.append("isMobile", this.isMobile).toString();
	}

}



