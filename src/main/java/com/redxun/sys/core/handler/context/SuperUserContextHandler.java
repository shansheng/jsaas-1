package com.redxun.sys.core.handler.context;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.api.ContextHandler;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;

public class SuperUserContextHandler implements ContextHandler {

	@Resource
	OsRelInstManager osRelInstManager;
	
	@Override
	public String getKey() {
		return "[SUPERUSER]";
	}

	@Override
	public String getName() {
		
		return "用户上级";
	}

	@Override
	public Object getValue(Map<String,Object> vars) {
		String userId = ContextUtil.getCurrentUserId();
		List<OsRelInst> list = osRelInstManager.getByParty2RelTypeId(userId, OsRelType.REL_CAT_USER_UP_LOWER_ID);
		if(BeanUtil.isEmpty(list)) return null;
		return list.get(0).getParty1();
	}

}
