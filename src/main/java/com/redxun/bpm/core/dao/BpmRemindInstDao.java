
/**
 * 
 * <pre> 
 * 描述：催办实例表 DAO接口
 * 作者:ray
 * 日期:2016-12-26 14:26:48
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmRemindInst;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.BeanUtil;

@Repository
public class BpmRemindInstDao extends BaseMybatisDao<BpmRemindInst> {

	@Override
	public String getNamespace() {
		return BpmRemindInst.class.getName();
	}
	
	/**
	 * 获取催办数据。
	 * @return
	 */
	public List<BpmRemindInst> getRemindInst(Boolean isExpire){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("newDate", new Date());
		params.put("isExpire", isExpire);
		return this.getBySqlKey("getRemindInst", params);
	}
	
	/**
	 * 根据任务删除催办实例。
	 * @param taskId
	 */
	public void removeByTask(String taskId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("taskId",taskId);
		this.deleteBySqlKey("removeByTask", params);
	}

	
	public List<BpmRemindInst> getByTaskIds(Set<String> tasks){
		if(BeanUtil.isEmpty(tasks)) return Collections.emptyList();
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("tasks",tasks);
		return  this.getBySqlKey("getByTaskIds", params);
	}
	
	
	public void removeByInst(String actInstId){
		this.deleteBySqlKey("removeByInst", actInstId);
	}
}

