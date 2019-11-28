



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
 * 描述：复合表单实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-05-20 22:45:57
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "复合表单")
public class BpmFormCmp extends BaseTenantEntity {

	@FieldDefine(title = "CMP_ID_")
	@Id
	@Column(name = "CMP_ID_")
	protected String cmpId;

	@FieldDefine(title = "VIEW_ID_")
	@Column(name = "VIEW_ID_")
	protected String viewId; 
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	protected String parentId; 
	@FieldDefine(title = "属性名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "属性Key")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "关联属性表单名")
	@Column(name = "ATT_FM_NAME_")
	protected String attFmName; 
	@FieldDefine(title = "关联属性表单别名")
	@Column(name = "ATT_FM_ALIAS_")
	protected String attFmAlias; 
	@FieldDefine(title = "BO实体定义ID")
	@Column(name = "BODEF_ID_")
	protected String bodefId; 
	@FieldDefine(title = "ONE_ONE=一对一")
	@Column(name = "REF_TYPE_")
	protected String refType; 
	@FieldDefine(title = "列表方案名称")
	@Column(name = "BO_LIST_NAME_")
	protected String boListName; 
	@FieldDefine(title = "列表方案别名")
	@Column(name = "BO_LIST_ALIAS_")
	protected String boListAlias; 
	@FieldDefine(title = "路径")
	@Column(name = "PATH_")
	protected String path; 
	@FieldDefine(title = "映射类型")
	@Column(name = "MAP_TYPE_")
	protected String mapType; 
	@FieldDefine(title = "数据源")
	@Column(name = "DBSOURCE_")
	protected String dbsource; 
	@FieldDefine(title = "SQL")
	@Column(name = "SQL_")
	protected String sql; 
	@FieldDefine(title = "URL")
	@Column(name = "URL_")
	protected String url; 
	@FieldDefine(title = "数据绑定配置")
	@Column(name = "BIND_CONFS_")
	protected String bindConfs; 
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn; 
	@FieldDefine(title = "显示方式")
	@Column(name = "SHOW_TYPE_")
	protected String showType; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	protected String status; 

	public BpmFormCmp() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmFormCmp(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.cmpId;
	}

	@Override
	public Serializable getPkId() {
		return this.cmpId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.cmpId = (String) pkId;
	}

	public String getCmpId() {
		return cmpId;
	}

	public void setCmpId(String cmpId) {
		this.cmpId = cmpId;
	}

	public void setViewId(String viewId) {
		this.viewId = viewId;
	}
	
	/**
	 * 返回 VIEW_ID_
	 * @return
	 */
	public String getViewId() {
		return this.viewId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	/**
	 * 返回 父ID
	 * @return
	 */
	public String getParentId() {
		return this.parentId;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 属性名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 属性Key
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	public void setAttFmName(String attFmName) {
		this.attFmName = attFmName;
	}
	
	/**
	 * 返回 关联属性表单名
	 * @return
	 */
	public String getAttFmName() {
		return this.attFmName;
	}
	public void setAttFmAlias(String attFmAlias) {
		this.attFmAlias = attFmAlias;
	}
	
	/**
	 * 返回 关联属性表单别名
	 * @return
	 */
	public String getAttFmAlias() {
		return this.attFmAlias;
	}
	public void setBodefId(String bodefId) {
		this.bodefId = bodefId;
	}
	
	/**
	 * 返回 BO实体定义ID
	 * @return
	 */
	public String getBodefId() {
		return this.bodefId;
	}
	public void setRefType(String refType) {
		this.refType = refType;
	}
	
	/**
	 * 返回 ONE_ONE=一对一
	 * @return
	 */
	public String getRefType() {
		return this.refType;
	}
	public void setBoListName(String boListName) {
		this.boListName = boListName;
	}
	
	/**
	 * 返回 列表方案名称
	 * @return
	 */
	public String getBoListName() {
		return this.boListName;
	}
	public void setBoListAlias(String boListAlias) {
		this.boListAlias = boListAlias;
	}
	
	/**
	 * 返回 列表方案别名
	 * @return
	 */
	public String getBoListAlias() {
		return this.boListAlias;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	/**
	 * 返回 路径
	 * @return
	 */
	public String getPath() {
		return this.path;
	}
	public void setMapType(String mapType) {
		this.mapType = mapType;
	}
	
	/**
	 * 返回 映射类型
	 * @return
	 */
	public String getMapType() {
		return this.mapType;
	}
	public void setDbsource(String dbsource) {
		this.dbsource = dbsource;
	}
	
	/**
	 * 返回 数据源
	 * @return
	 */
	public String getDbsource() {
		return this.dbsource;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	
	/**
	 * 返回 SQL
	 * @return
	 */
	public String getSql() {
		return this.sql;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * 返回 URL
	 * @return
	 */
	public String getUrl() {
		return this.url;
	}
	public void setBindConfs(String bindConfs) {
		this.bindConfs = bindConfs;
	}
	
	/**
	 * 返回 数据绑定配置
	 * @return
	 */
	public String getBindConfs() {
		return this.bindConfs;
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
	public void setShowType(String showType) {
		this.showType = showType;
	}
	
	/**
	 * 返回 显示方式
	 * @return
	 */
	public String getShowType() {
		return this.showType;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormCmp)) {
			return false;
		}
		BpmFormCmp rhs = (BpmFormCmp) object;
		return new EqualsBuilder()
		.append(this.cmpId, rhs.cmpId) 
		.append(this.viewId, rhs.viewId) 
		.append(this.parentId, rhs.parentId) 
		.append(this.name, rhs.name) 
		.append(this.key, rhs.key) 
		.append(this.attFmName, rhs.attFmName) 
		.append(this.attFmAlias, rhs.attFmAlias) 
		.append(this.bodefId, rhs.bodefId) 
		.append(this.refType, rhs.refType) 
		.append(this.boListName, rhs.boListName) 
		.append(this.boListAlias, rhs.boListAlias) 
		.append(this.path, rhs.path) 
		.append(this.mapType, rhs.mapType) 
		.append(this.dbsource, rhs.dbsource) 
		.append(this.sql, rhs.sql) 
		.append(this.url, rhs.url) 
		.append(this.bindConfs, rhs.bindConfs) 
		.append(this.sn, rhs.sn) 
		.append(this.showType, rhs.showType) 
		.append(this.status, rhs.status) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.cmpId) 
		.append(this.viewId) 
		.append(this.parentId) 
		.append(this.name) 
		.append(this.key) 
		.append(this.attFmName) 
		.append(this.attFmAlias) 
		.append(this.bodefId) 
		.append(this.refType) 
		.append(this.boListName) 
		.append(this.boListAlias) 
		.append(this.path) 
		.append(this.mapType) 
		.append(this.dbsource) 
		.append(this.sql) 
		.append(this.url) 
		.append(this.bindConfs) 
		.append(this.sn) 
		.append(this.showType) 
		.append(this.status) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("cmpId", this.cmpId) 
				.append("viewId", this.viewId) 
				.append("parentId", this.parentId) 
				.append("name", this.name) 
				.append("key", this.key) 
				.append("attFmName", this.attFmName) 
				.append("attFmAlias", this.attFmAlias) 
				.append("bodefId", this.bodefId) 
				.append("refType", this.refType) 
				.append("boListName", this.boListName) 
				.append("boListAlias", this.boListAlias) 
				.append("path", this.path) 
				.append("mapType", this.mapType) 
				.append("dbsource", this.dbsource) 
				.append("sql", this.sql) 
				.append("url", this.url) 
				.append("bindConfs", this.bindConfs) 
				.append("sn", this.sn) 
				.append("showType", this.showType) 
				.append("status", this.status) 
												.toString();
	}

}



