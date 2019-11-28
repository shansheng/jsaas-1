
/**
 * 
 * <pre> 
 * 描述：日志模块 DAO接口
 * 作者:陈茂昌
 * 日期:2017-09-21 14:38:42
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.log.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.log.entity.LogModule;

@Repository
public class LogModuleDao extends BaseMybatisDao<LogModule> {

	@Override
	public String getNamespace() {
		return LogModule.class.getName();
	}
	
	/**
	 * 删除。
	 */
	public void removeAll(){
		this.deleteBySqlKey("removeAll");
	}

	public LogModule getLogModuleByModuleAndSubModule(Map<String,Object> params){
		return this.getUnique("getLogModuleByModuleAndSubModule", params);
		
	}
}

