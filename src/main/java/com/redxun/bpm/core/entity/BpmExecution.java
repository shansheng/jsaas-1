package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.core.entity.BaseEntity;
import com.redxun.core.util.ExceptionUtil;

/**
 * ACT_RU_EXECUTION表操作类
 * @author mansan
 */
public class BpmExecution extends BaseEntity implements Cloneable
{
	
	private static Logger logger= LogManager.getLogger(BpmExecution.class);
	
	private String id;
	private Integer revision;
	private String processInstanceId;
	private String businessKey;
	private String processDefinitionId;
	private String activityId;
	private Short isActive;
	private Short isConcurrent;
	private Short isScope;
	private String parentId;
	private String superExecutionId;
	private Short isEventScope;
	private Integer suspensionState;
	private Integer cachedEntityState;
	private String tenantId;
	
	/**
	 * 构建execution树结构。
	 */
	private List<BpmExecution> children=new ArrayList<BpmExecution>();

	public BpmExecution()
	{
		
	}
	
	public BpmExecution(BpmExecution ex)
	{
		this.revision=ex.getRevision();
		this.processInstanceId=ex.getProcessInstanceId();
		//this.businessKey=executionEntity.getBusinessKey();
		this.processDefinitionId=ex.getProcessDefinitionId();
		this.activityId=ex.getActivityId();
		this.isActive=ex.getIsActive();
		this.isConcurrent=ex.getIsConcurrent();
		this.isScope=ex.isScope;
		this.parentId=ex.getParentId();
		this.superExecutionId=ex.getSuperExecutionId();
		this.isEventScope=ex.getIsEventScope();
		this.suspensionState=ex.getSuspensionState();
		this.cachedEntityState=ex.getCachedEntityState();
		
	}
	
	/**
	 * 根据executionEntity复制excution。
	 * @param executionEntity
	 */
	public BpmExecution(ExecutionEntity executionEntity)
	{
		this.revision=executionEntity.getRevision();
		this.processInstanceId=executionEntity.getProcessInstanceId();
		//this.businessKey=executionEntity.getBusinessKey();
		this.processDefinitionId=executionEntity.getProcessDefinitionId();
		this.activityId=executionEntity.getActivityId();
		this.isActive=executionEntity.isActive()?(short)1:0;
		this.isConcurrent=executionEntity.isConcurrent()?(short)1:0;
		this.isScope=executionEntity.isScope()?(short)1:0;
		this.parentId=executionEntity.getParentId();
		this.superExecutionId=executionEntity.getSuperExecutionId();
		this.isEventScope=executionEntity.isEventScope()?(short)1:0;
		this.suspensionState=executionEntity.getSuspensionState();
		this.cachedEntityState=executionEntity.getCachedEntityState();
	}
		
	
	public Integer getRevision()
	{
		return revision;
	}
	
	public void setRevision(Integer revision)
	{
		this.revision = revision;
	}
	
	public String getProcessInstanceId()
	{
		return processInstanceId;
	}
	
	public void setProcessInstanceId(String processInstanceId)
	{
		this.processInstanceId = processInstanceId;
	}
	
	public boolean isMain(){
		return this.processInstanceId.equals(this.id);
	}
	
	public String getBusinessKey()
	{
		return businessKey;
	}
	public void setBusinessKey(String businessKey)
	{
		this.businessKey = businessKey;
	}
	public String getParentId()
	{
		return parentId;
	}
	public void setParentId(String parentId)
	{
		this.parentId = parentId;
	}
	public String getProcessDefinitionId()
	{
		return processDefinitionId;
	}
	public void setProcessDefinitionId(String processDefinitionId)
	{
		this.processDefinitionId = processDefinitionId;
	}
	public String getSuperExecutionId()
	{
		return superExecutionId;
	}
	public void setSuperExecutionId(String superExecutionId)
	{
		this.superExecutionId = superExecutionId;
	}
	public String getActivityId()
	{
		return activityId;
	}
	public void setActivityId(String activityId)
	{
		this.activityId = activityId;
	}
	public Short getIsActive()
	{
		return isActive;
	}
	public void setIsActive(Short isActive)
	{
		this.isActive = isActive;
	}
	public Short getIsConcurrent()
	{
		return isConcurrent;
	}
	public void setIsConcurrent(Short isConcurrent)
	{
		this.isConcurrent = isConcurrent;
	}
	public Short getIsScope()
	{
		return isScope;
	}
	public void setIsScope(Short isScope)
	{
		this.isScope = isScope;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public Short getIsEventScope() {
		return isEventScope;
	}

	public void setIsEventScope(Short isEventScope) {
		this.isEventScope = isEventScope;
	}

	public Integer getSuspensionState() {
		return suspensionState;
	}

	public void setSuspensionState(Integer suspensionState) {
		this.suspensionState = suspensionState;
	}

	public Integer getCachedEntityState() {
		return cachedEntityState;
	}

	public void setCachedEntityState(Integer cachedEntityState) {
		this.cachedEntityState = cachedEntityState;
	}

	public String getTenantId() {
		return tenantId;
	}

	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}

	@Override
	public String getIdentifyLabel() {
		return id;
	}

	@Override
	public Serializable getPkId() {
		return id;
	}

	@Override
	public void setPkId(Serializable pkId) {
	}

	public List<BpmExecution> getChildren() {
		return children;
	}

	public void setChildren(List<BpmExecution> children) {
		this.children = children;
	}
	
	public void addChildren(BpmExecution children) {
		this.children.add(children);
	}
	
	
	@Override
	public Object clone()  {
		BpmExecution o = null;
		try{
			o = (BpmExecution)super.clone();
		}catch(CloneNotSupportedException e){
			logger.error(ExceptionUtil.getExceptionMessage(e));
		}
		return o;
	}

}
