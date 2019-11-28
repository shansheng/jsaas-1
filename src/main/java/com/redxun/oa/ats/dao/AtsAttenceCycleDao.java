
/**
 * 
 * <pre> 
 * 描述：考勤周期 DAO接口
 * 作者:mansan
 * 日期:2018-03-23 14:36:39
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsAttenceCycle;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsAttenceCycleDao extends BaseMybatisDao<AtsAttenceCycle> {

	@Override
	public String getNamespace() {
		return AtsAttenceCycle.class.getName();
	}

}

