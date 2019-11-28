package com.redxun.wx.portal.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * @author Louis
 * for 移动门户
 */
@Entity
@Table(name = "WX_MOBILE_PORTAL")
@TableDefine(title = "微信门户类别")
public class WxMobilePortal extends BaseTenantEntity {
	
	private static final long serialVersionUID = 1L;

	@FieldDefine(title = "ID")
	@Id
	@Column(name = "ID_")
	protected String id;
	
	@FieldDefine(title = "门户类别名称")
	@Column(name = "NAME_")
	protected String name;
	
	@FieldDefine(title = "门户类别id")
	@Column(name = "TYPE_ID_")
	protected String typeId;
	
	@FieldDefine(title = "应用类型")
	@Column(name = "BTN_TYPE_")
	protected String btnType;
	
	
	public WxMobilePortal() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
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

	public String getBtnType() {
		return btnType;
	}

	public void setBtnType(String btnType) {
		this.btnType = btnType;
	}
}
