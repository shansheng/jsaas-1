
/**
 * 
 * <pre> 
 * 描述：调用结果 DAO接口
 * 作者:ray
 * 日期:2019-02-15 14:34:23
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

@Repository
public class BpmHttpInvokeResultDao extends BaseMybatisDao<BpmHttpInvokeResult> {

	@Override
	public String getNamespace() {
		return BpmHttpInvokeResult.class.getName();
	}
	

}

