package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.bpm.core.entity.BpmTestCase;
/**
 * <pre> 
 * 描述：BpmTestCase数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmTestCaseDao extends BaseMybatisDao<BpmTestCase> {

	@Override
	public String getNamespace() {
		return BpmTestCase.class.getName();
	}
    
    /**
	 * 通过测试方案Id获得测试用例列表
	 * @param testSolId
	 * @return
	 */
	public List<BpmTestCase> getByTestSolId(String testSolId){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("TEST_SOL_ID_",testSolId);
		return this.getBySqlKey("query",filter);
	}
	
	public void delByInstId(String instId){
		this.deleteBySqlKey("delByInstId",instId);
	}
    
}
