package com.redxun.oa.info.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.oa.info.dao.OaRemindDefDao;
import com.redxun.oa.info.dao.OaRemindDefQueryDao;
import com.redxun.oa.info.entity.OaRemindDef;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.util.SysUtil;

/**
 * 
 * <pre>
 * 描述：消息提醒 处理接口
 * 作者:mansan
 * 日期:2018-04-28 16:03:20
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OaRemindDefManager extends ExtBaseManager<OaRemindDef> {
	@Resource
	private OaRemindDefDao oaRemindDefDao;
	
	@Resource
	private OaRemindDefQueryDao oaRemindDefQueryDao;
	@Resource
	private GroovyEngine groovyEngine;
	
	@Resource
	private CommonDao commonDao;
	

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return oaRemindDefDao;
	}

	@Override
	public BaseMybatisDao getMyBatisDao() {
		return oaRemindDefQueryDao;
	}

	public OaRemindDef getOaRemindDef(String uId) {
		OaRemindDef oaRemindDef = get(uId);
		return oaRemindDef;
	}

	@Override
	public void create(OaRemindDef entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);

	}

	@Override
	public void update(OaRemindDef entity) {
		super.update(entity);

	}

	/** 根据权限查询对应的消息 */
	public List<OaRemindDef> getMyRemindDef() {
        Map<String,Object> params=new HashMap<String,Object>();
		Map profileMap = ProfileUtil.getCurrentProfile();
		params.put("profileMap", profileMap);
		params.put("teantId", ContextUtil.getCurrentTenantId());
		List remindList  = oaRemindDefQueryDao.getReminds(params);
		return remindList;
	}
	
	public Long getRemindCountByType(OaRemindDef remind) throws IllegalAccessException, NoSuchFieldException {
		DbContextHolder.setDataSource(remind.getDsalias());
    	String type=remind.getType();
    	if("groovySql".equals(type)){	    	
    		String sql=SysUtil.replaceConstant(remind.getSetting()==null?"":remind.getSetting());
			sql=(String)groovyEngine.executeScripts(sql, new HashMap<String, Object>());
			if(sql==null) return new Long(0);
			SqlModel model=new SqlModel(sql);//获取SQL
			Object o=commonDao.queryOne(model);
			Long i  =o==null?0:(Long)o;
			return i;
    	}else  if("func".equals(type)){
    		Integer  count =  (Integer)groovyEngine.executeScripts(remind.getSetting(),new HashMap<String, Object>());
    		//Integer integer= new Integer(5);
    		Long i = count==null?0:count.longValue();
    		return i;
    	}else if("sql".equals(type)){
			String sql=SysUtil.parseScript(remind.getSetting(),new HashMap<String, Object>());
			SqlModel model=new SqlModel(sql);//获取SQL
			Long i  =(Long)commonDao.queryOne(model);
			return i;
    	}
    	
    	DbContextHolder.clearDataSource();
    	return 0L;
    }

}
