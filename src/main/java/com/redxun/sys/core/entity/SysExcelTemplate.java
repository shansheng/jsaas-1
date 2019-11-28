



package com.redxun.sys.core.entity;

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
 * 描述：EXCEL导入模板实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-12-20 11:56:39
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "EXCEL导入模板")
public class SysExcelTemplate extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "模式名称")
	@Column(name = "TEMPLATE_NAME_")
	protected String templateName; 
	@FieldDefine(title = "模式别名")
	@Column(name = "TEMPLATE_NAME_ALIAS_")
	protected String templateNameAlias; 
	@FieldDefine(title = "模式类型")
	@Column(name = "TEMPLATE_TYPE_")
	protected String templateType; 
	@FieldDefine(title = "备注")
	@Column(name = "TEMPLATE_COMMENT_")
	protected String templateComment; 
	@FieldDefine(title = "配置信息")
	@Column(name = "TEMPLATE_CONF_")
	protected String templateConf; 
	@FieldDefine(title = "模板文件名称")
	@Column(name = "EXCEL_TEMPLATE_FILE_")
	protected String excelTemplateFile; 
	
	
	
	
	
	public SysExcelTemplate() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysExcelTemplate(String in_id) {
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
	
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	/**
	 * 返回 模式名称
	 * @return
	 */
	public String getTemplateName() {
		return this.templateName;
	}
	public void setTemplateNameAlias(String templateNameAlias) {
		this.templateNameAlias = templateNameAlias;
	}
	
	/**
	 * 返回 模式别名
	 * @return
	 */
	public String getTemplateNameAlias() {
		return this.templateNameAlias;
	}
	public void setTemplateType(String templateType) {
		this.templateType = templateType;
	}
	
	/**
	 * 返回 模式类型
	 * @return
	 */
	public String getTemplateType() {
		return this.templateType;
	}
	public void setTemplateComment(String templateComment) {
		this.templateComment = templateComment;
	}
	
	/**
	 * 返回 备注
	 * @return
	 */
	public String getTemplateComment() {
		return this.templateComment;
	}
	public void setTemplateConf(String templateConf) {
		this.templateConf = templateConf;
	}
	
	/**
	 * 返回 配置信息
	 * @return
	 */
	public String getTemplateConf() {
		return this.templateConf;
	}
	public void setExcelTemplateFile(String excelTemplateFile) {
		this.excelTemplateFile = excelTemplateFile;
	}
	
	/**
	 * 返回 模板文件名称
	 * @return
	 */
	public String getExcelTemplateFile() {
		return this.excelTemplateFile;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysExcelTemplate)) {
			return false;
		}
		SysExcelTemplate rhs = (SysExcelTemplate) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.templateName, rhs.templateName) 
		.append(this.templateNameAlias, rhs.templateNameAlias) 
		.append(this.templateType, rhs.templateType) 
		.append(this.templateComment, rhs.templateComment) 
		.append(this.templateConf, rhs.templateConf) 
		.append(this.excelTemplateFile, rhs.excelTemplateFile) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.templateName) 
		.append(this.templateNameAlias) 
		.append(this.templateType) 
		.append(this.templateComment) 
		.append(this.templateConf) 
		.append(this.excelTemplateFile) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("templateName", this.templateName) 
				.append("templateNameAlias", this.templateNameAlias) 
				.append("templateType", this.templateType) 
				.append("templateComment", this.templateComment) 
				.append("templateConf", this.templateConf) 
				.append("excelTemplateFile", this.excelTemplateFile) 
												.toString();
	}

}



