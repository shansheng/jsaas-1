package com.redxun.bpm.core.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.repository.ProcessDefinition;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.dao.ActGeByteArrayDao;
import com.redxun.test.MyBatisTestCase;

public class ReqModelTestCase extends MyBatisTestCase{
	@Resource
	private RepositoryService repositoryService;
	@Resource
	private ActGeByteArrayDao actGeByteArrayDao;
	
	@Test
	@Rollback(true)
	public void testGetEditorJson(){
		ObjectMapper objectMapper=new ObjectMapper();
		String modelId="20000000857003";
		String json=new String(repositoryService.getModelEditorSource(modelId));
		System.out.println("json is:" + json);
		
		 try {
			ObjectNode editorJsonNode = (ObjectNode) objectMapper.readTree(
			            new String(repositoryService.getModelEditorSource(modelId), "utf-8"));
			ObjectNode pNodes=(ObjectNode)editorJsonNode.get("properties");
			if(pNodes==null){
				pNodes=objectMapper.createObjectNode();
			}
			pNodes.put("process_id", "CAR_REP_v1");
			pNodes.put("name", "汽车入库1");
			pNodes.put("name", "汽车入库详细描述1");
			repositoryService.addModelEditorSource(modelId,pNodes.toString().getBytes());
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 String json2=new String(repositoryService.getModelEditorSource(modelId));
			System.out.println("jsons2 is:" + json2);
		
	}
	
	//通过发布ID获得流程定义的详细配置
	@Test
	public void getByDeployId(){
		
		String deployId="20000000867001";
		String xml=actGeByteArrayDao.getDefXmlByDeployId(deployId);
		System.out.println("xml:"+xml);
	}
	
	@Test
	public void getBpmDef(){
		String actDefId="CAR_IN_STOCK:3:20000000892020";
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		
		String nodeId="id-18566340-81C4-4CAF-B3C1-9341FDEE7092";
		
		Map<String,TaskDefinition> taskMap= entity.getTaskDefinitions();
		Iterator<String> keyIt=taskMap.keySet().iterator();
		while (keyIt.hasNext()) {
			String key=keyIt.next();
			TaskDefinition taskDef=taskMap.get(key);
			
			System.out.println("key:"+taskDef.getKey() +" type:"+ taskDef.getNameExpression().getExpressionText());
		}
	}
	
	@Test
	public void getBpmNodes(){
		String actDefId="CAR_IN_STOCK:3:20000000892020";
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		List<ActivityImpl> acts= entity.getProcessDefinition().getActivities();
		for(ActivityImpl imp:acts){
			//System.out.println("name:"+ imp.toString());
			String id=imp.getId();
		
			Map<String,Object> properties=imp.getProperties();
			Iterator<String> keyIt=properties.keySet().iterator();
			System.out.println("nodeId:"+id+"===============");
			while(keyIt.hasNext()){
				String key=keyIt.next();
				Object val=properties.get(key);
				System.out.println("key:"+key+" val:"+String.valueOf(val));
			}
		}
	}
}
