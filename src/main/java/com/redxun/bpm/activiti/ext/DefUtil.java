package com.redxun.bpm.activiti.ext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.entity.config.NodeExecuteScript;
import com.redxun.core.util.BeanUtil;

public class DefUtil {

	 /**
	  * 构建脚本Map。
	  * @param configs
	  * @return
	  */
	 public static Map<String,String> getConditionMap(ExclusiveGatewayConfig configs){
		  Map<String,String> map=new HashMap<String, String>();
		  List<NodeExecuteScript> scripts=  configs.getConditions();
		  if(BeanUtil.isEmpty(scripts)) return map;
		  for(NodeExecuteScript script:scripts){
			  map.put( script.getNodeId(),script.getCondition());
		  }
		  return map;
	  }
}
