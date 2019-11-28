package com.redxun.bpm.core.manager.impl;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;

public abstract class AbstractFormDataHandler  implements IFormDataHandler {
	
	@Resource
	SysBoEntManager sysBoEntManager;
	
	
	

	@Override
	public JSONObject getInitData(String boDefId) {
		if(StringUtils.isEmpty(boDefId)) return null;
		
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId);
		if(ent==null) return null;
		
		return sysBoEntManager.getInitData(ent);
		
	}
		
}
