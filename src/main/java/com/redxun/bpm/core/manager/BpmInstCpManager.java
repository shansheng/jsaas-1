package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.bpm.core.dao.BpmInstCpDao;
import com.redxun.bpm.core.entity.BpmInstCp;
/**
 * <pre> 
 * 描述：BpmInstCp业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmInstCpManager extends MybatisBaseManager<BpmInstCp>{
	@Resource
	private BpmInstCpDao bpmInstCpDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstCpDao;
	}
	
	
	public void updRead(String id){
		bpmInstCpDao.updRead(id);
	}
	
	
}