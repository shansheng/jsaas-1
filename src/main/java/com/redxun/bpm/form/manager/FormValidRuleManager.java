
package com.redxun.bpm.form.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.bpm.form.dao.FormValidRuleDao;
import com.redxun.bpm.form.entity.FormValidRule;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：FORM_VALID_RULE 处理接口
 * 作者:ray
 * 日期:2018-11-27 22:58:37
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class FormValidRuleManager extends MybatisBaseManager<FormValidRule>{
	
	@Resource
	private FormValidRuleDao formValidRuleDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return formValidRuleDao;
	}
	
	
	
	public FormValidRule getFormValidRule(String uId){
		FormValidRule formValidRule = get(uId);
		return formValidRule;
	}
	

	
	
	@Override
	public void create(FormValidRule entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(FormValidRule entity) {
		super.update(entity);
	}



	public FormValidRule getBySetId(String setId) {
		return formValidRuleDao.getBySetId(setId);
	}
	
	
}
