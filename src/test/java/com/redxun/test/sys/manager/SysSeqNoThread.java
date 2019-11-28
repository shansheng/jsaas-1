package com.redxun.test.sys.manager;

import java.util.List;

import com.redxun.core.util.AppBeanUtil;
import com.redxun.sys.core.manager.SysSeqIdManager;

public class SysSeqNoThread implements Runnable {
	
	private List<String> list;
	
	public SysSeqNoThread(List<String> list){
		this.list=list;
	}

	@Override
	public void run() {
		SysSeqIdManager mgr=AppBeanUtil.getBean(SysSeqIdManager.class);
		for(int i=0;i<1000;i++){
			String no=mgr.genSequenceNo("ss", "1");
			this.list.add(no);
		}
		
		 
	}

}
