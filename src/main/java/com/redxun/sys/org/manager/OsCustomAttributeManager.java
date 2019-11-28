
package com.redxun.sys.org.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.dao.OsCustomAttributeDao;
import com.redxun.sys.org.entity.OsCustomAttribute;

/**
 * 
 * <pre> 
 * 描述：自定义属性 处理接口
 * 作者:mansan
 * 日期:2017-12-14 14:02:29
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OsCustomAttributeManager extends ExtBaseManager<OsCustomAttribute>{
	@Resource
	private OsCustomAttributeDao osCustomAttributeDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osCustomAttributeDao;
	}
	
	public OsCustomAttribute getOsCustomAttribute(String uId){
		OsCustomAttribute osCustomAttribute = get(uId);
		return osCustomAttribute;
	}
	/**
	 * 将自定义属性添加进modelAndView返回到前端构建表单
	 * @param modelAndView
	 */
	public void addCustomAttribute(ModelAndView modelAndView){
		String tenantId=ContextUtil.getCurrentTenantId();
		List<OsCustomAttribute> osCustomAttributes=getAllByTenantId(tenantId);
		modelAndView.addObject("osCustomAttributes", osCustomAttributes);
	}
	/**
	 * 将用户类型的自定义属性全部取出来
	 * @param tenantId
	 * @return
	 */
	public List<OsCustomAttribute> getUserTypeAttributeByTenantId(String tenantId,String attriButeTpye){
		return osCustomAttributeDao.getUserTypeAttributeByTenantId(tenantId,attriButeTpye);
	}

	public List<OsCustomAttribute> getUserTypeAttributeByTarGetId(String tenantId,String tarGetId,String attriButeTpye){
		return osCustomAttributeDao.getUserTypeAttributeByTarGetId(tenantId,tarGetId,attriButeTpye);
	}
	
	public OsCustomAttribute getBykey(String key,String tenantId) {
		return osCustomAttributeDao.getByKey(key,tenantId);
	}

	public List<OsCustomAttribute> getUserTypeAttributeByUserId(String userId){
		return osCustomAttributeDao.getUserTypeAttributeByUserId(userId);
	}

	@Override
	public BaseMybatisDao getMyBatisDao() {
		return osCustomAttributeDao;
	}
}
