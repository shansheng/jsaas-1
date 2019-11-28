package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.test.BaseTestCase;

public class CommonDaoTest extends BaseTestCase{
	
	@Resource
	CommonDao commonDao;
	
	@Test
	public void testAdd(){
		String sql="insert into orders (ID_,NAME_,ALIAS_) values (#{id},#{name},#{alias})";
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("id", "2");
		params.put("name", "红迅采购JSAAS合同");
		params.put("alias", "redxun");
		commonDao.execute(sql, params);
	}
	
	@Test
	public void testQuery() {
		String sql="select * from orders where id_=#{id}";
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("id", "2");
		List list= commonDao.query(sql, params);
		System.out.println(list);
		
	}
	

}
