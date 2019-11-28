package com.redxun.bpm.form.entity;

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
 * 描述：FORM_VALID_RULE实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-27 22:58:37
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "FORM_VALID_RULE")
public class FormValidRule extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	protected String solId; 
	@FieldDefine(title = "表单KEY")
	@Column(name = "FORM_KEY_")
	protected String formKey; 
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	protected String actDefId; 
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "表单定义")
	@Column(name = "JSON_")
	protected String json; 
	
	
	
	
	
	public FormValidRule() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public FormValidRule(String in_id) {
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
	
	public void setSolId(String solId) {
		this.solId = solId;
	}
	
	/**
	 * 返回 解决方案ID
	 * @return
	 */
	public String getSolId() {
		return this.solId;
	}
	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}
	
	/**
	 * 返回 表单KEY
	 * @return
	 */
	public String getFormKey() {
		return this.formKey;
	}
	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}
	
	/**
	 * 返回 流程定义ID
	 * @return
	 */
	public String getActDefId() {
		return this.actDefId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	/**
	 * 返回 节点ID
	 * @return
	 */
	public String getNodeId() {
		return this.nodeId;
	}
	public void setJson(String json) {
		this.json = json;
	}
	
	/**
	 * 返回 表单定义
	 * @return
	 */
	public String getJson() {
		return this.json;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof FormValidRule)) {
			return false;
		}
		FormValidRule rhs = (FormValidRule) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.solId, rhs.solId) 
		.append(this.formKey, rhs.formKey) 
		.append(this.actDefId, rhs.actDefId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.json, rhs.json) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.solId) 
		.append(this.formKey) 
		.append(this.actDefId) 
		.append(this.nodeId) 
		.append(this.json) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("solId", this.solId) 
				.append("formKey", this.formKey) 
				.append("actDefId", this.actDefId) 
				.append("nodeId", this.nodeId) 
				.append("json", this.json) 
												.toString();
	}

}



