package com.redxun.bpm.activiti.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.entity.KeyValEnt;

/**
 * 服务任务工厂。
 * @author ray
 *
 */
public class ServiceTaskFactory {
	
	private Map<String,IServiceTask> serviceTaskMap=new HashMap<>();
	
	private List<KeyValEnt<String>> tasks=new ArrayList<>();
	
	public void setTasks(List<IServiceTask> list){
		for(IServiceTask task:list){
			serviceTaskMap.put(task.getType(), task);
			tasks.add(new KeyValEnt<String>(task.getType(), task.getTitle()));
		}
	}
	
	public List<KeyValEnt<String>> getTasks(){
		return tasks;
	}
	
	public IServiceTask getServiceTask(String type){
		return serviceTaskMap.get(type);
	}
	
	

}
