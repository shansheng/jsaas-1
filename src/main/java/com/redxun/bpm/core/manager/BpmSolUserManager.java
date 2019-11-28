package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmSolUserDao;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
/**
 * <pre> 
 * 描述：BpmSolUser业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmSolUserManager extends MybatisBaseManager<BpmSolUser> implements ModelDataJsonConstants{
	@Resource
	private BpmSolUserDao bpmSolUserDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolUserDao;
	}
	/**
	 * 解决方案中流程节点的人员配置是否存在
	 * @param solId
	 * @param actDefId
	 * @return
	 */
	public boolean isExistConfig(String solId,String actDefId){
		 return bpmSolUserDao.isExistConfig(solId, actDefId);
	}
	 
	/**
     * 获得某个流程的节点的人员配置
     * @param actDefId
     * @return
     */
    public List<BpmSolUser> getByActDefId(String actDefId){
    	return bpmSolUserDao.getByActDefId(actDefId);
    }
    
    
    /**
     * 通过业务解决方案ID及节点id获得人员配置列表
     * @param solId 解决方案Id
     * @param nodeId 节点Id
     * @return
     */
    public List<BpmSolUser> getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
    	return bpmSolUserDao.getBySolActDefIdNodeId(solId, actDefId, nodeId);
    }
    
    public List<BpmSolUser> getBySolIdActDefId(String solId,String actDefId){
    	return bpmSolUserDao.getBySolIdActDefId(solId,actDefId);
    }
    
    /**
     * 通过业务解决方案ID及节点id获得人员配置列表
     * @param solId 解决方案Id
     * @param nodeId 节点Id
     * @return
     */
    public List<BpmSolUser> getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId,String groupType){
    	return bpmSolUserDao.getBySolIActDefIdNodeIdCategory(solId, actDefId, nodeId,groupType);
    }
    
    /**
     * 获取用户。
     * @param solId
     * @param actDefId
     * @param category
     * @return
     */
    public List<BpmSolUser> getBySolIdActDefId(String solId,String actDefId,String category){
    	return bpmSolUserDao.getBySolIdActDefIdCategory(solId, actDefId, category);
    }

	
	/**
     * 通过业务解决方案ID获得人员配置列表
     * @param solId
     * @return
     */
    public List<BpmSolUser> getBySolId(String solId){
    	return bpmSolUserDao.getBySolId(solId);
    }
    
    /**
     * 删除该解决方案的该流程定义的配置数据
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param category
     */
    public void delBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId,String category){
    	bpmSolUserDao.delBySolIdActDefIdNodeIdCategory(solId,actDefId, nodeId, category);
    }
    
    /**
     * 删除流程下的某个流程定义的节点人员配置
     * @param solId
     * @param actDefId
     */
    public void delBySolIdActDefId(String solId,String actDefId){
    	bpmSolUserDao.delBySolIdActDefId(solId, actDefId);
    }
    
    /**
     * 根据分组获取配置人员配置数据。
     * @param groupId
     * @param category
     * @return
     */
    public List<BpmSolUser> getByGroupId(String groupId){
    	return bpmSolUserDao.getByGroupId(groupId);
    }
    
    public void delBySolId(String solId){
    	bpmSolUserDao.delBySolId(solId);
    }
    
    
    public void delSolNodeId(String solId,String nodeId,String category){
    	bpmSolUserDao.delSolNodeIdCategory(solId, nodeId, category);
    }
}