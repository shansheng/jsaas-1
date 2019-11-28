package com.redxun.dubbo.demo.impl;

import com.redxun.dubbo.demo.DemoService;

public class DemoServiceImpl implements DemoService {

	@Override
	public String sayHello(String name) {
		
		return "hello:" + name;
	}

}
