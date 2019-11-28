package com.redxun.bpm.activiti.service;

import java.util.Set;

import com.redxun.core.util.AppBeanUtil;
import com.redxun.sys.core.manager.SysSeqIdManager;

public class SeqNoManager implements Runnable {
	
	private Set<String> set;

	public SeqNoManager() {
	
	}
	
	public SeqNoManager(Set<String> set) {
		this.set=set;
	}
	
	
	@Override
	public void run() {
		SysSeqIdManager manager=AppBeanUtil.getBean(SysSeqIdManager.class);
		for(int i=0;i<1000;i++){
			String no=manager.genSequenceNo("BPM_INST_BILL_NO", "1");
			this.set.add(no);
		}
		

	}

}
