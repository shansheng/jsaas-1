
package com.redxun.oa.article.manager;
import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.article.dao.ProItemDao;
import com.redxun.oa.article.entity.ProItem;
import com.redxun.sys.core.entity.SysInst;

/**
 * 
 * <pre> 
 * 描述：项目 处理接口
 * 作者:陈茂昌
 * 日期:2017-09-29 14:38:27
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class ProItemManager extends MybatisBaseManager<ProItem>{
	@Resource
	private ProItemDao proItemDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return proItemDao;
	}
	
	
	
	public ProItem getProItem(String uId){
		ProItem proItem = get(uId);
		return proItem;
	}
	
	public ProItem getByKey(String key,String tenantId){
		ProItem proItem=proItemDao.getByKey(key, tenantId);
		if(proItem==null){
			proItem=proItemDao.getByKey(key, SysInst.ADMIN_TENANT_ID);
		}
		return proItem;
	}
	
	public boolean isKeyExist(String key,String tenantId,String pkId){
		ProItem proItem=getByKey(key,tenantId);
		if(StringUtils.isEmpty(pkId) && proItem!=null){
			return true;
		}else if(StringUtils.isNotEmpty(pkId) && proItem!=null && !(pkId.equals(proItem.getPkId()))){
			return true;
		}
		
		return false;
	}
}
