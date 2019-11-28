
package com.redxun.sys.org.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.sys.org.dao.OsDimensionRightDao;
import com.redxun.sys.org.entity.OsDimensionRight;

/**
 * 
 * <pre> 
 * 描述：维度授权 处理接口
 * 作者:ray
 * 日期:2017-05-16 14:12:56
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OsDimensionRightManager extends ExtBaseManager<OsDimensionRight>{
	@Resource
	private OsDimensionRightDao osDimensionRightDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osDimensionRightDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return osDimensionRightDao;
	}
	
	public OsDimensionRight getDimRightByDimId(String dimId){
		return osDimensionRightDao.getDimRightByDimId(dimId);
	}
}
