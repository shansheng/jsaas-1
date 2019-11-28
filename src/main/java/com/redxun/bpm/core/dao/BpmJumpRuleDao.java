
/**
 * <pre>
 * 描述：流程跳转规则 DAO接口
 * 作者:ray
 * 日期:2018-04-10 13:44:42
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmJumpRule;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.jpa.BaseJpaDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BpmJumpRuleDao extends BaseMybatisDao<BpmJumpRule> {

    @Override
    public String getNamespace() {
        return BpmJumpRule.class.getName();
    }

    public List<BpmJumpRule> getBySolNodeId(String solId, String actDefId, String nodeId){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("solId", solId);
        params.put("actdefId", actDefId);
        params.put("nodeId", nodeId);

        return this.getBySqlKey("getBySolNodeId", params);
    }

    public List<BpmJumpRule> getBySolId(String solId) {
    	Map<String, Object> params = new HashMap<String, Object>();
    	params.put("solId", solId);
    	return this.getBySqlKey("getBySolId", params);
    }
}

