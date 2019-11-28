package com.redxun.bpm.core.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.sys.bo.entity.SysBoDef;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 流程解决方案的导入与导出方案实体
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@XStreamAlias("bpmSolutionExt")
public class BpmSolutionExt {
	
	/**
	 * 是否默认发布。
	 */
	private boolean deployed=false;
	
	/**
	 * 租户ID
	 */
	private String tenantId="";

	/**
	 * 流程解决方案
	 */
	private BpmSolution bpmSolution;
	/**
	 * 流程定义
	 */
	private BpmDefExt bpmDefExt;
	/**
	 * 在线表单视图
	 */
	private Set<BpmFormView> bpmFormViews=new HashSet<BpmFormView>();
	
	
	private Set<BpmMobileForm> mobileForms=new HashSet<BpmMobileForm>();
	
	/**
	 * 流程节点配置
	 */
	private List<BpmNodeSet> bpmNodeSets=new ArrayList<BpmNodeSet>();
	/**
	 * 流程节点变量配置
	 */
	private List<BpmSolVar> bpmSolVars=new ArrayList<BpmSolVar>();
	/**
	 * 流程节点视图配置
	 */
	private List<BpmSolFv> bpmSolFvs=new ArrayList<BpmSolFv>();
	/**
	 * 流程节点用户配置
	 */
	private List<BpmSolUser> bpmSolUsers=new ArrayList<BpmSolUser>();
	
	/**
	 * 流程配置用户组。
	 */
	private List<BpmSolUsergroup> bpmSolUsergroups=new ArrayList<BpmSolUsergroup>();
	
	/**
	 * bo定义
	 */
	private List<SysBoDef> sysBoDefs=new ArrayList<SysBoDef>(); 
	
	/**
	 * 催办导出。
	 */
	private List<BpmRemindDef> bpmRemindDefs=new ArrayList<BpmRemindDef>();

	/**
	 * 跳转规则导出
	 */
	private List<BpmJumpRule> bpmJumpRules = new ArrayList<BpmJumpRule>();
	
	
	/**
	 * 导入新旧BOID关系集合
	 * key是旧BOID,value是新BOID
	 */
	private Map<String,String> boIdRefs=new HashMap<String,String>();
	
	/**
	 * 导出表单权限。
	 */
	private List<BpmFormRight> bpmFormRights=new ArrayList<BpmFormRight>();
	
	
	public BpmSolutionExt() {
	
	}
	
	public BpmSolutionExt(BpmSolution bpmSolution) {
		this.bpmSolution=bpmSolution;
	}
	
	public BpmSolution getBpmSolution() {
		return bpmSolution;
	}
	
	public void setBpmSolution(BpmSolution bpmSolution) {
		this.bpmSolution = bpmSolution;
	}

	public BpmDefExt getBpmDefExt() {
		return bpmDefExt;
	}

	public void setBpmDefExt(BpmDefExt bpmDefExt) {
		this.bpmDefExt = bpmDefExt;
	}

	public List<BpmNodeSet> getBpmNodeSets() {
		return bpmNodeSets;
	}
	
	public void setBpmNodeSets(List<BpmNodeSet> bpmNodeSets) {
		this.bpmNodeSets = bpmNodeSets;
	}
	
	public List<BpmSolVar> getBpmSolVars() {
		return bpmSolVars;
	}
	
	public void setBpmSolVars(List<BpmSolVar> bpmSolVars) {
		this.bpmSolVars = bpmSolVars;
	}
	
	public List<BpmSolFv> getBpmSolFvs() {
		return bpmSolFvs;
	}
	
	public void setBpmSolFvs(List<BpmSolFv> bpmSolFvs) {
		this.bpmSolFvs = bpmSolFvs;
	}
	
	public List<BpmSolUser> getBpmSolUsers() {
		return bpmSolUsers;
	}
	
	public void setBpmSolUsers(List<BpmSolUser> bpmSolUsers) {
		this.bpmSolUsers = bpmSolUsers;
	}

	public Set<BpmFormView> getBpmFormViews() {
		return bpmFormViews;
	}

	public void setBpmFormViews(Set<BpmFormView> bpmFormViews) {
		this.bpmFormViews = bpmFormViews;
	}

	
	public List<BpmSolUsergroup> getBpmSolUsergroups() {
		return bpmSolUsergroups;
	}

	public void setBpmSolUsergroups(List<BpmSolUsergroup> bpmSolUsergroups) {
		this.bpmSolUsergroups = bpmSolUsergroups;
	}

	public List<SysBoDef> getSysBoDefs() {
		return sysBoDefs;
	}

	public void setSysBoDefs(List<SysBoDef> sysBoDefs) {
		this.sysBoDefs = sysBoDefs;
	}

	public boolean isDeployed() {
		return deployed;
	}

	public void setDeployed(boolean deployed) {
		this.deployed = deployed;
	}

	public Set<BpmMobileForm> getMobileForms() {
		return mobileForms;
	}

	public void setMobileForms(Set<BpmMobileForm> mobileForms) {
		this.mobileForms = mobileForms;
	}

	public List<BpmRemindDef> getBpmRemindDefs() {
		return bpmRemindDefs;
	}

	public void setBpmRemindDefs(List<BpmRemindDef> bpmRemindDefs) {
		this.bpmRemindDefs = bpmRemindDefs;
	}

	public Map<String, String> getBoIdRefs() {
		return boIdRefs;
	}

	public void setBoIdRefs(Map<String, String> boIdRefs) {
		this.boIdRefs = boIdRefs;
	}

	public List<BpmFormRight> getBpmFormRights() {
		return bpmFormRights;
	}

	public void setBpmFormRights(List<BpmFormRight> bpmFormRights) {
		this.bpmFormRights = bpmFormRights;
	}

	public String getTenantId() {
		return tenantId;
	}

	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}

	public List<BpmJumpRule> getBpmJumpRules() {
		return bpmJumpRules;
	}

	public void setBpmJumpRules(List<BpmJumpRule> bpmJumpRules) {
		this.bpmJumpRules = bpmJumpRules;
	}

}
