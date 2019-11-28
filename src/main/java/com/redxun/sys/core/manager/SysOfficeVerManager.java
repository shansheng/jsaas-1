
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysOfficeVerDao;
import com.redxun.sys.core.entity.SysOfficeVer;

/**
 * 
 * <pre> 
 * 描述：OFFICE版本 处理接口
 * 作者:ray
 * 日期:2018-01-15 15:34:18
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysOfficeVerManager extends MybatisBaseManager<SysOfficeVer>{
	@Resource
	private SysOfficeVerDao sysOfficeVerDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysOfficeVerDao;
	}
	
	
	
	public SysOfficeVer getSysOfficeVer(String uId){
		SysOfficeVer sysOfficeVer = get(uId);
		return sysOfficeVer;
	}
}
