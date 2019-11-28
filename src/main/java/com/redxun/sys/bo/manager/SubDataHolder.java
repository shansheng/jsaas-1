package com.redxun.sys.bo.manager;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 子表数据
 * @author ray
 *
 */
public class SubDataHolder {
	
	String tableName="";
	
	private boolean isOneToMany=false;
	
	
	/**
	 * 新增的数据
	 */
	private List<JSONObject> addList =new ArrayList<JSONObject>();
	

	
	/**
	 * 更新当前的数据
	 */
	private List<UpdJsonEnt> updList =new ArrayList<UpdJsonEnt>();
	
	/**
	 * 删除列表。
	 */
	private List<JSONObject> delList= new ArrayList<JSONObject>();


	public String getTableName() {
		return tableName;
	}


	public void setTableName(String tableName) {
		this.tableName = tableName;
	}


	public List<JSONObject> getAddList() {
		return addList;
	}


	public void setAddList(List<JSONObject> addList) {
		this.addList = addList;
	}

	

	

	public List<UpdJsonEnt> getUpdList() {
		return updList;
	}


	public void setUpdList(List<UpdJsonEnt> updList) {
		this.updList = updList;
	}


	public List<JSONObject> getDelList() {
		return delList;
	}


	public void setDelList(List<JSONObject> delList) {
		this.delList = delList;
	}
	
	public void addAddList(JSONObject obj){
		addList.add(obj);
	}
	
	
	
	public void addDelList(JSONObject obj){
		delList.add(obj);
	}
	
	public void addDelJsonAry(JSONArray ary){
		for(Object obj:ary){
			delList.add((JSONObject) obj);
		}
	}

	public void addUpdJsonEnt(UpdJsonEnt ent){
		updList.add(ent);
	}

	public boolean isOneToMany() {
		return isOneToMany;
	}


	public void setOneToMany(boolean isOneToMany) {
		this.isOneToMany = isOneToMany;
	}
	

}
