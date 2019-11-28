package com.redxun.bpm.core.entity.config;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ExclusiveGatewayConfig extends ActivityConfig{
	
	private List<NodeExecuteScript> conditions=new ArrayList<NodeExecuteScript>();

	public List<NodeExecuteScript> getConditions() {
		return conditions;
	}

}
