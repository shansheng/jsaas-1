package com.redxun.job;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.quartz.JobExecutionContext;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.scheduler.BaseJob;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.HttpClientUtil.HttpRtnModel;
import com.redxun.core.util.PropertiesUtil;

/*
 *  同步数据
 */
public class OsSyncJob  extends BaseJob {
	
	@Resource
	CommonDao commonDao=AppBeanUtil.getBean(CommonDao.class);
	
	@Override
	public void executeJob(JobExecutionContext context) {
		
		//获取上次更新时间
		String sql = "SELECT MAX(lastupdatetime) lastupdatetime FROM os_sync ";
		ArrayList<Map<String, Date>> content = (ArrayList<Map<String, Date>>) commonDao.query(sql);
		Long timeLong;
		if (content.get(0)==null) {
			timeLong = 0L;
		} else {
			Date time = content.get(0).get("lastupdatetime");
			timeLong = time.getTime();
		}

		
		checkUpdate(timeLong);
		
		
	}
	
	public void checkUpdate(long startTime) {
		String url = PropertiesUtil.getProperty("xinDaUrl") + "addressBookZzdsControl/getAddressBookCheck.do?startTime="
				+ startTime;
		try {
			HttpRtnModel model = HttpClientUtil.getFromUrlHreader(url, null);
			String content = model.getContent();
			JSONObject json = JSONObject.parseObject(content);
			JSONObject result = json.getJSONObject("result");
			JSONObject list = json.getJSONArray("list").getJSONObject(0);
			Date date = new Date(json.getLong("time"));
			String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
			
			String sql = "INSERT INTO os_sync (lastupdatetime) VALUES (\""+dateString+"\")";
			commonDao.execute(sql);
			if (result.getString("flag").equals("0")) {
				if (list.getIntValue("personCount") > 0) {
					updatePerson(startTime, list.getString("personCount"));
				}
				if (list.getIntValue("depCount") > 0) {
					updateDep(startTime, list.getString("depCount"));
				}
				
				
			} else {
				System.out.println(result.getShort("flag"));
				System.out.println(result.getString("message"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 同步用户信息 、用户与用户组关系表 和sys_account表方法
	private void updatePerson(long startTime, String personCount) {
		String url =PropertiesUtil.getProperty("xinDaUrl") + "addressBookZzdsControl/getPersoninfosyn.do?" + "startTime="
				+ startTime + "&pageNo=1" + "&pageSize=" + personCount;

		try {
			HttpRtnModel model = HttpClientUtil.getFromUrlHreader(url, null);
			String content = model.getContent();
			JSONObject json = JSONObject.parseObject(content);
			Date createTime = new Date(json.getLong("time"));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("create_time_", sdf.format(createTime));
			List<JSONObject> personList = JSONObject.parseArray(json.getString("list"), JSONObject.class);

			Iterator<JSONObject> iterator = personList.iterator();
			// 初次同步所有
			if (startTime == 0) {
				while (iterator.hasNext()) {
					JSONObject person = iterator.next();
					insertUser(person, params, sdf);
					insertRelInst(person, params, sdf);
					insertSysAccout(person, params, sdf);
				}
			} else {
				String sql = "select user_id_ from os_user";
				ArrayList<String> list = new ArrayList<String>();
				ArrayList<Map<String, String>> idList = (ArrayList<Map<String, String>>) commonDao.query(sql);
				for (Map<String, String> map : idList) {
					list.add(map.get("user_id_"));
				}
				System.out.println("更新数据：" + personList.size() + "条");
				System.out.println(idList);
				
				
				
				while (iterator.hasNext()) {
					JSONObject person = iterator.next();
					if (!list.contains(person.getString("id"))) {
						insertUser(person, params, sdf);
						insertRelInst(person, params, sdf);
						insertSysAccout(person, params, sdf);

					} else {
						updateUser(person, params, sdf);
						updateRelInst(person, params, sdf);
						updateSysAccout(person, params, sdf);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("更新用户成功");
	}

	// 同步用户组方法
	public void updateDep(long startTime, String depCount) {

		String url =PropertiesUtil.getProperty("xinDaUrl") + "addressBookZzdsControl/getDepartmentinfosyn.do?startTime="
				+ startTime + "&pageNo=1" + "&pageSize=" + depCount;
		
		try {
			HttpRtnModel model = HttpClientUtil.getFromUrlHreader(url, null);
			String content = model.getContent();
			JSONObject json = JSONObject.parseObject(content);
			Date createTime = new Date(Long.parseLong(json.getString("time")));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("create_time_", sdf.format(createTime));
			List<JSONObject> groupList = JSONObject.parseArray(json.getString("list"), JSONObject.class);
			Iterator<JSONObject> iterator = groupList.iterator();
			if (startTime == 0) {
				while (iterator.hasNext()) {
					JSONObject group = iterator.next();
					insertGroup(group, params, sdf);
				}

			} else {
				String sql = "select group_id_ from os_group";
				ArrayList<String> list = new ArrayList<String>();
				ArrayList<Map<String, String>> idList = (ArrayList<Map<String, String>>) commonDao.query(sql);
				for (Map<String, String> map : idList) {
					list.add(map.get("group_id_"));
				}

				while (iterator.hasNext()) {
					JSONObject group = iterator.next();
					if (!list.contains(group.getString("id"))) {
						insertGroup(group, params, sdf);
					} else {
						updateGroup(group, params, sdf);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("更新用户组成功");

	}

	// 更新修改后sys_account数据
	private void updateSysAccout(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {

		if (person.getString("deleteFlag").equals("1")) {
			String deleteSql = "delete * from sys_account where account_id_=#{account_id_}";
			params.put("account_id_", person.getString("id"));
			commonDao.execute(deleteSql, params);
		} else {
			String updateSql = "update sys_account set fullname_=#{fullname_} , update_time_=#{update_time_} "
					+ ", create_time_=#{create_time_} where account_id_=#{account_id_}";

			params.put("account_id_", person.getString("id"));
			params.put("fullname_", person.getString("name"));
			params.put("update_time_", sdf.format(new Date(Long.parseLong(person.getString("n_last_update_time")))));
			commonDao.execute(updateSql, params);
		}

	}

	// 插入sys_account数据
	private void insertSysAccout(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {
		if (!person.getString("deleteFlag").equals("1")) {
			String insertSql = "INSERT INTO sys_account (ACCOUNT_ID_,NAME_,PWD_,ENC_TYPE_,FULLNAME_,USER_ID_,REMARK_,STATUS_,DOMAIN_,CREAT_ORG_ID_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_) VALUES (#{account_id_},#{name_},#{pwd_},#{enc_type_},#{fullname_},#{user_id_},#{remark_},"
					+ "#{status_},#{domain_},#{create_org_id_},#{tenant_id_},#{create_by_},#{create_time_},#{update_by_},#{update_time_})";

			params.put("account_id_", person.getString("id"));
			params.put("name_", person.getString("code") );
			params.put("pwd_", "1234");
			params.put("enc_type_", "NONE");
			params.put("fullname_", person.getString("name"));

			// todo
			params.put("user_id_", person.getString("id"));
			params.put("status_", "ENABLED");
			params.put("domain_", "rexun.cn");
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("update_time_", sdf.format(new Date(person.getLong("n_last_update_time"))));
			commonDao.execute(insertSql, params);
		}

	}

	// 更新修改后用户组与用户关系数据
	private void updateRelInst(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {

		if (person.getString("deleteFlag").equals("1")) {
			String deleteSql = "delete * from os_rel_inst where inst_id_ = #{inst_id_}";
			params.put("inst_id_", person.getString("id"));
			commonDao.execute(deleteSql, params);
		} else {
			String updateSql = "update os_rel_inst set party1_= #{party1_} ,party2_= #{party2_} , update_time_= #{update_time_} where inst_id_ = #{inst_id_}";

			params.put("inst_id_", person.getString("id"));
			params.put("party1_", person.getString("depId"));
			params.put("party2_", person.getString("id"));
			params.put("update_time_", sdf.format(new Date(Long.parseLong(person.getString("n_last_update_time")))));
			commonDao.execute(updateSql, params);
		}

	}

	// 插入用户组与用户关系数据
	private void insertRelInst(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {
		if (!person.getString("deleteFlag").equals("1")) {
			String insertSql = "INSERT INTO os_rel_inst (INST_ID_,REL_TYPE_ID_,REL_TYPE_KEY_,PARTY1_,PARTY2_,DIM1_,DIM2_,IS_MAIN_,STATUS_,ALIAS_,REL_TYPE_,PATH_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_,TENANT_ID_) VALUES (#{inst_id_},#{rel_type_id_},#{rel_type_key_},#{party1_},#{party2_},#{dim1_},#{dim2_},#{is_main_},"
					+ "#{status_},#{alias_},#{rel_type_},#{path_},#{create_by_},#{create_time_},#{update_by_},#{update_time_},#{tenant_id_})";

			params.put("inst_id_", person.getString("id"));
			params.put("rel_type_id_", "1");
			params.put("rel_type_key_", "GROUP-USER-BELONG");
			params.put("party1_", person.getString("depId"));
			params.put("party2_", person.getString("id"));
			params.put("dim1_", "1");
			params.put("is_main_", "YES");
			params.put("status_", "ENABLED");
			params.put("rel_type_", "GROUP-USER");
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("update_time_", sdf.format(new Date(person.getLong("n_last_update_time"))));
			commonDao.execute(insertSql, params);
		}

	}

	// 更新修改后的用户数据信息
	private void updateUser(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {

		if (person.getString("deleteFlag").equals("1")) {
			String deleteSql = "delete from os_user where user_id_ =#{user_id_}";
			params.put("user_id_", person.getString("id"));
			commonDao.execute(deleteSql, params);
		} else {
			String updateSql = "update os_user set  fullname_=#{fullname_} , user_no_=#{user_no_} ,"
					+ " user_type_=#{user_type_} , status_=#{status_} , from_=#{from_} , sex_=#{sex_} ,"
					+ "mobile_=#{mobile_} , sync_wx_=#{sync_wx_} , photo_=#{pohto_} , tenant_id_=#{tenant_id_} ,"
					+ "create_by_=#{create_by_} , update_by_=#{update_by_} , update_time_=#{update_time_} ,"
					+ "create_time_=#{create_time_} where user_id_=#{user_id_} ";

			params.put("user_id_", person.getString("id"));
			params.put("fullname_", person.getString("name"));
			params.put("user_no_", person.getString("code") );
			params.put("user_type_", person.getString("position"));
			params.put("status_", "IN_JOB");
			params.put("from_", "import");
			params.put("sex_", person.getString("sex"));
			params.put("mobile_", person.getString("mobile"));
			params.put("sync_wx_", 0);
			params.put("pohto_", person.getString("imgSummary"));
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("update_time_", sdf.format(new Date(Long.parseLong(person.getString("n_last_update_time")))));
			commonDao.execute(updateSql, params);
		}

	}

	// 插入新增用户数据的方法
	private void insertUser(JSONObject person, Map<String, Object> params, SimpleDateFormat sdf) {

		if (!person.getString("deleteFlag").equals("1")) {
			String insertSql = "INSERT INTO os_user (USER_ID_,FULLNAME_,USER_NO_,ENTRY_TIME_,QUIT_TIME_,USER_TYPE_,STATUS_,FROM_,BIRTHDAY_,SEX_,MOBILE_,EMAIL_,ADDRESS_,URGENT_,SYNC_WX_,URGENT_MOBILE_,QQ_,PHOTO_,CREATE_BY_,CREATE_TIME_,TENANT_ID_,UPDATE_BY_,UPDATE_TIME_) VALUES (#{user_id_},#{fullname_},#{user_no_},#{entry_type_},#{quit_type_},#{user_type_},#{status_},#{from_},"
					+ "#{birthday_},#{sex_},#{mobile_},#{email_},#{address},#{urgent_},#{sync_wx_},#{urgent_mobile_},#{qq_},#{pohto_},"
					+ "#{create_by_},#{create_time_},#{tenant_id_},#{update_by_},#{update_time_})";
			String sex = null;
			if (person.getString("sex") != null) {
				sex = person.getString("sex").equals("1") ? "male" : "female";
			}
			params.put("user_id_", person.getString("id"));
			params.put("fullname_", person.getString("name"));
			params.put("user_no_", person.getString("code") );
			params.put("user_type_", person.getString("position"));
			params.put("status_", "IN_JOB");
			params.put("from_", "import");
			params.put("sex_", sex);
			params.put("mobile_", person.getString("mobile"));
			params.put("sync_wx_", 0);
			// params.put("pohto_", person.getString("imgSummary"));
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("update_time_", sdf.format(new Date(person.getLong("n_last_update_time"))));
			commonDao.execute(insertSql, params);
		}

	}

	// 插入新增的用户组数据方法
	public void insertGroup(JSONObject group, Map<String, Object> params, SimpleDateFormat sdf) {

		if (!group.getString("deleteFlag").equals("1")) {
			String insertSql = "INSERT INTO os_group (GROUP_ID_,DIM_ID_,NAME_,KEY_,RANK_LEVEL_,STATUS_,DESCP_,SN_,PARENT_ID_,DEPTH_,PATH_,CHILDS_,AREA_CODE_,FORM_,SYNC_WX_,WX_PARENT_PID_,WX_PID_,"
					+ "IS_DEFAULT_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_) VALUES (#{group_id_},#{dim_id_},#{name_},#{key_},#{rank_level_},#{status_},#{descp_},#{sn_},#{parent_id_},"
					+ "#{depth_},#{path_},#{childs_},#{area_code_},#{from_},#{sync_wx_},#{wx_parent_pid_},#{wx_pid_},#{is_default_},#{tenant_id_},"
					+ "#{create_by_},#{create_time_},#{update_by_},#{update_time_})";

			// String path = "0."+getPath(groupList, group).reverse().toString()+".";
			params.put("group_id_", group.getString("id"));
			params.put("dim_id_", "1");
			params.put("name_", group.getString("name"));
			params.put("key_", group.getString("code"));
			params.put("rank_level_", 1);
			params.put("status_", "ENABLED");
			params.put("descp_", group.getString("dep_abb"));
			params.put("depth_", 1);
			// params.put("path_", path);
			params.put("childs_", 0);
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("parent_id_", group.getString("parent_id"));
			params.put("sn_", Integer.parseInt(group.getString("seq")));
			params.put("update_time_", sdf.format(new Date(Long.parseLong(group.getString("n_last_update_time")))));
			commonDao.execute(insertSql, params);

		}

	}

	// 更新修改后用户组方法
	public void updateGroup(JSONObject group, Map<String, Object> params, SimpleDateFormat sdf) {
		// 删除用户组
		if (group.getString("deleteFlag").equals("1")) {
			String deleteSql = "delete from os_group where group_id_ =\"" + group.getString("id") + "\"";
			commonDao.execute(deleteSql, params);
		} else {
			String udateSql = "update  os_group set  dim_id_=#{dim_id_}, name_=#{name_}, key_=#{key_}, "
					+ "rank_level_=#{rank_level_}, status_=#{status_}, descp_=#{descp_}, path_=#{path_}, childs_=#{childs_}, "
					+ "tenant_id_=#{tenant_id_}, create_by_=#{create_by_}, update_by_=#{update_by_}, sn_=#{sn_}, "
					+ "update_time_=#{update_time_} where group_id_ =#{group_id_}";

			params.put("dim_id_", "1");
			params.put("name_", group.getString("name"));
			params.put("key_", group.getString("code"));
			params.put("rank_level_", 1);
			params.put("status_", "ENABLED");
			params.put("descp_", group.getString("dep_abb"));
			params.put("depth_", 1);
			// params.put("path_", path);
			params.put("childs_", 0);
			params.put("tenant_id_", "1");
			params.put("create_by_", "1");
			params.put("update_by_", "1");
			params.put("parent_id_", group.getString("parent_id"));
			params.put("sn_", Integer.parseInt(group.getString("seq")));
			params.put("update_time_", sdf.format(new Date(Long.parseLong(group.getString("n_last_update_time")))));
			params.put("group_id_", group.getString("id"));
			commonDao.execute(udateSql, params);
		}

	}

	// 获取用户组的路径path 对应os_group的PATH_字段
	public StringBuffer getPath(List<JSONObject> groupList, JSONObject group) {
		StringBuffer path = new StringBuffer(group.getString("id"));
		for (JSONObject jsonObject : groupList) {
			String id = jsonObject.getString("id");
			if (group.getString("parent_id") == null) {
				return path;
			}
			if (group.getString("parent_id").equals(id)) {
				StringBuffer father = getPath(groupList, jsonObject);
				path.append(".");
				path.append(father);
			}
		}
		return path;
	}

	
	
	

}
