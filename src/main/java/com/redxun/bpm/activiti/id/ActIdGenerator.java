package com.redxun.bpm.activiti.id;

import org.activiti.engine.impl.cfg.IdGenerator;

/**
 *  工作流中的ID产生器
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActIdGenerator implements IdGenerator{
	
	private com.redxun.core.seq.IdGenerator idGenerator;

	public com.redxun.core.seq.IdGenerator getIdGenerator() {
		return idGenerator;
	}

	public void setIdGenerator(com.redxun.core.seq.IdGenerator idGenerator) {
		this.idGenerator = idGenerator;
	}

	@Override
	public String getNextId() {
		return idGenerator.getSID();
	}
}
