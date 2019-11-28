package com.redxun.bpm.core.manager.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.BoResult.ACTION_TYPE;

/**
 * 使用json结构存储JSON
 * @author RAY
 *
 */
@Service
public class JsonFormDataHandler extends AbstractFormDataHandler {
	
	
	@Resource
	BpmFormInstManager  bpmFormInstManager;

	@Override
	public JSONObject getData(String boDefId, String id) {
		BpmFormInst inst= bpmFormInstManager.get(id);
		String json=inst.getJsonData();
		return JSONObject.parseObject(json);
	}

	@Override
	public BoResult saveData(String boDefId, String instId, JSONObject json) {
		BoResult result=new BoResult();
		BpmFormInst inst=null;
		if(StringUtil.isEmpty(instId)){
			inst=new BpmFormInst();
			inst.setFormInstId(IdUtil.getId());
			inst.setJsonData(json.toJSONString());
			bpmFormInstManager.create(inst);
			
			result.setPk(inst.getFormInstId());
			result.setAction(ACTION_TYPE.ADD);
			
		}
		else{
			inst=bpmFormInstManager.get(instId);
			String oldJson="";
			try {
				oldJson=JSONUtil.copyJsons(inst.getJsonData(), json.toJSONString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			inst.setJsonData(oldJson);
			bpmFormInstManager.update(inst);
			result.setAction(ACTION_TYPE.UPDATE);
		}
		
		return result;
	}

	@Override
	public JSONObject getData(String boDefId, Map<String, Object> params) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
