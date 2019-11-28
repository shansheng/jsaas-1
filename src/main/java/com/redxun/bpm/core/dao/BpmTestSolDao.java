package com.redxun.bpm.core.dao;
import java.util.List;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.query.Page;
/**
 * <pre> 
 * 描述：BpmTestSol数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmTestSolDao extends BaseMybatisDao<BpmTestSol> {

    @Override
    public String getNamespace() {
        return BpmTestSol.class.getName();
    }
    
    public List<BpmTestSol> getBySolId(String solId,Page page){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("SOL_ID_",solId);
        filter.setPage(page);
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 按方案及流程定义获得测试方案
     * @param solId
     * @param actDefId
     * @param page
     * @return
     */
    public List<BpmTestSol> getBySolIdActDefId(String solId,String actDefId,Page page){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("SOL_ID_",solId);
        filter.addFieldParam("ACT_DEF_ID_",actDefId);
        filter.setPage(page);
        return this.getBySqlKey("query",filter);
    }
    
}
