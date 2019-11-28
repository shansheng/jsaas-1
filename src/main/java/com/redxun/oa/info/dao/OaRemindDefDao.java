
/**
 * 
 * <pre> 
 * 描述：消息提醒 DAO接口
 * 作者:mansan
 * 日期:2018-04-28 16:03:20
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import com.redxun.oa.info.entity.OaRemindDef;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.jpa.BaseJpaDao;

@Repository
public class OaRemindDefDao extends BaseJpaDao<OaRemindDef> {


	@Override
	protected Class getEntityClass() {
		return OaRemindDef.class;
	}

}

