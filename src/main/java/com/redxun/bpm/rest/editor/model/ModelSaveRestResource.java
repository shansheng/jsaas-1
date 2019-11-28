/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.redxun.bpm.rest.editor.model;

import javax.annotation.Resource;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.manager.BpmDefManager;

/**
 * @author Tijs Rademakers
 */
@RestController
public class ModelSaveRestResource implements ModelDataJsonConstants {
  
  protected static Logger logger=LogManager.getLogger(ModelSaveRestResource.class);

  @Autowired
  private RepositoryService repositoryService;
  @Resource
  private BpmDefManager bpmDefManager;
  
  @Resource(name="iJson")
  private ObjectMapper objectMapper;
  
  @RequestMapping(value="/model/{modelId}/save",method=RequestMethod.POST)
  @ResponseStatus(value = HttpStatus.OK)
  public void saveModel(@PathVariable String modelId, @RequestBody MultiValueMap<String, String> values) {
    try {

      Model model = repositoryService.getModel(modelId);
      String isDeploy=values.getFirst("action");
      String name=values.getFirst("name");
      String description=values.getFirst("description");
      String designJson=values.getFirst("json_xml");
      //取得扩展的流程定义
      BpmDef bpmDef=bpmDefManager.getByModelId(modelId);
      logger.debug("jsonXml:"+designJson);
      if("modify".equals(isDeploy)){//修改旧的ModelId
    	  bpmDefManager.updateDefAndModifyActivitiDef(model,name,description,designJson);
      }else if("deployNew".equals(isDeploy)){//发布流程定义
    	  if(StringUtils.isEmpty(bpmDef.getActDefId())){//更新扩展的流程定义与Activiti的发布关联的信息
    		  bpmDefManager.doDeployModelAndUpdDef(model,name,description,designJson);
    	  }else{//发布新版本
    		 //1.生成Activiti的流程定义相关信息
    		 //2.生成新的BpmDef的信息，并且更新旧版本为从版本
    		 bpmDefManager.doDeployNewVersion(model, name, description, designJson);
    	  }
      }else{//仅更新设计器的设计文件及bpmdef的数据
    	  bpmDefManager.updateDef(model,name,description,designJson);
      }
    } catch (Exception e) {
    	logger.error("Error saving model", e);
      throw new ActivitiException("Error saving model", e);
    }
  }


}
