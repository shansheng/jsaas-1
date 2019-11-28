package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmAgentSolDao;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.core.constants.MStatus;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
/**
 * <pre> 
 * 描述：BpmAgentSol业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmAgentSolManager extends BaseManager<BpmAgentSol>{
	@Resource
	private BpmAgentSolDao bpmAgentSolDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmAgentSolDao;
	}
	
	public List<BpmAgentSol> getByAgentId(String agentId){
		return bpmAgentSolDao.getByAgentId(agentId);
	}
	
	
	
	public void delByAgentId(String agentId){
		bpmAgentSolDao.delByAgentId(agentId);
	}
}