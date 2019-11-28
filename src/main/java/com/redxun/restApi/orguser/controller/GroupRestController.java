package com.redxun.restApi.orguser.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.restApi.orguser.entity.Dimension;
import com.redxun.restApi.orguser.entity.Group;
import com.redxun.restApi.orguser.entity.RankType;
import com.redxun.restApi.orguser.entity.Tenant;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRankType;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRankTypeManager;

@RequestMapping("/sys/org/")
@RestController
public class GroupRestController {
	
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	SysInstManager sysInstManager;
	@Resource
	OsDimensionManager osDimensionManager;
	@Resource
	OsRankTypeManager osRankTypeManager;
	/**
	 * 根据维度获取所有的组。
	 * 
	 * @param dimId
	 * @return
	 */
	@RequestMapping("getGroups/{tenantId}/{dimId}")
	public List<Group> getGroups(@PathVariable(value="dimId") String dimId,@PathVariable(value="tenantId") String tenantId){
		List<OsGroup> groups= osGroupManager.getByDimIdTenantId(dimId, tenantId);
		List<Group> list=new ArrayList<>();
		for(OsGroup osGroup:groups){
			Group group=OrgUtil.convertGroup(osGroup);
			group.setDimId(dimId);
			list.add(group);
		}
		return list;
	}
	
	/**
	 * 根据租户获取维度。
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getDimension/{tenantId}")
	public List<Dimension> getDimByTenantId(@PathVariable(value="tenantId") String tenantId){
		List<OsDimension> osDimensions= osDimensionManager.getAllByTenantId(tenantId);
		List<Dimension> list=new ArrayList<>();
		for(OsDimension osDimension:osDimensions){
			Dimension dimension=OrgUtil.convertDimension(osDimension);
			list.add(dimension);
		}
		return list;
	}
	
	/**
	 * 根据租户ID获取等级类型。
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getOsRankType/{tenantId}")
	public List<RankType> getOsRankType(@PathVariable(value="tenantId") String tenantId){
		List<OsRankType> osRankTypes= osRankTypeManager.getAllByTenantId(tenantId);
		List<RankType> list=new ArrayList<>();
		for(OsRankType osRankType:osRankTypes){
			RankType rankType=OrgUtil.convertRankType(osRankType);
			list.add(rankType);
		}
		return list;
	}
	
	/**
	 * 获取平台定义的租户列表。
	 * @return
	 */
	@RequestMapping("getTenants")
	public List<Tenant> getTenants(){
		List<Tenant> tenants=new ArrayList<>();
		List<SysInst> insts= sysInstManager.getValidSysInsts();
		for(SysInst inst:insts){
			Tenant tenant=new Tenant();
			tenant.setId(inst.getInstId());
			tenant.setName(inst.getNameCn());
			tenants.add(tenant);
		}
		return tenants;
	}
}
