package com.redxun.saweb.security.provider;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import com.redxun.saweb.context.ContextUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsRelInstManager;
/**
 * 用户验证
 * @author keitch
 *  @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
public class UserDetailsProvider implements UserDetailsService {

    @Resource
    UserService  userService;
    @Resource
    GroupService groupService;
    @Resource
    OsRelInstManager osRelInstManager;
    @Resource
    SysInstManager sysInstManager;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
    	OsUser user = null;
    	if(username.indexOf("|")!=-1){//同时传入公司Id
    		String[]uIds=username.split("[|]");
    		SysInst sysInst=sysInstManager.getByCompId(uIds[1]);
    		user=(OsUser) userService.getByUsernameTenantId(uIds[0],sysInst.getInstId());
    	}else{
    		user=(OsUser) userService.getByUsername(username);
    	}

        if (user == null) return null;

		ContextUtil.setCurUser(user);
        
    	List<? extends IGroup> groupList= groupService.getGroupsByUserIdUserType(user.getUserId(),user.getUserType());
    	
    	IGroup mainGroup=groupService.getMainByUserId(user.getUserId());
    	if(mainGroup!=null){
    		OsGroup mainDep=(OsGroup)mainGroup;
    		user.setMainDep(mainDep);
    		if(StringUtils.isNotEmpty(mainDep.getPath())){
    			String[] mainDepIds=mainDep.getPath().split("[.]");
    			StringBuffer depBuf=new StringBuffer();
    			for(String depId:mainDepIds){
    				if("0".equals(depId)){
    					continue;
    				}
    				OsGroup group=(OsGroup)groupService.getById(depId);
    				if(group!=null){
    					depBuf.append(group.getName()).append("/");
    				}
    			}
    			user.setDepPathNames(depBuf.toString());
    		}
    	}
    	
    	Collection<GrantedAuthority> roles=new ArrayList<GrantedAuthority>();
		for(IGroup group:groupList){
			user.getGroupIds().add(group.getIdentityId());
			GrantedAuthority role=new SimpleGrantedAuthority(group.getKey());
			roles.add(role);
		}
		user.setAuthorities(roles);
        //获得当前用户的上下级配置信息
		List<OsRelInst> upLowRelInsts = osRelInstManager.getByRelTypeIdParty2(OsRelType.REL_CAT_USER_UP_LOWER_ID,user.getUserId());
		user.setUpLowRelInsts(upLowRelInsts);
        return user;
    }
}
