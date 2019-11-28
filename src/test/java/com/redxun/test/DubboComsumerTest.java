package com.redxun.test;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.dubbo.demo.DemoService;

public class DubboComsumerTest extends SimpleBaseTestCase{
	@Resource
	DemoService demoService;
	
	@Test
	public void hello(){
		String rtn=demoService.sayHello("ray");
		System.out.println(rtn);
	}
}
