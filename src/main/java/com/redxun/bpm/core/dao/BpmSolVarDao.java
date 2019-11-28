package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
/**
 * <pre> 
 * 描述：BpmSolVar数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmSolVarDao extends BaseMybatisDao<BpmSolVar> {
    /**
     * 获得解决方案中的流程定义的某个节点的变量配置
     * @param solId
     * @param actDefId
     * @param scope
     * @return
     */
    public List<BpmSolVar> getBySolIdActDefIdScope(String solId,String actDefId,String scope){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("actDefId", actDefId);
    	params.put("scope", scope);
    	
    	return this.getBySqlKey("getBySolIdActDefIdScope", params);
    }
    
  
    /**
     * 获得解决方案中流程定义所有变量配置
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmSolVar> getBySolIdActDefId(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("actDefId", actDefId);
    	return this.getBySqlKey("getBySolIdActDefId", params);
    }

    /**
     * 按解决方案Id删除
     * @param solId
     */
    public void delBySolId(String solId){
    	this.deleteBySqlKey("delBySolId", solId);
    }
    
    /**
     * 按解决方案及流程定义Id删除
     * @param solId
     * @param actDefId
     */
    public void delBySolIdActDefId(String solId,String actDefId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("actDefId", actDefId);
    	
    	this.deleteBySqlKey("delBySolIdActDefId", params);
    }


	@Override
	public String getNamespace() {
		return  BpmSolVar.class.getName();
	}
    
}
