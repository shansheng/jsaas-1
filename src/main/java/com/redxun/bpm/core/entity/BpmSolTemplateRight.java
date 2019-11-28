



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
import java.util.ArrayList;
import java.util.List;

/**
 * <pre>
 *  
 * 描述：BPM_SOL_TEMPLATE_RIGHT实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-05-06 14:52:16
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "BPM_SOL_TEMPLATE_RIGHT")
public class BpmSolTemplateRight extends BaseTenantEntity {

	@FieldDefine(title = "权限ID")
	@Id
	@Column(name = "RIGHT_ID_")
	protected String rightId;

	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId; 
	@FieldDefine(title = "组IDS")
	@Column(name = "GROUP_IDS_")
	protected String groupIds; 
	@FieldDefine(title = "用户IDS")
	@Column(name = "USER_IDS_")
	protected String userIds; 
	@FieldDefine(title = "IS_ALL")
	@Column(name = "IS_ALL")
	protected String isAll; 
	
	
	
	
	
	public BpmSolTemplateRight() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmSolTemplateRight(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.rightId;
	}

	@Override
	public Serializable getPkId() {
		return this.rightId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.rightId = (String) pkId;
	}
	
	public String getRightId() {
		return this.rightId;
	}

	
	public void setRightId(String aValue) {
		this.rightId = aValue;
	}
	
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}
	
	/**
	 * 返回 分类ID
	 * @return
	 */
	public String getTreeId() {
		return this.treeId;
	}
	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}
	
	/**
	 * 返回 组IDS
	 * @return
	 */
	public String getGroupIds() {
		return this.groupIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
	/**
	 * 返回 用户IDS
	 * @return
	 */
	public String getUserIds() {
		return this.userIds;
	}
	public void setIsAll(String isAll) {
		this.isAll = isAll;
	}
	
	/**
	 * 返回 IS_ALL
	 * @return
	 */
	public String getIsAll() {
		return this.isAll;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolTemplateRight)) {
			return false;
		}
		BpmSolTemplateRight rhs = (BpmSolTemplateRight) object;
		return new EqualsBuilder()
		.append(this.rightId, rhs.rightId) 
		.append(this.treeId, rhs.treeId) 
		.append(this.groupIds, rhs.groupIds) 
		.append(this.userIds, rhs.userIds) 
		.append(this.isAll, rhs.isAll) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.rightId) 
		.append(this.treeId) 
		.append(this.groupIds) 
		.append(this.userIds) 
		.append(this.isAll) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("rightId", this.rightId) 
				.append("treeId", this.treeId) 
				.append("groupIds", this.groupIds) 
				.append("userIds", this.userIds) 
														.append("isAll", this.isAll) 
		.toString();
	}

}



