
/**
 * 
 * <pre> 
 * 描述：关联关系 DAO接口
 * 作者:mansan
 * 日期:2017-06-29 09:59:32
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstData;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstDataDao extends BaseMybatisDao<BpmInstData> {

	@Override
	public String getNamespace() {
		return BpmInstData.class.getName();
	}
	
	/**
	 * 根据实例ID获取实例列表。
	 * @param instId
	 * @return
	 */
	public List<BpmInstData> getByInstId(String instId){
		List<BpmInstData> list=this.getBySqlKey("getByInstId", instId);
		return list;
	}
	
	
	/**
	 * 删除流程实例删除数据。
	 * @param instId
	 */
	public void removeByInstId(String instId){
		this.deleteBySqlKey("removeByInstId", instId);
		
	}

	
	
}

