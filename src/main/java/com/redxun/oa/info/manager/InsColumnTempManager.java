
package com.redxun.oa.info.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.info.dao.InsColumnTempQueryDao;
import com.redxun.oa.info.entity.InsColumnTemp;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：栏目模板管理表 处理接口
 * 作者:mansan
 * 日期:2018-08-30 09:50:56
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class InsColumnTempManager extends MybatisBaseManager<InsColumnTemp>{
	//系统预置
	public final String ISSYS = "1";
	//不是系统预置
	public final String ISNOTSYS = "0";
	
	@Resource
	private InsColumnTempQueryDao insColumnTempQueryDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return insColumnTempQueryDao;
	}
	
	
	
	public InsColumnTemp getInsColumnTemp(String uId){
		InsColumnTemp insColumnTemp = get(uId);
		return insColumnTemp;
	}
	

	
	
	@Override
	public void create(InsColumnTemp entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(InsColumnTemp entity) {
		super.update(entity);
	}

	/**
	 * 导入是判断标识键是否存在。
	 * @param alias
	 * @return
	 */
	public boolean isKeyExist(InsColumnTemp entity){
		Integer rtn= insColumnTempQueryDao.getCountByAlias(entity);
		return rtn>0;
	}

	public InsColumnTemp getKey(String key) {
		return insColumnTempQueryDao.getKey(key);
	}
	
	
}
