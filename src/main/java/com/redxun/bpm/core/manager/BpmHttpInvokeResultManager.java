
package com.redxun.bpm.core.manager;

import com.redxun.bpm.core.dao.BpmHttpInvokeResultDao;
import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 
 * <pre> 
 * 描述：调用结果 处理接口
 * 作者:ray
 * 日期:2019-02-15 14:34:24
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmHttpInvokeResultManager extends MybatisBaseManager<BpmHttpInvokeResult> {
	
	@Resource
	private BpmHttpInvokeResultDao bpmHttpInvokeResultDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmHttpInvokeResultDao;
	}
	
	
	
	public BpmHttpInvokeResult getBpmHttpInvokeResult(String uId){
		BpmHttpInvokeResult bpmHttpInvokeResult = get(uId);
		return bpmHttpInvokeResult;
	}
	

	
	
	@Override
	public void create(BpmHttpInvokeResult entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(BpmHttpInvokeResult entity) {
		super.update(entity);
		
		
		
		
	}
	
	
}
