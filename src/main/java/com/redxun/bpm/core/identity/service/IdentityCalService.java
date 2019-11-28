package com.redxun.bpm.core.identity.service;

import java.io.Serializable;
import java.util.Collection;

import com.redxun.bpm.core.entity.TaskExecutor;

/**
 * 任务人员计算服务接口类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface IdentityCalService extends Serializable{
	//人员计算类型
	String getTypeKey();
	//人员计算名称
	String getTypeName();
	//人员计算描述
	String getDescp();
	

	
	/**
	 * 计算节点返回的人员实体
	 * @param idCalConfig
	 * @return
	 */
	Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig);
}
