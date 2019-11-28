
/**
 * 
 * <pre> 
 * 描述：部分代理的流程方案 DAO接口
 * 作者:ray
 * 日期:2018-10-27 21:42:07
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmAgentSolDao extends BaseMybatisDao<BpmAgentSol> {

	@Override
	public String getNamespace() {
		return BpmAgentSol.class.getName();
	}
	
	public List<BpmAgentSol> getByAgentId(String agentId){
		List<BpmAgentSol> list=this.getBySqlKey("getByAgentId", agentId);
		return list;
    }
	
	
	
	
	public void delByAgentId(String agentId){
		this.deleteBySqlKey("delByAgentId", agentId);
    }
	

}

