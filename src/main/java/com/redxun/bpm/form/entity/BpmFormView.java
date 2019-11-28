package com.redxun.bpm.form.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.StringUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 * 描述：BpmFormView实体类定义
 * 业务表单视图
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_FORM_VIEW")
@TableDefine(title = "业务表单视图")
@XStreamAlias("bpmFormView")
public class BpmFormView extends BaseTenantEntity {
	
	public final static String NO_FORM_VIEW_TIPS="<div style=\"border:solid 1px #ccc;width:100%;color:red;text-align:center\"><h2>没有配置业务方案审批表单，请联系管理员！</h2></div>";
	
	/**
	 * 应用程序级表单类型=_PROCESS
	 */
	public final static String SCOPE_PROCESS="_PROCESS";
	/**
	 * 开始级表单类型=_START
	 */
	public final static String SCOPE_START="_START";
	/**
	 * 明细级表单类型=_DETAIL
	 */
	public final static String SCOPE_DETAIL="_DETAIL";
	
	public final static String TYPE_FORM="FORM";
	
//	public final static String TYPE_PRINT="PRINT";
	
	public final static String TYPE_MOBILE="MOBILE";
	
	/**
	 * 初始状态
	 */
	public final static String STATUS_INIT="INIT";
	/**
	 * 发布状态
	 */
	public final static String STATUS_DEPLOYED="DEPLOYED";
	/**
	 * 表单类型-在线设计表单=ONLINE-DESIGN
	 */
	public final static String FORM_TYPE_ONLINE_DESIGN="ONLINE-DESIGN";
	/**
	 * 表单类型-自定义表单=SEL-DEV
	 */
	public final static String FORM_TYPE_SEL_DEV="SEL-DEV";
	/**
	 * 通过BO生成。
	 */
	public final static String FORM_TYPE_GENBYBO="GENBYBO";
	
	/**
	 * 表单类型-复合表单=CMP
	 */
	public final static String FORM_TYPE_CMP="CMP";
	
	
	public final static String PAGE_TAG="#page#";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "VIEW_ID_")
	protected String viewId;
	/* 名称 */
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	@Size(max = 255)
	@NotEmpty
	protected String name;
	/* 标识键 */
	@FieldDefine(title = "标识键")
	@Column(name = "KEY_")
	@Size(max = 100)
	@NotEmpty
	protected String key;
	/* 类型 */
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	@Size(max = 50)
	@NotEmpty
	protected String type;
	/* 表单tab标题 */
	@FieldDefine(title = "表单tab标题")
	@Column(name = "TITLE_")
	@Size(max = 2000)
	protected String title;
	/* 表单视图模板 */
	@FieldDefine(title = "表单视图模板")
	@Column(name = "TEMPLATE_VIEW_")
	@Size(max = 2147483647)
	protected String templateView;
	
	@FieldDefine(title = "表单模板")
	@Column(name = "TEMPLATE_")
	@Size(max = 2147483647)
	protected String template;
	
	/* 表单展示URL */
	@FieldDefine(title = "表单展示URL")
	@Column(name = "RENDER_URL_")
	@Size(max = 255)
	protected String renderUrl;
	/* 版本号 */
	@FieldDefine(title = "版本号")
	@Column(name = "VERSION_")
	protected Integer version;
	/* 是否为主版本 */
	@FieldDefine(title = "是否为主版本")
	@Column(name = "IS_MAIN_")
	@Size(max = 20)
	@NotEmpty
	protected String isMain;
	
	/* 是否绑定模型 */
	@FieldDefine(title = "是否绑定模型")
	@Column(name = "IS_BIND_MD_")
	@Size(max = 20)
	protected String isBindMd;
	
	/* 是否绑定模型 */
	@FieldDefine(title = "模板ID")
	@Column(name = "TEMPLATE_ID_")
	@Size(max = 50)
	protected String templateId;
	
	@Transient
	protected String templateName;
	
	/* 隶属主版本视图ID */
	@FieldDefine(title = "隶属主版本视图ID")
	@Column(name = "MAIN_VIEW_ID_")
	@Size(max = 64)
	protected String mainViewId;
	/* 视图说明 */
	@FieldDefine(title = "视图说明")
	@Column(name = "DESCP_")
	@Size(max = 500)
	protected String descp;
	/* 状态 */
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	@Size(max = 20)
	@NotEmpty
	protected String status;
	
	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId;
	
	
	@FieldDefine(title = "BO实例ID")
	@Column(name = "BO_DEFID_")
	protected String boDefId="";
	
	@FieldDefine(title = "按钮定义")
	@Column(name = "BUTTON_DEF_")
	protected String buttonDef="";
	
	/**
	 * 分为normal和first
	 */
	@FieldDefine(title = "表单展示类型")
	@Column(name = "DISPLAY_TYPE_")
	@Size(max = 64)
	protected String displayType;
	
	@FieldDefine(title = "PDF模板")
	@Column(name = "PDF_TEMP_")
	@Size(max = 2147483647)
	protected String pdfTemp;
	
	
	
	/**
	 * 原来的viewId。
	 */
	@Transient
	protected String oldViewId=null;
	
	@Transient
	protected String oldBodefId=null;
	
	@Transient
	protected BpmSolFv bpmSolFv=null;
	
	@Transient
	protected String isCreate;

	/**
	 * Default Empty Constructor for class BpmFormView
	 */
	public BpmFormView() {
		super();
	}
	
	

	public BpmFormView(String viewId, String name, String key, String type) {
		super();
		this.viewId = viewId;
		this.name = name;
		this.key = key;
		this.type = type;
	}



	/**
	 * Default Key Fields Constructor for class BpmFormView
	 */
	public BpmFormView(String in_viewId) {
		this.setViewId(in_viewId);
	}


	
	
	/**
	 * 获取标题数组
	 * @return
	 */
	public String getTitle() {
		return title;
	}


	/**
	 * 设置标题数组
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}



	/**
	 * * @return String
	 */
	public String getViewId() {
		return this.viewId;
	}

	/**
	 * 设置
	 */
	public void setViewId(String aValue) {
		this.viewId = aValue;
	}

	/**
	 * 分类Id * @return String
	 */
	public String getTreeId() {
		return this.treeId;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	/**
	 * 设置 分类Id
	 */
	public void setTreeId(String aValue) {
		this.treeId=aValue;
	}



	public String getIsBindMd() {
		return isBindMd;
	}

	public void setIsBindMd(String isBindMd) {
		this.isBindMd = isBindMd;
	}

	/**
	 * 名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	public String getDisplayType() {
		if(StringUtil.isEmpty( this.displayType)){
			return "normal";
		}
		return displayType;
	}



	public void setDisplayType(String displayType) {
		this.displayType = displayType;
	}



	/**
	 * 设置 名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 标识键 * @return String
	 */
	public String getKey() {
		return this.key;
	}

	/**
	 * 设置 标识键
	 */
	public void setKey(String aValue) {
		this.key = aValue;
	}

	/**
	 * 类型 * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 类型
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * 表单视图模板 * @return String
	 */
	public String getTemplateView() {
		return this.templateView;
	}

	/**
	 * 设置 表单视图模板
	 */
	public void setTemplateView(String aValue) {
		this.templateView = aValue;
	}

	/**
	 * 表单展示URL * @return String
	 */
	public String getRenderUrl() {
		return this.renderUrl;
	}

	/**
	 * 设置 表单展示URL
	 */
	public void setRenderUrl(String aValue) {
		this.renderUrl = aValue;
	}

	/**
	 * 版本号 * @return Integer
	 */
	public Integer getVersion() {
		return this.version;
	}

	/**
	 * 设置 版本号
	 */
	public void setVersion(Integer aValue) {
		this.version = aValue;
	}

	/**
	 * 是否为主版本 * @return String
	 */
	public String getIsMain() {
		return this.isMain;
	}

	/**
	 * 设置 是否为主版本
	 */
	public void setIsMain(String aValue) {
		this.isMain = aValue;
	}

	/**
	 * 隶属主版本视图ID * @return String
	 */
	public String getMainViewId() {
		return this.mainViewId;
	}

	/**
	 * 设置 隶属主版本视图ID
	 */
	public void setMainViewId(String aValue) {
		this.mainViewId = aValue;
	}

	/**
	 * 视图说明 * @return String
	 */
	public String getDescp() {
		return this.descp;
	}

	/**
	 * 设置 视图说明
	 */
	public void setDescp(String aValue) {
		this.descp = aValue;
	}

	/**
	 * 状态 * @return String
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * 设置 状态
	 */
	public void setStatus(String aValue) {
		this.status = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.name;
	}

	@Override
	public Serializable getPkId() {
		return this.viewId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.viewId = (String) pkId;
	}
	

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getBoDefId() {
		return boDefId;
	}



	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	

	public String getOldViewId() {
		return oldViewId;
	}



	public void setOldViewId(String oldViewId) {
		this.oldViewId = oldViewId;
	}
	
	

	public String getOldBodefId() {
		return oldBodefId;
	}



	public void setOldBodefId(String oldBodefId) {
		this.oldBodefId = oldBodefId;
	}

	public String getPdfTemp() {
		return pdfTemp;
	}



	public void setPdfTemp(String pdfTemp) {
		this.pdfTemp = pdfTemp;
	}



	public BpmSolFv getBpmSolFv() {
		return bpmSolFv;
	}



	public void setBpmSolFv(BpmSolFv bpmSolFv) {
		this.bpmSolFv = bpmSolFv;
	}



	public String getButtonDef() {
		return buttonDef;
	}



	public void setButtonDef(String buttonDef) {
		this.buttonDef = buttonDef;
	}



	public String getTemplate() {
		return template;
	}



	public void setTemplate(String template) {
		this.template = template;
	}

	public void setIsCreate(String isCreate) {
		this.isCreate = isCreate;
	}
	
	public String getIsCreate() {
		return isCreate;
	}


	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormView)) {
			return false;
		}
		BpmFormView rhs = (BpmFormView) object;
		return new EqualsBuilder().append(this.viewId, rhs.viewId)
				.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
				.append(this.viewId)
				.append(this.name)
				.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("viewId", this.viewId).append("name", this.name).append("key", this.key).append("type", this.type).append("templateView", this.templateView).append("renderUrl", this.renderUrl).append("version", this.version).append("isMain", this.isMain).append("mainViewId", this.mainViewId).append("descp", this.descp)
				.append("status", this.status).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
