
/**
 * 
 * <pre> 
 * 描述：问卷类型 DAO接口
 * 作者:zpf
 * 日期:2019-11-20 15:28:18
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireType;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolQuestionnaireTypeDao extends BaseMybatisDao<PatrolQuestionnaireType> {

	@Override
	public String getNamespace() {
		return PatrolQuestionnaireType.class.getName();
	}
	
	public List<PatrolQuestionnaireType> getAllType(){
		Map<String, Object> map = new HashMap<>();
		return this.getBySqlKey("getAllType",map);
	}
}

