package com.redxun.test;

import java.util.ArrayList;
import java.util.List;

public class Orders {
	
	private String name="";
	
	private List<OrderItems> items=new ArrayList<OrderItems>();
	
	private List<OrderItems> users=new ArrayList<OrderItems>();

	public List<OrderItems> getUsers() {
		return users;
	}

	public void setUsers(List<OrderItems> users) {
		this.users = users;
	}

	public List<OrderItems> getItems() {
		return items;
	}

	public void setItems(List<OrderItems> items) {
		this.items = items;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
