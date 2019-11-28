
/**
 * 
 * <pre> 
 * 描述：系统对象授权表 DAO接口
 * 作者:mansan
 * 日期:2018-05-02 09:55:15
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.oa.info.entity.OaRemindDef;
import com.redxun.oa.info.entity.SysObjectAuthPermission;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.query.QueryFilter;

@Repository
public class SysObjectAuthPermissionDao extends BaseJpaDao<SysObjectAuthPermission> {


	@Override
	protected Class getEntityClass() {
		return SysObjectAuthPermission.class;
	}
	
	



}

