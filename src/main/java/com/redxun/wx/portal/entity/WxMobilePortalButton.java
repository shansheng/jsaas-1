package com.redxun.wx.portal.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * @author Louis
 * for 移动门户
 */
public class WxMobilePortalButton extends BaseTenantEntity {

	private static final long serialVersionUID = 1L;


	@FieldDefine(title = "ID")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "KEY值")
	@Column(name = "KEY_")
	protected String key;

	@FieldDefine(title = "功能按钮名称")
	@Column(name = "NAME_")
	protected String name;

	@FieldDefine(title = "APP应用ID")
	@Column(name = "APP_ID_")
	protected String appId;

	@FieldDefine(title = "图标")
	@Column(name = "ICON_")
	protected String icon;

	@FieldDefine(title = "按钮链接地址")
	@Column(name = "URL_")
	protected String url;

	@FieldDefine(title = "所属类别ID")
	@Column(name = "TYPE_ID_")
	protected String typeId;

	@FieldDefine(title = "应用类型")
	@Column(name = "APP_TYPE_")
	protected String appType;

	@FieldDefine(title = "入口别名")
	@Column(name = "portAlias")
	protected String portAlias;

	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public Integer getSn() {
		return sn;
	}

	public void setSn(Integer sn) {
		this.sn = sn;
	}

	public String getAppType() {
		return appType;
	}

	public void setAppType(String appType) {
		this.appType = appType;
	}

	public String getPortAlias() {
		return portAlias;
	}

	public void setPortAlias(String portAlias) {
		this.portAlias = portAlias;
	}
}
