package com.redxun.bpm.core.manager.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDataHandler;
import com.redxun.sys.bo.manager.SysBoEntManager;

/**
 * 使用数据库的方式存储JSON。
 * @author ray
 *
 */
@Service
public class DbFormDataHandler extends AbstractFormDataHandler {
	
	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	SysBoDataHandler sysBoDataHandler;

	@Override
	public JSONObject getData(String boDefId, String id) {
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId);
		JSONObject json=null;
		if(StringUtil.isEmpty(id)){
			json= getInitData(boDefId) ;
		}
		else{
			json= sysBoDataHandler.getDataByPk(id, ent) ;	
		}
		
		return json;
	}

	@Override
	public BoResult saveData(String boDefId, String instId, JSONObject jsonObj) {
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId);
		BoResult result= sysBoDataHandler.handleData(ent, jsonObj);
		return result;
	}

	@Override
	public JSONObject getData(String boDefId, Map<String, Object> params) {
		SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
		JSONObject json= sysBoDataHandler.getDataByParams(params, boEnt);
		return json;
	}

}
