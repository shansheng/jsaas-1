package com.redxun.sys.echarts.entity;

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
@Table(name = "SYS_ECHARTS_PREMISSION")
@TableDefine(title = "报表树权限设置")
public class SysEchartsPremission extends BaseTenantEntity {
	private static final long serialVersionUID = 1L;

	@FieldDefine(title = "ID")
	@Id
	@Column(name = "ID_")
	private String id;
	
	@FieldDefine(title = "树ID")
	@Column(name = "TREE_ID_")
	private String treeId;
	
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	private String type;
	
	@FieldDefine(title = "用户或组ID")
	@Column(name = "OWNER_ID_")
	private String ownerId;
	
	@FieldDefine(title = "用户名或组名")
	@Column(name = "OWNER_NAME_")
	private String ownerName;
	
	public SysEchartsPremission() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTreeId() {
		return treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}

	public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
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
	
	public boolean equals(Object object) {
		if (!(object instanceof SysEchartsPremission)) {
			return false;
		}
		SysEchartsPremission rhs = (SysEchartsPremission) object;
		return new EqualsBuilder().append(this.id, rhs.id)
				.append(this.treeId, rhs.treeId).append(this.type, rhs.type)
				.append(this.ownerId, rhs.ownerId).append(this.ownerName, rhs.ownerName).isEquals();
	}
	
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id)
				.append(this.treeId).append(type)
				.append(ownerId).append(ownerName).toHashCode();
	}
	
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id)
				.append("treeId", this.treeId).append("type", this.type)
				.append("ownerId", this.ownerId).append("ownerName", this.ownerName).toString();
	}

}
