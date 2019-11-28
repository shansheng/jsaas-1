
/**
 * 
 * <pre> 
 * 描述：表单权限 DAO接口
 * 作者:ray
 * 日期:2018-02-09 15:54:25
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmFormRightDao extends BaseMybatisDao<BpmFormRight> {

	@Override
	public String getNamespace() {
		return BpmFormRight.class.getName();
	}

	
	/**
	 * 根据参数获取权限数据。
	 * @param tenantId
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @param formAlias
	 * @return
	 */
	public List<BpmFormRight> getBySolForm(String tenantId,String solId,String actDefId,String nodeId,String formAlias) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("tenantId", tenantId);
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("formAlias", formAlias);
		
		return this.getBySqlKey("getBySolForm", params);
	}

	public void delBySolForm(String tenantId,String solId,String actDefId,String nodeId,String formAlias) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("tenantId", tenantId);
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("formAlias", formAlias);
		
		this.deleteBySqlKey("delBySolForm", params);
	}
	
	/**
	 * 删除流程方案下数据
	 * @param solId
	 */
	public void delBySolId(String solId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("solId", solId);
		this.deleteBySqlKey("delBySolId", params);
	}


	public void delBySolAndBodefId(String solId, String aliasBindBodefId) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("solId", solId);
		params.put("aliasBindBodefId", aliasBindBodefId);
		this.deleteBySqlKey("delBySolAndBodefId", params);
		
	}
	
	public BpmFormRight getBySolId(String solId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("solId", solId);
		return (BpmFormRight) this.getOne("getBySolId", params);
	}
}

