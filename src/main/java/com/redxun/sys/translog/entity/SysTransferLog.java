



package com.redxun.sys.translog.entity;

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
 * 描述：权限转移日志表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "权限转移日志表")
public class SysTransferLog extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "操作描述")
	@Column(name = "OP_DESCP_")
	protected String opDescp; 
	@FieldDefine(title = "权限转移人")
	@Column(name = "AUTHOR_PERSON_")
	protected String authorPerson; 
	@FieldDefine(title = "目标转移人")
	@Column(name = "TARGET_PERSON_")
	protected String targetPerson; 
	
	
	protected String authorPersonName;
	
	protected String targetPersonName;
	
	public SysTransferLog() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysTransferLog(String in_id) {
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
	
	public void setOpDescp(String opDescp) {
		this.opDescp = opDescp;
	}
	
	/**
	 * 返回 操作描述
	 * @return
	 */
	public String getOpDescp() {
		return this.opDescp;
	}
	public void setAuthorPerson(String authorPerson) {
		this.authorPerson = authorPerson;
	}
	
	/**
	 * 返回 权限转移人
	 * @return
	 */
	public String getAuthorPerson() {
		return this.authorPerson;
	}
	public void setTargetPerson(String targetPerson) {
		this.targetPerson = targetPerson;
	}
	
	/**
	 * 返回 目标转移人
	 * @return
	 */
	public String getTargetPerson() {
		return this.targetPerson;
	}
	
	public String getAuthorPersonName() {
		return authorPersonName;
	}

	public void setAuthorPersonName(String authorPersonName) {
		this.authorPersonName = authorPersonName;
	}

	public String getTargetPersonName() {
		return targetPersonName;
	}

	public void setTargetPersonName(String targetPersonName) {
		this.targetPersonName = targetPersonName;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysTransferLog)) {
			return false;
		}
		SysTransferLog rhs = (SysTransferLog) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.opDescp, rhs.opDescp) 
		.append(this.authorPerson, rhs.authorPerson) 
		.append(this.targetPerson, rhs.targetPerson) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.opDescp) 
		.append(this.authorPerson) 
		.append(this.targetPerson) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("opDescp", this.opDescp) 
				.append("authorPerson", this.authorPerson) 
				.append("targetPerson", this.targetPerson) 
								.toString();
	}

}



