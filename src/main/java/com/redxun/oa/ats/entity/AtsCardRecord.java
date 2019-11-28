



package com.redxun.oa.ats.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.DateFormatUtil;

/**
 * <pre>
 *  
 * 描述：打卡记录实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_card_record")
@TableDefine(title = "打卡记录")
public class AtsCardRecord extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "考勤卡号")
	@Column(name = "CARD_NUMBER")
	protected String cardNumber; 
	@FieldDefine(title = "打卡日期")
	@Column(name = "CARD_DATE")
	protected Date cardDate; 
	@FieldDefine(title = "打卡来源")
	@Column(name = "CARD_SOURCE")
	protected Short cardSource; 
	@FieldDefine(title = "打卡位置")
	@Column(name = "CARD_PLACE")
	protected String cardPlace; 
	
	//打卡时间
	protected String cardTime;
	//用户编号
	protected String userId;
	//用户姓名
	protected String userName;
	//打卡来源名称
	protected String cardSourceName;
	
	public void setCardSourceName(String cardSourceName) {
		this.cardSourceName = cardSourceName;
	}
	public String getCardSourceName() {
		return cardSourceName;
	}
	
	public AtsCardRecord() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsCardRecord(String in_id) {
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
	
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	
	/**
	 * 返回 考勤卡号
	 * @return
	 */
	public String getCardNumber() {
		return this.cardNumber;
	}
	public void setCardDate(Date cardDate) {
		this.cardDate = cardDate;
	}
	
	/**
	 * 返回 打卡日期
	 * @return
	 */
	public Date getCardDate() {
		return this.cardDate;
	}
	
	public String getCardTime(){
		return DateFormatUtil.format(this.cardDate, "HH:mm:ss");
	}
	public void setCardSource(Short cardSource) {
		this.cardSource = cardSource;
		if(CardResoureType.BUDAKA==this.cardSource) {
			setCardSourceName("补打卡");
		}
		if(CardResoureType.EXECL==this.cardSource) {
			setCardSourceName("EXCEL");
		}
		if(CardResoureType.WEIXIN==this.cardSource) {
			setCardSourceName("企业微信");
		}
	}
	
	/**
	 * 返回 打卡来源
	 * @return
	 */
	public Short getCardSource() {
		return this.cardSource;
	}
	public void setCardPlace(String cardPlace) {
		this.cardPlace = cardPlace;
	}
	
	/**
	 * 返回 打卡位置
	 * @return
	 */
	public String getCardPlace() {
		return this.cardPlace;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsCardRecord)) {
			return false;
		}
		AtsCardRecord rhs = (AtsCardRecord) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.cardNumber, rhs.cardNumber) 
		.append(this.cardDate, rhs.cardDate) 
		.append(this.cardSource, rhs.cardSource) 
		.append(this.cardPlace, rhs.cardPlace) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.cardNumber) 
		.append(this.cardDate) 
		.append(this.cardSource) 
		.append(this.cardPlace) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("cardNumber", this.cardNumber) 
				.append("cardDate", this.cardDate) 
				.append("cardSource", this.cardSource) 
				.append("cardPlace", this.cardPlace) 
												.toString();
	}

	//打卡来源
	public static class CardResoureType {
		/**
		 * 补打卡  0
		 */
		public static Short BUDAKA = 0;
		/**
		 * 企业微信 1
		 */
		public static Short WEIXIN = 1;
		/**
		 * EXCEL文档 2
		 */
		public static Short EXECL = 2;
	}
}




