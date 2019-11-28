package com.redxun.sys.bo.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.StringUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 *  
 * 描述：表单实体对象实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2017-02-15 15:02:18
 * 版权：广州红迅软件
 * </pre>
 */
@javax.persistence.Table(name = "SYS_BO_ENTITY")
@TableDefine(title = "表单实体对象")
@XStreamAlias("sysBoEnt")
public class SysBoEnt extends BaseTenantEntity {
	
//	public final static String RELATION_TYPE_MAIN="main";
//	public final static String RELATION_TYPE_SUB="sub";
	
	public final static String SQL_FK="REF_ID_";
	
	public final static String SQL_PATH="PATH_";
	
	public final static String SQL_FK_STATEMENT="#{fk}";
	
	public final static String SQL_PK="ID_";
	
	public final static String COMPLEX_NAME="_name";
	
	public static  final String SUB_PRE="SUB_";
	
	public static  final String FIELD_TENANT="TENANT_ID_";
	
	public static  final String FIELD_INST="INST_ID_";
	
	public static  final String FIELD_INST_STATUS_="INST_STATUS_";
	
	public static  final String FIELD_CREATE_BY="CREATE_BY_";
	
	public static  final String FIELD_CREATE_USER="CREATE_USER_NAME_";
	
	public static  final String FIELD_CREATE_TIME="CREATE_TIME_";
	
	public static  final String FIELD_CREATE_DATE="CREATE_DATE_";
	
	public static  final String FIELD_UPDATE_BY="UPDATE_BY_";
	
	public static  final String FIELD_UPDATE_USER="UPDATE_USER_NAME_";
	
	public static  final String FIELD_UPDATE_TIME="UPDATE_TIME_";
	
	public static  final String FIELD_UPDATE_DATE="UPDATE_DATE_";
	
	public static  final String FIELD_GROUP="GROUP_ID_";
	
	public static  final String FIELD_GROUP_NAME="GROUP_NAME_";
	
	
	
	public static  final String FIELD_PARENTID="PARENT_ID_";
	
	public static  final String GENMODE_DB="db";
	
	public static  final String GENMODE_CREATE="create";

	public static  final String GENMODE_FORM="form";

	private boolean hasRead=false;
	
	private Map<String,String> commonFieldMap=new HashMap<>();
	
	
	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "注释")
	@Column(name = "COMMENT_")
	protected String comment; 
	@FieldDefine(title = "表名")
	@Column(name = "TABLE_NAME_")
	protected String tableName; 
	@FieldDefine(title = "数据源名称")
	@Column(name = "DS_NAME_")
	protected String dsName; 
	@FieldDefine(title = "是否生成物理表")
	@Column(name = "GEN_TABLE_")
	protected String genTable; 
	
	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	protected String treeId; 
	
	/**
	 * 是否引用表单
	 */
	protected int isRef=0;
	
	@FieldDefine(title = "主键字段")
	@Column(name = "PK_FIELD_")
	protected String pkField;
	
	
	@FieldDefine(title = "父键字段")
	@Column(name = "PARENT_FIELD_")
	protected String parentField;
	
	@FieldDefine(title = "分类")
	@Column(name = "CATEGORY_ID_")
	protected String categoryId="";
	
	/**
	 * 关联表单
	 */
	protected String formAlias="";
	
	@FieldDefine(title = "扩展JSON")
	@Column(name = "EXT_JSON_")
	protected String extJson="";
	
	/**
	 * 是否主实体。
	 */
	protected Integer isMain=0;
	
	/**
	 * 主实体ID。
	 */
	protected String mainId="";
	

	/**
	 * 生成模式
	 * create: 直接设计
	 * form: 通过表单生成
	 * db :  从数据库生成
	 */
	protected String genMode="";


	/**
	 * 是否生成模型（不属于表字段）。
	 */
	protected String isCreateMode="";
	
	
	
	@FieldDefine(title = "是否树形")
	@Column(name = "TREE_")
	protected String tree ="NO";
	
	
	
	@Transient
	protected String boDefId;
	
	@Transient
	protected String setId;
	
	/**
	 * 处理在提交过程中的字段属性配置
	 */
	@Transient
	protected String sysBoAttrsJson;
	
	@Transient
	protected String mainField;

	@Transient
	protected String subField;

	/**
	 * 关联关系。
	 */
	@Transient
	protected String relationType=SysBoRelation.RELATION_MAIN;
	
	@Transient
	protected List<SysBoAttr> sysBoAttrs = new ArrayList<SysBoAttr>();
	
	@Transient
	protected List<SysBoEnt> boEntList=new ArrayList<SysBoEnt>();
	
	@Transient
	protected String version=SysBoDef.VERSION_NEW;
	
	@Transient
	protected boolean hasConflict=false;
	
	@Transient
	protected String delFromEnt = "0";
	
	public SysBoEnt() {
	}

	public String getIsCreateMode() {
		return isCreateMode;
	}

	public void setIsCreateMode(String isCreateMode) {
		this.isCreateMode = isCreateMode;
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysBoEnt(String in_id) {
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

	public String getPkField() {
		if(StringUtil.isEmpty(pkField)){
			return SQL_PK;
		}
		return pkField;
	}

	public void setPkField(String pkField) {
		this.pkField = pkField;
	}

	public String getParentField() {
		if(StringUtil.isEmpty(parentField)){
			return SQL_FK;
		}
		return parentField;
	}

	public void setParentField(String parentField) {
		this.parentField = parentField;
	}

	public void setId(String aValue) {
		this.id = aValue;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}
	
	/**
	 * 返回 名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	/**
	 * 返回 注释
	 * @return
	 */
	public String getComment() {
		return this.comment;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	/**
	 * 返回 表名
	 * @return
	 */
	public String getTableName() {
		return this.tableName;
		
	}
	public void setDsName(String dsName) {
		this.dsName = dsName;
	}
	
	/**
	 * 返回 数据源名称
	 * @return
	 */
	public String getDsName() {
		return this.dsName;
	}
	public void setGenTable(String genTable) {
		this.genTable = genTable;
	}
	
	/**
	 * 返回 是否生成物理表
	 * @return
	 */
	public String getGenTable() {
		return this.genTable;
	}
	
	public List<SysBoAttr> getSysBoAttrs() {
		return sysBoAttrs;
	}

	public void setSysBoAttrs(List<SysBoAttr> in_sysBoAttr) {
		this.sysBoAttrs = in_sysBoAttr;
	}


	public String getRelationType() {
		return relationType;
	}

	public void setRelationType(String relationType) {
		this.relationType = relationType;
	}

	public List<SysBoEnt> getBoEntList() {
		return boEntList;
	}

	public void setBoEntList(List<SysBoEnt> boEntList) {
		this.boEntList = boEntList;
	}
	
	public void clearSubBoEnt(){
		this.boEntList.clear();
	}
	
	/**
	 * 添加实体。
	 * @param boEnt
	 */
	public void addBoEnt(SysBoEnt boEnt){
		this.boEntList.add(boEnt);
	}
	
	public void addBoAttr(SysBoAttr boAttr){
		//相同属性。
		hasEqualName(boAttr);
		this.sysBoAttrs.add(boAttr);
	}
	
	private void hasEqualName(SysBoAttr boAttr){
		String name=boAttr.getName();
		for(SysBoAttr attr:this.sysBoAttrs){
			if(name.equalsIgnoreCase(attr.getName())){
				boAttr.setContain(true);
				//设置有字段冲突。
				this.setHasConflict(true);
				return ;
			}
		}
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	public String isDelFromEnt() {
		return delFromEnt;
	}

	public void setDelFromEnt(String delFromEnt) {
		this.delFromEnt = delFromEnt;
	}

	public String getTreeId() {
		return treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public boolean isHasConflict() {
		return hasConflict;
	}

	public void setHasConflict(boolean hasConflict) {
		this.hasConflict = hasConflict;
	}

	public int getIsRef() {
		return isRef;
	}

	public void setIsRef(int isRef) {
		this.isRef = isRef;
	}

	public String getFormAlias() {
		return formAlias;
	}

	public void setFormAlias(String formAlias) {
		this.formAlias = formAlias;
	}

	public String getExtJson() {
		return extJson;
	}

	public void setExtJson(String extJson) {
		this.extJson = extJson;
	}

	public String getTree() {
		return tree;
	}

	public void setTree(String tree) {
		this.tree = tree;
	}

	public String getSysBoAttrsJson() {
		return sysBoAttrsJson;
	}

	public void setSysBoAttrsJson(String sysBoAttrsJson) {
		this.sysBoAttrsJson = sysBoAttrsJson;
	}

	public String getMainField() {
		return mainField;
	}

	public void setMainField(String mainField) {
		this.mainField = mainField;
	}

	public String getSubField() {
		return subField;
	}

	public void setSubField(String subField) {
		this.subField = subField;
	}
	
	public Integer getIsMain() {
		return isMain;
	}

	public void setIsMain(Integer isMain) {
		this.isMain = isMain;
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public String getGenMode() {
		return genMode;
	}
	
	public boolean isDbMode(){
		return SysBoEnt.GENMODE_DB.equals(genMode);
	}

	public void setGenMode(String genMode) {
		this.genMode = genMode;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysBoEnt)) {
			return false;
		}
		SysBoEnt rhs = (SysBoEnt) object;
		return new EqualsBuilder()
		.append(this.name, rhs.name) 
		.append(this.tableName, rhs.tableName) 
		.append(this.dsName, rhs.dsName) 
		.isEquals();
	}
	
	public Map<String,String> getCommonfields(){
		if(hasRead){
			return commonFieldMap;
		}
		
		List<SysBoAttr> attrs= this.getSysBoAttrs();
		for(SysBoAttr attr:attrs){
			String control=attr.getControl();
			if("mini-commonfield".equals(control)){
				JSONObject json=JSONObject.parseObject(attr.getExtJson());
				String field=json.getString("refField");
				commonFieldMap.put(field, attr.getName());
			}
		}
		this.hasRead=true;
		return commonFieldMap;
		
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("comment", this.comment) 
				.append("tableName", this.tableName) 
				.append("dsName", this.dsName) 
				.append("genTable", this.genTable).toString();
	}

	public String getUpperName() {
		return this.name.toUpperCase();
	}

}



