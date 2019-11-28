package com.redxun.bpm.core.manager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmIdentityLinkDao;
import com.redxun.bpm.core.entity.BpmIdentityLink;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;

@Service
public class BpmIdentityLinkManager extends BaseManager<BpmIdentityLink>{
	@Resource
	BpmIdentityLinkDao dao;
	@Override
	protected IDao getDao() {
		return dao;
	}
	
	public void deleteByTaskId(String taskId){
		dao.deleteByTaskId(taskId);
	}

}
