package com.redxun.bpm.core.service;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.test.BaseTestCase;


public class BpmRuPathManagerTest extends BaseTestCase {
	
	@Resource
	private BpmRuPathManager bpmRuPathManager;
	
	@Test
	public void getBackNodes(){
		List<BpmRuPath> runPaths= bpmRuPathManager.getBackNodes("2410000009670067","N1");
		System.out.println(runPaths.size());
	}

}
