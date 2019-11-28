
package com.redxun.sys.log.manager;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.log.dao.LogModuleDao;
import com.redxun.sys.log.entity.LogModule;

/**
 * 
 * <pre> 
 * 描述：日志模块 处理接口
 * 作者:陈茂昌
 * 日期:2017-09-21 14:38:42
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class LogModuleManager extends MybatisBaseManager<LogModule>{
	@Resource
	private LogModuleDao logModuleDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return logModuleDao;
	}
	
	
	
	public LogModule getLogModule(String uId){
		LogModule logModule = get(uId);
		return logModule;
	}
	
	public void removeAll(){
		logModuleDao.removeAll();
	}
	
	
	public LogModule getLogModuleByModuleAndSubModule(String module,String subModule){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("module", module);
		params.put("subModule", subModule);
		return logModuleDao.getLogModuleByModuleAndSubModule(params);
	}
}
