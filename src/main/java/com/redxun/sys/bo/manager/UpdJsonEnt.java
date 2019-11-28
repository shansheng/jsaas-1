package com.redxun.sys.bo.manager;

import com.alibaba.fastjson.JSONObject;

/**
 * 更新JSON
 * @author ray
 *
 */
public class UpdJsonEnt {
	
	public UpdJsonEnt(){}
	
	

	public UpdJsonEnt(String pk, JSONObject curJson, JSONObject originJson) {
		this.pk = pk;
		this.curJson = curJson;
		this.originJson = originJson;
	}



	private String pk="";
	
	private JSONObject curJson;
	
	private JSONObject originJson;

	public String getPk() {
		return pk;
	}

	public void setPk(String pk) {
		this.pk = pk;
	}

	public JSONObject getCurJson() {
		return curJson;
	}

	public void setCurJson(JSONObject curJson) {
		this.curJson = curJson;
	}

	public JSONObject getOriginJson() {
		return originJson;
	}

	public void setOriginJson(JSONObject originJson) {
		this.originJson = originJson;
	}
	
	
	
	
}
