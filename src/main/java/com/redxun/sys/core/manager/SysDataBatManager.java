
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.core.dao.SysDataBatDao;
import com.redxun.sys.core.entity.SysDataBat;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：数据批量录入 处理接口
 * 作者:ray
 * 日期:2019-01-02 10:49:42
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysDataBatManager extends MybatisBaseManager<SysDataBat>{
	
	@Resource
	private SysDataBatDao sysDataBatDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysDataBatDao;
	}
	
	
	
	public SysDataBat getSysDataBat(String uId){
		SysDataBat sysDataBat = get(uId);
		return sysDataBat;
	}
	

	
	
	@Override
	public void create(SysDataBat entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysDataBat entity) {
		super.update(entity);
		
		
		
		
	}
	
	
}
