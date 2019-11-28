
/**
 * 
 * <pre> 
 * 描述：用户类型 DAO接口
 * 作者:mansan
 * 日期:2018-09-03 14:21:10
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsUserType;

@Repository
public class OsUserTypeDao extends BaseMybatisDao<OsUserType> {

	@Override
	public String getNamespace() {
		return OsUserType.class.getName();
	}
	
	/**
	 * 按编号获得用户类型
	 * @param code
	 * @return
	 */
	public OsUserType getByCode(String code){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("code", code);
		return this.getUnique("getByCode", params);
	}
	
}

