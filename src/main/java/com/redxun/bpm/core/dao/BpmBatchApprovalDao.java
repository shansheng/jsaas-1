
/**
 * 
 * <pre> 
 * 描述：流程批量审批设置表 DAO接口
 * 作者:mansan
 * 日期:2018-06-27 15:19:53
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmBatchApproval;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.core.entity.SysInstType;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmBatchApprovalDao extends BaseMybatisDao<BpmBatchApproval> {

	@Override
	public String getNamespace() {
		return BpmBatchApproval.class.getName();
	}

	public List<BpmBatchApproval> getInvailAll() {
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("status","1");

        ITenant tenant= ContextUtil.getTenant();
        if(tenant!=null&&!SysInstType.INST_TYPE_PLATFORM.equals(ContextUtil.getTenant().getInstType()))
            params.put("tenantId",tenant.getTenantId());
		return this.getBySqlKey("getInvailAll", params);
	}
	
	public List getTaskByUser(String fields,String userId,String actDefId,String nodeId,String tableName){
		Map<String,Object> params=new HashMap<>();
		params.put("fields", fields);
		params.put("userId", userId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("tableName", tableName);
		
		List list=this.getBySqlKey("getTaskByUser", params);
		
		return list;
		
	}
	
	/**
	 * 根据解决方案节点Id 查询数据是否存在。
	 * @param solId
	 * @param nodeId
	 * @param id
	 * @return
	 */
	public Integer getCountBySolNodeId(String solId,String nodeId,String id){
		Map<String,Object> params=new HashMap<>();
		params.put("solId", solId);
		params.put("nodeId", nodeId);
		params.put("id", id);
		
		Integer rtn=(Integer) this.getOne("getCountBySolNodeId", params);
		
		return rtn;
		
	}

}

