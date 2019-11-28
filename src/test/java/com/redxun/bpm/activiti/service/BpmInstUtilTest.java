package com.redxun.bpm.activiti.service;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import com.redxun.test.BaseTestCase;

public class BpmInstUtilTest extends BaseTestCase {
//	
//	@Resource
//	ActInstService actInstService;
	@Resource
	JdbcTemplate jdbcTemplate;

	@Test
	public void startFlow(){
//		StartProcessModel model=new StartProcessModel();
//		model.setSolId("2410000002790010");
//		model.setUserAccount("admin@mycine.cn");
//		model.getVars().put("days", 3);
//		
//		//actInstService.startProcess(model);
//		BpmInstUtil.startFlow(model);
		String sql="select * from sys_inst";
		List list= jdbcTemplate.queryForList(sql);
		System.out.println("ok");
	}
}
