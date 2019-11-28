package com.redxun.bpm.activiti.service;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.sys.core.manager.SysSeqIdManager;
import com.redxun.test.BaseTestCase;

public class ActRepServiceTest extends BaseTestCase{
	
	@Resource
	ActRepService actRepService;
	@Resource
	JdbcTemplate jdbcTemplate;
	@Resource
	SysSeqIdManager sysSeqIdManager;
	

	//@Test
	public void getNode(){
//		ActNodeDef node=actRepService.getIncomeGateWay("twolayer:1:2410000000740079", "SYNC3");
//		System.out.println(node.getNodeId());
	}
	
	
	//@Test
	public void getOutNodes(){
//		Set<ActNodeDef> nodes=actRepService.getOutNodesByGateWay("twolayer:1:2410000000740079", "SYNC1");
//		System.out.println(nodes.size());
	}

	//@Test
	public void getPreGateway(){
//		ActNodeDef actNodeDef= actRepService.getPreGateway("tongbu:1:2410000000700023","N5");
		
	}
	
//	@Test
	public void updateversion(){
		String sql="update sys_seq_id set CUR_VAL=3 WHERE SEQ_ID_='2400000001031001'";
		
		int i=jdbcTemplate.update(sql);
		System.err.println("-------------------------" +i);
	}
	
	@Test
	public void genSeqNo() throws InterruptedException{
		Set<String> set=Collections.synchronizedSet(new HashSet<String>());
		SeqNoManager manager=new SeqNoManager(set);
		Thread t1=new Thread( manager);
		Thread t2=new Thread( manager);
		Thread t3=new Thread( manager);
		long start=System.currentTimeMillis();
		t1.start();
		t2.start();
		t3.start();
		
		t1.join();
		t2.join();
		t3.join();
		System.err.println("--------------------------------------------------------");
		System.out.println(System.currentTimeMillis()-start);
		System.err.println("--------------------------------------------------------");
		
		System.out.println(set.size());
		
//		for(int i=0;i<100;i++){
//			sysSeqIdManager.genSequenceNo("BPM_INST_BILL_NO", "1");
//		}
	}
	
	
	//
	
	
	
}
