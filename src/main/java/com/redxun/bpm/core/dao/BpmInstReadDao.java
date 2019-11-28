package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstRead;
import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.query.Page;
/**
 * <pre>
 * 描述：BpmInstRead数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmInstReadDao extends BaseMybatisDao<BpmInstRead> {

    @Override
    public String getNamespace() {
        return BpmInstRead.class.getName();
    }

    /**
     * 判断是否已经存入阅读记录
     * @param userId
     * @param instId
     * @return
     */
    public boolean isRead(String userId,String instId){
        Map<String,Object> params=new HashMap<>();
        params.put("instId", instId);
        params.put("userId", userId);

        Integer a =(Integer) this.getOne("getIsReadCount", params);
    	if(a >0L){
    		return true;
    	}else{
    		return false;
    	}
    }

    /**
     * 获得该流程的所有阅读记录
     * @param instId
     * @return
     */
    public List<BpmInstRead> getAllByInstId(String instId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("INST_ID_",instId);
        filter.addSortParam("CREATE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }

    /**
     * 获得该流程的所有阅读记录
     * @param instId
     * @return
     */
    public List<BpmInstRead> getAllByInstId(String instId,Page page){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("INST_ID_",instId);
        filter.addSortParam("CREATE_TIME_","DESC");
        filter.setPage(page);
        return this.getBySqlKey("query",filter);
    }

    public void removeByInst(String instId){
        this.deleteBySqlKey("removeByInst",instId);
    }

}
