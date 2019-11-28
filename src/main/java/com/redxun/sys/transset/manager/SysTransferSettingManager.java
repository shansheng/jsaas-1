
package com.redxun.sys.transset.manager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.sys.translog.dao.SysTransferLogDao;
import com.redxun.sys.translog.entity.SysTransferLog;
import com.redxun.sys.transset.dao.SysTransferSettingDao;
import com.redxun.sys.transset.entity.SysTransferSetting;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * <pre> 
 * 描述：权限转移设置表 处理接口
 * 作者:mansan
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysTransferSettingManager extends MybatisBaseManager<SysTransferSetting>{
	
	@Resource
	private SysTransferSettingDao sysTransferSettingDao;
	@Resource
	private SysTransferLogDao sysTransferLogDao;
	@Resource
	private JdbcTemplate jdbcTemplate;
	@Resource
	private OsUserManager osUserManager;
	@Resource
	GroovyEngine groovyEngine;
	
	public static String IDS = "{ids}";
	public static String NAMES = "{names}";
	public static String TARGET_PERSONID = "{targetPersonId}";
	public static String TARGET_PERSONNAME = "{targetPersonName}";
	public static String AUTHOR_ID = "{authorId}";
	public static String AUTHOR_NAME = "{authorName}";
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysTransferSettingDao;
	}
	
	
	
	public SysTransferSetting getSysTransferSetting(String uId){
		SysTransferSetting sysTransferSetting = get(uId);
		return sysTransferSetting;
	}
	

	
	
	@Override
	public void create(SysTransferSetting entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(SysTransferSetting entity) {
		super.update(entity);
	}



	public List<KeyValEnt> getHandlers() {
		List<KeyValEnt> list=new ArrayList<KeyValEnt>();
		list.add(new KeyValEnt(AUTHOR_ID,"授权人ID"));
		list.add(new KeyValEnt(AUTHOR_NAME,"授权人名称"));
		list.add(new KeyValEnt(TARGET_PERSONID,"目的人ID"));
		list.add(new KeyValEnt(TARGET_PERSONNAME,"目的人名称"));
		list.add(new KeyValEnt(IDS,"所选ID列表，‘，’分割"));
		list.add(new KeyValEnt(NAMES,"所选NAME列表，‘，’分割"));
		return list;
	}



	public List<Map<String,Object>> excuteSelectSql(SysTransferSetting sysTransDef, String authorId) {
		Map<String, Object> map = new HashMap<String, Object>();
		String sql=(String)groovyEngine.executeScripts(sysTransDef
				.getSelectSql().replace(AUTHOR_ID, authorId), map);   //获取SQL
		if (StringUtil.isEmpty(sql)) {
			return new ArrayList<Map<String,Object>>();
		}
		List<Map<String,Object>> l = jdbcTemplate.queryForList(sql);
		return l;
	}

	public void excuteUpdateSql(SysTransferSetting sysTransDef, OsUser author, OsUser targetPerson, String selectedItem) {
		JSONArray selectedItemJa = JSONArray.fromObject(selectedItem);
		StringBuffer ids = new StringBuffer();
		StringBuffer names = new StringBuffer();
		for (int i = 0; i < selectedItemJa.size(); i++) {
			if (ids.length() != 0) {
				ids.append(",");
				names.append(",");
			}
			JSONObject jo = selectedItemJa.getJSONObject(i);
			ids.append(jo.getString("id"));
			names.append(jo.getString("name"));
		}

		// 替代sql
		String updateSql = sysTransDef
				.getUpdateSql()
				.replace(AUTHOR_ID, author.getUserId().toString())
				.replace(TARGET_PERSONID,
						targetPerson.getUserId().toString())
				.replace(IDS, ids.toString())
				.replace(NAMES, names.toString())
				.replace(AUTHOR_NAME, author.getFullname())
				.replace(TARGET_PERSONNAME, targetPerson.getFullname())
				.replace(AUTHOR_ID, author.getUserId().toString())
				.replace(TARGET_PERSONID,
						targetPerson.getUserId().toString())
				.replace(IDS, ids.toString())
				.replace(AUTHOR_NAME, author.getFullname())
				.replace(TARGET_PERSONNAME, targetPerson.getFullname());

		String sql=(String)groovyEngine.executeScripts(updateSql, new HashMap<String, Object>());   //获取SQL
		if (StringUtil.isNotEmpty(sql)) {
			jdbcTemplate.execute(sql);
			String authorId = author.getUserId();
			String targetPersonId = targetPerson.getUserId();
			String content = getLogContent(sysTransDef, authorId, targetPersonId, selectedItem);
			SysTransferLog entity = new SysTransferLog();
			entity.setId(IdUtil.getId());
			entity.setAuthorPerson(authorId);
			entity.setOpDescp(content);
			entity.setTargetPerson(targetPersonId);
 			sysTransferLogDao.create(entity);
		}
	}



	public String getLogContent(SysTransferSetting sysTransDef, String authorId,
			String targetPersonId, String selectedItem) {
		// 开始写日志
		String content = sysTransDef.getLogTemplet();
		OsUser author = osUserManager.get(authorId);
		OsUser target = osUserManager.get(targetPersonId);

		JSONArray selectedItemJa = JSONArray.fromObject(selectedItem);
		StringBuffer names = new StringBuffer();
		for (int i = 0; i < selectedItemJa.size(); i++) {
			if (names.length() != 0) {
				names.append(",");
			}
			JSONObject jo = selectedItemJa.getJSONObject(i);
			names.append(jo.getString("name"));
		}

		content = content
				.replace(NAMES, names.toString())
				.replace(AUTHOR_NAME, author.getFullname())
				.replace(TARGET_PERSONNAME,
						target.getFullname());

		return content;
	}



	public List<SysTransferSetting> getInvailAll() {
		return sysTransferSettingDao.getInvailAll();
	}

}