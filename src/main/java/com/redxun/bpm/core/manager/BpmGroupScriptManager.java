
package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmGroupScriptDao;
import com.redxun.bpm.core.entity.BpmGroupScript;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;

/**
 * 
 * <pre> 
 * 描述：人员脚本 处理接口
 * 作者:ray
 * 日期:2017-06-01 11:33:08
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmGroupScriptManager extends MybatisBaseManager<BpmGroupScript>{
	@Resource
	private BpmGroupScriptDao bpmGroupScriptDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmGroupScriptDao;
	}
	
	
	
	public List<BpmGroupScript> getAllClass(QueryFilter queryFilter){
		return bpmGroupScriptDao.getAllClass(queryFilter);
	}
}
