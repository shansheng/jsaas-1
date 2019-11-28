package com.redxun.bpm.core.entity;

import java.util.List;

import com.redxun.sys.core.entity.SysTree;


/**
 * <pre>
 * 描述：BpmDef实体类定义
 * 流程定义
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */

public class VirtualBpmNode{
	private int id;
	private String label;
	private String type;
	private String url;
	private int sonNum;
	private String parentId;
	private String treeId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getSonNum() {
		return sonNum;
	}
	public void setSonNum(int sonNum) {
		this.sonNum = sonNum;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getTreeId() {
		return treeId;
	}
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	
	

}
