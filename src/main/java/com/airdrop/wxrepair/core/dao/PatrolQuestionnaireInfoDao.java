
/**
 * 
 * <pre> 
 * 描述：问卷信息 DAO接口
 * 作者:zpf
 * 日期:2019-10-16 10:18:37
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolQuestionnaireInfoDao extends BaseMybatisDao<PatrolQuestionnaireInfo> {

	@Override
	public String getNamespace() {
		return PatrolQuestionnaireInfo.class.getName();
	}

	public List<PatrolQuestionnaireInfo> getAllQuestionnaire() {
		Map map = new HashMap();
		return this.getBySqlKey("getAllQuestionnaire",map);
	}
}

