package com.redxun.oa.info.entity;

/**
 * 自定义栏目返回的数据结构。
 * @author ray
 */
public class InsColumnEntity<T> {
	private String title;
	private String url;
	private Integer count;
	private T obj;
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public T getObj() {
		return obj;
	}
	public void setObj(T obj) {
		this.obj = obj;
	}
	
	public InsColumnEntity(){
		super();
	}
	
	public InsColumnEntity(String title, String url, Integer count, T obj) {
		super();
		this.title = title;
		this.url = url;
		this.count = count;
		this.obj = obj;
	}
	public InsColumnEntity(String title, String url, Integer count, T obj,String type) {
		super();
		this.title = title;
		this.url = url;
		this.count = count;
		this.obj = obj;
		this.type = type;
	}
	
	
}
