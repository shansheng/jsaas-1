package com.redxun.bpm.core.manager;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmDefExt;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.entity.BpmJumpRule;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmSolutionExt;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmMobileFormManager;
import com.redxun.core.database.api.ITableOperator;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.thoughtworks.xstream.XStream;

@Service
public class SolutionExpImpManager {
	
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	BpmSolUserManager bpmSolUserManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmSolVarManager bpmSolVarManager;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmSolUsergroupManager bpmSolUsergroupManager;
	@Resource
	ActRepService actRepService;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	BpmMobileFormManager bpmMobileFormManager;
	@Resource
	BpmRemindDefManager bpmRemindDefManager;
	@Resource
	BpmFormRightManager bpmFormRightManager;
	@Resource
	private ITableOperator  tableOperator;
	@Resource
	private BpmJumpRuleManager bpmJumpRuleManager;
	
	
	/**
	 * 
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @throws Exception
	 */
	public void doImport(MultipartFile file, boolean isDeploy) throws Exception{
		
		ProcessHandleHelper.initProcessMessage();
		
		List<BpmSolutionExt>   list=getBpmSolutionExts(file, isDeploy);
		String tenantId = ContextUtil.getCurrentTenantId();
		for(BpmSolutionExt solutionExt:list){
			doImport( solutionExt, tenantId);
		}
	}
	
	
	/**
	 * 读取上传的对象。
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	private List<BpmSolutionExt> getBpmSolutionExts(MultipartFile file,boolean isDeploy
			) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("bpmSolutionExt", BpmSolutionExt.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<BpmSolutionExt> list=new ArrayList<BpmSolutionExt>();

		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			BpmSolutionExt solutionExt = (BpmSolutionExt) xstream.fromXML(xml);
			solutionExt.setDeployed(isDeploy);
			list.add(solutionExt);
		}
		zipIs.close();
		return list;
	
	}
	
	/**
	 * 根据solId获取需要导出的对象。
	 * @param solIds
	 * @param expOptions
	 * @return
	 */
	public List<BpmSolutionExt> getSolutionByIds(String[] solIds,Set<String> expOptions){
		String tenantId=ContextUtil.getCurrentTenantId();
		List< BpmSolutionExt> list=new ArrayList<BpmSolutionExt>();
		for (String solId : solIds) {
			BpmSolution bpmSolution = bpmSolutionManager.get(solId);
			
			if (StringUtils.isEmpty(bpmSolution.getDefKey()) || StringUtils.isEmpty(bpmSolution.getActDefId())) continue;
			BpmSolutionExt bpmSolutionExt = getBpmSolutionExt(bpmSolution,expOptions);
			if(bpmSolutionExt==null ) continue;
			
			list.add(bpmSolutionExt);
			
		}
		return list;
	}
	
	private BpmSolutionExt getBpmSolutionExt(BpmSolution bpmSolution,Set<String> expOptions){
		String actDefId=bpmSolution.getActDefId();
		String solId=bpmSolution.getSolId();
		
		BpmSolutionExt bpmSolutionExt = new BpmSolutionExt(bpmSolution);
		// 获得流程定义配置,仅导出当前使用的流程定义
		BpmDef bpmDef = bpmDefManager.getByActDefId(actDefId);
		if (bpmDef == null)  return null;
		// 加入流程定义
		if (expOptions.contains("bpmDefExt")) {
			BpmDefExt bpmDefExt = new BpmDefExt(bpmDef);
			bpmSolutionExt.setBpmDefExt(bpmDefExt);
			
			if (StringUtils.isNotEmpty(bpmDef.getModelId())) {
				String editorJson = actRepService.getEditorJsonByModelId(bpmDef.getModelId());
				bpmDefExt.setModelJson(editorJson);
			}
		}
		if (expOptions.contains("bpmNodeSets")) {
			// 加入配置的节点属性
			List<BpmNodeSet> bpmNodeSets = bpmNodeSetManager.getBySolIdActDefId(solId, actDefId);
			bpmSolutionExt.setBpmNodeSets(bpmNodeSets);
		}
		if (expOptions.contains("bpmSolUsers")) {
			// 加入人员变量配置
			List<BpmSolUser> bpmSolUsers = bpmSolUserManager.getBySolIdActDefId(solId,actDefId,"task");
			bpmSolutionExt.setBpmSolUsers(bpmSolUsers);
			
			//用户组导出
			List<BpmSolUsergroup> usergroups=bpmSolUsergroupManager.getBySolActDefId(solId, actDefId);
			
			for(BpmSolUsergroup usergroup:usergroups){
				List<BpmSolUser> solUsers = bpmSolUserManager.getByGroupId(usergroup.getId());
				usergroup.setUserList(solUsers);
			}
			
			bpmSolutionExt.setBpmSolUsergroups(usergroups);
		}
		if (expOptions.contains("bpmSolVars")) {
			// 加入变量配置
			List<BpmSolVar> bpmSolVars = bpmSolVarManager.getBySolIdActDefId(solId, actDefId);
			bpmSolutionExt.setBpmSolVars(bpmSolVars);
		}
		if (expOptions.contains("bpmSolFvs")) {
			// 加入表单配置
			List<BpmSolFv> bpmSolFvs = bpmSolFvManager.getBySolIdActDefId(solId, bpmDef.getActDefId());
			//获取权限。
			List<BpmFormRight> formRights= bpmFormRightManager.getBySolForm(solId, actDefId, "");
			bpmSolutionExt.setBpmFormRights(formRights);

			for (BpmSolFv fv : bpmSolFvs) {
				//审批表单
				if (StringUtils.isNotEmpty(fv.getCondForms())) {
					List<BpmFormView> condForms=bpmFormViewManager.getTaskFormViews(solId,actDefId,fv.getNodeId(),"");
					Set<BpmFormView> tmpSet = new HashSet<BpmFormView>(condForms); 
					bpmSolutionExt.getBpmFormViews().addAll(tmpSet);
				}
				//手机表单
				if (StringUtils.isNotEmpty(fv.getMobileForms())) {
					List<BpmMobileForm> mobileForms=bpmMobileFormManager.getFormView(solId,actDefId, fv.getNodeId(),"");
					Set<BpmMobileForm> tmpSet = new HashSet<BpmMobileForm>(mobileForms); 
					bpmSolutionExt.getMobileForms().addAll(tmpSet);
				}
			}
			bpmSolutionExt.setBpmSolFvs(bpmSolFvs);
		}
		if(expOptions.contains("bpmJumpRule")) {
			//加入跳转规则
			List<BpmJumpRule> bpmJumpRules = bpmJumpRuleManager.getBySolId(solId);
			bpmSolutionExt.setBpmJumpRules(bpmJumpRules);
		}
		
		//导出BO定义
		String boDefId=bpmSolution.getBoDefId();
		if(StringUtil.isNotEmpty(boDefId)){
			String[] boDefIds = boDefId.split(",");
			List<SysBoDef> boDefs = new ArrayList<SysBoDef>();
			for(String id:boDefIds){
				SysBoDef boDef= sysBoDefManager.get(id);
				SysBoEnt boEnt=sysBoEntManager.getByBoDefId(id);
				boDef.setSysBoEnt(boEnt);
				boDefs.add(boDef);
			}
			bpmSolutionExt.setSysBoDefs(boDefs);
		}
		
		//催办导出
		List<BpmRemindDef> remindDefs= bpmRemindDefManager.getBySolId(solId, actDefId);
		bpmSolutionExt.setBpmRemindDefs(remindDefs);
		
		return bpmSolutionExt;
	}

	
	/**
	 * 流程方案的导入
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void doImport(BpmSolutionExt bpmSolutionExt,String tenantId) throws Exception{
		
		bpmSolutionExt.setTenantId(tenantId);
		
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		//判断流程方案是否已经存在
		// writed by Louis
		BpmSolution sourceSolution = null;

		sourceSolution = bpmSolutionManager.getByKey(solution.getKey(), tenantId);
		// 1处理流程定义
		importBpmDef(bpmSolutionExt);
		// 2处理解决方案
		importSolution(bpmSolutionExt, sourceSolution);
		// 3导入用户
		importUsers(bpmSolutionExt, sourceSolution);
		// 4导入节点设置
		importBpmNodeSet(bpmSolutionExt, sourceSolution);
		// 5处理流程变量
		importVars(bpmSolutionExt, sourceSolution);
		// 6导入表单配置
		importSolFv(bpmSolutionExt, sourceSolution);
		// 7导入BO
		importBo(bpmSolutionExt);
		// 8导入表单
		importFormView(bpmSolutionExt);
		// 9导入手机表单
		importMobileForm(bpmSolutionExt);
		// 10导入表单权限
		importFormRight(bpmSolutionExt, sourceSolution);
		// 11导入催办
		importRemindDef(bpmSolutionExt, sourceSolution);
		// 12导入跳转规则
		importJumpRule(bpmSolutionExt, sourceSolution);
	}
	
	/**
	 * 导入流程定义。
	 * <pre>
	 *  1. 插入BPM_DEF
	 *  2. 发布流程 到流程引擎
	 * </pre>
	 * <pre>
	 * 	bpmDef :修改的值
	 * 		defId ： 流程定义ID
	 * 		tenantId: 租户ID
	 * 		actDefId: act_re_procdef 主键
	 * 		actDepId: act_re_deployment 主键
	 * 		modelId: ACT_RE_MODEL 主键
	 * 		verson : 版本号 （这里主要是解决多个方案对应同一份流程定义的问题)
	 * 
	 * </pre>
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void importBpmDef(BpmSolutionExt bpmSolutionExt) throws Exception{
		
		BpmDefExt bpmDefExt= bpmSolutionExt.getBpmDefExt();
		
		BpmDef bpmDef=bpmDefExt.getBpmDef();
		//流程定义设计的JSON数据。
		String modelJson=bpmDefExt.getModelJson();
		//清空原有的分类
		
		bpmDef.setTenantId(bpmSolutionExt.getTenantId());
		bpmDefManager.createAndDeploy(bpmDef, modelJson);
		
	}
	
	/**
	 * 1.导入bpm_sol_user
	 * <pre>
	 * 	1.关联字段
	 * 		ID_
	 * 		SOL_ID_
	 * 		TENANT_ID_
	 * 		ACT_DEF_ID_
	 * </pre>
	 * 2.导入 bpm_sol_usergroup
	 * <pre>
	 * 	ID_
	 * 	SOL_ID_
	 *  TENANT_ID_
	 *  ACT_DEF_ID_
	 * </pre>
	 * @param bpmSolutionExt
	 */
	private void importUsers(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution){
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		String solId=solution.getSolId();
		String tenantId= solution.getTenantId();
		String actDefId= solution.getActDefId();
		
		List<BpmSolUsergroup> userGroups= bpmSolutionExt.getBpmSolUsergroups();
		for(BpmSolUsergroup usergroup:userGroups){
			String groupId=IdUtil.getId();
			usergroup.setId(groupId);
			usergroup.setSolId(sourceSolution == null ? solId : sourceSolution.getSolId());
			usergroup.setTenantId(tenantId);
			usergroup.setActDefId(actDefId);
			bpmSolUsergroupManager.create(usergroup);
		}
	}
	
	/**
	 * 	需要变更的字段。
	 * <pre>
	 * 	1.SET_ID_
	 *  3.TENANT_ID_
	 *  4.ACT_DEF_ID_
	 * </pre>
	 * @param bpmSolutionExt
	 */
	private void importBpmNodeSet(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution){
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		List<BpmNodeSet> nodeSetList = null;
		if(sourceSolution != null) {
			nodeSetList = bpmNodeSetManager.getByActDefId(sourceSolution.getActDefId());
			if(nodeSetList != null) {
				bpmNodeSetManager.delBySolIdActDefId(sourceSolution.getSolId(), sourceSolution.getActDefId());
			}
		}
		
		for(BpmNodeSet bpmNodeSet:bpmSolutionExt.getBpmNodeSets()){
        	bpmNodeSet.setSetId(IdUtil.getId());
        	bpmNodeSet.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
        	bpmNodeSet.setTenantId(solution.getTenantId());
        	bpmNodeSet.setActDefId(solution.getActDefId());
        	bpmNodeSetManager.create(bpmNodeSet);
        }
	}
	
	/**
	 * 变量导入 需要变更的字段。
	 * <pre>
	 * 1.VAR_ID_
	 * 2.SOL_ID_
	 * 3.TENANT_ID_
	 * 4.ACT_DEF_ID_
	 * </pre>
	 * @param bpmSolutionExt
	 */
	private void importVars(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution){
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
        for(BpmSolVar bpmSolVar:bpmSolutionExt.getBpmSolVars()){
        	bpmSolVar.setVarId(IdUtil.getId());
        	bpmSolVar.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
        	bpmSolVar.setActDefId(solution.getActDefId());
        	bpmSolVar.setTenantId(solution.getTenantId());
        	bpmSolVarManager.create(bpmSolVar);
        }
	}
	
	/**
	 * 导入表单配置。
	 * 变更字段。
	 * <pre>
	 * 1.ID_
	 * 2.SOL_ID_
	 * 3.TENANT_ID_
	 * 4.ACT_DEF_ID_
	 * </pre>
	 */
	private void importSolFv(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution){
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
	    for(BpmSolFv bpmSolFv:bpmSolutionExt.getBpmSolFvs()){
        	bpmSolFv.setId(IdUtil.getId());
        	bpmSolFv.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
        	bpmSolFv.setActDefId(solution.getActDefId());
        	bpmSolFv.setTenantId(solution.getTenantId());
        	bpmSolFvManager.create(bpmSolFv);
        }
	}
	
	/**
	 * 变更字段。
	 * 
	 * <pre>
	 * 关于表单VIEWID处理。
	 * 
	 * 先找回原来的表单，将表单的ID使用新的ID进行更换，权限也是使用这个新的ID。
	 * 
	 * 1.RIGHT_ID_
	 * 2.VIEW_ID_ 这个要放到表单导入之前处理。
	 * 3.SOL_ID_ 方案ID
	 * 4.TENANT_ID_ 租户ID
	 * 5.ACT_DEF_ID_ 流程定义ID
	 * </pre>
	 * @param bpmSolutionExt
	 */
	private void importFormRight(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution){
		List<BpmFormRight> formRights= bpmSolutionExt.getBpmFormRights();
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		
		for(BpmFormRight formRight:formRights){
			formRight.setId(IdUtil.getId());
			formRight.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
			formRight.setActDefId(solution.getActDefId());
			String boDefId=bpmSolutionExt.getBoIdRefs().get(formRight.getBoDefId());
			formRight.setBoDefId(boDefId);
			formRight.setTenantId(bpmSolutionExt.getTenantId());
			bpmFormRightManager.create(formRight);
		}
		
	}
	
	/**
	 * 需要修改字段。
	 * <pre>
	 * VIEW_ID_
	 * TENANT_ID_
	 * </pre>
	 * @param bpmSolutionExt
	 * @throws Exception
	 */
	private void importFormView(BpmSolutionExt bpmSolutionExt) throws Exception{
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		Set<BpmFormView> formViews= bpmSolutionExt.getBpmFormViews();
		for(BpmFormView formView:formViews){
			String viewId=IdUtil.getId();			
			formView.setOldViewId(formView.getViewId());
			formView.setTreeId(null); //设置为null，防止在表单列表中找不到其存在 - add by Louis
			formView.setViewId(viewId);
			formView.setTenantId(solution.getTenantId());
			
			if(StringUtil.isEmpty(formView.getBoDefId()))continue;
			
			if(null==sysBoDefManager.get(formView.getBoDefId()))           //处理新旧BOID关系
				formView.setBoDefId(bpmSolutionExt.getBoIdRefs().get(formView.getBoDefId()));
			else
				formView.setBoDefId(sysBoDefManager.get(formView.getBoDefId()).getId());
			
			//判断是否存在，存在则跳过。
			boolean rtn= bpmFormViewManager.isAliasExist(formView.getKey());
			if(rtn) continue;
			
			bpmFormViewManager.create(formView);
		}
	}
	
	/**
	 * 导入手机表单配置。
	 * @param bpmSolutionExt
	 * @throws Exception
	 */
	private void importMobileForm(BpmSolutionExt bpmSolutionExt) throws Exception{
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		Set<BpmMobileForm> formViews= bpmSolutionExt.getMobileForms();
		for(BpmMobileForm formView:formViews){
			String id=IdUtil.getId();
			formView.setId(id);
			formView.setTenantId(solution.getTenantId());
			if(StringUtil.isEmpty(formView.getBoDefId()))continue;
			
			if(null==sysBoDefManager.get(formView.getBoDefId()))           //处理新旧BOID关系
				formView.setBoDefId(bpmSolutionExt.getBoIdRefs().get(formView.getBoDefId()));
			else
				formView.setBoDefId(sysBoDefManager.get(formView.getBoDefId()).getId());
			//判断是否存在，存在则跳过。
			boolean rtn= bpmMobileFormManager.isAliasExist(formView.getAlias());
			if(rtn) continue;
			
			bpmMobileFormManager.create(formView);
		}
	}
	
	/**
	 * 导入流程方案表。
	 * <pre>
	 *  修改数据： 
	 *  	solId : 方案ID
	 *  	actDefId: 流程定义ID
	 *  	status : 解决方案状态
	 *  	
	 * </pre>
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void importSolution(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution)throws Exception{
		
		//重设流程定义的分类
		if(bpmSolutionExt.getBpmSolution().getTreeId()!=null){
			SysTree sysTree=sysTreeManager.get(bpmSolutionExt.getBpmSolution().getTreeId());
			
			if(sysTree==null){
				bpmSolutionExt.getBpmSolution().setTreeId(null);
				bpmSolutionExt.getBpmSolution().setTreePath(null);
			}else{
				bpmSolutionExt.getBpmSolution().setTreeId(bpmSolutionExt.getBpmSolution().getTreeId());
				bpmSolutionExt.getBpmSolution().setTreePath(sysTree.getPath());
			}
		}else{
			bpmSolutionExt.getBpmSolution().setTreeId(null);
			bpmSolutionExt.getBpmSolution().setTreePath(null);
		}
		
		if(bpmSolutionExt.getBpmSolution().getGrantType()==null){
			bpmSolutionExt.getBpmSolution().setGrantType(BpmSolution.GRANT_ALL);
	    }
		
		BpmDef bpmDef=bpmSolutionExt.getBpmDefExt().getBpmDef();
		
		BpmSolution bpmSolution=bpmSolutionExt.getBpmSolution();
		bpmSolution.setSolId(IdUtil.getId());
		bpmSolution.setActDefId(bpmDef.getActDefId());
		String status=bpmSolutionExt.isDeployed()?BpmSolution.STATUS_DEPLOYED:BpmSolution.STATUS_CREATED;
		bpmSolution.setStatus(status);
		bpmSolution.setTenantId(bpmSolutionExt.getTenantId());
		
		//判断solution是否已经存在
		if(sourceSolution == null) {//不存在
			bpmSolutionManager.create(bpmSolution);
		} else { //存在则更新
			bpmSolution.setSolId(sourceSolution.getSolId());
			bpmSolutionManager.update(bpmSolution);
		}
		
	}
	
	/**
	 * sys_bo_definition
	 * <pre>
	 * ID_
	 * TENANT_ID_
	 * </pre>
	 * @throws SQLException 
	 */
	private void importBo(BpmSolutionExt bpmSolutionExt) throws SQLException{
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		List<SysBoDef> sysBoDefs = new ArrayList<SysBoDef>();
		List<SysBoDef> boDefs= bpmSolutionExt.getSysBoDefs();
		Map<String,String> boIdRefs=new HashMap<String,String>();
		String boDefIdsStr = ""; //boDefId集合
		for(SysBoDef def:boDefs){
			JsonResult result= sysBoDefManager.checkBoDefExist("", def.getAlais(), solution.getTenantId());
			SysBoDef oldBoDef = null;
			if(!result.isSuccess()) {
				//如果系统中BO已经存在的情况,从系统中查询出对话框。
				oldBoDef= sysBoDefManager.getByAlias(def.getAlais());
				//sysBoDefs.add(boDef);
				//solution.setBoDefId(boDef.getId());
				//bpmSolutionManager.update(solution);
				//boDefIdsStr += (boDef.getId() + ","); //boDefId进行字符串连接
				//continue ;
			};
			
			String boDefId= (oldBoDef == null ? IdUtil.getId() : oldBoDef.getId());
			
			boIdRefs.put(def.getId(), boDefId);  //保存新旧BOID关系  key是旧BOID,value是新BOID
			
			String tenantId=solution.getTenantId();
			def.setId(boDefId);
			def.setTenantId(tenantId);
			sysBoDefs.add(def);
			if(result.isSuccess()) {
				sysBoDefManager.create(def);
			}
			
			//设置bo定义ID
			//solution.setBoDefId(boDefId);
			//bpmSolutionManager.update(solution);
			boDefIdsStr += (boDefId + ",");
			
			//保存BO相关的表。
			SysBoEnt boEnt=def.getSysBoEnt();
			boEnt.setTenantId(tenantId);
			sysBoDefManager.saveEnt(boDefId, boEnt, boEnt.getBoEntList(),true);
			//创建表
			boolean genTable=boEnt.getGenTable().equals(SysBoDef.BO_YES);
			 
			if(genTable && !boEnt.isDbMode()){
				/*if(!tableOperator.isTableExist(boEnt.getTableName())){ //如果表不存在，则创建
					sysBoEntManager.createTable(boEnt);
				}*/
				sysBoEntManager.createTable(boEnt);
			}
		}
		solution.setBoDefId(boDefIdsStr.substring(0, boDefIdsStr.length() - 1));
		bpmSolutionManager.update(solution); //update为多个boDefId
		bpmSolutionExt.setSysBoDefs(sysBoDefs);
		bpmSolutionExt.setBoIdRefs(boIdRefs);
	}
	
	/**
	 * 导入催办定义。
	 * @param bpmSolutionExt
	 * @throws SQLException
	 */
	private void importRemindDef(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution) throws SQLException{
		BpmSolution solution=bpmSolutionExt.getBpmSolution();
		List<BpmRemindDef> remindDefs=bpmSolutionExt.getBpmRemindDefs();
		for(BpmRemindDef remindDef:remindDefs){
			remindDef.setId(IdUtil.getId());
			remindDef.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
			remindDef.setTenantId(solution.getTenantId());
			remindDef.setActDefId(remindDef.getActDefId());
			bpmRemindDefManager.create(remindDef);
		}
		
	}
	
	/** 
	 * writed by Louis
	 * 导入跳转规则
	 */
	private void importJumpRule(BpmSolutionExt bpmSolutionExt, BpmSolution sourceSolution) throws Exception {
		BpmSolution solution = bpmSolutionExt.getBpmSolution();
		List<BpmJumpRule> jumpRules = bpmSolutionExt.getBpmJumpRules();
		for(BpmJumpRule rule : jumpRules) {
			rule.setId(IdUtil.getId());
			rule.setSolId(sourceSolution == null ? solution.getSolId() : sourceSolution.getSolId());
			rule.setActdefId(solution.getActDefId());
			rule.setTenantId(solution.getTenantId());
			bpmJumpRuleManager.create(rule);
		}
	}
	
}
