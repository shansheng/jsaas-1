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
@Table(name = "SYS_ECHARTS_LISTPREMISSION")
@TableDefine(title = "报表列表权限设置")
public class SysEchartsListPremission extends BaseTenantEntity  {
	
	private static final long serialVersionUID = 1L;

	@FieldDefine(title = "ID")
	@Id
	@Column(name = "ID_")
	private String id;
	
	@FieldDefine(title = "singleID")
	@Column(name = "PRE_ID_")
	private String preId;
	
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	private String type;
	
	@FieldDefine(title = "用户或组ID")
	@Column(name = "OWNER_ID_")
	private String ownerId;
	
	@FieldDefine(title = "用户名或组名")
	@Column(name = "OWNER_NAME_")
	private String ownerName;
	
	public SysEchartsListPremission() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPreId() {
		return preId;
	}

	public void setPreId(String preId) {
		this.preId = preId;
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
		SysEchartsListPremission rhs = (SysEchartsListPremission) object;
		return new EqualsBuilder().append(this.id, rhs.id)
				.append(this.preId, rhs.preId).append(this.type, rhs.type)
				.append(this.ownerId, rhs.ownerId).append(this.ownerName, rhs.ownerName).isEquals();
	}
	
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id)
				.append(this.preId).append(type)
				.append(ownerId).append(ownerName).toHashCode();
	}
	
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id)
				.append("preId", this.preId).append("type", this.type)
				.append("ownerId", this.ownerId).append("ownerName", this.ownerName).toString();
	}

}
