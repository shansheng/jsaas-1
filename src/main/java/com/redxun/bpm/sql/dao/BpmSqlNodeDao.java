package com.redxun.bpm.sql.dao;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.sql.entity.BpmSqlNode;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
/**
 * <pre> 
 * 描述：BpmSqlNode数据访问类
 * @author cjx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * </pre>
 */
@Repository
public class BpmSqlNodeDao extends BaseMybatisDao<BpmSqlNode> {
    
    /**
     * 通过业务解决方案ID及节点Id获得节点的sql
     * @param solId
     * @param nodeId
     * @return
     */
    public BpmSqlNode getBySolIdNodeId(String solId,String nodeId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("nodeId", nodeId);
    	
    	return (BpmSqlNode)this.getUnique("getBySolIdNodeId", params);
    }

	@Override
	public String getNamespace() {
		return BpmSqlNode.class.getName();
	}
    
}
