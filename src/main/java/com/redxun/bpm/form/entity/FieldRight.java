package com.redxun.bpm.form.entity;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.redxun.org.api.model.IGroup;
import com.redxun.sys.org.entity.OsGroup;

/**
 * 字段权限配置
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class FieldRight {
	// 是否全部
	private Boolean all;
	// 用户ID
	private String userIds;
	// 用户名称
	private String unames;
	// 组ID
	private String groupIds;
	// 组名称
	private String gnames;

	public Boolean getAll() {
		return all;
	}

	public void setAll(Boolean all) {
		this.all = all;
	}

	public String getUnames() {
		return unames;
	}

	public void setUnames(String unames) {
		this.unames = unames;
	}

	public String getGroupIds() {
		return groupIds;
	}

	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}

	public String getGnames() {
		return gnames;
	}

	public void setGnames(String gnames) {
		this.gnames = gnames;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
	public boolean isInUserIds(String userId){
		if(StringUtils.isEmpty(userIds)){
			return false;
		}
		
		String[]uIds=userIds.split("[,]");
		for(String uId:uIds){
			if(userId.equals(uId)){
				return true;
			}
		}
		return false;
	}
	
	public boolean isInGroups(Map<String,IGroup> groups){
		if(StringUtils.isEmpty(groupIds)){
			return false;
		}
		
		String[]gIds=groupIds.split("[,]");
		for(String gId:gIds){
			if(groups.containsKey(gId)){
				return true;
			}
		}
		return false;
	}

}
