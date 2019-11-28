



package com.redxun.bpm.core.entity;

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
 * 描述：BPM_REG_LIB实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-12-25 15:49:05
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "BPM_REG_LIB")
public class BpmRegLib extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "REG_ID_")
	protected String regId;

	@FieldDefine(title = "用户ID，为0代表公共的")
	@Column(name = "USER_ID_")
	protected String userId; 
	@FieldDefine(title = "正则表达式")
	@Column(name = "REG_TEXT_")
	protected String regText; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "类型，0为校验正则，1为替换正则")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "别名")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "替换表达式")
	@Column(name = "MENT_TEXT_")
	protected String mentText; 
	
	
	
	
	public BpmRegLib() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmRegLib(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.regId;
	}

	@Override
	public Serializable getPkId() {
		return this.regId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.regId = (String) pkId;
	}
	
	public String getRegId() {
		return this.regId;
	}

	
	public void setRegId(String aValue) {
		this.regId = aValue;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 用户ID，为0代表公共的
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setRegText(String regText) {
		this.regText = regText;
	}
	
	/**
	 * 返回 正则表达式
	 * @return
	 */
	public String getRegText() {
		return this.regText;
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
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 类型，0为校验正则，1为替换正则
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 别名
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	
	
	public String getMentText() {
		return mentText;
	}

	public void setMentText(String mentText) {
		this.mentText = mentText;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmRegLib)) {
			return false;
		}
		BpmRegLib rhs = (BpmRegLib) object;
		return new EqualsBuilder()
		.append(this.regId, rhs.regId) 
		.append(this.userId, rhs.userId) 
		.append(this.regText, rhs.regText) 
		.append(this.name, rhs.name) 
		.append(this.type, rhs.type) 
		.append(this.key, rhs.key) 
		.append(this.mentText, rhs.mentText) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.regId) 
		.append(this.userId) 
		.append(this.regText) 
		.append(this.name) 
		.append(this.type) 
		.append(this.key) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("regId", this.regId) 
				.append("userId", this.userId) 
				.append("regText", this.regText) 
														.append("name", this.name) 
				.append("type", this.type) 
				.append("key", this.key) 
		.toString();
	}

}



