package com.redxun.bpm.core.manager;

import com.redxun.bpm.core.entity.BpmRuPath;

public class PathResult {
	
	
	
	
	
	public PathResult() {
		
	}

	public PathResult(boolean directTo, BpmRuPath bpmRuPath) {
		this.directTo = directTo;
		this.bpmRuPath = bpmRuPath;
	}
	
	/**
	 * 网关。
	 */
	private String gateWay="";

	/**
	 * 可以直接跳回。
	 * 如果路径
	 */
	private boolean directTo=false;
	
	/**
	 * 跳转回来。
	 */
	private BpmRuPath bpmRuPath;
	
	

	public boolean isDirectTo() {
		return directTo;
	}

	public void setDirectTo(boolean directTo) {
		this.directTo = directTo;
	}

	public BpmRuPath getBpmRuPath() {
		return bpmRuPath;
	}

	public void setBpmRuPath(BpmRuPath bpmRuPath) {
		this.bpmRuPath = bpmRuPath;
	}
	
	public boolean canTransto(){
		return "userTask".equals(this.bpmRuPath.getNodeType());
	}

	public String getGateWay() {
		return gateWay;
	}

	public void setGateWay(String gateWay) {
		this.gateWay = gateWay;
	}
	
	
	
	

}
