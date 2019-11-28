
/**
 * 
 * <pre> 
 * 描述：流程沟通留言板 DAO接口
 * 作者:mansan
 * 日期:2017-10-27 16:51:41
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmMessageBoard;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;

@Repository
public class BpmMessageBoardDao extends BaseMybatisDao<BpmMessageBoard> {

	@Override
	public String getNamespace() {
		return BpmMessageBoard.class.getName();
	}

	public List<BpmMessageBoard> getMessageBoardByInstId(String instId,QueryFilter filter) {
		// TODO Auto-generated method stub
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("instId", instId);
		return this.getBySqlKey("getMessageBoardByInstId", params , filter.getPage());
	}
	
	public List getInstUser(String instId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("instId", instId);
		return this.getBySqlKey("getInstUser", params);
		
	}

	public void deleteByInst(String instId) {
		this.deleteBySqlKey("deleteByInst",instId);
	}
	

}

