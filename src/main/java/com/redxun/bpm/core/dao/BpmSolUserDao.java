package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
/**
 * <pre> 
 * 描述：BpmSolUser数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmSolUserDao extends BaseMybatisDao<BpmSolUser> {
	
	@Override
	public String getNamespace() {
		// TODO Auto-generated method stub
		return BpmSolUser.class.getName();
	}
	
    /**
     * 
     * @param solId
     * @param actDefId
     * @return
     */
    public boolean isExistConfig(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
		params.put("actDefId", actDefId);
    	Long count=(Long) this.getOne("isExistConfig",params);
    	if(count!=null && count>0){
    		return true;
    	}
    	return false;
    }
    
    
    
    /**
     * 通过业务解决方案ID获得人员配置列表 
     * @param solId
     * @return
     */
    public List<BpmSolUser> getBySolId(String solId){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		return this.getBySqlKey("getBySolId", params);
    }
    
    
    /**
     * 获得某个流程的节点的人员配置 
     * @param actDefId
     * @return
     */
    public List<BpmSolUser> getByActDefId(String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("actDefId", actDefId);
		return this.getBySqlKey("getByActDefId", params);
    }
    
    /**
     * 
     * @param solId
     * @param actDefId
     * @param nodeId
     * @return
     */
    public List<BpmSolUser> getBySolActDefIdNodeId(String solId,String actDefId,String nodeId){
    	return getBySolIActDefIdNodeIdCategory(solId,actDefId,nodeId,"task");
    }
    
    
    
    /**
     * 
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param category
     * @return
     */
    public List<BpmSolUser> getBySolIActDefIdNodeIdCategory(String solId,String actDefId,String nodeId,String category){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("category", category);
		return this.getBySqlKey("getBySolIActDefIdNodeIdCategory", params);
    }
    
    
    /**
     * 
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmSolUser> getBySolIdActDefId(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		return this.getBySqlKey("getBySolIdActDefId", params);
    }
    
    /**
     * 
     * @param solId
     * @param actDefId
     * @param category
     * @return
     */
    public List<BpmSolUser> getBySolIdActDefIdCategory(String solId,String actDefId,String category){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("category", category);
		return this.getBySqlKey("getBySolIdActDefIdCategory", params);
    }

    /**
     * 
     * @param actDefId
     * @param nodeId
     * @param category
     * @return
     */
    public List<BpmSolUser> getByActDefIdNodeIdCategory(String actDefId,String nodeId,String category){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("category", category);
		return this.getBySqlKey("getByActDefIdNodeIdCategory", params);
    }
    
    

    /**
     * 删除该解决方案的该流程定义的配置数据  
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param category
     */
    public void delBySolIdActDefIdNodeIdCategory(String solId,String actDefId,String nodeId,String category){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("category", category);
    	this.deleteBySqlKey("delBySolIdActDefIdNodeIdCategory",params);
    }
    
    /**
     * 根据分组获取关联用户。
     * @param groupId
     * @param category
     * @return
     */
    public List<BpmSolUser> getByGroupId(String groupId){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("groupId", groupId);
		return this.getBySqlKey("getByGroupId", params);
    }
    
    /**
     * 按解决方案Id删除 
     * @param solId
     */
    public void delBySolId(String solId){
    	this.deleteBySqlKey("delBySolId", solId);
    }
    
    
    /**
     * 根据解决方案节点id和类型删除用户。
     * @param solId
     * @param nodeId
     * @param category
     */
    public void delSolNodeIdCategory(String solId,String nodeId,String category){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("nodeId", nodeId);
		params.put("category", category);
		this.deleteBySqlKey("delSolNodeIdCategory", params);
    }
    
    /**
     * 删除流程下的某个流程定义的节点人员配置 
     * @param solId
     * @param actDefId
     */
    public void delBySolIdActDefId(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		this.deleteBySqlKey("delBySolIdActDefId", params);
    }

	
    /**
     * 根据组ID删除   
     * @param groupId
     */
    public void delByGroupId(String groupId){
    	this.deleteBySqlKey("delByGroupId",groupId);
    	
    }
    
    public List<BpmSolUser> getEmptyGroup(){
    	Map<String, Object> params=new HashMap<String, Object>();
		return this.getBySqlKey("getEmptyGroup", params);
    }
    
}
