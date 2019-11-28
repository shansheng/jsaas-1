package com.redxun.restApi.orguser.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.restApi.orguser.entity.RelInst;
import com.redxun.restApi.orguser.entity.RelType;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

@RequestMapping("/sys/org/")
@RestController
public class RelInstRestController {

	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	OsRelTypeManager osRelTypeManager;
	
	
	/**
	 * 根据租户ID获取关系类型列表。
	 * <pre>
	 * 	根据租户ID获取系统定义的关系。
	 * </pre>
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getRelType/{tenantId}")
	public List<RelType> getRelTypeByTenantId(@PathVariable(value="tenantId") String tenantId){
		List<RelType> insts=new ArrayList<>();
		List<OsRelType> relTypes= osRelTypeManager.getAllByTenantId(tenantId);
		for(OsRelType osRelType:relTypes){
			RelType inst=OrgUtil.convertRelType(osRelType);
			insts.add(inst);
		}
		return insts;
	}
	
	
	/**
	 * 根据关系类型获取关系类型实例数据。
	 * <pre>
	 * 	获取关系类型主要用来创建 ：
	 *  1.用户和用户的关系。
	 *  2.用户和组的关系。
	 *  3.组和组的关系。
	 * </pre>
	 * @param relTypeId
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getRelInst/{tenantId}/{relTypeId}")
	public List<RelInst> getRelInstByRelType(@PathVariable(value="relTypeId") String relTypeId,@PathVariable(value="tenantId") String tenantId){
		List<OsRelInst> insts= osRelInstManager.getByRelTypeIdTenantId(relTypeId, tenantId);
		List<RelInst> relInsts=new ArrayList<>();
		for(OsRelInst inst:insts){
			RelInst relInst=OrgUtil.convertRelInst(inst);
			relInsts.add(relInst);
		}
		return relInsts;
	}
	
	
	
	
}
