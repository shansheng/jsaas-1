
package com.redxun.sys.translog.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.translog.dao.SysTransferLogDao;
import com.redxun.sys.translog.entity.SysTransferLog;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：权限转移日志表 处理接口
 * 作者:mansan
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysTransferLogManager extends MybatisBaseManager<SysTransferLog>{
	
	@Resource
	private SysTransferLogDao sysTransferLogDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysTransferLogDao;
	}
	
	
	
	public SysTransferLog getSysTransferLog(String uId){
		SysTransferLog sysTransferLog = get(uId);
		return sysTransferLog;
	}
	

	
	
	@Override
	public void create(SysTransferLog entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysTransferLog entity) {
		super.update(entity);
	}
	
	public void deleteTenantId(String tenantId) {
		sysTransferLogDao.deleteByTenantId(tenantId);		
	}
	
}
