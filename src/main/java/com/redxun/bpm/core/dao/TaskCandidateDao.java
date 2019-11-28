
/**
 * 
 * <pre> 
 * 描述：act_ru_identitylink DAO接口
 * 作者:ray
 * 日期:2018-10-26 17:26:32
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.TaskCandidate;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class TaskCandidateDao extends BaseMybatisDao<TaskCandidate> {

	@Override
	public String getNamespace() {
		return TaskCandidate.class.getName();
	}
	
	/**
	 * 根据任务获取候选人。
	 * @param taskId
	 * @return
	 */
	public List<TaskCandidate> getByTaskId(String taskId){
		List<TaskCandidate> list=this.getBySqlKey("getByTaskId", taskId);
		return list;
	}

}

