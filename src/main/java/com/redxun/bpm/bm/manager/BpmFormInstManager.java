
package com.redxun.bpm.bm.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.bm.dao.BpmFormInstDao;
import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;

/**
 * 
 * <pre> 
 * 描述：流程数据模型实例 处理接口
 * 作者:ray
 * 日期:2018-10-27 21:12:32
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmFormInstManager extends MybatisBaseManager<BpmFormInst>{
	
	@Resource
	private BpmFormInstDao bpmFormInstDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormInstDao;
	}

	/**
	 * 通过流程实例Id获得流程表单实例
	 * 
	 * @param bpmInstId
	 * @return
	 */
	public BpmFormInst getByBpmInstId(String bpmInstId) {
		return bpmFormInstDao.getByBpmInstId(bpmInstId);
	}
	
	
	
	
	
	
}
