



package com.redxun.sys.transset.entity;

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
 * 描述：权限转移设置表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "权限转移设置表")
public class SysTransferSetting extends BaseTenantEntity {
	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	protected String status; 
	@FieldDefine(title = "SELECTSQL语句")
	@Column(name = "SELECT_SQL_")
	protected String selectSql; 
	@FieldDefine(title = "UPDATESQL语句")
	@Column(name = "UPDATE_SQL_")
	protected String updateSql; 
	@FieldDefine(title = "日志内容模板")
	@Column(name = "LOG_TEMPLET_")
	protected String logTemplet; 
	
	//创建人名称
	protected String createByName;
	
	
	public SysTransferSetting() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysTransferSetting(String in_id) {
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
	public void setSelectSql(String selectSql) {
		this.selectSql = selectSql;
	}
	
	/**
	 * 返回 SELECTSQL语句
	 * @return
	 */
	public String getSelectSql() {
		return this.selectSql==null?"":this.selectSql;
	}
	public void setUpdateSql(String updateSql) {
		this.updateSql = updateSql;
	}
	
	/**
	 * 返回 UPDATESQL语句
	 * @return
	 */
	public String getUpdateSql() {
		return this.updateSql==null?"":this.updateSql;
	}
	public void setLogTemplet(String logTemplet) {
		this.logTemplet = logTemplet;
	}
	
	/**
	 * 返回 日志内容模板
	 * @return
	 */
	public String getLogTemplet() {
		return this.logTemplet;
	}
	
	public String getCreateByName() {
		return createByName;
	}

	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysTransferSetting)) {
			return false;
		}
		SysTransferSetting rhs = (SysTransferSetting) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.status, rhs.status) 
		.append(this.selectSql, rhs.selectSql) 
		.append(this.updateSql, rhs.updateSql) 
		.append(this.logTemplet, rhs.logTemplet) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.status) 
		.append(this.selectSql) 
		.append(this.updateSql) 
		.append(this.logTemplet) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("status", this.status) 
				.append("selectSql", this.selectSql) 
				.append("updateSql", this.updateSql) 
				.append("logTemplet", this.logTemplet) 
												.toString();
	}

}



