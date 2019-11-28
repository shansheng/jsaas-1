



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
 * 描述：取卡规则实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_card_rule")
@TableDefine(title = "取卡规则")
public class AtsCardRule extends BaseTenantEntity {

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
	@FieldDefine(title = "上班取卡提前(小时)")
	@Column(name = "START_NUM")
	protected Double startNum; 
	@FieldDefine(title = "下班取卡延后(小时)")
	@Column(name = "END_NUM")
	protected Double endNum; 
	@FieldDefine(title = "最短取卡间隔(分钟）")
	@Column(name = "TIME_INTERVAL")
	protected Double timeInterval; 
	@FieldDefine(title = "适用段次")
	@Column(name = "SEGMENT_NUM")
	protected Integer segmentNum; 
	@FieldDefine(title = "是否默认")
	@Column(name = "IS_DEFAULT")
	protected Short isDefault; 
	@FieldDefine(title = "第一次上班取卡范围开始时数")
	@Column(name = "SEG_BEF_FIR_START_NUM")
	protected Double segBefFirStartNum; 
	@FieldDefine(title = "第一次上班取卡范围结束时数")
	@Column(name = "SEG_BEF_FIR_END_NUM")
	protected Double segBefFirEndNum; 
	@FieldDefine(title = "第一次上班取卡方式")
	@Column(name = "SEG_BEF_FIR_TAKE_CARD_TYPE")
	protected Short segBefFirTakeCardType; 
	@FieldDefine(title = "第一次下班取卡范围开始时数")
	@Column(name = "SEG_AFT_FIR_START_NUM")
	protected Double segAftFirStartNum; 
	@FieldDefine(title = "第一次下班取卡范围结束时数")
	@Column(name = "SEG_AFT_FIR_END_NUM")
	protected Double segAftFirEndNum; 
	@FieldDefine(title = "第一次下班取卡方式")
	@Column(name = "SEG_AFT_FIR_TAKE_CARD_TYPE")
	protected Short segAftFirTakeCardType; 
	@FieldDefine(title = "第二次上班取卡范围开始时数")
	@Column(name = "SEG_BEF_SEC_START_NUM")
	protected Double segBefSecStartNum; 
	@FieldDefine(title = "第二次上班取卡范围结束时数")
	@Column(name = "SEG_BEF_SEC_END_NUM")
	protected Double segBefSecEndNum; 
	@FieldDefine(title = "第二次上班取卡方式")
	@Column(name = "SEG_BEF_SEC_TAKE_CARD_TYPE")
	protected Short segBefSecTakeCardType; 
	@FieldDefine(title = "第二次下班取卡范围开始时数")
	@Column(name = "SEG_AFT_SEC_START_NUM")
	protected Double segAftSecStartNum; 
	@FieldDefine(title = "第二次下班取卡范围结束时数")
	@Column(name = "SEG_AFT_SEC_END_NUM")
	protected Double segAftSecEndNum; 
	@FieldDefine(title = "第二次下班取卡方式")
	@Column(name = "SEG_AFT_SEC_TAKE_CARD_TYPE")
	protected Short segAftSecTakeCardType; 
	@FieldDefine(title = "第一段间分配类型")
	@Column(name = "SEG_FIR_ASSIGN_TYPE")
	protected Short segFirAssignType; 
	@FieldDefine(title = "第一段间分配段次")
	@Column(name = "SEG_FIR_ASSIGN_SEGMENT")
	protected Short segFirAssignSegment; 
	@FieldDefine(title = "第二段间分配类型")
	@Column(name = "SEG_SEC_ASSIGN_TYPE")
	protected Short segSecAssignType; 
	@FieldDefine(title = "第二段间分配段次")
	@Column(name = "SEG_SEC_ASSIGN_SEGMENT")
	protected Short segSecAssignSegment; 
	
	
	
	
	public AtsCardRule() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsCardRule(String in_id) {
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
	public void setStartNum(Double startNum) {
		this.startNum = startNum;
	}
	
	/**
	 * 返回 上班取卡提前(小时)
	 * @return
	 */
	public Double getStartNum() {
		return this.startNum;
	}
	public void setEndNum(Double endNum) {
		this.endNum = endNum;
	}
	
	/**
	 * 返回 下班取卡延后(小时)
	 * @return
	 */
	public Double getEndNum() {
		return this.endNum;
	}
	public void setTimeInterval(Double timeInterval) {
		this.timeInterval = timeInterval;
	}
	
	/**
	 * 返回 最短取卡间隔(分钟）
	 * @return
	 */
	public Double getTimeInterval() {
		return this.timeInterval;
	}
	public void setSegmentNum(Integer segmentNum) {
		this.segmentNum = segmentNum;
	}
	
	/**
	 * 返回 适用段次
	 * @return
	 */
	public Integer getSegmentNum() {
		return this.segmentNum;
	}
	public void setIsDefault(Short isDefault) {
		this.isDefault = isDefault;
	}
	
	/**
	 * 返回 是否默认
	 * @return
	 */
	public Short getIsDefault() {
		return this.isDefault;
	}
	public void setSegBefFirStartNum(Double segBefFirStartNum) {
		this.segBefFirStartNum = segBefFirStartNum;
	}
	
	/**
	 * 返回 第一次上班取卡范围开始时数
	 * @return
	 */
	public Double getSegBefFirStartNum() {
		return this.segBefFirStartNum;
	}
	public void setSegBefFirEndNum(Double segBefFirEndNum) {
		this.segBefFirEndNum = segBefFirEndNum;
	}
	
	/**
	 * 返回 第一次上班取卡范围结束时数
	 * @return
	 */
	public Double getSegBefFirEndNum() {
		return this.segBefFirEndNum;
	}
	public void setSegBefFirTakeCardType(Short segBefFirTakeCardType) {
		this.segBefFirTakeCardType = segBefFirTakeCardType;
	}
	
	/**
	 * 返回 第一次上班取卡方式
	 * @return
	 */
	public Short getSegBefFirTakeCardType() {
		return this.segBefFirTakeCardType;
	}
	public void setSegAftFirStartNum(Double segAftFirStartNum) {
		this.segAftFirStartNum = segAftFirStartNum;
	}
	
	/**
	 * 返回 第一次下班取卡范围开始时数
	 * @return
	 */
	public Double getSegAftFirStartNum() {
		return this.segAftFirStartNum;
	}
	public void setSegAftFirEndNum(Double segAftFirEndNum) {
		this.segAftFirEndNum = segAftFirEndNum;
	}
	
	/**
	 * 返回 第一次下班取卡范围结束时数
	 * @return
	 */
	public Double getSegAftFirEndNum() {
		return this.segAftFirEndNum;
	}
	public void setSegAftFirTakeCardType(Short segAftFirTakeCardType) {
		this.segAftFirTakeCardType = segAftFirTakeCardType;
	}
	
	/**
	 * 返回 第一次下班取卡方式
	 * @return
	 */
	public Short getSegAftFirTakeCardType() {
		return this.segAftFirTakeCardType;
	}
	public void setSegBefSecStartNum(Double segBefSecStartNum) {
		this.segBefSecStartNum = segBefSecStartNum;
	}
	
	/**
	 * 返回 第二次上班取卡范围开始时数
	 * @return
	 */
	public Double getSegBefSecStartNum() {
		return this.segBefSecStartNum;
	}
	public void setSegBefSecEndNum(Double segBefSecEndNum) {
		this.segBefSecEndNum = segBefSecEndNum;
	}
	
	/**
	 * 返回 第二次上班取卡范围结束时数
	 * @return
	 */
	public Double getSegBefSecEndNum() {
		return this.segBefSecEndNum;
	}
	public void setSegBefSecTakeCardType(Short segBefSecTakeCardType) {
		this.segBefSecTakeCardType = segBefSecTakeCardType;
	}
	
	/**
	 * 返回 第二次上班取卡方式
	 * @return
	 */
	public Short getSegBefSecTakeCardType() {
		return this.segBefSecTakeCardType;
	}
	public void setSegAftSecStartNum(Double segAftSecStartNum) {
		this.segAftSecStartNum = segAftSecStartNum;
	}
	
	/**
	 * 返回 第二次下班取卡范围开始时数
	 * @return
	 */
	public Double getSegAftSecStartNum() {
		return this.segAftSecStartNum;
	}
	public void setSegAftSecEndNum(Double segAftSecEndNum) {
		this.segAftSecEndNum = segAftSecEndNum;
	}
	
	/**
	 * 返回 第二次下班取卡范围结束时数
	 * @return
	 */
	public Double getSegAftSecEndNum() {
		return this.segAftSecEndNum;
	}
	public void setSegAftSecTakeCardType(Short segAftSecTakeCardType) {
		this.segAftSecTakeCardType = segAftSecTakeCardType;
	}
	
	/**
	 * 返回 第二次下班取卡方式
	 * @return
	 */
	public Short getSegAftSecTakeCardType() {
		return this.segAftSecTakeCardType;
	}
	public void setSegFirAssignType(Short segFirAssignType) {
		this.segFirAssignType = segFirAssignType;
	}
	
	/**
	 * 返回 第一段间分配类型
	 * @return
	 */
	public Short getSegFirAssignType() {
		return this.segFirAssignType;
	}
	public void setSegFirAssignSegment(Short segFirAssignSegment) {
		this.segFirAssignSegment = segFirAssignSegment;
	}
	
	/**
	 * 返回 第一段间分配段次
	 * @return
	 */
	public Short getSegFirAssignSegment() {
		return this.segFirAssignSegment;
	}
	public void setSegSecAssignType(Short segSecAssignType) {
		this.segSecAssignType = segSecAssignType;
	}
	
	/**
	 * 返回 第二段间分配类型
	 * @return
	 */
	public Short getSegSecAssignType() {
		return this.segSecAssignType;
	}
	public void setSegSecAssignSegment(Short segSecAssignSegment) {
		this.segSecAssignSegment = segSecAssignSegment;
	}
	
	/**
	 * 返回 第二段间分配段次
	 * @return
	 */
	public Short getSegSecAssignSegment() {
		return this.segSecAssignSegment;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsCardRule)) {
			return false;
		}
		AtsCardRule rhs = (AtsCardRule) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.startNum, rhs.startNum) 
		.append(this.endNum, rhs.endNum) 
		.append(this.timeInterval, rhs.timeInterval) 
		.append(this.segmentNum, rhs.segmentNum) 
		.append(this.isDefault, rhs.isDefault) 
		.append(this.segBefFirStartNum, rhs.segBefFirStartNum) 
		.append(this.segBefFirEndNum, rhs.segBefFirEndNum) 
		.append(this.segBefFirTakeCardType, rhs.segBefFirTakeCardType) 
		.append(this.segAftFirStartNum, rhs.segAftFirStartNum) 
		.append(this.segAftFirEndNum, rhs.segAftFirEndNum) 
		.append(this.segAftFirTakeCardType, rhs.segAftFirTakeCardType) 
		.append(this.segBefSecStartNum, rhs.segBefSecStartNum) 
		.append(this.segBefSecEndNum, rhs.segBefSecEndNum) 
		.append(this.segBefSecTakeCardType, rhs.segBefSecTakeCardType) 
		.append(this.segAftSecStartNum, rhs.segAftSecStartNum) 
		.append(this.segAftSecEndNum, rhs.segAftSecEndNum) 
		.append(this.segAftSecTakeCardType, rhs.segAftSecTakeCardType) 
		.append(this.segFirAssignType, rhs.segFirAssignType) 
		.append(this.segFirAssignSegment, rhs.segFirAssignSegment) 
		.append(this.segSecAssignType, rhs.segSecAssignType) 
		.append(this.segSecAssignSegment, rhs.segSecAssignSegment) 
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
		.append(this.startNum) 
		.append(this.endNum) 
		.append(this.timeInterval) 
		.append(this.segmentNum) 
		.append(this.isDefault) 
		.append(this.segBefFirStartNum) 
		.append(this.segBefFirEndNum) 
		.append(this.segBefFirTakeCardType) 
		.append(this.segAftFirStartNum) 
		.append(this.segAftFirEndNum) 
		.append(this.segAftFirTakeCardType) 
		.append(this.segBefSecStartNum) 
		.append(this.segBefSecEndNum) 
		.append(this.segBefSecTakeCardType) 
		.append(this.segAftSecStartNum) 
		.append(this.segAftSecEndNum) 
		.append(this.segAftSecTakeCardType) 
		.append(this.segFirAssignType) 
		.append(this.segFirAssignSegment) 
		.append(this.segSecAssignType) 
		.append(this.segSecAssignSegment) 
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
				.append("startNum", this.startNum) 
				.append("endNum", this.endNum) 
				.append("timeInterval", this.timeInterval) 
				.append("segmentNum", this.segmentNum) 
				.append("isDefault", this.isDefault) 
				.append("segBefFirStartNum", this.segBefFirStartNum) 
				.append("segBefFirEndNum", this.segBefFirEndNum) 
				.append("segBefFirTakeCardType", this.segBefFirTakeCardType) 
				.append("segAftFirStartNum", this.segAftFirStartNum) 
				.append("segAftFirEndNum", this.segAftFirEndNum) 
				.append("segAftFirTakeCardType", this.segAftFirTakeCardType) 
				.append("segBefSecStartNum", this.segBefSecStartNum) 
				.append("segBefSecEndNum", this.segBefSecEndNum) 
				.append("segBefSecTakeCardType", this.segBefSecTakeCardType) 
				.append("segAftSecStartNum", this.segAftSecStartNum) 
				.append("segAftSecEndNum", this.segAftSecEndNum) 
				.append("segAftSecTakeCardType", this.segAftSecTakeCardType) 
				.append("segFirAssignType", this.segFirAssignType) 
				.append("segFirAssignSegment", this.segFirAssignSegment) 
				.append("segSecAssignType", this.segSecAssignType) 
				.append("segSecAssignSegment", this.segSecAssignSegment) 
												.toString();
	}

}



