
/**
 * 
 * <pre> 
 * 描述：题目选项 DAO接口
 * 作者:zpf
 * 日期:2019-11-13 14:46:31
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolQuestionOption;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolQuestionOptionDao extends BaseMybatisDao<PatrolQuestionOption> {

	@Override
	public String getNamespace() {
		return PatrolQuestionOption.class.getName();
	}

	public List<PatrolQuestionOption> getQuestionOption(Object qId) {
		Map map = new HashMap();
		map.put("qId",qId);
		return this.getBySqlKey("getQuestionOption",map);
	}
}

