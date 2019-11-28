package com.redxun.bpm.core.entity;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmInstTmp实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：
 * </pre>
 */
@Table(name = "BPM_INST_TMP")
@TableDefine(title = "")
public class BpmInstTmp extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "TMP_ID_")
	protected String tmpId;
	/* busKey */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "BUS_KEY_")
	@Size(max = 64)
	protected String busKey;
	/* instId */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "INST_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String instId;
	/* formJson */
	@FieldDefine(title = "${column.remarks}")
	@Column(name = "FORM_JSON_")
	//@Size(max = 4000)
	@NotEmpty
	protected String formJson;

	/**
	 * Default Empty Constructor for class BpmInstTmp
	 */
	public BpmInstTmp() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstTmp
	 */
	public BpmInstTmp(String in_tmpId) {
		this.setTmpId(in_tmpId);
	}

	/**
	 * * @return String
	 */
	public String getTmpId() {
		return this.tmpId;
	}
	/**
	 * 设置 tmpId
	 */
	public void setTmpId(String aValue) {
		this.tmpId = aValue;
	}
	/**
	 * * @return String
	 */
	public String getBusKey() {
		return this.busKey;
	}
	/**
	 * 设置 busKey
	 */
	public void setBusKey(String aValue) {
		this.busKey = aValue;
	}
	/**
	 * * @return String
	 */
	public String getInstId() {
		return this.instId;
	}
	/**
	 * 设置 instId
	 */
	public void setInstId(String aValue) {
		this.instId = aValue;
	}
	/**
	 * * @return String
	 */
	public String getFormJson() {
		return this.formJson;
	}
	/**
	 * 设置 formJson
	 */
	public void setFormJson(String aValue) {
		this.formJson = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.tmpId;
	}

	@Override
	public Serializable getPkId() {
		return this.tmpId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.tmpId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstTmp)) {
			return false;
		}
		BpmInstTmp rhs = (BpmInstTmp) object;
		return new EqualsBuilder().append(this.tmpId, rhs.tmpId).append(this.busKey, rhs.busKey)
				.append(this.instId, rhs.instId).append(this.formJson, rhs.formJson)
				.append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.tmpId).append(this.busKey).append(this.instId)
				.append(this.formJson).append(this.tenantId).append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("tmpId", this.tmpId).append("busKey", this.busKey)
				.append("instId", this.instId).append("formJson", this.formJson).append("tenantId", this.tenantId)
				.append("createBy", this.createBy).append("createTime", this.createTime)
				.append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
