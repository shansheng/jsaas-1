package com.redxun.bpm.core.dao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.bpm.core.entity.BpmSolUsergroup;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <pre> 
 * 描述：BpmSolUsergroup数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Repository
public class BpmSolUsergroupDao extends BaseMybatisDao<BpmSolUsergroup> {

    @Override
    public String getNamespace() {
        return BpmSolUsergroup.class.getName();
    }


    public Integer getMaxSn(String tenantId,String solId,String actDefId,String nodeId,String groupType){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("tenantId", tenantId);
        params.put("solId", solId);
        params.put("actDefId", actDefId);
        params.put("nodeId", nodeId);
        params.put("groupType", groupType);

        Integer rtn=(Integer) this.getOne("getMaxSn", params);
        if(rtn==null) return 1;
        return rtn+1;
    }

    public List<BpmSolUsergroup> getBySolNode( String solId, String actDefId, String nodeId, String groupType){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("solId", solId);
        params.put("actDefId", actDefId);
        params.put("nodeId", nodeId);
        params.put("groupType", groupType);

        List<BpmSolUsergroup> rtn=(List<BpmSolUsergroup>) this.getBySqlKey("getBySolNode", params);
        return rtn;
    }


    public List<BpmSolUsergroup> getBySolActDefId(String tenantId, String solId,String actDefId){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("tenantId", tenantId);
        params.put("solId", solId);
        params.put("actDefId", actDefId);


        List<BpmSolUsergroup> rtn=(List<BpmSolUsergroup>) this.getBySqlKey("getBySolActDefId", params);
        return rtn;
    }


	public void delBySolIdActDefId(String solId, String actDefId) {
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		this.deleteBySqlKey("delBySolIdActDefId", params);
	}


}
