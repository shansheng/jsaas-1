
/**
 * 
 * <pre> 
 * 描述：流程更新日志
 DAO接口
 * 作者:ray
 * 日期:2018-07-17 11:56:12
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmLog;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmLogDao extends BaseMybatisDao<BpmLog> {

	@Override
	public String getNamespace() {
		return BpmLog.class.getName();
	}
	

}

