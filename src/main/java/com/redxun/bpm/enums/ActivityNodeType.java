package com.redxun.bpm.enums;
/**
 * 节点类型
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public enum ActivityNodeType {
	startEvent("开始节点"),
	endEvent("结束节点"),
	userTask("用户任务节点"),
	signTask("会签任务节点"),
	subProcess("子流程"),
	callActivity("外部子流程"),
	exclusivegateway("分支网关"),
	parallelGateway("同步网关"),
	inclusiveGateway("条件网关"),
	subStartGateway("内嵌子流程开始网关"),
	subEndGateway("内嵌子流程结束网关"),
	subMultiStartGateway("多实例内嵌子流程开始网关"),
	serviceTask("服务任务节点");

	private String typeText;
	
	public String getTypeText() {
		return typeText;
	}
	
	ActivityNodeType(String typeText) {
		this.typeText=typeText;
	}
	
}
