
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysInstTypeMenuDao;
import com.redxun.sys.core.entity.SysInstTypeMenu;

/**
 * 
 * <pre> 
 * 描述：机构类型授权菜单 处理接口
 * 作者:mansan
 * 日期:2017-12-19 11:00:46
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysInstTypeMenuManager extends MybatisBaseManager<SysInstTypeMenu>{
	@Resource
	private SysInstTypeMenuDao sysInstTypeMenuDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysInstTypeMenuDao;
	}
	
	
	
	public SysInstTypeMenu getSysInstTypeMenu(String uId){
		SysInstTypeMenu sysInstTypeMenu = get(uId);
		return sysInstTypeMenu;
	}

	public void deleteByInstTypeId(String typeId) {
		
		sysInstTypeMenuDao.deleteByInstTypeId(typeId);
		
	}
}
