package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.core.dao.BpmSignDataDao;
import com.redxun.bpm.core.entity.BpmSignData;
/**
 * <pre> 
 * 描述：BpmSignData业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmSignDataManager extends BaseManager<BpmSignData>{
	@Resource
	private BpmSignDataDao bpmSignDataDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSignDataDao;
	}
	
	 /**
     * 按流程实例Id及节点Id获得会签数据
     * @param actInstId
     * @param nodeId
     * @return
     */
    public List<BpmSignData> getByInstIdNodeId(String actInstId,String nodeId){
    	return bpmSignDataDao.getByInstIdNodeId(actInstId, nodeId);
    }
    
    public void delByActInstIdNodeId(String actInstId,String nodeId){
    	bpmSignDataDao.delByActInstIdNodeId(actInstId, nodeId);
    }
    
    public void delByActInstId(String actInstId){
    	bpmSignDataDao.delByActInstId(actInstId);
    }
}