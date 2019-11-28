
package com.redxun.sys.code.manager;
import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.code.dao.SysCodeTempDao;
import com.redxun.sys.code.entity.SysCodeTemp;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysInst;

import java.util.List;

import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：模板文件管理表 处理接口
 * 作者:ray
 * 日期:2018-11-01 16:22:39
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysCodeTempManager extends MybatisBaseManager<SysCodeTemp>{
	
	@Resource
	private SysCodeTempDao sysCodeTempDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysCodeTempDao;
	}
	
	
	
	public SysCodeTemp getSysCodeTemp(String uId){
		SysCodeTemp sysCodeTemp = get(uId);
		return sysCodeTemp;
	}
	

	
	
	@Override
	public void create(SysCodeTemp entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysCodeTemp entity) {
		super.update(entity);
	}



	public boolean isExist(String alias,String pkId,String tenantId) {
		SysCodeTemp sysCodeTemp=getByAlias(alias,tenantId);
		if(StringUtils.isEmpty(pkId) && sysCodeTemp!=null){
			return true;
		}else if(StringUtils.isNotEmpty(pkId) && sysCodeTemp!=null && !(pkId.equals(sysCodeTemp.getPkId()))){
			return true;
		}
		
		return false;
	}



	private SysCodeTemp getByAlias(String alias, String tenantId) {
		SysCodeTemp sysCodeTemp=sysCodeTempDao.getByAlias(alias, tenantId);
		if(sysCodeTemp==null){
			sysCodeTemp=sysCodeTempDao.getByAlias(alias, SysInst.ADMIN_TENANT_ID);
		}
		return sysCodeTemp;
	}
	
	
}
