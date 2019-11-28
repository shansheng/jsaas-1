
/**
 * 
 * <pre> 
 * 描述：流程方案代理 DAO接口
 * 作者:ray
 * 日期:2018-10-27 21:19:20
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmAgent;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmAgentDao extends BaseMybatisDao<BpmAgent> {

	@Override
	public String getNamespace() {
		return BpmAgent.class.getName();
	}
	
	public List<BpmAgent> getValidAgents(String userId,String type){
		Map<String,Object> params=new HashMap<>();
		params.put("agentUserId", userId);
		params.put("type", type);
		params.put("startTime", new Date());
		params.put("endTime", new Date());
		
		return this.getBySqlKey("getValidAgents", params);
    }
	
	public List<BpmAgent> getValidAgentSol(String userId,String solId){
		Map<String,Object> params=new HashMap<>();
		params.put("agentUserId", userId);
		params.put("solId", solId);
		params.put("startTime", new Date());
		params.put("endTime", new Date());
		
		return this.getBySqlKey("getValidAgentSol", params);
    }
	
	

}

