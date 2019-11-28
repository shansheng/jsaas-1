
/**
 * 
 * <pre> 
 * 描述：启动流程日志 DAO接口
 * 作者:ray
 * 日期:2018-06-29 17:37:16
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstStartLog;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstStartLogDao extends BaseMybatisDao<BpmInstStartLog> {

	@Override
	public String getNamespace() {
		return BpmInstStartLog.class.getName();
	}
	
	/**
	 * 根据实例id 和子方案ID获取 BpmInstStartLog.
	 * @param instId
	 * @param subSolId
	 * @return
	 */
	public BpmInstStartLog getByInstSubSolId(String instId,String subSolId){
		Map<String,Object> params=new HashMap<>();
		params.put("fromInstId", instId);
		params.put("toSolId", subSolId);
		BpmInstStartLog startLog=this.getUnique("getByInstSubSolId", params);
		return startLog;
	}

}

