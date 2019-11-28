package com.redxun.test;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.saweb.util.IdUtil;

public class CommonDaoTest extends BaseTestCase{
	@Resource
	CommonDao commonDao;
	//@Test
	public void testCallProc(){
		String sql="CALL INSERTDEMO (#{id},#{name},#{alias})";
		
		SqlModel sqlModel=new SqlModel(sql);
		sqlModel.addParam("id", IdUtil.getId());
		sqlModel.addParam("name", "红迅软件");
		sqlModel.addParam("alias", "redxun");
		
		commonDao.execute(sqlModel);
		
	}
	
	@Test
	public void testCallProcOut(){
		String sql="CALL INSERTDEMO1 (#{id},#{name},@alias)";
		
		SqlModel sqlModel=new SqlModel(sql);
		sqlModel.addParam("id", IdUtil.getId());
		sqlModel.addParam("name", "红迅软件");
		sqlModel.addParam("alias", null);
		
		commonDao.execute(sqlModel);
		String alias= (String) sqlModel.getParams().get("alias");
		System.out.println(alias);
		
		
	}
}
