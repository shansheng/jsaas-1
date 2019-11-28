package com.redxun.sys.bo.manager;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;

/**
 * 数据包。
 * @author ray
 *
 */
public class DataHolder {
	
	public final static String ACTION_NEW="new";
	
	public final static String ACTION_UPD="upd";
	
	public  final static String ACTION_DEL="del";
	
	
	/**
	 * 动作
	 * new,upd,del
	 */
	private String action="";
	/**
	 * 新的主表数据。
	 */
	private JSONObject originMain=new JSONObject();
	
	private JSONObject curMain=new JSONObject();
	
	/**
	 * 当主表插入时，记录主表数据的新主键。
	 */
	private String newPk="";
	
	

	/**
	 * 子表数据管理。
	 */
	private Map<String,SubDataHolder> subDataMap=new HashMap<String,SubDataHolder>();

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public JSONObject getOriginMain() {
		return originMain;
	}

	public void setOriginMain(JSONObject originMain) {
		this.originMain = originMain;
	}

	public JSONObject getCurMain() {
		return curMain;
	}

	public void setCurMain(JSONObject curMain) {
		this.curMain = curMain;
	}
	

	public Map<String, SubDataHolder> getSubDataMap() {
		return subDataMap;
	}

	public void setSubDataMap(Map<String, SubDataHolder> subDataMap) {
		this.subDataMap = subDataMap;
	}
	
	/**
	 * 添加子表数据。
	 * @param tableName
	 * @param subDataHolder
	 */
	public void addSubData(String tableName,SubDataHolder subDataHolder){
		subDataMap.put(tableName, subDataHolder);
	}
	
	/**
	 * 获取子表数据。
	 * @param tableName
	 * @return
	 */
	public SubDataHolder getSubData(String tableName){
		return subDataMap.get(tableName);
	}

	public String getNewPk() {
		return newPk;
	}

	public void setNewPk(String newPk) {
		this.newPk = newPk;
	}
	
	

}
