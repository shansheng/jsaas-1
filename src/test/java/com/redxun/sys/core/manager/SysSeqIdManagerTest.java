package com.redxun.sys.core.manager;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.test.BaseTestCase;

public class SysSeqIdManagerTest extends BaseTestCase{
	@Resource
	SysSeqIdManager manager;
	
	@Test
	public void testGetById(){
		String alias="daySeq";
		String tenantId="1";
		long time=new Date().getTime();
		for(int i=0;i<100;i++){
			String id=manager.genSequenceNo(alias, tenantId);
			System.out.println("id:"+ id);
		}
		
		long time2=new Date().getTime();
		
		System.out.println("dur time is:"+ (time2-time));
	}
}
