



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：打卡导入方案实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_import_plan")
@TableDefine(title = "打卡导入方案")
public class AtsImportPlan extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "编码")
	@Column(name = "CODE")
	protected String code; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME")
	protected String name; 
	@FieldDefine(title = "分割符")
	@Column(name = "SEPARATE")
	protected Short separate; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	@FieldDefine(title = "打卡对应关系")
	@Column(name = "PUSH_CARD_MAP")
	protected String pushCardMap; 
	
	
	
	
	public AtsImportPlan() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsImportPlan(String in_id) {
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
	
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * 返回 编码
	 * @return
	 */
	public String getCode() {
		return this.code;
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
	public void setSeparate(Short separate) {
		this.separate = separate;
	}
	
	/**
	 * 返回 分割符
	 * @return
	 */
	public Short getSeparate() {
		return this.separate;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getMemo() {
		return this.memo;
	}
	public void setPushCardMap(String pushCardMap) {
		this.pushCardMap = pushCardMap;
	}
	
	/**
	 * 返回 打卡对应关系
	 * @return
	 */
	public String getPushCardMap() {
		return this.pushCardMap;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsImportPlan)) {
			return false;
		}
		AtsImportPlan rhs = (AtsImportPlan) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.separate, rhs.separate) 
		.append(this.memo, rhs.memo) 
		.append(this.pushCardMap, rhs.pushCardMap) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.code) 
		.append(this.name) 
		.append(this.separate) 
		.append(this.memo) 
		.append(this.pushCardMap) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("code", this.code) 
				.append("name", this.name) 
				.append("separate", this.separate) 
				.append("memo", this.memo) 
				.append("pushCardMap", this.pushCardMap) 
												.toString();
	}

}



