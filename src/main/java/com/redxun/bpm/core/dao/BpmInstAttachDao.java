
/**
 * 
 * <pre> 
 * 描述：流程实例附件 DAO接口
 * 作者:ray
 * 日期:2019-01-14 14:22:32
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmInstAttach;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstAttachDao extends BaseMybatisDao<BpmInstAttach> {

	@Override
	public String getNamespace() {
		return BpmInstAttach.class.getName();
	}

    public void delByInstId(String instId){
        this.deleteBySqlKey("delByInstId",instId);
    }
    public List<BpmInstAttach> getByInstId(String instId){
        return this.getBySqlKey("getByInstId", instId);
    }

}

