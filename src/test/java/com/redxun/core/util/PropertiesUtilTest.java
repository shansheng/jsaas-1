package com.redxun.core.util;

import org.junit.Test;

import com.redxun.test.BaseTestCase;

public class PropertiesUtilTest extends BaseTestCase {
	
	
	
	@Test
	public  void getProperty(){
		String url=PropertiesUtil.getProperty("db.url");
		System.out.println(url);
	}

}
