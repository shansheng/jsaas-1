
/**
 * 
 * <pre> 
 * 描述：流程超时节点表 DAO接口
 * 作者:ray
 * 日期:2019-03-27 18:50:23
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;
import com.redxun.bpm.core.entity.BpmOvertimeNode;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmOvertimeNodeDao extends BaseMybatisDao<BpmOvertimeNode> {

	@Override
	public String getNamespace() {
		return BpmOvertimeNode.class.getName();
	}
	

}

