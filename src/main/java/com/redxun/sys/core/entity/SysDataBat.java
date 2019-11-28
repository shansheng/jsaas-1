



package com.redxun.sys.core.entity;

import com.redxun.core.entity.BaseTenantEntity;
import java.io.Serializable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.NotEmpty;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;
import java.util.ArrayList;
import java.util.List;

/**
 * <pre>
 *  
 * 描述：数据批量录入实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-01-02 10:49:41
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "数据批量录入")
public class SysDataBat extends BaseTenantEntity {
	
	public static String INPUT_TYPE_BAT="1";
	public static String INPUT_TYPE_SINGLE="2";
	public static String INPUT_TYPE_INTERFACE="3";

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "上传文件ID")
	@Column(name = "UPLOAD_ID_")
	protected String uploadId; 
	@FieldDefine(title = "批次ID")
	@Column(name = "BAT_ID_")
	protected String batId; 
	@FieldDefine(title = "服务名")
	@Column(name = "SERVICE_NAME_")
	protected String serviceName; 
	@FieldDefine(title = "子系统ID")
	@Column(name = "APP_ID_")
	protected String appId; 
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "EXCEL文件")
	@Column(name = "EXCEL_ID_")
	protected String excelId; 
	@FieldDefine(title = "表名")
	@Column(name = "TABLE_NAME_")
	protected String tableName; 
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "流程实例状态")
	@Column(name = "INST_STATUS_")
	protected String instStatus; 
	
	
	
	
	
	public SysDataBat() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysDataBat(String in_id) {
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
	
	public void setUploadId(String uploadId) {
		this.uploadId = uploadId;
	}
	
	/**
	 * 返回 上传文件ID
	 * @return
	 */
	public String getUploadId() {
		return this.uploadId;
	}
	public void setBatId(String batId) {
		this.batId = batId;
	}
	
	/**
	 * 返回 批次ID
	 * @return
	 */
	public String getBatId() {
		return this.batId;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	
	/**
	 * 返回 服务名
	 * @return
	 */
	public String getServiceName() {
		return this.serviceName;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	
	/**
	 * 返回 子系统ID
	 * @return
	 */
	public String getAppId() {
		return this.appId;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 类型
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setExcelId(String excelId) {
		this.excelId = excelId;
	}
	
	/**
	 * 返回 EXCEL文件
	 * @return
	 */
	public String getExcelId() {
		return this.excelId;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	/**
	 * 返回 表名
	 * @return
	 */
	public String getTableName() {
		return this.tableName;
	}
	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	/**
	 * 返回 流程实例ID
	 * @return
	 */
	public String getInstId() {
		return this.instId;
	}
	public void setInstStatus(String instStatus) {
		this.instStatus = instStatus;
	}
	
	/**
	 * 返回 流程实例状态
	 * @return
	 */
	public String getInstStatus() {
		return this.instStatus;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysDataBat)) {
			return false;
		}
		SysDataBat rhs = (SysDataBat) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.uploadId, rhs.uploadId) 
		.append(this.batId, rhs.batId) 
		.append(this.serviceName, rhs.serviceName) 
		.append(this.appId, rhs.appId) 
		.append(this.type, rhs.type) 
		.append(this.excelId, rhs.excelId) 
		.append(this.tableName, rhs.tableName) 
		.append(this.instId, rhs.instId) 
		.append(this.instStatus, rhs.instStatus) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.uploadId) 
		.append(this.batId) 
		.append(this.serviceName) 
		.append(this.appId) 
		.append(this.type) 
		.append(this.excelId) 
		.append(this.tableName) 
		.append(this.instId) 
		.append(this.instStatus) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("uploadId", this.uploadId) 
				.append("batId", this.batId) 
				.append("serviceName", this.serviceName) 
				.append("appId", this.appId) 
				.append("type", this.type) 
				.append("excelId", this.excelId) 
				.append("tableName", this.tableName) 
				.append("instId", this.instId) 
				.append("instStatus", this.instStatus) 
												.toString();
	}

}



