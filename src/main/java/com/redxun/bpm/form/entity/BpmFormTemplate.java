package com.redxun.bpm.form.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：BpmFormTemplate实体类定义
 * 表单模版
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_FORM_TEMPLATE")
@TableDefine(title = "表单模版")
public class BpmFormTemplate extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 模版名称 */
	@FieldDefine(title = "模版名称")
	@Column(name = "NAME_")
	@Size(max = 50)
	protected String name;
	/* 别名 */
	@FieldDefine(title = "别名")
	@Column(name = "ALIAS_")
	@Size(max = 50)
	protected String alias;
	/* 模版 */
	@FieldDefine(title = "模版")
	@Column(name = "TEMPLATE_")
	@Size(max = 65535)
	protected String template;
	
	/* 模版类型 (pc,mobile) */
	@FieldDefine(title = "模版类型 (pc,mobile)")
	@Column(name = "TYPE_")
	@Size(max = 50)
	protected String type;
	/* 初始添加的(1是,0否) */
	@FieldDefine(title = "初始添加的(1是,0否)")
	@Column(name = "INIT_")
	protected Integer init=0;
	
	/* 分类 */
	@FieldDefine(title = "分类")
	@Column(name = "CATEGORY_")
	@Size(max = 50)
	protected String category="";

	/**
	 * Default Empty Constructor for class BpmFormTemplate
	 */
	public BpmFormTemplate() {
		super();
	}
	

	

	/**
	 * Default Key Fields Constructor for class BpmFormTemplate
	 */
	public BpmFormTemplate(String in_id) {
		this.setId(in_id);
	}

	/**
	 * 主键 * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 主键
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 模版名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 模版名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 别名 * @return String
	 */
	public String getAlias() {
		return this.alias;
	}

	/**
	 * 设置 别名
	 */
	public void setAlias(String aValue) {
		this.alias = aValue;
	}

	/**
	 * 模版 * @return String
	 */
	public String getTemplate() {
		return this.template;
	}

	/**
	 * 设置 模版
	 */
	public void setTemplate(String aValue) {
		this.template = aValue;
	}

	

	/**
	 * 模版类型 (pc,mobile) * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 模版类型 (pc,mobile)
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * 初始添加的(1是,0否) * @return Integer
	 */
	public Integer getInit() {
		return this.init;
	}

	/**
	 * 设置 初始添加的(1是,0否)
	 */
	public void setInit(Integer aValue) {
		this.init = aValue;
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

	public String getCategory() {
		return category;
	}




	public void setCategory(String category) {
		this.category = category;
	}




	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormTemplate)) {
			return false;
		}
		BpmFormTemplate rhs = (BpmFormTemplate) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.name, rhs.name).append(this.alias, rhs.alias)
				.append(this.template, rhs.template).append(this.type, rhs.type)
				.append(this.init, rhs.init).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.name).append(this.alias)
				.append(this.template).append(this.type).append(this.init).toHashCode();
	}

	




	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("name", this.name).append("alias", this.alias)
				.append("template", this.template).append("type", this.type)
				.append("init", this.init).toString();
	}

}
