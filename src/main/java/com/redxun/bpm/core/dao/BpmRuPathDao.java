package com.redxun.bpm.core.dao;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.enums.TaskOptionType;
/**
 * <pre> 
 * 描述：BpmRuPath数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmRuPathDao extends BaseMybatisDao<BpmRuPath> {

	@Override
	public String getNamespace() {
		return BpmRuPath.class.getName();
	}
    
    //TODO
    public Map<String,String> getLatestCheckStatus(String actInstId){
		Map<String,Object> params = new HashMap<>();
		params.put("actInstId",actInstId);
		params.put("nodeType","userTask");
		Map<String,String> map=new HashMap<String, String>();
		List list=this.getBySqlKey("getLatestCheckStatus",params);
		for(int i=0;i<list.size();i++){
			Map m=(Map)list.get(i);
			String nodeId=(String)m.get("nodeId");
			String jumpType=(String)m.get("jumpType");
			map.put(nodeId, jumpType);
		}

		return map;
    }
    
    /**
     * 获得父节点下的执行路径
     * @param parentId
     * @return
     */
    public List<BpmRuPath> getByParentId(String parentId){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("PARENT_ID_",parentId);
		return this.getBySqlKey("query",filter);
    }
    
    /**
     * 获得某个父节点下的某个节点的跳转记录
     * @param parentId
     * @param nodeId
     * @return
     */
    public BpmRuPath getByParentIdNodeId(String parentId,String nodeId){

    	Map<String,Object> params = new HashMap<>();
		params.put("parentId",parentId);
		params.put("nodeId",nodeId);
		return this.getUnique("getByParentIdNodeId",params);
    }
    
    /**
     * 获得流程实例的跳转路线
     * @param actInstId
     * @return
     */
    public List<BpmRuPath> getByActInstId(String actInstId){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("ACT_INST_ID_",actInstId);
		filter.addSortParam("PARENT_ID_","ASC");
		return this.getBySqlKey("query",filter);
    }
    
    /**
     * 获得执行路径的点
     * @param actInstId
     * @return
     */
    public BpmRuPath getByActInstIdNodeIdLevel(String actInstId,String nodeId,Integer level){
    	BpmRuPath path=getByActInstIdNodeIdLevelToken( actInstId, nodeId, level, "");
    	return path;
    }
    
    public BpmRuPath getByActInstIdNodeIdLevelToken(String actInstId,String nodeId,Integer level,String token){
    	Map<String,Object> params = new HashMap<>();
    	params.put("ACT_INST_ID_", actInstId);
    	params.put("NODE_ID_", nodeId);
    	params.put("LEVEL_", level);
    	params.put("TOKEN_", token);
    	
		List<BpmRuPath> ruPathList= this.getBySqlKey("getByActInstIdNodeIdLevel",params);
    	if(ruPathList.size()>0){
    		return ruPathList.get(0);
    	}
    	return null;
    }
    
    
    /**
     * 获得执行路径的点
     * @param actInstId
     * @return
     */
    public Integer getMaxLevel(String actInstId,String nodeId){
    	Map<String,Object> params = new HashMap<>();
    	params.put("actInstId",actInstId);
    	params.put("nodeId",nodeId);
    	return (Integer)this.getOne("getMaxLevel",params);
    }
    
    /**
     * 取得离开始节点的最远路径点
     * @param actInstId
     * @param nodeId
     * @return
     */
    public BpmRuPath getFarestPath(String actInstId,String nodeId){
    	Integer level=getMaxLevel(actInstId, nodeId);
    	if(level==null){
    		level=1;
    	}
    	return getByActInstIdNodeIdLevel(actInstId,nodeId,level);
    }
    
    public BpmRuPath getFarestPath(String actInstId,String nodeId,String token){
    	Integer level=getMaxLevel(actInstId, nodeId);
    	if(level==null){
    		level=1;
    	}
    	return getByActInstIdNodeIdLevelToken(actInstId, nodeId, level, token);
    }
    
    
    /**
     * 通过实例Id,节点类弄，跳转类型获得列表
     * @param actInstId
     * @param nodeType
     * @param jumpType
     * @return
     */
    public List<BpmRuPath> getByActInstIdNodeTypeJumpType(String actInstId,String nodeType,String jumpType){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("ACT_INST_ID_",actInstId);
		filter.addFieldParam("NODE_TYPE_",nodeType);
		filter.addFieldParam("JUMP_TYPE_",jumpType);
		return this.getBySqlKey("query",filter);
    }
    
    /**
     * 找到最新的回退记录列表
     * @param actInstId
     * @return
     */
    public List<BpmRuPath> getLatestBackStart(String actInstId){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("ACT_INST_ID_",actInstId);
		filter.addLikeFieldParam("JUMP_TYPE_",TaskOptionType.BACK.name()+"%");
		filter.addSortParam("CREATE_TIME_","DESC");
		return this.getBySqlKey("query",filter);
    }
    /**
     * 查找该实例中传入参数的时间大的最新审批记录
     * @param actInstId
     * @param createTime
     * @return
     */
    public List<BpmRuPath> getByActInstIdGtCreateTinme(String actInstId,Date createTime){
    	Map<String,Object> params = new HashMap<>();
		params.put("actInstId",actInstId);
		params.put("createTime",createTime);
		return this.getBySqlKey("getByActInstIdGtCreateTinme",params);
    }

	/**
	 * -------------------------------下为query
	 */

	public List<BpmRuPath> getLatestByActInstId(String actInstId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		return this.getBySqlKey("getLatestByActInstId", params);
	}

	public void removeByInst(String instId){
		this.deleteBySqlKey("removeByInst", instId);
	}

	/**
	 * 根据execution 和节点ID查询rupath。
	 * @param executionId
	 * @param nodeId
	 * @return
	 */
	public List<BpmRuPath> getByExecutionNode(String executionId,String nodeId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("executionId", executionId);
		params.put("nodeId", nodeId);

		return this.getBySqlKey("getByExecutionNode", params);
	}

	/**
	 * 获取最近的一个任务节点。
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	public BpmRuPath getLastPathByNode(String actInstId,String nodeId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("nodeId", nodeId);

		return this.getUnique("getLastPathByNode", params);
	}

	public BpmRuPath getLastPathByNode(String actInstId,String nodeId,Date createTime){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("nodeId", nodeId);
		params.put("createTime", createTime);

		return this.getUnique("getLastPathByNode", params);
	}

	/**
	 * 获取从某个节点开始最早的审批记录。
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	public List<BpmRuPath > getEarliestByActInstId(String actInstId,String nodeId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("nodeId", nodeId);
		return this.getBySqlKey("getEarliestByActInstId", params);
	}



	/**
	 * 获取上一个任务节点。
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	public BpmRuPath getMinPathByNode(String actInstId, String nodeId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("nodeId", nodeId);

		return this.getUnique("getMinPathByNode", params);
	}

}
