
/**
 * 
 * <pre> 
 * 描述：栏目模板管理表 DAO接口
 * 作者:mansan
 * 日期:2018-08-30 09:50:56
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import com.redxun.oa.info.entity.InsColumnTemp;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.jpa.BaseJpaDao;

@Repository
public class InsColumnTempDao extends BaseJpaDao<InsColumnTemp> {


	@Override
	protected Class getEntityClass() {
		return InsColumnTemp.class;
	}

}

