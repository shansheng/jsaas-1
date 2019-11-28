
package com.redxun.sys.org.manager;
import javax.annotation.Resource;

import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.dao.SysScriptLibaryDao;
import com.redxun.sys.org.entity.SysScriptLibary;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：sys_script_sibary 处理接口
 * 作者:ray
 * 日期:2019-03-29 18:12:21
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysScriptLibaryManager extends MybatisBaseManager<SysScriptLibary>{
	
	@Resource
	private SysScriptLibaryDao sysScriptLibaryDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysScriptLibaryDao;
	}
	
	
	
	public SysScriptLibary getSysScriptLibary(String uId){
		SysScriptLibary sysScriptLibary = get(uId);
		return sysScriptLibary;
	}

	@Override
	public void create(SysScriptLibary entity) {
		entity.setLibId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysScriptLibary entity) {
		super.update(entity);
	}

	public void addSysScriptLibary(List<SysScriptLibary> libaryList){
		for (SysScriptLibary entity:libaryList) {
			entity.setLibId(IdUtil.getId());
			entity.setTenantId(ContextUtil.getCurrentTenantId());
			super.create(entity);
		}
	}

	/**
	 * 查找某个用户组下的用户,并且按条件过滤
	 * @param filter
	 * @return
	 */
	public List<SysScriptLibary> getListBytreeId(QueryFilter filter){
		return sysScriptLibaryDao.getListBytreeId(filter);
	}


	public List<SysScriptLibary> getAllList(){
		return sysScriptLibaryDao.getAllList();
	}
}
