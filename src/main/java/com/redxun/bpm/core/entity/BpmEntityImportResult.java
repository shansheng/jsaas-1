package com.redxun.bpm.core.entity;

/**
 * 流程实体导入结果
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmEntityImportResult {
	/**
	 * 实体类型-解决方案=SOLUTION
	 */
	public final static String ENTITY_TYPE_SOLUCTION="SOLUTION";
	/**
	 * 实体类型-流程定义=BPM_DEF
	 */
	public final static String ENTITY_TYPE_BPM_DEF="BPM_DEF";
	/**
	 * 实体类型-流程有单=BPM_FORM
	 */
	public final static String ENTITY_TYPE_BPM_FORM="BPM_FORM";
	
	/**
	 * 导入方式-新建=NEW
	 */
	public final static String IMP_TYPE_NEW="NEW";
	/**
	 * 导入方式-更新=UPDATE
	 */
	public final static String IMP_TYPE_UPDATE="UPDATE";
	/**
	 * 导入方式-重新建=RENEW
	 */
	public final static String IMP_TYPE_RENEW="RENEW";
	
	/**
	 * 实体类型，包括解决方案SOLUTION，流程定义(BPM_DEF)，流程表单(BPM_FORM)
	 */
	private String entityType;
	/**
	 * 导入方式，添加新（NEW），更新（UPDATE),重命名新(RENEW)
	 */
	private String importType;
	/**
	 * 导入的实体，包括BpmSolution,BpmDefExt,BpmFormView
	 */
	private Object bpmEntity;
	/**
	 * 新导入的Key
	 */
	private String newKey;
	/**
	 * 名称
	 */
	private String name;
	
	public BpmEntityImportResult() {
		
	}
	
	public BpmEntityImportResult(String entityType,String importType,Object bpmEntity){
		this.entityType=entityType;
		this.importType=importType;
		this.bpmEntity=bpmEntity;
	}
	
	public BpmEntityImportResult(String entityType,String importType,Object bpmEntity,String newKey){
		this.entityType=entityType;
		this.importType=importType;
		this.bpmEntity=bpmEntity;
		this.newKey=newKey;
	}
	
	public String getEntityType() {
		return entityType;
	}
	
	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}
	
	public String getImportType() {
		return importType;
	}
	
	public void setImportType(String importType) {
		this.importType = importType;
	}
	
	public Object getBpmEntity() {
		return bpmEntity;
	}
	
	public void setBpmEntity(Object bpmEntity) {
		this.bpmEntity = bpmEntity;
	}

	public String getNewKey() {
		return newKey;
	}

	public void setNewKey(String newKey) {
		this.newKey = newKey;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
