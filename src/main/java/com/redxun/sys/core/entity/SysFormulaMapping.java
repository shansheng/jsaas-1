



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
 * 描述：表单方案公式映射实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-08-21 23:31:09
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "表单方案公式映射")
public class SysFormulaMapping extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "表单方案ID")
	@Column(name = "FORM_SOL_ID_")
	protected String formSolId; 
	@FieldDefine(title = "公式名称")
	@Column(name = "FORMULA_NAME_")
	protected String formulaName; 
	@FieldDefine(title = "公式ID")
	@Column(name = "FORMULA_ID_")
	protected String formulaId; 
	@FieldDefine(title = "BO定义")
	@Column(name = "BO_DEF_ID_")
	protected String boDefId; 
	
	
	
	
	
	public SysFormulaMapping() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysFormulaMapping(String in_id) {
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
	
	public void setFormSolId(String formSolId) {
		this.formSolId = formSolId;
	}
	
	/**
	 * 返回 表单方案ID
	 * @return
	 */
	public String getFormSolId() {
		return this.formSolId;
	}
	public void setFormulaName(String formulaName) {
		this.formulaName = formulaName;
	}
	
	/**
	 * 返回 公式名称
	 * @return
	 */
	public String getFormulaName() {
		return this.formulaName;
	}
	public void setFormulaId(String formulaId) {
		this.formulaId = formulaId;
	}
	
	/**
	 * 返回 公式ID
	 * @return
	 */
	public String getFormulaId() {
		return this.formulaId;
	}
	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}
	
	/**
	 * 返回 BO定义
	 * @return
	 */
	public String getBoDefId() {
		return this.boDefId;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysFormulaMapping)) {
			return false;
		}
		SysFormulaMapping rhs = (SysFormulaMapping) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.formSolId, rhs.formSolId) 
		.append(this.formulaName, rhs.formulaName) 
		.append(this.formulaId, rhs.formulaId) 
		.append(this.boDefId, rhs.boDefId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.formSolId) 
		.append(this.formulaName) 
		.append(this.formulaId) 
		.append(this.boDefId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("formSolId", this.formSolId) 
				.append("formulaName", this.formulaName) 
				.append("formulaId", this.formulaId) 
				.append("boDefId", this.boDefId) 
												.toString();
	}

}



