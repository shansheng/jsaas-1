
/**
 * 
 * <pre> 
 * 描述：调用任务 DAO接口
 * 作者:ray
 * 日期:2019-01-24 10:30:29
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BpmHttpTaskDao extends BaseMybatisDao<BpmHttpTask> {

	@Override
	public String getNamespace() {
		return BpmHttpTask.class.getName();
	}
	

	public List<BpmHttpTask> getUnfinishedTask(){
		return this.getBySqlKey("getUnfinishedTask",new Object());
	}
}

