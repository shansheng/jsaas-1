
/**
 * 
 * <pre> 
 * 描述：流程定义 DAO接口
 * 作者:mansan
 * 日期:2017-03-23 09:37:12
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmDef;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmDefDao extends BaseMybatisDao<BpmDef> {

	@Override
	public String getNamespace() {
		return BpmDef.class.getName();
	}
	
	/**
	 * 是否有已存在。
	 * @param bpmDef
	 * @return
	 */
	public boolean getCountByKey(BpmDef bpmDef){
		Integer rtn= (Integer) this.getOne("getCountByKey", bpmDef);
		return rtn>0;
	}
	
	/**
	 * 根据key和id查询，看是否能查到数据。
	 * @param bpmDef
	 * @return
	 */
	public Integer getCountByKeyAndId(BpmDef bpmDef){
		Integer rtn= (Integer) this.getOne("getCountByKeyAndId", bpmDef);
		return rtn;
	}
	
	public List<BpmDef> getByKey(String key,String tenantId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByKey", params);
	}
	
	/**
	 * 根据模型ID获取流程定义ID
	 * @param modelId
	 * @return
	 */
	public BpmDef getByModelId(String modelId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("modelId", modelId);
		return this.getUnique("getByModelId", params);
	}
	
	public BpmDef getByKeyMain(String key,String tenantId){
		//#{tenantId} and STATUS_=#{status} and IS_MAIN_=#{isMain}
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		params.put("isMain", MBoolean.YES.name());
		params.put("status", BpmDef.STATUS_DEPLOY);
		return this.getUnique("getByKeyMain", params);
		
	}
	
	public Integer getMaxVersion(String tenantId,String key){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("key", key);
		params.put("status",BpmDef.STATUS_DEPLOY);
		Integer rtn=(Integer) this.getOne("getMaxVersion", params);
		return rtn;
		
	}
	
	public BpmDef getByKeyVersion(String tenantId,String key,Integer version){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("key", key);
		params.put("version", version);
		return this.getUnique("getByKeyVersion", params);
	}
	
	/**
	 * 根据主定义ID获取列表。
	 * @param tenantId
	 * @param mainDefId
	 * @return
	 */
	public List<BpmDef> getByMainDefId(String tenantId,String mainDefId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("mainDefId", mainDefId);
		
		return this.getBySqlKey("getByMainDefId", params);
	}
	
	public void updateIsMainByMailDefId(String mainDefId,String isMain){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("mainDefId", mainDefId);
		params.put("isMain", isMain);
		this.updateBySqlKey("updateIsMainByMailDefId", params);
	}
	
	public  BpmDef getByActDefId(String actDefId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("actDefId", actDefId);
		return this.getUnique("getByActDefId", params);
	}
	
	public void delByMainDefId(String actDefId){
		this.deleteBySqlKey("delByMainDefId", actDefId);
	}
	
	
	

}

