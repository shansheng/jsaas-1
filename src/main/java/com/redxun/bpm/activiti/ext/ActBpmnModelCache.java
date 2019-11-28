package com.redxun.bpm.activiti.ext;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.impl.persistence.deploy.DeploymentCache;

import com.redxun.core.cache.CacheUtil;
import com.redxun.core.cache.ICache;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.WebAppUtil;

public class ActBpmnModelCache implements DeploymentCache<BpmnModel>{

	
	private static String BPMN_PRE="bpmn_model_";
	
	private static String BPMN_M_ID="bpmn_id_set_";
	
	@Override
	public BpmnModel get(String id) {
		return (BpmnModel) CacheUtil.getCache(BPMN_PRE+id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void add(String id, BpmnModel object) {
		CacheUtil.addCache(BPMN_PRE+id, object);
		Set<String> idSet= (Set<String>) CacheUtil.getCache(BPMN_M_ID);
		if(BeanUtil.isEmpty(idSet)){
			idSet=new HashSet<String>();
		}
		idSet.add(id);
		CacheUtil.addCache(BPMN_M_ID, idSet);
	}

	@Override
	public void remove(String id) {
		CacheUtil.delCache(BPMN_PRE+id);
		Set<String> idSet= (Set<String>) CacheUtil.getCache(BPMN_M_ID);
		if(idSet!=null) {
			idSet.remove(id);
		}
		CacheUtil.addCache(BPMN_M_ID, idSet);
	}
	
	/**
	 * 清理流程图缓存。
	 * @param actDefId
	 */
	public static void clearByDefId(String actDefId){
		ActBpmnModelCache cache=WebAppUtil.getBean(ActBpmnModelCache.class);
		cache.remove(actDefId);
	}
	

	@Override
	public void clear() {
		Set<String> idSet= (Set<String>) CacheUtil.getCache(BPMN_M_ID);
		if(idSet!=null) {
			for(String id:idSet) {
				CacheUtil.delCache(BPMN_PRE+id);
			}
			CacheUtil.delCache(BPMN_M_ID);
		}
	}
}
