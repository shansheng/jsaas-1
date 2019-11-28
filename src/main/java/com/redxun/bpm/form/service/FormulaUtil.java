package com.redxun.bpm.form.service;

import java.util.List;

import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.util.AppBeanUtil;

public class FormulaUtil {
	
	/**
	 * 判断是否在字符串数组中。
	 * @param str		a
	 * @param args		"a","b","c"
	 * @return
	 */
	public static boolean in(String str,String...  args){
		for(String s:args){
			if(str.equals(s)) return true;
		}
		return false;
	}
	
	/**
	 * 判断数据是否存在。
	 * @param tableName
	 * @param fieldName
	 * @param val
	 * @return
	 */
	public static boolean isExist(String tableName,String fieldName,Object val){
		CommonDao dao=AppBeanUtil.getBean(CommonDao.class);
		String dbType=dao.getDbType();
		String sql="";
		if("mysql".equals(dbType)){
			sql="SELECT 1 amount FROM os_user where FULLNAME_=#{fieldName} LIMIT 1 ";
		}
		else if("oracle".equals(dbType)){
			sql="SELECT 1 amount FROM "+tableName +" WHERE ROWNUM <= 1 and FULLNAME_=#{fieldName}";
		}
		SqlModel model=new SqlModel(sql);
		model.addParam("fieldName", val);
		List list=dao.query(model);
		int size=list.size();
		return size>0;
	}
	
	/**
	 * 数据是否存在。
	 * @param sql
	 * @return
	 */
	public static boolean isExistBySql(String sql){
		CommonDao dao=AppBeanUtil.getBean(CommonDao.class);
		SqlModel model=new SqlModel(sql);
		List list=dao.query(model);
		int size=list.size();
		return size>0;
	}

}
