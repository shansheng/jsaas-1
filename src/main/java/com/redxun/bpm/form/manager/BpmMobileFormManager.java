package com.redxun.bpm.form.manager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.form.dao.BpmMobileFormDao;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.bpm.form.manager.BpmFormViewManager.FormConfig;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;

/**
 * <pre> 
 * 描述：BpmMobileForm业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmMobileFormManager extends BaseManager<BpmMobileForm>{
	@Resource
	private BpmMobileFormDao bpmMobileFormDao;
	
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmMobileFormDao;
	}
	
	/**
	 * 判断系统中指定别名的表单是否存在。
	 * @param mobileForm
	 * @return
	 */
	public boolean isAliasExist(BpmMobileForm mobileForm){
		Map<String,Object> params=new HashMap<String, Object>();
		if(StringUtil.isEmpty(mobileForm.getTenantId())){
			String tenantId=ContextUtil.getCurrentTenantId();
			params.put("tenantId",tenantId);
		}
		else{
			params.put("tenantId",mobileForm.getTenantId());
		}
		params.put("alias", mobileForm.getAlias());
		if(StringUtil.isNotEmpty(mobileForm.getId())){
			params.put("id", mobileForm.getId());
		}
		return  bpmMobileFormDao.isAliasExist(params)>0;
	}
	
	public List<BpmMobileForm> getByBoDefId(String boDefId){
		String tenantId=ContextUtil.getCurrentTenantId();
		List<BpmMobileForm> list=bpmMobileFormDao.getByBoDefId(boDefId.split(","),tenantId);
		return list;
	}
	
	/**
	 * 根据别名获取手机表单。
	 * @param alias
	 * @return
	 */
	public BpmMobileForm getByAlias(String alias){
		BpmMobileForm mobileForm= bpmMobileFormDao.getByAlias(alias);
		return mobileForm;
	}
	
	/**
	 * 验证别名 是否存在。
	 * @param alias
	 * @return
	 */
	public boolean isAliasExist(String alias){
		Map<String,Object> params=new HashMap<String, Object>();
		String tenantId=ContextUtil.getCurrentTenantId();
		params.put("tenantId",tenantId);
		params.put("alias",alias);
		Integer rtn= bpmMobileFormDao.isAliasExist(params);
		return rtn>0;
	}
	
	
	/**
	 * 获取手机表单列表。
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @param instId
	 * @return
	 */
	public List<BpmMobileForm> getFormView(String solId,String actDefId,String nodeId, String instId){
		List<BpmMobileForm> formViews=new ArrayList<BpmMobileForm>();
    	//获得开始表单
    	FormConfig config=bpmFormViewManager.getFormAlias(solId, actDefId, nodeId, BpmFormView.TYPE_MOBILE, instId);
    	List<String> formList=config.getFormKeys();
    	if(BeanUtil.isEmpty(formList)) return formViews;
		
    	for(String alias:formList){
    		BpmMobileForm formView= bpmMobileFormDao.getByAlias(alias);
    		formView.setBpmSolFv(config.getBpmSolFv());
    		formViews.add(formView);
    	}
    	return formViews;

    }
	
	/**
	 * 获取发起手机表单列表。
	 * @param solId
	 * @param actDefId
	 * @param instId
	 * @return
	 */
	public List<BpmMobileForm> getStartFormView(String solId,String actDefId, String instId){
		List<BpmMobileForm> formViews=new ArrayList<BpmMobileForm>();
    	//获得开始表单
    	FormConfig config=bpmFormViewManager.getFormAlias(solId, actDefId, BpmFormView.SCOPE_START, BpmFormView.TYPE_MOBILE, instId);
    	List<String> formList=config.getFormKeys();
    	if(BeanUtil.isEmpty(formList)) return formViews;
		
    	for(String alias:formList){
    		BpmMobileForm formView= bpmMobileFormDao.getByAlias(alias);
    		formView.setBpmSolFv(config.getBpmSolFv());
    		formViews.add(formView);
    	}
    	return formViews;

    }
	
	
}