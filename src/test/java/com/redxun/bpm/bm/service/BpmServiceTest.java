package com.redxun.bpm.bm.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.junit.Test;

import com.redxun.bpm.activiti.service.ActInstService;
import com.redxun.bpm.activiti.service.StartProcessModel;
import com.redxun.bpm.activiti.util.BpmInstUtil;
import com.redxun.bpm.core.entity.config.DestNodeUsers;
import com.redxun.bpm.core.entity.config.TaskNodeUser;
import com.redxun.test.BaseTestCase;

public class BpmServiceTest extends BaseTestCase{
	@Resource
	RepositoryService repositoryService;
	@Resource
	TaskService taskService;
	
	@Resource
	ActInstService actInstService;  
	
//	@Test
	public void getByActivites(){
		String actDefId="reqHoliday:1:20000001007012";
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity) repositoryService.getProcessDefinition(actDefId);
		List<ActivityImpl> acts= entity.getProcessDefinition().getActivities();
		for(ActivityImpl imp:acts){
			
			String id=imp.getId();
		
			Map<String,Object> properties=imp.getProperties();
			Iterator<String> keyIt=properties.keySet().iterator();
			System.out.println("nodeId:"+id+"===============");
			
			while(keyIt.hasNext()){
				String key=keyIt.next();
				Object val=properties.get(key);
				if(val!=null){
					System.out.println("key:"+key+" val:"+String.valueOf(val));
				}
			}
			
			String type=(String)properties.get("type");
			String name=(String)properties.get("name");
			DestNodeUsers nodeUsers=new DestNodeUsers();
			
			if("userTask".equals(type)){
				nodeUsers.setNodeId(id);
				nodeUsers.setNodeText(name);
				TaskNodeUser taskNodeUser=new TaskNodeUser();
						
			}
		}
		
	}
	
	
	
	@Test
	public void startFlowTest(){
		StartProcessModel model=new StartProcessModel();
		model.setFrom("BO");
		model.setSolId("2410000012580025");
		model.setUserAccount("admin@mycine.cn");
		model.setBusinessKey("2410000013160016");
		actInstService.startProcess(model);
	}
}
