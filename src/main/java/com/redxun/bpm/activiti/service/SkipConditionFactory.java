package com.redxun.bpm.activiti.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.entity.KeyValEnt;

/**
 * 自动条件跳过工厂类。
 * @author ray
 *
 */
public class SkipConditionFactory {

	private List<ITaskSkipCondition> conditions;
	
	private Map<String,ITaskSkipCondition> conditionMap=new HashMap<String,ITaskSkipCondition>();
	
	
	public void setSkipConditions(List<ITaskSkipCondition> list){
		this.conditions=list;
		for(ITaskSkipCondition condition:list){
			conditionMap.put(condition.getType(), condition);
		}
	}
	
	public ITaskSkipCondition getCondition(String type){
		return conditionMap.get(type);
	}
	
	/**
	 * 返回可用跳转类型。
	 * @return
	 */
	public List<KeyValEnt<String>> getTypes(){
		List<KeyValEnt<String>> list=new ArrayList<KeyValEnt<String>>();
		for(ITaskSkipCondition condition:conditions){
			KeyValEnt<String> kv=new KeyValEnt<String>(condition.getType(), condition.getName());
			list.add(kv);
		}
		return list;
	}
	
	
	
}
