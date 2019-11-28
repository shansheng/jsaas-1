package com.redxun.bpm.form.manager;

import javax.annotation.Resource;

import org.junit.Test;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.test.BaseTestCase;



public class BpmFormRightManagerTest extends BaseTestCase {
	
	@Resource
	private BpmFormRightManager bpmFormRightManager;
	
	@Test
	public void getInitByBoDefId(){
		JSONObject json=bpmFormRightManager.getInitByBoDefId("2410000000200001");
		System.out.println(json.toJSONString());
	}

}
