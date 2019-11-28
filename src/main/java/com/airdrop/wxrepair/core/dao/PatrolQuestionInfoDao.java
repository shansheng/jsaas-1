
/**
 * 
 * <pre> 
 * 描述：问题信息 DAO接口
 * 作者:zpf
 * 日期:2019-10-10 16:51:08
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolQuestionInfo;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolQuestionInfoDao extends BaseMybatisDao<PatrolQuestionInfo> {

	@Override
	public String getNamespace() {
		return PatrolQuestionInfo.class.getName();
	}

	public List<Map> getQuestionByNaire(String nId) {
		Map map = new HashMap();
		map.put("nId",nId);
		return this.getBySqlKey("getQuestionByNaire",map);
	}

	public List<Map> getQuestionOption(Object qId) {
		Map map = new HashMap();
		map.put("qId",qId);
		return this.getBySqlKey("getQuestionOption",map);
	}
}

