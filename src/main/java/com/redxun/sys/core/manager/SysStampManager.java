
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysStampDao;
import com.redxun.sys.core.entity.SysStamp;

/**
 * 
 * <pre> 
 * 描述：office印章 处理接口
 * 作者:ray
 * 日期:2018-02-01 09:41:38
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysStampManager extends MybatisBaseManager<SysStamp>{
	@Resource
	private SysStampDao sysStampDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysStampDao;
	}
	
	
	
	public SysStamp getSysStamp(String uId){
		SysStamp sysStamp = get(uId);
		return sysStamp;
	}
}
