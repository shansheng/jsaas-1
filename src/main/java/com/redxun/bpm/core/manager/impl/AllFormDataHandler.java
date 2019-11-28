package com.redxun.bpm.core.manager.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.BoResult.ACTION_TYPE;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDataHandler;
import com.redxun.sys.bo.manager.SysBoEntManager;

/**
 * 同时使用json和数据库表存储数据。
 * @author ray
 *
 */
@Service
public class AllFormDataHandler extends AbstractFormDataHandler {
	
	@Resource
	BpmFormInstManager  bpmFormInstManager;
	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	SysBoDataHandler sysBoDataHandler;

	@Override
	public JSONObject getData(String boDefId, String id) {
		BpmFormInst inst= bpmFormInstManager.get(id);
		String json=inst.getJsonData();
		return JSONObject.parseObject(json);
	}

	@Override
	public BoResult  saveData(String boDefId, String instId, JSONObject jsonObj) {
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId);
		BoResult boResult =sysBoDataHandler.handleData(ent, jsonObj);
		String pk=boResult.getPk();
		JSONObject rtnJson= sysBoDataHandler.getDataByPk(pk, ent) ;
		boolean isAdd=ACTION_TYPE.ADD.equals(boResult.getAction());
		saveJson(pk,isAdd, rtnJson.toJSONString());
		
		return boResult;
	}
	
	protected String saveJson(String instId,boolean isAdd, String json){
		BpmFormInst inst=null;
		if(isAdd){
			inst=new BpmFormInst();
			inst.setFormInstId(instId);
			inst.setJsonData(json);
			bpmFormInstManager.create(inst);
		}
		else{
			inst=bpmFormInstManager.get(instId);
			String oldJson="";
			try {
				oldJson=JSONUtil.copyJsons(inst.getJsonData(), json);
			} catch (Exception e) {
				e.printStackTrace();
			}
			inst.setJsonData(oldJson);
			bpmFormInstManager.update(inst);
		}
		return instId;
	}

	@Override
	public JSONObject getData(String boDefId, Map<String, Object> params) {
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId);
		
		return null;
	}

}
