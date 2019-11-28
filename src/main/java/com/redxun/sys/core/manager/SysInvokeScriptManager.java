
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysInvokeScriptDao;
import com.redxun.sys.core.entity.SysInvokeScript;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：执行脚本配置 处理接口
 * 作者:ray
 * 日期:2018-10-18 11:06:29
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysInvokeScriptManager extends MybatisBaseManager<SysInvokeScript>{
	
	@Resource
	private SysInvokeScriptDao sysInvokeScriptDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysInvokeScriptDao;
	}
	
	
	public SysInvokeScript getByAlias(String alias,String tenantId){
		SysInvokeScript invokeScript=sysInvokeScriptDao.getByAlias(alias, tenantId);
		return invokeScript;
	}
	
	
}
