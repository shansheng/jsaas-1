package com.redxun.bpm.core.dao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.bpm.core.entity.BpmSolTemplateRight;
import com.redxun.bpm.core.entity.BpmSolution;

import java.util.HashMap;
import java.util.Map;

/**
 * <pre> 
 * 描述：BpmSolTemplateRight数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Repository
public class BpmSolTemplateRightDao extends BaseMybatisDao<BpmSolTemplateRight> {

    @Override
    public String getNamespace() {
        return BpmSolTemplateRight.class.getName();
    }

    /**
     * 通过treeId获取唯一的权限
     * @param treeId
     * @return
     */
    public BpmSolTemplateRight getByTreeId(String treeId){
        Map<String,Object> params = new HashMap<>();
        params.put("treeId",treeId);
        return this.getUnique("getByTreeId",params);
    }
    
}
