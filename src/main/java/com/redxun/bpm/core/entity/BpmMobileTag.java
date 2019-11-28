



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：记录CID和机型实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2017-11-29 22:29:36
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_MOBILE_TAG")
@TableDefine(title = "记录CID和机型")
public class BpmMobileTag extends BaseTenantEntity {

	@FieldDefine(title = "标识ID主键")
	@Id
	@Column(name = "TAGID_")
	protected String tagid;

	@FieldDefine(title = "每台机器每个APP标识码")
	@Column(name = "CID_")
	protected String cid; 
	@FieldDefine(title = "苹果、安卓、其他")
	@Column(name = "MOBILE_TYPE_")
	protected String mobileType; 
	@FieldDefine(title = "是屏蔽则不发")
	@Column(name = "ISBAN_")
	protected String isban; 
	@FieldDefine(title = "CID绑定的别名")
	@Column(name = "ALIAS_")
	protected String alias; 
	@FieldDefine(title = "CID归类使用")
	@Column(name = "TAG_")
	protected String tag; 
	
	
	
	
	public BpmMobileTag() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmMobileTag(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.tagid;
	}

	@Override
	public Serializable getPkId() {
		return this.tagid;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.tagid = (String) pkId;
	}
	
	public String getTagid() {
		return this.tagid;
	}

	
	public void setTagid(String aValue) {
		this.tagid = aValue;
	}
	
	public void setCid(String cid) {
		this.cid = cid;
	}
	
	/**
	 * 返回 每台机器每个APP标识码
	 * @return
	 */
	public String getCid() {
		return this.cid;
	}
	public void setMobileType(String mobileType) {
		this.mobileType = mobileType;
	}
	
	/**
	 * 返回 苹果、安卓、其他
	 * @return
	 */
	public String getMobileType() {
		return this.mobileType;
	}
	public void setIsban(String isban) {
		this.isban = isban;
	}
	
	/**
	 * 返回 是屏蔽则不发
	 * @return
	 */
	public String getIsban() {
		return this.isban;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	/**
	 * 返回 CID绑定的别名
	 * @return
	 */
	public String getAlias() {
		return this.alias;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	
	/**
	 * 返回 CID归类使用
	 * @return
	 */
	public String getTag() {
		return this.tag;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmMobileTag)) {
			return false;
		}
		BpmMobileTag rhs = (BpmMobileTag) object;
		return new EqualsBuilder()
		.append(this.tagid, rhs.tagid) 
		.append(this.cid, rhs.cid) 
		.append(this.mobileType, rhs.mobileType) 
		.append(this.isban, rhs.isban) 
		.append(this.alias, rhs.alias) 
		.append(this.tag, rhs.tag) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.tagid) 
		.append(this.cid) 
		.append(this.mobileType) 
		.append(this.isban) 
		.append(this.alias) 
		.append(this.tag) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("tagid", this.tagid) 
				.append("cid", this.cid) 
				.append("mobileType", this.mobileType) 
				.append("isban", this.isban) 
				.append("alias", this.alias) 
				.append("tag", this.tag) 
												.toString();
	}

}



