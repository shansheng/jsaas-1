
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysOfficeTemplateDao;
import com.redxun.sys.core.entity.SysOfficeTemplate;

/**
 * 
 * <pre> 
 * 描述：office模板 处理接口
 * 作者:ray
 * 日期:2018-01-28 11:11:47
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysOfficeTemplateManager extends MybatisBaseManager<SysOfficeTemplate>{
	@Resource
	private SysOfficeTemplateDao sysOfficeTemplateDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysOfficeTemplateDao;
	}
	
	
	
	public SysOfficeTemplate getSysOfficeTemplate(String uId){
		SysOfficeTemplate sysOfficeTemplate = get(uId);
		return sysOfficeTemplate;
	}
}
