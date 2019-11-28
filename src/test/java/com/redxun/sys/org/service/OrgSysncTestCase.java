package com.redxun.sys.org.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.annotation.Rollback;

import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.test.BaseTestCase;
public class OrgSysncTestCase extends BaseTestCase{
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	OsDimensionManager osDemensionManager;
	
	@Resource
	OsRelInstManager osRelInstManager;
	
	@Test
	@Rollback(false)
	public void testGetDep() throws Exception{
		JdbcTemplate jdbcTemplate=DataSourceUtil.getJdbcTempByDsAlias("cemsys");
		String sql="select * from rm_department";
		List<Map<String,Object>> list=jdbcTemplate.queryForList(sql);
		OsDimension osDemension=osDemensionManager.get("1");
		List<OsGroup> osGroups=new ArrayList<OsGroup>();
		for(int i=0;i<list.size();i++){
			Map<String,Object> row=list.get(i);
			String id=(String)row.get("id");
			
			OsGroup osGroup=osGroupManager.get(id);
			boolean isNew=false;
			if(osGroup==null){
				osGroup=new OsGroup();
				isNew=true;
			}
			String depCode=(String)row.get("dpCode");
			String dpName=(String)row.get("dpName");
			String dpType=(String)row.get("dpType");
			String addressCode=(String)row.get("addressCode");
			String belongDpId=(String)row.get("belongDpId");
			osGroup.setGroupId(id);
			osGroup.setName(dpName);
			osGroup.setKey(depCode);
			osGroup.setTenantId("1");
//			if(StringUtils.isEmpty(belongDpId)){
//				belongDpId="0";
//			}
			osGroup.setParentId(belongDpId);
			osGroup.setStatus("ENABLE");
			osGroup.setIsMain("NO");
			osGroup.setAreaCode(addressCode);
			if(StringUtils.isNotEmpty(dpType) && StringUtils.isNumeric(dpType)){
				osGroup.setRankLevel(new Integer(dpType));
			}
			osGroup.setOsDimension(osDemension);
			osGroup.setSn(0);
			
			if(isNew){
				osGroupManager.create(osGroup);
			}else{
				osGroupManager.update(osGroup);
			}
			osGroups.add(osGroup);
		}
		
		updateGroupPath(osGroups);
		//System.out.println("count:"+ count);
	}
	
	@Test
	@Rollback(false)
	public void sysncOrgUser() throws Exception{
		testGetDep();
		syncDepUser();
	}
	
	@Test
	public void testGetPath(){
		StringBuffer sb =new StringBuffer();
		
		String groupId="ff80808161658f9b0161659bbb28004e";
		
		OsGroup osGroup=osGroupManager.get(groupId);
		
		genOrgPath(osGroup,sb);
		
		System.out.println("path:"+sb.toString());
	}
	
	/**
	 * 更新组织的路径 
	 * @param group
	 * @param sb
	 */
	private void genOrgPath(OsGroup group,StringBuffer sb){

		if(StringUtils.isEmpty(group.getParentId()) || "0".equals(group.getParentId())){
			//group.setChilds(1);
			//group.setParentId("0");
			
			String path="0."+ group.getGroupId()+".";
			sb.insert(0, path);
			
			return;
		}
		
		sb.insert(0,group.getGroupId()+".");
		
		OsGroup parentGroup=osGroupManager.get(group.getParentId());
		
		if(parentGroup==null){
			return;
		}
		
		genOrgPath(parentGroup,sb);
		
		//group.setChilds(1);
	}
	
	private void updateGroupPath(List<OsGroup> groups){
		for(OsGroup group: groups){
			if(StringUtils.isEmpty(group.getParentId())){
				continue;
			}
			
			StringBuffer sb=new StringBuffer();
			
			genPath(group,sb);
			
			group.setPath(sb.toString());
			
			osGroupManager.update(group);
		}
	}
	
	private void genPath(OsGroup group,StringBuffer sb){

		if(StringUtils.isEmpty(group.getParentId())){
			group.setParentId("0");
			String path="0."+ group.getGroupId()+".";
			sb.insert(0, path);
			return;
		}
		
		OsGroup parentGroup=osGroupManager.get(group.getParentId());
		
		if(parentGroup==null){
			return;
		}
		
		genPath(parentGroup,sb);
		
		group.setChilds(1);
	}
	
	@Test
	@Rollback(false)
	public void syncDepUser() throws Exception{
		JdbcTemplate jdbcTemplate=DataSourceUtil.getJdbcTempByDsAlias("cemsys");
		String sql="select * from sm_user";
		List<Map<String,Object>> list=jdbcTemplate.queryForList(sql);
		for(int i=0;i<list.size();i++){
			Map<String,Object> row=list.get(i);
			String id=(String)row.get("id");
			String userName=(String)row.get("userName");
			String password=(String)row.get("password");
			//String userTypeNum=(String)row.get("userTypeNum");
			String departmentId=(String)row.get("departmentId");
			String gender=(String)row.get("gender");
			OsUser osUser=osUserManager.get(id);
			boolean isNew=false;
			if(osUser==null){
				isNew=true;
				osUser=new OsUser();
			}
			osUser.setUserId(id);
			osUser.setFullname(userName);
			osUser.setTenantId("1");
			osUser.setStatus("IN_JOB");
			osUser.setUserNo(userName);
			osUser.setSex(gender);
			
			if(isNew){
				osUserManager.create(osUser);
				
			
				if(StringUtils.isNotEmpty(departmentId)){
					OsRelInst inst=new OsRelInst();
					inst.setInstId(IdUtil.getId());
					inst.setParty1(departmentId);
					inst.setParty2(id);
					inst.setRelType("GROUP-USER");
					inst.setStatus("ENABLED");
					inst.setIsMain("YES");
					inst.setDim1("1");
					inst.setRelTypeKey("GROUP-USER-BELONG");
					inst.setRelTypeId("1");
					inst.setTenantId("1");
					osRelInstManager.create(inst);
				}
			}else{
				osUserManager.update(osUser);
			}
		}
	}
	
	public void getCurentUser(){
        /*
		String id=com.redxun.saweb.util.IdUtil.getId();
		  com.redxun.sys.org.entity.OsUser osUser=(com.redxun.sys.org.entity.OsUser)com.redxun.saweb.context.ContextUtil.getCurrentUser();
		  com.redxun.sys.org.entity.OsGroup mainGroup=(com.redxun.sys.org.entity.OsGroup)osUser.getMainDep();
		  
		  String deptCode=null;
		  Integer level=0;
		  String areaCode=null;
		 
		  if(mainGroup!=null){
			 level=mainGroup.getRankLevel();
			 deptCode=mainGroup.getKey();
			 areaCode=mainGroup.getAreaCode();
		  }

		String sql="insert into testconter(ID,KDBH,KDMC,SFBZHKD,KDLBM,KDLB,KDDZ,KDLXDH,KDCZ,BZHKCSL,FBZHKCSL,SJBGSSL,KDFZRXM,KDFZRDH,KDLXRXM,KDLXRDH,deptCode,deptLevel,areaCode,activityId) values(";
		sql+="'"+id+"','${EduLocation_kdbh}','${EduLocation_kdmc}','${EduLocation_sfbzhkd}','${EduLocation_kdlb}','${EduLocation_kdlb_name}','${EduLocation_kddz}','${EduLocation_kdlxdh}','${EduLocation_cz}','${EduLocation_bzhkcsl}','${EduLocation_fbzhkcsl}','${EduLocation_bmssl}','${EduLocation_kdfzrxm}','${EduLocation_kdfzrdh}','${EduLocation_kdlxrxm}','${EduLocation_kdlxrdh}','"+deptCode+"','"+level+"','"+areaCode+"','${processInstanceId}')";
		System.out.println("xxxxxxxxxxxxxxxxxxxxx========="+sql);*/
		
	}
}
