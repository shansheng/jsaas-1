package com.redxun.test.sys.manager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.junit.Test;

import com.redxun.test.BaseTestCase;

public class SysSeqIdTest extends BaseTestCase{
	
	@Test
	public void getSeqNo() throws InterruptedException{
		List<String> list = Collections.synchronizedList(new ArrayList<String>());
		long start=System.currentTimeMillis();
		Thread t1=new Thread(new SysSeqNoThread(list));
		Thread t2=new Thread(new SysSeqNoThread(list));
		Thread t3=new Thread(new SysSeqNoThread(list));
		t1.start();
		t2.start();
		t3.start();
		t1.join();
		t2.join();
		t3.join();
		
		System.err.println(list.size());
		System.err.println(System.currentTimeMillis()-start);
		System.err.println("ok");
	}

}
