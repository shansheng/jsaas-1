package com.redxun.bpm.bm.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.PathResult;
import com.redxun.test.BaseTestCase;

public class BpmRuPathManagerTest extends BaseTestCase{

	@Resource
	BpmRuPathManager bpmRuPathManager; 
	@Test
	public void getBackNode(){
		PathResult result= bpmRuPathManager.getBackNode("2410000009670067", "N5");
		System.err.println("ok");
	}
}
