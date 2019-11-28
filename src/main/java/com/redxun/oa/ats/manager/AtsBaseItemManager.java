
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsBaseItemDao;
import com.redxun.oa.ats.entity.AtsBaseItem;

/**
 * 
 * <pre> 
 * 描述：基础数据 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsBaseItemManager extends MybatisBaseManager<AtsBaseItem>{
	//系统预置
	public final short ISSYS = 1;
	//不是系统预置
	public final short ISNOTSYS = 0;
	
	@Resource
	private AtsBaseItemDao atsBaseItemDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsBaseItemDao;
	}
	
	
	public AtsBaseItem getAtsBaseItem(String uId){
		AtsBaseItem atsBaseItem = get(uId);
		return atsBaseItem;
	}
}
