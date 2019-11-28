
/**
 * 
 * <pre> 
 * 描述：考勤组 DAO接口
 * 作者:mansan
 * 日期:2018-03-27 11:27:43
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsAttenceGroup;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsAttenceGroupDao extends BaseMybatisDao<AtsAttenceGroup> {

	@Override
	public String getNamespace() {
		return AtsAttenceGroup.class.getName();
	}

}

