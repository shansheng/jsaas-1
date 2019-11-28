



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
 * 描述：SYS_WORD_TMPLATE【模板表】实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-05-29 14:54:08
 * 版权：广州红迅软件
 * </pre> sys_word_template
 */
@TableDefine(title = "SYS_WORD_TEMPLATE【模板表】")
public class SysWordTemplate extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	
	@FieldDefine(title = "模板名称")
	@Column(name = "TEMPLATE_NAME_")
	protected String templateName; 
	
	@FieldDefine(title = "数据源(SQL/自定义)")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "业务对象ID")
	@Column(name = "BO_DEF_ID_")
	protected String boDefId;
	@Column(name = "BO_DEF_NAME_")
	protected String boDefName;
	
	@FieldDefine(title = "设定SQL语句，用于自定义数据源操作表单")
	@Column(name = "SETTING_")
	protected String setting; 
	@FieldDefine(title = "数据源")
	@Column(name = "DS_ALIAS_")
	protected String dsAlias; 
	@FieldDefine(title = "模板ID")
	@Column(name = "TEMPLATE_ID_")
	protected String templateId; 
	
	@FieldDefine(title = "描述")
	@Column(name = "DESCRIPTION_")
	protected String description; 
	
	
	
	
	
	public SysWordTemplate() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysWordTemplate(String in_id) {
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
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 数据源(SQL/自定义)
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}
	
	/**
	 * 返回 业务对象ID
	 * @return
	 */
	public String getBoDefId() {
		return this.boDefId;
	}
	public void setSetting(String setting) {
		this.setting = setting;
	}
	
	/**
	 * 返回 设定SQL语句，用于自定义数据源操作表单
	 * @return
	 */
	public String getSetting() {
		return this.setting;
	}
	public void setDsAlias(String dsAlias) {
		this.dsAlias = dsAlias;
	}
	
	/**
	 * 返回 数据源
	 * @return
	 */
	public String getDsAlias() {
		return this.dsAlias;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
	/**
	 * 返回 模板ID
	 * @return
	 */
	public String getTemplateId() {
		return this.templateId;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	/**
	 * 返回 模板名称
	 * @return
	 */
	public String getTemplateName() {
		return this.templateName;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getDescription() {
		return this.description;
	}
	
	
	
	
		

	public String getBoDefName() {
		return boDefName;
	}

	public void setBoDefName(String boDefName) {
		this.boDefName = boDefName;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysWordTemplate)) {
			return false;
		}
		SysWordTemplate rhs = (SysWordTemplate) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.type, rhs.type) 
		.append(this.boDefId, rhs.boDefId) 
		.append(this.setting, rhs.setting) 
		.append(this.dsAlias, rhs.dsAlias) 
		.append(this.templateId, rhs.templateId) 
		.append(this.templateName, rhs.templateName) 
		.append(this.description, rhs.description) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.type) 
		.append(this.boDefId) 
		.append(this.setting) 
		.append(this.dsAlias) 
		.append(this.templateId) 
		.append(this.templateName) 
		.append(this.description) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("type", this.type) 
				.append("boDefId", this.boDefId) 
				.append("setting", this.setting) 
				.append("dsAlias", this.dsAlias) 
				.append("templateId", this.templateId) 
				.append("templateName", this.templateName) 
				.append("description", this.description) 
												.toString();
	}

}



