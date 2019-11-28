package com.redxun.bpm.core.identity.service;


/**
 * 抽象的实体计算服务类
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public abstract class AbstractIdentityCalService  implements IdentityCalService {
	//分类Key
	protected String typeKey;
	//分类名称
	protected String typeName;
	//分类描述
	protected String description;
	//处理的类名
	protected String handlerClass;
	
	
	public String getTypeKey() {
		return typeKey;
	}
	
	public void setTypeKey(String typeKey) {
		this.typeKey = typeKey;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String getDescp() {
		return this.description;
	}
	
	
}
