package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmSolFvDao;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
/**
 * <pre> 
 * 描述：BpmSolFv业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmSolFvManager extends MybatisBaseManager<BpmSolFv>{
	@Resource
	BpmSolFvDao bpmSolFvDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolFvDao;
	}
	
	/**
     * 通过流程解决方案ID获得其节点的表单的配置
     * @param solId
     * @return
     */
    public List<BpmSolFv>getBySolId(String solId){
    	return bpmSolFvDao.getBySolId(solId);
    }
    

    
    public List<BpmSolFv> getBySolIdActDefId(String solId,String actDefId){
    	return bpmSolFvDao.getBySolIdActDefId(solId, actDefId);
    }
    
    /**
     * 优先使用解决方案中的该流程定义的表单配置，若找不到，则用回旧数据中的表单
     * @param solId
     * @param actDefId
     * @param nodeId
     * @return
     */
    public BpmSolFv getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
    	BpmSolFv fv=bpmSolFvDao.getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	return fv;
    }
    
    public void delBySolIdActDefId(String solId,String actDefId){
    	bpmSolFvDao.delBySolIdActDefId(solId, actDefId);
    }
    
    
    public void delBySolId(String solId){
    	bpmSolFvDao.delBySolId(solId);
    }

   
    
    public List<BpmSolFv> getBySolutionId(String solId,String actDefId){
    	return bpmSolFvDao.getBySolutionId(solId, actDefId);
    }
    

   
    
}