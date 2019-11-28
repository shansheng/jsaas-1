package com.redxun.oa.info.entity;

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
 * 描述：消息提醒实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-04-28 16:03:20
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "消息提醒")
public class OaRemindDef extends BaseTenantEntity {

	@FieldDefine(title = "主题")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "主题")
	@Column(name = "SUBJECT_")
	protected String subject; 
	@FieldDefine(title = "提醒需要连接到的地址")
	@Column(name = "URL_")
	protected String url; 
	@FieldDefine(title = "设置类型(FUNC:方法,SQL:SQL,GROOVYSQL)")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "SQL语句或方法")
	@Column(name = "SETTING_")
	protected String setting; 
	@FieldDefine(title = "数据源别名")
	@Column(name = "DSALIAS_")
	protected String dsalias; 
	@FieldDefine(title = "消息描述")
	@Column(name = "DESCRIPTION_")
	protected String description; 
	@FieldDefine(title = "排序")
	@Column(name = "SN_")
	protected String sn; 
	@FieldDefine(title = "是否有效1.有效0.无效")
	@Column(name = "ENABLED_")
	protected Integer enabled; 

	public OaRemindDef() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public OaRemindDef(String in_id) {
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
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	/**
	 * 返回 主题
	 * @return
	 */
	public String getSubject() {
		return this.subject;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * 返回 提醒需要连接到的地址
	 * @return
	 */
	public String getUrl() {
		return this.url;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 设置类型(FUNC:方法,SQL:SQL,GROOVYSQL)
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setSetting(String setting) {
		this.setting = setting;
	}
	
	/**
	 * 返回 SQL语句或方法
	 * @return
	 */
	public String getSetting() {
		return this.setting;
	}
	public void setDsalias(String dsalias) {
		this.dsalias = dsalias;
	}
	
	/**
	 * 返回 数据源别名
	 * @return
	 */
	public String getDsalias() {
		return this.dsalias;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * 返回 消息描述
	 * @return
	 */
	public String getDescription() {
		return this.description;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	
	/**
	 * 返回 排序
	 * @return
	 */
	public String getSn() {
		return this.sn;
	}
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	
	/**
	 * 返回 是否有效1.有效0.无效
	 * @return
	 */
	public Integer getEnabled() {
		return this.enabled;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof OaRemindDef)) {
			return false;
		}
		OaRemindDef rhs = (OaRemindDef) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.subject, rhs.subject) 
		.append(this.url, rhs.url) 
		.append(this.type, rhs.type) 
		.append(this.setting, rhs.setting) 
		.append(this.dsalias, rhs.dsalias) 
		.append(this.description, rhs.description) 
		.append(this.sn, rhs.sn) 
		.append(this.enabled, rhs.enabled) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.subject) 
		.append(this.url) 
		.append(this.type) 
		.append(this.setting) 
		.append(this.dsalias) 
		.append(this.description) 
		.append(this.sn) 
		.append(this.enabled) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("subject", this.subject) 
				.append("url", this.url) 
				.append("type", this.type) 
				.append("setting", this.setting) 
				.append("dsalias", this.dsalias) 
				.append("description", this.description) 
				.append("sn", this.sn) 
				.append("enabled", this.enabled) 
												.toString();
	}

}



