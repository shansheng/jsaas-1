package com.redxun.sys.core.handler.context;

import java.util.Map;

import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ContextHandler;

/**
 * 系统的唯一ID
 * @author ray
 *
 */
public class UidContextHandler implements ContextHandler {

	@Override
	public String getKey() {
		return "[UID]";
	}

	@Override
	public String getName() {
		return "唯一ID";
	}

	@Override
	public Object getValue(Map<String, Object> vars) {
		return IdUtil.getId();
	}

}
