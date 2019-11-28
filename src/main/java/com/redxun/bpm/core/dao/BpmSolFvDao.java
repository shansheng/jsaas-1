
/**
 * 
 * <pre> 
 * 描述：解决方案关联的表单视图 DAO接口
 * 作者:ray
 * 日期:2017-03-22 18:37:16
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;

@Repository
public class BpmSolFvDao extends BaseMybatisDao<BpmSolFv> {

	@Override
	public String getNamespace() {
		return BpmSolFv.class.getName();
	}
	
	public List<BpmSolFv> getBySolutionId(String solId,String actDefId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		return this.getBySqlKey("getBySolutionId", params);
	}
	

	
	 public BpmSolFv getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
		 Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("nodeId", nodeId);
		params.put("actDefId", actDefId);
		return this.getUnique("getBySolIdActDefIdNodeId", params);
	 }
	 
	 public List<BpmSolFv> getBySolId(String solId){
		return this.getBySqlKey("getBySolId", solId);
	 }
	 
	 public List<BpmSolFv> getBySolIdActDefId(String solId,String actDefId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		return this.getBySqlKey("getBySolIdActDefId", params);
	 }
	 
	 public void delBySolIdActDefId(String solId,String actDefId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		this.deleteBySqlKey("delBySolIdActDefId", params);
	 }
	 
	 public void delBySolId(String solId){
		this.deleteBySqlKey("delBySolId", solId);
	 }
	 
	 
}

