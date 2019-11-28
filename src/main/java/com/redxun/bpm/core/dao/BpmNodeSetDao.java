package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
/**
 * <pre> 
 * 描述：BpmNodeSet数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmNodeSetDao extends BaseMybatisDao<BpmNodeSet> {
  
    
    public BpmNodeSet getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("actDefId", actDefId);
    	params.put("nodeId", nodeId);
    	
    	BpmNodeSet nodeSet=this.getUnique("getBySolIdActDefIdNodeId", params);
    	
    	return nodeSet;
    	
    }
    
    /**
     * 通过流程定义获得流节点列表
     * @param actDefId
     * @return
     */
    public List<BpmNodeSet> getByActDefId(String actDefId){
    	List<BpmNodeSet> nodeSets=this.getBySqlKey("getByActDefId", actDefId);
    	return nodeSets;
    }
    
    /**
     * 获得某个解决方案中的流程定义的配置
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmNodeSet> getBySolIdActDefId(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("actDefId", actDefId);
    	return  this.getBySqlKey("getByActDefId", params);
    }
    /**
     * 按方案Id及ActDefId删除节点配置
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
     * 按流程解决方案ID删除
     * @param solId
     */
    public void delBySolId(String solId){
    	this.deleteBySqlKey("delBySolId", solId);
    }

	@Override
	public String getNamespace() {
		return BpmNodeSet.class.getName();
	}
    
    
    
}
