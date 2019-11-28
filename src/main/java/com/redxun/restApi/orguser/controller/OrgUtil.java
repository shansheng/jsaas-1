package com.redxun.restApi.orguser.controller;

import java.util.ArrayList;
import java.util.List;

import com.redxun.restApi.orguser.entity.Dimension;
import com.redxun.restApi.orguser.entity.Group;
import com.redxun.restApi.orguser.entity.RankType;
import com.redxun.restApi.orguser.entity.RelInst;
import com.redxun.restApi.orguser.entity.RelType;
import com.redxun.restApi.orguser.entity.User;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRankType;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;

public class OrgUtil {
	
	/**
	 * 转换用户组对象。
	 * @param org
	 * @return
	 */
	public static Group convertGroup(OsGroup org){
		Group group=new Group();
		group.setGroupId(org.getGroupId());
		group.setParentId(org.getParentId());
		group.setName(org.getName());
		group.setDimId(org.getDimId());
		group.setRankLevel(org.getRankLevel());
		group.setSn(org.getSn());
		group.setTenantId(org.getTenantId());
		group.setKey(org.getKey());
		group.setAreaCode(org.getAreaCode());
		group.setIsDefault(org.getIsDefault());
		group.setStatus(org.getStatus());
		group.setDescp(org.getDescp());
		group.setForm(org.getForm());
		
		return group;
	}
	
	/**
	 * 转换用户对象。
	 * @param osUser
	 * @return
	 */
	public static User convertUser(OsUser osUser){
		User user=new User();
		user.setUserId(osUser.getUserId());
		user.setFullname(osUser.getFullname());
		user.setAddress(osUser.getAddress());
		user.setEmail(osUser.getEmail());
		user.setMobile(osUser.getMobile());
		user.setUserNo(osUser.getUserNo());
		user.setPassword(osUser.getPassword());
		user.setSex(osUser.getSex());
		user.setQq(osUser.getQq());
		user.setAddress(osUser.getAddress());
		user.setTenantId(osUser.getTenantId());
		
		user.setBirthday(osUser.getBirthday());
		user.setEntryTime(osUser.getEntryTime());
		user.setFrom(osUser.getFrom());
		user.setQuitTime(osUser.getQuitTime());
		user.setStatus(osUser.getStatus());
		user.setSyncWx(osUser.getSyncWx());
		user.setUrgent(osUser.getUrgent());
		user.setUrgentMobile(osUser.getUrgentMobile());
		user.setPhoto(osUser.getPhoto());
		
		
		return user;
	}
	
	/**
	 * 转换用户列表。
	 * @param users
	 * @return
	 */
	public static List<User> convertUsers(List<OsUser> users){
		List<User> list=new ArrayList<>();
		for(OsUser user:users){
			User tmp=OrgUtil.convertUser(user);
			list.add(tmp);
		}
		return list;
	}
	
	
	
	
	/**
	 * 转换关系实例对象数据。
	 * @param osRelInst
	 * @return
	 */
	public static RelInst convertRelInst(OsRelInst osRelInst){
		RelInst inst=new RelInst();
		
		inst.setInstId(osRelInst.getInstId());
		inst.setDim1(osRelInst.getDim1());
		inst.setDim2(osRelInst.getDim2());
		inst.setIsMain(osRelInst.getIsMain());
		inst.setParty1(osRelInst.getParty1());
		inst.setParty2(osRelInst.getParty2());
		inst.setRelType(osRelInst.getRelType());
		inst.setRelTypeId(osRelInst.getRelTypeId());
		inst.setRelTypeKey(osRelInst.getRelTypeKey());
		inst.setStatus(osRelInst.getStatus());
		
		return inst;
	}
	
	/**
	 * 关系类型转换。
	 * @param osRelType
	 * @return
	 */
	public static RelType convertRelType(OsRelType osRelType){
		RelType relType=new RelType();
		relType.setId(osRelType.getId());
		relType.setName(osRelType.getName());
		relType.setKey(osRelType.getKey());
		relType.setParty1(osRelType.getParty1());
		relType.setParty2(osRelType.getParty2());
		relType.setDimId1(osRelType.getDimId1());
		relType.setDimId2(osRelType.getDimId2());
		relType.setConstType(osRelType.getConstType());
		relType.setIsDefault(osRelType.getIsDefault());
		relType.setIsSystem(osRelType.getIsSystem());
		relType.setIsTwoWay(osRelType.getIsTwoWay());
		relType.setMemo(osRelType.getMemo());
		relType.setRelType(osRelType.getRelType());
		relType.setStatus(osRelType.getStatus());
		return relType;
	}
	
	/**
	 * 维度定义数据。
	 * @param os
	 * @return
	 */
	public static Dimension convertDimension(OsDimension os){
		Dimension dim=new Dimension();
		dim.setDimId(os.getDimId());
		dim.setDesc(os.getDesc());
		dim.setDimKey(os.getDimKey());
		dim.setIsCompose(os.getIsCompose());
		dim.setIsGrant(os.getIsGrant());
		dim.setIsSystem(os.getIsSystem());
		dim.setName(os.getName());
		dim.setShowType(os.getShowType());
		dim.setStatus(os.getStatus());
		
		return dim;
		
	}
	
	/**
	 * 转换类型。
	 * @param rankType
	 * @return
	 */
	public static RankType convertRankType(OsRankType rankType){
		RankType type=new RankType();
		type.setId(rankType.getId());
		type.setDimId(rankType.getDimId());
		type.setKey(rankType.getKey());
		type.setLevel(rankType.getLevel());
		type.setName(rankType.getName());
		return type;
	}
	
}
