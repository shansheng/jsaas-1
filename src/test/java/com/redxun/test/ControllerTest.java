package com.redxun.test;

import java.io.IOException;
import java.util.Set;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.sys.log.LogEntScanner;

public class ControllerTest extends BaseTestCase{

	@Resource
	LogEntScanner logEntScanner;
	
	@Test
	public void loadAnnotion() throws ClassNotFoundException, IOException{
		
		Set<String> set=logEntScanner.getModule();
		System.out.println(set.size());
	}
	
}
