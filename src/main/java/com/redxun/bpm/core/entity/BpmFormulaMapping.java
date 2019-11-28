



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
 * 描述：公式映射实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-09-03 22:27:06
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "公式映射")
public class BpmFormulaMapping extends BaseTenantEntity {

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
	@FieldDefine(title = "公式名")
	@Column(name = "FORMULA_NAME")
	protected String formulaName; 
	@FieldDefine(title = "公式ID")
	@Column(name = "FORMULA_ID_")
	protected String formulaId; 
	
	
	
	
	
	public BpmFormulaMapping() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmFormulaMapping(String in_id) {
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
	public void setFormulaName(String formulaName) {
		this.formulaName = formulaName;
	}
	
	/**
	 * 返回 公式名
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
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormulaMapping)) {
			return false;
		}
		BpmFormulaMapping rhs = (BpmFormulaMapping) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.solId, rhs.solId) 
		.append(this.actDefId, rhs.actDefId) 
		.append(this.nodeId, rhs.nodeId) 
		.append(this.formulaName, rhs.formulaName) 
		.append(this.formulaId, rhs.formulaId) 
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
		.append(this.formulaName) 
		.append(this.formulaId) 
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
				.append("formulaName", this.formulaName) 
				.append("formulaId", this.formulaId) 
												.toString();
	}

}



