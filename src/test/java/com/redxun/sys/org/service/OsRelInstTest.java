package com.redxun.sys.org.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.test.BaseTestCase;

public class OsRelInstTest extends BaseTestCase{
	
	@Resource
	private OsRelInstManager osRelInstManager;
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private JdbcTemplate jdbcTemplate;
	
//	@Test
//	public void  updUpLowPath(){
//		Map<String,String> map=new HashMap<>();
//		Map<String,OsRelInst> relMap=new HashMap<>(); 
//		List<OsRelInst> list= osRelInstManager.getByRelTypeIdTenantId("3", "1");
//		for(OsRelInst inst:list){
//			map.put(inst.getParty2(), inst.getParty1());
//			relMap.put(inst.getInstId(), inst);
//		}
//		
//		for(OsRelInst inst:list){
//			String part2=inst.getParty2();
//			String path=getPath(part2,map);
//			System.out.println(path);
//			if(path!=null){
//				inst.setPath(path);
//				osRelInstManager.update(inst);
//			}
//		}
//	}
	
	private String getPath(String part2,Map<String,String> map){
		String path=part2;
		String part1=map.get(part2);
		while(!part1.equals("0")){
			path= part1 +"." + path;
			part1=map.get(part1);
			if(part1==null) return null;
		}
		return "0." + path;
	}
	
	
	public void updGroupPath(){
		List<OsGroup> groups= osGroupManager.getByDimId("1");
		Map<String,String> maps=new HashMap<>();
		for(OsGroup group:groups){
			maps.put(group.getGroupId(), group.getParentId());
		}
	
		for(OsGroup group:groups){
			String groupId=group.getGroupId();
			String path= getGroupPath(groupId,maps);
			System.out.println(path);
			
		}
	}
	
	private String getGroupPath(String groupId,Map<String,String> map){
		String path=groupId +".";
		String parentId=map.get(groupId);
		while(!parentId.equals("0")){
			path= parentId +"." + path;
			parentId=map.get(parentId);
			if(parentId==null) return null;
		}
		return "0." + path;
	}
	
	@Test
	public void updChildsCount(){
		String sql="select t.GROUP_ID_, (select count(*) from os_group a where a.PARENT_ID_=t.GROUP_ID_ ) COUNT from os_group t where t.DIM_ID_='1'";
		List<Map<String, Object>>  list=  jdbcTemplate.queryForList(sql);
		for(Map<String, Object> map:list){
			String gid=(String) map.get("GROUP_ID_");
			Long count=(Long) map.get("COUNT");
			
			String updsql="update os_group set CHILDS_="+count+" where GROUP_ID_='"+gid+"'";
			jdbcTemplate.execute(updsql);
		}
		
	}
	

}
