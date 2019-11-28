package com.redxun.bpm.activiti.entity;
/**
 * 在创建area热区时put进ftl里面需要用的类,不持久化
 * @author Administrator
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmMessage {
	/**
	 * userTaskId
	 */
protected  String bpmId;

/**左顶点x
 * 
 */
protected String XPosition;
/**形状类型
 * 
 */
protected String shapeType;
/**左顶点y
 * 
 */
protected String YPosition;
/**
 * 宽度
 */
protected String Width;
/**
 * 高度
 */
protected String Height;
/**
 * 坐标字符串
 */
protected String coord;
/**
 * 任务名
 */
protected String taskName;
public String getBpmId() {
	return bpmId;
}
public void setBpmId(String bpmId) {
	this.bpmId = bpmId;
}
public String getCoord() {
	return coord;
}
public void setCoord(String coord) {
	this.coord = coord;
}
public String getTaskName() {
	return taskName;
}
public void setTaskName(String taskName) {
	this.taskName = taskName;
}
public String getXPosition() {
	return XPosition;
}
public void setXPosition(String xPosition) {
	XPosition = xPosition;
}
public String getYPosition() {
	return YPosition;
}
public void setYPosition(String yPosition) {
	YPosition = yPosition;
}
public String getWidth() {
	return Width;
}
public void setWidth(String width) {
	Width = width;
}
public String getHeight() {
	return Height;
}
public void setHeight(String height) {
	Height = height;
}
public String getShapeType() {
	return shapeType;
}
public void setShapeType(String shapeType) {
	this.shapeType = shapeType;
}



}
