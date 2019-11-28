



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：假期类型实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_holiday_type")
@TableDefine(title = "假期类型")
public class AtsHolidayType extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "编码")
	@Column(name = "CODE")
	protected String code; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME")
	protected String name; 
	@FieldDefine(title = "是否系统预置")
	@Column(name = "IS_SYS")
	protected Short isSys; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS")
	protected Short status; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	@FieldDefine(title = "是否异常")
	@Column(name = "ABNORMITY")
	protected Integer abnormity; 
	
	
	
	
	public AtsHolidayType() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsHolidayType(String in_id) {
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
	
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * 返回 编码
	 * @return
	 */
	public String getCode() {
		return this.code;
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
	public void setIsSys(Short isSys) {
		this.isSys = isSys;
	}
	
	/**
	 * 返回 是否系统预置
	 * @return
	 */
	public Short getIsSys() {
		return this.isSys;
	}
	public void setStatus(Short status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public Short getStatus() {
		return this.status;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getMemo() {
		return this.memo;
	}
	public void setAbnormity(Integer abnormity) {
		this.abnormity = abnormity;
	}
	
	/**
	 * 返回 是否异常
	 * @return
	 */
	public Integer getAbnormity() {
		return this.abnormity;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsHolidayType)) {
			return false;
		}
		AtsHolidayType rhs = (AtsHolidayType) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.isSys, rhs.isSys) 
		.append(this.status, rhs.status) 
		.append(this.memo, rhs.memo) 
		.append(this.abnormity, rhs.abnormity) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.code) 
		.append(this.name) 
		.append(this.isSys) 
		.append(this.status) 
		.append(this.memo) 
		.append(this.abnormity) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("code", this.code) 
				.append("name", this.name) 
				.append("isSys", this.isSys) 
				.append("status", this.status) 
				.append("memo", this.memo) 
				.append("abnormity", this.abnormity) 
												.toString();
	}

}



