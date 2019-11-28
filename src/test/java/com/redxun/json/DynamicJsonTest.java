package com.redxun.json;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.sys.org.entity.OsUser;

public class DynamicJsonTest {
	
	public static void main(String[]args){
		//testCreateJson();
		jsonDateParse();
	}
	
	/**
	 * 动态创建JSON
	 */
	public static  void testCreateJson(){
		 ObjectMapper mapper=new ObjectMapper();
		 ObjectNode rootNode=  mapper.createObjectNode();
		 rootNode.put("aa", "demo1");
		 rootNode.put("bb", 1);
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 rootNode.put("cc",sdf.format(new Date()));
		 
		 ObjectNode proNode=mapper.createObjectNode();
		 proNode.put("cc", "ccc");
		 proNode.put("ac","acdemo1");
		 
		 rootNode.set("comp", proNode);
		 
		 ArrayNode arrNode=mapper.createArrayNode();
		 
		 arrNode.add(proNode);
		 arrNode.add(proNode);
		 
		 rootNode.set("arr", arrNode);
		 System.out.println(rootNode.toString());
	}
	
	public static void jsonDateParse(){
		//OsUser osUser=new OsUser();
		String json="{'fullname':'abc','birthday':'2010-12-03 02:01:01'}";
		OsUser osUser=(OsUser)JSONUtil.json2Bean(json,OsUser.class);
		
		OsUser tmpUser2=new OsUser();
		
		System.out.println("tmp2 birthday:"+tmpUser2.getBirthday());
		BeanUtil.copyProperties(tmpUser2, osUser);
		System.out.println("after tmp birthday:"+tmpUser2.getBirthday());
		
		System.out.println("fullname:"+osUser.getFullname()+" birthday:");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(osUser.getBirthday()!=null){
			System.out.println(sdf.format(osUser.getBirthday()));
		}
		
	}
}
