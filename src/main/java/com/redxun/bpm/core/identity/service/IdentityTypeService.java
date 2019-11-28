package com.redxun.bpm.core.identity.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.InitializingBean;

/**
 * 实体类型分类服务类
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class IdentityTypeService implements InitializingBean{
	//流程任务人员计算服务类映射
	private Map<String, IdentityCalService> identityCalServicesMap=new LinkedHashMap<String, IdentityCalService>();
	//程任务人员计算服务类
	private List<IdentityCalService>  identityCalServices=new ArrayList<IdentityCalService>();

	
	@Override
	public void afterPropertiesSet() throws Exception {
		for(IdentityCalService service:identityCalServices){
			identityCalServicesMap.put(service.getTypeKey(), service);
		}
	}


	public List<IdentityCalService> getIdentityCalServices() {
		return identityCalServices;
	}


	public void setIdentityCalServices(List<IdentityCalService> identityCalServices) {
		this.identityCalServices = identityCalServices;
	}


	public Map<String, IdentityCalService> getIdentityCalServicesMap() {
		return identityCalServicesMap;
	}

	
}
