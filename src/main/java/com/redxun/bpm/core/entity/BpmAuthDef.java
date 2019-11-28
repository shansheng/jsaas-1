package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
 *  
 * 描述：BpmAuthDef实体类定义
 * 授权流程定义
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_AUTH_DEF")
@TableDefine(title = "授权流程定义")
public class BpmAuthDef extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 设定ID */
	@FieldDefine(title = "设定ID")
	@Column(name = "SETTING_ID_")
	@Size(max = 50)
	protected String settingId;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 50)
	protected String solId;
	/* 类型 */
	@FieldDefine(title = "类型ID")
	@Column(name = "TREE_ID_")
	@Size(max = 50)
	protected String treeId;
	/* 权限JSON */
	@FieldDefine(title = "权限JSON")
	@Column(name = "RIGHT_JSON_")
	@Size(max = 50)
	protected String rightJson;
	
	protected String name="";
	
	protected String key="";

	/**
	 * Default Empty Constructor for class BpmAuthDef
	 */
	public BpmAuthDef() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmAuthDef
	 */
	public BpmAuthDef(String in_id) {
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
	 * 设定ID * @return String
	 */
	public String getSettingId() {
		return this.settingId;
	}

	/**
	 * 设置 设定ID
	 */
	public void setSettingId(String aValue) {
		this.settingId = aValue;
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
		this.solId = aValue;
	}

	/**
	 * 权限JSON * @return String
	 */
	public String getRightJson() {
		return this.rightJson;
	}

	/**
	 * 设置 权限JSON
	 */
	public void setRightJson(String aValue) {
		this.rightJson = aValue;
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

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmAuthDef)) {
			return false;
		}
		BpmAuthDef rhs = (BpmAuthDef) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.settingId, rhs.settingId)
				.append(this.solId, rhs.solId).append(this.rightJson, rhs.rightJson).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.settingId).append(this.solId)
				.append(this.rightJson).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("settingId", this.settingId)
				.append("solId", this.solId).append("rightJson", this.rightJson).toString();
	}

}
