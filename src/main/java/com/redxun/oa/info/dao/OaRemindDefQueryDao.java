
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

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.info.entity.OaRemindDef;

@Repository
public class OaRemindDefQueryDao extends BaseMybatisDao<OaRemindDef> {

	@Override
	public String getNamespace() {
		return OaRemindDef.class.getName();
	}
	

	
	
	public List<OaRemindDef> getReminds(Map<String,Object> map){
		return this.getBySqlKey("getReminds",map);
	}
	

}

