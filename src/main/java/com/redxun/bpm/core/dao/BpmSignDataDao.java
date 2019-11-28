package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmSignData;
import com.redxun.core.dao.jpa.BaseJpaDao;
/**
 * <pre> 
 * 描述：BpmSignData数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmSignDataDao extends BaseMybatisDao<BpmSignData> {


    @Override
    public String getNamespace() {
        return BpmSignData.class.getName();
    }

    /**
     * 按流程实例Id及节点Id获得会签数据
     * @param actInstId
     * @param nodeId
     * @return
     */
    public List<BpmSignData> getByInstIdNodeId(String actInstId,String nodeId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addFieldParam("NODE_ID_",nodeId);
        return this.getBySqlKey("query",filter);
    }

    public void delByActInstIdNodeId(String actInstId,String nodeId){
        Map<String,Object> params = new HashMap<>();
        params.put("actInstId",actInstId);
        params.put("nodeId",nodeId);
        this.deleteBySqlKey("delByActInstIdNodeId",params);
    }
    
    public void delByActInstId(String actInstId){
        Map<String,Object> params = new HashMap<>();
        params.put("actInstId",actInstId);
        this.deleteBySqlKey("delByActInstId",params);
    }
    
    
}
