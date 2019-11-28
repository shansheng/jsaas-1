package com.redxun.sys.echarts.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

@Entity
@Table(name = "SYS_ECHARTS_CUSTOM")
@TableDefine(title = "自定义查询")
@XStreamAlias("sysEchartsCustom")
public class SysEchartsCustom extends BaseTenantEntity {

	private static final long serialVersionUID = 1L;

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名字")
	@Column(name = "NAME_")
	protected String name;

	@FieldDefine(title = "标识或别名")
	@Column(name = "KEY_")
	protected String key;

	@FieldDefine(title = "图表类型")
	@Column(name = "ECHARTS_TYPE_")
	protected String echartsType;

	@FieldDefine(title = "标题字段的json")
	@Column(name = "TITLE_FIELD_")
	protected String titleField;

	@FieldDefine(title = "图例字段的json")
	@Column(name = "LEGEND_FIELD_")
	protected String legendField;

	@FieldDefine(title = "grid字段的json")
	@Column(name = "GRID_FIELD_")
	protected String gridField;

	@FieldDefine(title = "x轴字段的json")
	@Column(name = "XAXIS_FIELD_")
	protected String xAxisField;

	@FieldDefine(title = "x轴字段data的json")
	@Column(name = "XAXIS_DATA_FIELD_")
	protected String xAxisDataField;

	@FieldDefine(title = "x轴y轴转换")
	@Column(name = "XY_CONVERT_")
	protected Integer xyConvert;

	@FieldDefine(title = "数据字段json")
	@Column(name = "DATA_FIELD_")
	protected String dataField;

	@FieldDefine(title = "系列列表字段定义")
	@Column(name = "SERIES_FIELD_")
	protected String seriesField;

	@FieldDefine(title = "数据的使用方式 - 为饼图配置")
	@Column(name = "DETAIL_METHOD_")
	protected Integer detailMethod;

	@FieldDefine(title = "条件字段定义")
	@Column(name = "WHERE_FIELD_")
	protected String whereField;

	@FieldDefine(title = "排序字段")
	@Column(name = "ORDER_FIELD_")
	protected String orderField;

	@FieldDefine(title = "数据源的别名")
	@Column(name = "DS_ALIAS_")
	protected String dsAlias;

	@FieldDefine(title = "是否数据库表0:视图,1:数据库表")
	@Column(name = "TABLE_")
	protected Integer table;

	@FieldDefine(title = "SQL")
	@Column(name = "SQL_")
	protected String sql = "";

	@FieldDefine(title = "SQL构建类型")
	@Column(name = "SQL_BUILD_TYPE_")
	protected String sqlBuildType;

	@FieldDefine(title = "下钻key")
	@Column(name = "DRILL_DOWN_KEY_")
	protected String drillDownKey;

	@FieldDefine(title = "下钻字段定义")
	@Column(name = "DRILL_DOWN_FIELD_")
	protected String drillDownField;

	@FieldDefine(title = "主题")
	@Column(name = "THEME_")
	protected String theme;

	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId;

	@FieldDefine(title = "缩放区域")
	@Column(name = "DATA_ZOOM_")
	protected String dataZoom;

	public SysEchartsCustom() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysEchartsCustom(String in_id) {
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
	 * 返回 名字
	 * 
	 * @return
	 */
	public String getName() {
		return this.name;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getEchartsType() {
		return echartsType;
	}

	public void setEchartsType(String echartsType) {
		this.echartsType = echartsType;
	}

	/**
	 * 返回 标识或别名
	 * 
	 * @return
	 */
	public String getKey() {
		return this.key;
	}

	public String getTitleField() {
		return titleField;
	}

	public void setTitleField(String titleField) {
		this.titleField = titleField;
	}

	public String getLegendField() {
		return legendField;
	}

	public void setLegendField(String legendField) {
		this.legendField = legendField;
	}

	public String getxAxisField() {
		return xAxisField;
	}

	public void setxAxisField(String xAxisField) {
		this.xAxisField = xAxisField;
	}

	public String getxAxisDataField() {
		return xAxisDataField;
	}

	public void setxAxisDataField(String xAxisDataField) {
		this.xAxisDataField = xAxisDataField;
	}

	public Integer getXyConvert() {
		return xyConvert;
	}

	public void setXyConvert(Integer xyConvert) {
		this.xyConvert = xyConvert;
	}

	public String getDataField() {
		return dataField;
	}

	public void setDataField(String dataField) {
		this.dataField = dataField;
	}

	public String getSeriesField() {
		return seriesField;
	}

	public void setSeriesField(String seriesField) {
		this.seriesField = seriesField;
	}

	public Integer getDetailMethod() {
		return detailMethod;
	}

	public void setDetailMethod(Integer detailMethod) {
		this.detailMethod = detailMethod;
	}

	public String getWhereField() {
		return whereField;
	}

	public void setWhereField(String whereField) {
		this.whereField = whereField;
	}

	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}

	/**
	 * 返回 排序字段
	 * 
	 * @return
	 */
	public String getOrderField() {
		return this.orderField;
	}

	public void setDsAlias(String dsAlias) {
		this.dsAlias = dsAlias;
	}

	/**
	 * 返回 数据源的别名
	 * 
	 * @return
	 */
	public String getDsAlias() {
		return this.dsAlias;
	}

	public void setTable(Integer table) {
		this.table = table;
	}

	/**
	 * 返回 是否数据库表0:视图,1:数据库表
	 * 
	 * @return
	 */
	public Integer getTable() {
		return this.table;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public void setSqlBuildType(String sqlBuildType) {
		this.sqlBuildType = sqlBuildType;
	}

	public String getGridField() {
		return gridField;
	}

	public void setGridField(String gridField) {
		this.gridField = gridField;
	}

	/**
	 * 返回 SQL构建类型
	 * 
	 * @return
	 */
	public String getSqlBuildType() {
		return this.sqlBuildType;
	}

	public String getDrillDownKey() {
		return drillDownKey;
	}

	public void setDrillDownKey(String drillDownKey) {
		this.drillDownKey = drillDownKey;
	}

	public String getDrillDownField() {
		return drillDownField;
	}

	public void setDrillDownField(String drillDownField) {
		this.drillDownField = drillDownField;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
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

	public String getDataZoom() {
		return dataZoom;
	}

	public void setDataZoom(String dataZoom) {
		this.dataZoom = dataZoom;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysEchartsCustom)) {
			return false;
		}
		SysEchartsCustom rhs = (SysEchartsCustom) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.name, rhs.name).append(this.key, rhs.key).append(this.echartsType, rhs.echartsType).append(this.titleField, rhs.titleField).append(this.legendField, rhs.legendField)
				.append(this.gridField, rhs.gridField).append(this.xAxisField, rhs.xAxisField).append(this.xAxisDataField, rhs.xAxisDataField).append(this.xyConvert, rhs.xyConvert).append(this.dataField, rhs.dataField)
				.append(this.seriesField, rhs.seriesField).append(this.detailMethod, rhs.detailMethod).append(this.orderField, rhs.orderField).append(this.dsAlias, rhs.dsAlias).append(this.table, rhs.table)
				.append(this.sqlBuildType, rhs.sqlBuildType).append(this.drillDownKey, rhs.drillDownKey).append(this.treeId, rhs.treeId).append(this.drillDownField, rhs.drillDownField).append(this.theme, rhs.theme).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.name).append(this.key).append(this.echartsType).append(this.titleField).append(this.legendField).append(this.gridField).append(this.xAxisField)
				.append(this.xAxisDataField).append(this.xyConvert).append(this.dataField).append(this.seriesField).append(this.detailMethod).append(this.orderField).append(this.dsAlias).append(this.table).append(this.sqlBuildType)
				.append(this.drillDownKey).append(this.treeId).append(this.drillDownField).append(this.theme).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("name", this.name).append("key", this.key).append("echartsType", this.echartsType).append("titleField", this.titleField).append("legendField", this.legendField)
				.append("gridField", this.gridField).append("xAxisField", this.xAxisField).append("xAxisDataField", this.xAxisDataField).append("xyConvert", this.xyConvert).append("dataField", this.dataField)
				.append("seriesField", this.seriesField).append("detailMethod", this.detailMethod).append("orderField", this.orderField).append("dsAlias", this.dsAlias).append("table", this.table).append("sqlBuildType", this.sqlBuildType)
				.append("drillDownKey", this.drillDownKey).append("drillDownField", this.drillDownField).append("theme", this.theme).append("treeId", this.treeId).append("dataZoom", this.dataZoom).toString();
	}
}
