
/**
 * 
 * <pre> 
 * 描述：FORM_VALID_RULE DAO接口
 * 作者:ray
 * 日期:2018-11-27 22:58:37
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.form.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.form.entity.FormValidRule;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class FormValidRuleDao extends BaseMybatisDao<FormValidRule> {

	@Override
	public String getNamespace() {
		return FormValidRule.class.getName();
	}

	public FormValidRule getBySetId(String setId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("solId", setId);
		return this.getUnique("getBySetId", params);
	}
	

}

