
/**
 * 
 * <pre> 
 * 描述：流程数据绑定表 DAO接口
 * 作者:mansan
 * 日期:2018-07-24 17:46:41
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.webreq.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.webreq.entity.SysWebReqDef;

@Repository
public class SysWebReqDefDao extends BaseMybatisDao<SysWebReqDef> {

	@Override
	public String getNamespace() {
		return SysWebReqDef.class.getName();
	}

	public SysWebReqDef getKey(String key) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("key", key);
		return this.getUnique("getKey", map);
	}

	public Integer isExist(SysWebReqDef sysWebReqDef) {
		Integer rtn=(Integer) this.getOne("isExist", sysWebReqDef);
		return rtn;
	}
	

}

