package com.redxun.restApi.orguser.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.restApi.orguser.entity.Group;
import com.redxun.restApi.orguser.entity.User;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.org.dao.OsUserDao;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsUserManager;

@RestController
@RequestMapping("/sys/org/")
public class UserRestController {
	
	@Resource
    UserService  userService;
    @Resource
    GroupService groupService;
    @Resource
    OsUserManager osUserManager;
    @Resource
    OsUserDao osUserDao;
    @Resource
    OsRelInstManager osRelInstManager;

	
    /**
     * 根据帐号查询用户和组织信息。
     * @param account
     * @return
     */
	@RequestMapping("getUser")
	@ResponseBody
	public User getUser(HttpServletRequest request ){
		String account=RequestUtil.getString(request, "account");
		OsUser osuser = (OsUser) userService.getByUsername(account);
        if (osuser == null) return new User();
        User user=OrgUtil.convertUser(osuser);
        
        List<? extends IGroup> groupList= groupService.getGroupsByUserId(user.getUserId());
    	IGroup mainGroup=groupService.getMainByUserId(user.getUserId());
    	if(BeanUtil.isNotEmpty(mainGroup)){
    		Group osGroup=OrgUtil. convertGroup((OsGroup) mainGroup);
    		user.setMainGroup(osGroup);
    	}
    	for(IGroup group:groupList){
    		Group osGroup=OrgUtil.convertGroup((OsGroup) group);
    		user.addGroup(osGroup);
    	}
		return user;
	}
	
	
	
	
	/**
	 * 根据租户获取下面的所有用户。
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getUsers/{tenantId}")
	@ResponseBody
	public List<User> getUsers(@PathVariable(value="tenantId")  String tenantId){
		List<OsUser> users= osUserManager.getAllByTenantId(tenantId);
		List<User> list= OrgUtil.convertUsers(users);
		return list;
	}
	
	/**
	 * 根据 岗位两方获取用户。
	 * @param part1
	 * @param part2
	 * @param tenantId
	 * @return
	 */
	@RequestMapping("getUserByPart/{tenantId}/{part1}/{part2}")
	@ResponseBody
	public List<User> getUserByPart(@PathVariable(value="part1") String part1,
			@PathVariable(value="part2") String part2,
				@PathVariable(value="tenantId")String tenantId){
		List<OsUser> users= osUserDao.getByPart(part1, part2, tenantId);
		List<User> list= OrgUtil.convertUsers(users);
		return list;
	}
	
	/**
	 * 根据岗位Id 获取对应的人。
	 * @param id
	 * @return
	 */
	@RequestMapping("getUsersByRelInst/{id}")
	@ResponseBody
	public List<User> getUsersByRelInst(@PathVariable(value="id") String id){
		OsRelInst inst= osRelInstManager.get(id);
		List<OsUser> users= osUserDao.getByPart(inst.getParty1(), inst.getParty2(), inst.getTenantId());
		List<User> list= OrgUtil.convertUsers(users);
		return list;
	}
	
	

}
