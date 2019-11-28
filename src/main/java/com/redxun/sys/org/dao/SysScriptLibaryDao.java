
/**
 * 
 * <pre> 
 * 描述：sys_script_libary DAO接口
 * 作者:ray
 * 日期:2019-03-29 18:12:21
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.query.QueryFilter;
import com.redxun.sys.org.entity.SysScriptLibary;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class SysScriptLibaryDao extends BaseMybatisDao<SysScriptLibary> {

	@Override
	public String getNamespace() {
		return SysScriptLibary.class.getName();
	}

	/**
	 * 查找某个用户组下的用户,并且按条件过滤
	 * @param filter
	 * @return
	 */
	public List<SysScriptLibary> getListBytreeId(QueryFilter filter){
		Map<String,Object> params=filter.getParams();
		return this.getBySqlKey("getListBytreeId", params,filter.getPage());
	}

	public List<SysScriptLibary> getAllList(){
		Map<String,Object> params=new HashMap<>();
		return this.getBySqlKey("getAllList", params);
	}
}

