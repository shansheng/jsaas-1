package com.redxun.bpm.activiti.ext;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.deploy.DeploymentCache;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;

import com.redxun.core.cache.CacheUtil;
import com.redxun.core.cache.ICache;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.util.WebAppUtil;

/**
 * 流程引擎的自定义缓存接口，可以配置到activiti的配置文件中。
 * 支持集群部署，如果集群部署的情况可以使用到memcached缓存。
 * <pre> 
 * &lt;property name="processDefinitionCache">
 *	&lt;bean class="com.redxun.bpm.activiti.ext.ActivitiDefCache">&lt;/bean>
 * &lt;/property>
 * 作者：ray
 * </pre>
 */
public class ActivitiDefCache implements DeploymentCache<ProcessDefinitionEntity> {
	
	
	
	private static String PROCESS_DEF_LIST="process_def_list__";
	
	private static String PROCESS_DEF_PRE_="proce_def_pre_";
	
	private static String getKey(String actDefId){
		return PROCESS_DEF_PRE_ + actDefId;
	}
	
	private ThreadLocal<Map<String,ProcessDefinitionEntity>> processDefinitionCacheLocal = new ThreadLocal<Map<String,ProcessDefinitionEntity>>();

	
	/**
	 * 清除线程变量缓存，这个在每次请求前进行调用。
	 */
	public static void clearLocal(){
		ActivitiDefCache cache=(ActivitiDefCache)WebAppUtil.getBean(ActivitiDefCache.class);
		cache.clearProcessCache();
	}
	
	/**
	 * 根据流程定义ID清除缓存，这个在流程定义xml发生变更时进行调用。
	 * @param actDefId
	 */
	public static void clearByDefId(String actDefId){
		ActivitiDefCache cache=(ActivitiDefCache)WebAppUtil.getBean(ActivitiDefCache.class);
		
		cache.clearProcessDefinitionEntity(actDefId);
		
	}
	
	
	 private void clearProcessDefinitionEntity(String defId){
		 remove(defId);
		 processDefinitionCacheLocal.remove();
	 }
	 
	 private  void clearProcessCache(){
		 processDefinitionCacheLocal.remove();
	 }
	 
	 private  void setThreadLocalDef(ProcessDefinitionEntity processEnt){
		  if(processDefinitionCacheLocal.get()==null){
			  Map<String, ProcessDefinitionEntity> map=new HashMap<String, ProcessDefinitionEntity>();
			  map.put(processEnt.getId(),processEnt);
			  processDefinitionCacheLocal.set(map);
		  }
		  else{
			  Map<String, ProcessDefinitionEntity> map=processDefinitionCacheLocal.get();
			  map.put(processEnt.getId(),processEnt);
		  }
		
	 }
	 
	 private  ProcessDefinitionEntity getThreadLocalDef(String processDefinitionId){
		  if(processDefinitionCacheLocal.get()==null)   return null;
		  Map<String, ProcessDefinitionEntity> map=processDefinitionCacheLocal.get();
		  if(!map.containsKey(processDefinitionId))  return null;
		  //LOG.info("get definition from local thread:"+processDefinitionId);
		  return map.get(processDefinitionId);
	 }
	

	@Override
	public ProcessDefinitionEntity get(String id) {
		String key=getKey(id);
		ProcessDefinitionEntity ent=(ProcessDefinitionEntity)CacheUtil.getCache(key);
		if(ent==null) return null;
		ProcessDefinitionEntity cloneEnt=null;
		try {
			//克隆流程定义。
			cloneEnt=(ProcessDefinitionEntity)FileUtil.cloneObject(ent);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProcessDefinitionEntity p=getThreadLocalDef(id);
		if(p!=null) return p;
		
		setThreadLocalDef(cloneEnt);
		return cloneEnt;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public void add(String id, ProcessDefinitionEntity object) {
		String key=getKey(id);
		CacheUtil.addCache(key, object);
		
		//将流程定义的ID放到一个列表作为缓存存储。
		List<String> defList= (List<String>) CacheUtil.getCache(PROCESS_DEF_LIST);
		if(BeanUtil.isEmpty(defList)){
			defList=new ArrayList<String>();
		}
		defList.add(id);
		CacheUtil.addCache(PROCESS_DEF_LIST, defList);
	}

	@Override
	public void remove(String id) {
		String key=getKey(id);
		CacheUtil.delCache(key);
	}

	@Override
	public void clear() {
		List<String> defList= (List<String>) CacheUtil.getCache(PROCESS_DEF_LIST);
		if(BeanUtil.isEmpty(defList)) return;
		for(String id : defList){
			String key=getKey(id);
			CacheUtil.delCache(key);
		}
	}

}
