
/**
 * 
 * <pre> 
 * 描述：公司或新闻评论 DAO接口
 * 作者:ray
 * 日期:2018-11-01 11:13:29
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.oa.info.entity.InsNewsCm;
import com.redxun.saweb.context.ContextUtil;

@Repository
public class InsNewsCmDao extends BaseMybatisDao<InsNewsCm> {

	@Override
	public String getNamespace() {
		return InsNewsCm.class.getName();
	}
	
	public List<InsNewsCm> getByNewId(String newId){
    	
		String tenantId = ContextUtil.getCurrentTenantId();
    	Map<String,Object> params=new HashMap<>();
    	params.put("newId", newId);
    	params.put("tenantId", tenantId);    	
	
    	return this.getBySqlKey("getByNewId", params);
	}
    /**
     * 获取所有回复某条评论的子评论
     * @param repId 回复的那条评论的Id
     * @return
     */
    public List<InsNewsCm> getByReplyId(String repId){
    	String tenantId = ContextUtil.getCurrentTenantId();
    	//String ql="from InsNewsCm insnc where insnc.repId=? and insnc.tenantId = ? order by createTime";
    	//return this.getByJpql(ql, new Object[]{repId,tenantId});
    	Map<String,Object> params=new HashMap<>();
    	params.put("repId", repId);
    	params.put("tenantId", tenantId);
    	return this.getBySqlKey("getByReplyId", params);
    }
}

