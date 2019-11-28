
/**
 * 
 * <pre> 
 * 描述：ACT_RU_IDENTITYLINK DAO接口
 * 作者:ray
 * 日期:2019-01-14 11:54:06
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmIdentityLink;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmIdentityLinkDao extends BaseMybatisDao<BpmIdentityLink> {

	@Override
	public String getNamespace() {
		return BpmIdentityLink.class.getName();
	}
	public void deleteByTaskId(String taskId){
		this.deleteBySqlKey("deleteBySqlKey",taskId);
	}
	

}

