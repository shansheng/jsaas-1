package com.redxun.bpm.core.manager;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmAgentDao;
import com.redxun.bpm.core.entity.BpmAgent;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
/**
 * <pre> 
 * 描述：BpmAgent业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmAgentManager extends MybatisBaseManager<BpmAgent>{
	
	@Resource
	private BpmAgentDao bpmAgentDao;
	@Resource
	BpmAgentSolManager bpmAgentSolManager;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmAgentDao;
	}
	
	
	
	
    @Override
	public void create(BpmAgent entity) {
    	if(BpmAgent.TYPE_PART.equals(entity.getType())){
	    	for(BpmAgentSol sol:entity.getBpmAgentSols()){
				sol.setAsId(IdUtil.getId());
				sol.setAgentId(entity.getAgentId());
				bpmAgentSolManager.create(sol);
			}
    	}
		super.create(entity);
	}




	@Override
	public void update(BpmAgent entity) {
		if(BpmAgent.TYPE_PART.equals(entity.getType())){
			bpmAgentSolManager.delByAgentId(entity.getAgentId());
		
			for(BpmAgentSol sol:entity.getBpmAgentSols()){
				sol.setAsId(IdUtil.getId());
				sol.setAgentId(entity.getAgentId());
				bpmAgentSolManager.create(sol);
			}
		}
		
		super.update(entity);
	}




	/**
     * 根据用户查找代理设定，查询代理人。
     * @param userId	用户ID
     * @param solId		解决方案
     * @param vars		流程变量。
     * @return
     */
    public String getAgentByUserId(String userId,String solId,Map<String,Object> vars){
    	List<BpmAgent> bpmAgents=bpmAgentDao.getValidAgents(userId,BpmAgent.TYPE_ALL);
		if(bpmAgents.size()>0){
			return bpmAgents.get(0).getToUserId();
		}
		
		
		//获得部分代理人
		bpmAgents=bpmAgentDao.getValidAgentSol(userId, solId);
		if(bpmAgents.size()>0){
			return bpmAgents.get(0).getToUserId();
		}
		
		return "";
    }
}