package com.redxun.bpm.core.entity;

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

/**
 * <pre>
 *  
 * 描述：表单权限实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-02-09 15:54:25
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_FORM_RIGHT")
@TableDefine(title = "表单权限")
public class BpmFormRight extends BaseTenantEntity {
	
	public static String PERMISSION="permission_";
	
	public static String READONLY="readOnly";
	
	/**
	 * 表单字段
	 */
	public final static String NODE_FORM="_FORM";
	
	public final static String NODE_FORM_SOL="_FORMSOL";
	/**
	 * 全局表单
	 */
	public final static String NODE_PROCESS="_PROCESS";
	
	/**
	 * 全局明细表单
	 */
	public final static String NODE_DETAIL="_DETAIL";
	
	/**
	 * 开始表单
	 */
	public final static String NODE_START="_START";
	
	public final static String RIGHT_TYPE_FORM="form";
	/**
	 * 子表权限。
	 */
	public final static String RIGHT_TYPE_TABLE="table";
	
	public final static String RIGHT_TYPE_DEALWITH="dealwith";
	
	public final static String RIGHT_TYPE_OPINION="opinion";
	/**
	 * 按钮定义权限。
	 */
	public final static String RIGHT_TYPE_BUTTON="button";

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "方案ID")
	@Column(name = "SOL_ID_")
	protected String solId; 
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	protected String actDefId; 
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	protected String nodeId; 
	@FieldDefine(title = "表单别名")
	@Column(name = "FORM_ALIAS_")
	protected String formAlias; 
	@FieldDefine(title = "权限JSON")
	@Column(name = "JSON_")
	protected String json; 
	@Column(name = "BODEF_ID_")
	protected String boDefId; 
	
	
	
	
	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	public BpmFormRight() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmFormRight(String in_id) {
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
	 * 返回 方案ID
	 * @return
	 */
	public String getSolId() {
		return this.solId;
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
	public void setFormAlias(String formAlias) {
		this.formAlias = formAlias;
	}
	
	/**
	 * 返回 表单别名
	 * @return
	 */
	public String getFormAlias() {
		return this.formAlias;
	}
	public void setJson(String json) {
		this.json = json;
	}
	
	/**
	 * 返回 权限JSON
	 * @return
	 */
	public String getJson() {
		return this.json;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormRight)) {
			return false;
		}
		BpmFormRight rhs = (BpmFormRight) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.solId, rhs.solId) 
		.append(this.actDefId, rhs.actDefId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.formAlias, rhs.formAlias) 
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
		.append(this.actDefId) 
		.append(this.nodeId) 
		.append(this.formAlias) 
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
				.append("actDefId", this.actDefId) 
				.append("nodeId", this.nodeId) 
				.append("formAlias", this.formAlias) 
				.append("json", this.json) 
												.toString();
	}

}



