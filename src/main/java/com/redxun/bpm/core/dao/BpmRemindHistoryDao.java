
/**
 * 
 * <pre> 
 * 描述：催办历史 DAO接口
 * 作者:ray
 * 日期:2016-12-26 14:26:48
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmRemindHistory;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmRemindHistoryDao extends BaseMybatisDao<BpmRemindHistory> {

	@Override
	public String getNamespace() {
		return BpmRemindHistory.class.getName();
	}
	
	
	/**
	 * 根据实例和开始结束时间判断是否已发送。
	 * @param instId
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public Integer getByStartEnd(String instId,Date startTime,Date endTime){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("reminderInstId", instId);
    	params.put("startTime", startTime);
    	params.put("endTime", endTime);
    	
    	Integer rtn=(Integer) this.getOne("getByStartEnd", params);
    	
		return rtn;
    	
    }
	
	/**
	 * 根据流程实例删除催办历史。
	 * @param actInstId
	 */
	public void removeByActInst(String actInstId){
    	this.deleteBySqlKey("removeByActInst", actInstId);
    }
	

}

