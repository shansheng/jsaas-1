package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.microsvc.util.Util;

/**
 * 分页查询对象。
 * <pre>
 * 	{userAccount:'abc@redxun.cn',
 *		//params:{pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}}
 *	userAccount:用户帐号
 *	pageIndex:页码从1开始
 *	pageSize:页大小
 *	sortField:排序字段
 *	sortOrder:排序
 *	paramMap:查询参数		 
 * </pre>
 * @author ray
 *
 */
public class PageParamsModel implements Serializable{
	
	//{userAccount:'abc@redxun.cn',
		//params:{pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}}
	private String userAccount="";
	
	private int pageIndex=1;
	
	private int pageSize=20;
	
	private String sortField="";
	
	private String sortOrder="desc";
	
	private Map<String,String> paramMap=new HashMap<String, String>();

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Map<String, String> getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map<String, String> paramMap) {
		this.paramMap = paramMap;
	}
	
	public void addParam(String name,String value){
		this.paramMap.put(name, value);
	}

	@Override
	public String toString() {
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("userAccount", this.userAccount);
		
		
		JSONObject paramsObj=new JSONObject();
		
		paramsObj.put("pageIndex", this.pageIndex);
		paramsObj.put("pageSize", this.pageSize);
		
		if(Util.isNotEmpty(sortField)){
			paramsObj.put("sortField", this.sortField);
			paramsObj.put("sortOrder", this.sortOrder);
		}
		
		if(Util.isObjNotEmpty(this.paramMap)){
			Iterator<Map.Entry<String, String>> it = paramMap.entrySet().iterator();
			while(it.hasNext()){
				Map.Entry<String, String> ent=it.next();
				paramsObj.put(ent.getKey(), ent.getValue());
			}
		}
		
		jsonObj.put("params",paramsObj);
		
		return jsonObj.toJSONString();
		
	}
	
	
	
	
	

}
