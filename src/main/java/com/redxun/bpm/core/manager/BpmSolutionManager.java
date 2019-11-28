
package com.redxun.bpm.core.manager;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.json.JsonResult;
import com.redxun.core.json.JsonResultUtil;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.entity.InsPortalParams;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.org.manager.OsGroupManager;
/**
 * <pre> 
 * 描述：BpmSolution业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * @Copyright (c) 2016-2017 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmSolutionManager extends MybatisBaseManager<BpmSolution>{
	@Resource
	private BpmSolutionDao bpmSolutionDao;

	
	@Resource
	private BpmSolFvManager bpmSolFvManager;
	@Resource
	private BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmFormRightManager bpmFormRightManager;
	@Resource
	private BpmDefManager bpmDefManager;
	@Resource 
	BpmSolUserManager bpmSolUserManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmSolVarManager bpmSolVarManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmAuthSettingManager bpmAuthSettingManager;
	@Resource
    ActRepService actRepService;
	@Resource
	SysBoEntManager sysBoEntManager;
	
	
	@Override
	protected IDao getDao() {
		return bpmSolutionDao;
	}
	
	
	/**
	 * 按流程定义Key获得流程定义的解决方案
	 * @param defKey
	 * @param tenantId
	 * @return
	 */
	public List<BpmSolution> getByDefKey(String defKey,String tenantId){
		return bpmSolutionDao.getByDefKey(defKey,tenantId);
	}
	
	
	
	@Override
	public void delete(String id) {
		bpmFormRightManager.delBySolId(id);
		super.delete(id);
	}
	
	
	/**
	 * 门户首页显示我的申请流程方案列表
	 * @param portParams
	 * @return
	 */
	public List<BpmSolution> getSolutionsByPortalParams(InsPortalParams portParams){
		QueryFilter sqlFilter=new QueryFilter();
		Page page=new Page();
		page.setPageIndex(0);
		page.setPageSize(portParams.getPageSize());
		page.setSkipCountTotal(true);
		sqlFilter.setPage(page);
		
		String tenantId=ContextUtil.getCurrentTenantId();
		sqlFilter.addFieldParam("TENANT_ID_", tenantId);
		sqlFilter.addFieldParam("rightType", "start");
		String grantType=BpmAuthSettingManager.getGrantType();
		sqlFilter.addFieldParam("grantType", grantType);
		Map<String, Set<String>> profileMap= ProfileUtil.getCurrentProfile();
		sqlFilter.addFieldParam("profileMap", profileMap);
		
		return bpmSolutionDao.getSolutions(sqlFilter);
	}
	
	/**
     * 通过Key获得解决方案
     * @param key
     * @param tenantId
     * @return
     */
    public BpmSolution getByKey(String key,String tenantId){
    	BpmSolution bs= bpmSolutionDao.getByKey(key, tenantId);
    	if(bs!=null){
    		return bs;
    	}
    	return bpmSolutionDao.getByKey(key, ITenant.ADMIN_TENANT_ID);
    }
	
	
	/**
     * 获得所有状态为DEPLOYED的解决方案
     * @return
     */
    public List<BpmSolution> getDeployedSol(){
    	return bpmSolutionDao.getDeployedSol();
    }
    
   
    
    /**
     * 根据权限获取流程解决方案
     * @param filter
     * @param isAdmin
     * @return
     */
    public List<BpmSolution> getSolutions(QueryFilter filter,boolean isAdmin){
    	String tenantId=ContextUtil.getCurrentTenantId();
    	String userId=ContextUtil.getCurrentUserId();
    	
    	filter.addFieldParam("TENANT_ID_", tenantId);
    	IUser user=ContextUtil.getCurrentUser();
    	List<BpmSolution> solutionList=null;
    	if(user.isSuperAdmin()){
    		solutionList=bpmSolutionDao.getSolutionsByAdmin(filter);
    	}
    	else{
    		filter.addFieldParam("userId", userId);
    		if(isAdmin){
    			filter.addFieldParam("admin", "admin");
    		}
    		filter.addFieldParam("rightType", isAdmin?"def":"start");
    		
    		
    		Map<String, Set<String>> profileMap= ProfileUtil.getCurrentProfile();
			filter.addFieldParam("profileMap", profileMap);
			String grantType=BpmAuthSettingManager.getGrantType();
			filter.addFieldParam("grantType", grantType);
			solutionList=bpmSolutionDao.getSolutions(filter);
    	}
    	
    	bpmAuthSettingManager.setRight(solutionList);
    	if(BeanUtil.isNotEmpty(solutionList)) {
	    	for (BpmSolution bpmSolution : solutionList) {
	    		SysBoEnt ent = sysBoEntManager.getByBoDefId(bpmSolution.getBoDefId(),false);
	    		if(BeanUtil.isNotEmpty(ent)) {
	    			bpmSolution.setTableNames(ent.getTableName());
	    		}
	    	}
    	}
    	
		return solutionList;
	}
    
    /**
	 * 1.获取全部的分类。
	 * 2.获取使用了的分类。
	 * 3.对数据进行处理，删除没有使用的树形数据。
	 * @return
	 */
	public List<SysTree> getCategoryTree(boolean isAdmin ){
		String tenantId=ContextUtil.getCurrentTenantId();
		String userId=ContextUtil.getCurrentUserId();
		
		Map<String,Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		List<SysTree> sysTrees= sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, tenantId);
		//用过的树形数据。
		// 行数据为map，键值为 TREE_ID_,TREE_PATH_,AMOUNT
		List userList= bpmSolutionDao.getCategoryTree(tenantId,userId,isAdmin, profileMap);
		//取得删除的树形数据。
		List<SysTree> removeTrees = sysTreeManager.getRemoveList(sysTrees, userList);
		
		sysTrees.removeAll(removeTrees);
		
		return sysTrees;
	}
	
	/**
	 * 检查方案别名。
	 * <pre>
	 * 1.在添加时检查系统别名是否可以添加。
	 * 2.在修改时检查系统别名不能修改。
	 * </pre>
	 * @param solution
	 * @return
	 */
	public JsonResult getCanSave(BpmSolution solution){
		String pk=solution.getSolId();
		JsonResult result=JsonResultUtil.success();
		if(StringUtil.isEmpty(pk)){
			String tenantId=ContextUtil.getCurrentTenantId();
			solution.setTenantId(tenantId);
			Integer rtn= bpmSolutionDao.getCountByKey(solution);
			if(rtn>0){
				result=JsonResultUtil.fail("标识键在系统中已存在!");
			}
		}
		else{
			Integer rtn=  bpmSolutionDao.getCountByKeyId(solution);
			if(rtn==0){
				result=JsonResultUtil.fail("标识键不能修改!");
			}
		}
		return result;
	}
	
	/**
	 * 流程方案是否存在。
	 * @param solution
	 * @return
	 */
	public boolean isExist(BpmSolution solution){
		String tenantId=ContextUtil.getCurrentTenantId();
		solution.setTenantId(tenantId);
		Integer rtn= bpmSolutionDao.getCountByKey(solution);
		return rtn>0;
	}
	
	public static void main(String[] args) {
		JsonResult rtn=null;
		JsonResult json=new JsonResult(false);
		rtn=json;
		json=new JsonResult(true);
		
		System.out.println("ok");
		
	}
	
	public List<BpmSolution> getSolutionsByTreeId(String treeId){
		return bpmSolutionDao.getByTreeId(treeId);
	}

	



	
	
}