
/**
 * 
 * <pre> 
 * 描述：考勤计算设置 DAO接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsAttenceCalculateSet;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsAttenceCalculateSetDao extends BaseMybatisDao<AtsAttenceCalculateSet> {

	@Override
	public String getNamespace() {
		return AtsAttenceCalculateSet.class.getName();
	}


}

