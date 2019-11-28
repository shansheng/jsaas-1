
/**
 * 
 * <pre> 
 * 描述：催办定义 DAO接口
 * 作者:ray
 * 日期:2016-12-26 14:26:48
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmRemindDef;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmRemindDefDao extends BaseMybatisDao<BpmRemindDef> {

	@Override
	public String getNamespace() {
		return BpmRemindDef.class.getName();
	}

	
	/**
	 * 获取节点催办定义。
	 * @param solId
	 * @param nodeId
	 * @return
	 */
	public List<BpmRemindDef> getBySolNode(String solId,String actDefId,String nodeId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("solId", solId);
		params.put("nodeId", nodeId);
		params.put("actDefId", actDefId);
		
		List<BpmRemindDef>  list=this.getBySqlKey("getBySolNode", params);
		return list;
	}
	
	/**
	 * 根据方案和流程定义获取催办配置。
	 * @param solId
	 * @param actDefId
	 * @return
	 */
	public List<BpmRemindDef> getBySolId(String solId,String actDefId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		List<BpmRemindDef>  list=this.getBySqlKey("getBySolId", params);
		return list;
	}
	
	 public void delBySolIdActDefId(String solId,String actDefId){
		 Map<String,Object> params=new HashMap<String,Object>();
		 params.put("solId", solId);
		 params.put("actDefId", actDefId);
		 this.deleteBySqlKey("delBySolIdActDefId", params);
	 }
}

