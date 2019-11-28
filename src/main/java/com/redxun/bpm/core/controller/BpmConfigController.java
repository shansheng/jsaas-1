package com.redxun.bpm.core.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.service.SkipConditionFactory;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;

/**
 * 流程参数的配置常量来源
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
@Controller
@RequestMapping("/bpm/core/bpmConfig/")
public class BpmConfigController {
	@Resource(name="iJson")
	ObjectMapper objectMapper;
	
	@Resource
	private SkipConditionFactory skipConditionFactory;
	@Resource
	private BpmNodeSetManager bpmNodeSetManager;
	
	/**
	 * 获得按钮
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getCheckButtons")
	@ResponseBody
	public String getCheckButtons(HttpServletRequest request) throws Exception{
		String type=RequestUtil.getString(request, "type","task");
		String solId=RequestUtil.getString(request, "solId");
		String actDefId=RequestUtil.getString(request, "actDefId");
		String path=WebAppUtil.getAppAbsolutePath().replace("\\", "/") +"/WEB-INF/classes/config/flowButton.json";
		String json= FileUtil.readFile(path);
		JSONObject jsonObj=JSONObject.parseObject(json);
		JSONArray taskObj=jsonObj.getJSONArray(type);
		if("task".equals(type)) {
			BpmNodeSet set = bpmNodeSetManager.getBySolIdActDefIdNodeId(solId, actDefId, ProcessConfig.PROCESS_NODE_ID);
			JsonNode jsonObject=objectMapper.readTree(set.getSettings());
			JsonNode configsNode=jsonObject.get("configs");
			Map<String,Object> configMap=JSONUtil.jsonNode2Map(configsNode);
			String bpmDefs=(String)configMap.get("bpmDefs");
			if(bpmDefs==null){
				return taskObj.toString();
			}
			JSONArray ary = JSONArray.parseArray(bpmDefs);
			for (Object object : ary) {
				JSONObject obj = (JSONObject)object;
				JSONObject btn = new JSONObject();
				String alias = obj.getString("alias");
				btn.put("id", "btn"+StringUtil.makeFirstLetterUpperCase(alias));
				btn.put("alias", alias);
				btn.put("name", "启动"+obj.getString("name"));
				btn.put("script", "startSubProcess('"+alias+"')");
				btn.put("iconCls", "icon-start");
				taskObj.add(btn);
			}
		}
		
		
		return taskObj.toJSONString();
	}
	
	/**
	 * 获得通知的类型配置
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getNoticeTypes")
	@ResponseBody
	public ArrayNode getNoticeTypes(HttpServletRequest request) throws Exception{
		ArrayNode arrayNode=objectMapper.createArrayNode();
		Map<String,String> map= MessageUtil.getMapMsgType();
		for(Map.Entry<String, String> ent:map.entrySet()){   
			ObjectNode objectNode=objectMapper.createObjectNode();
			objectNode.put("name",ent.getKey());
			objectNode.put("text", ent.getValue());
			arrayNode.add(objectNode);
		}
		return arrayNode;
	}
	
	@RequestMapping("getJumpTypes")
	@ResponseBody
	public List<KeyValEnt<String>> getJumpTypes(HttpServletRequest request) throws Exception{
		List<KeyValEnt<String>> list= skipConditionFactory.getTypes();
		return list;
	}
	
	
}
