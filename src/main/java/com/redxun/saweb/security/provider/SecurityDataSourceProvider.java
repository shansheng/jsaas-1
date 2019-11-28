package com.redxun.saweb.security.provider;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import com.redxun.core.cache.CacheUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.SysInstType;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.manager.SysInstTypeManager;
import com.redxun.sys.core.manager.SysMenuManager;

/**
 *  安全数据构建的Provider
 * @author csx
 *  @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 *
 */
public class SecurityDataSourceProvider implements ISecurityDataProvider {
	

	
	@Resource
	private SysInstTypeManager sysInstTypeManager;
	
	private SysMenuManager sysMenuManager;
	
	public void setSysMenuManager(SysMenuManager sysMenuManager) {
		this.sysMenuManager = sysMenuManager;
	}

	public void setAnonymousUrls(Set<String> anonymousUrls) {
		this.anonymousUrls = anonymousUrls;
	}

	public void setPublicUrls(Set<String> publicUrls) {
		this.publicUrls = publicUrls;
	}

	/**
	 * 匿名访问的URLs
	 */
	private Set<String> anonymousUrls=null;
	/**
	 * 登录访问的共公URLs
	 */
	private Set<String> publicUrls=null;
	/**
	 * 租户机构的最大可访问一些公共地址
	 */
	private Set<String> tadminUrls=null;
	
	

	
	public Set<String> getTadminUrls() {
		return tadminUrls;
	}

	public void setTadminUrls(Set<String> tadminUrls) {
		this.tadminUrls = tadminUrls;
	}

	public Set<String> getAnonymousUrls() {
		return anonymousUrls;
	}

	public Map<String,  Set<String>> getTenantUrlSet() {
		Map<String,  Set<String>> urlSet=(Map<String, Set<String>>) CacheUtil.getCache("tenantUrl_");
		if(BeanUtil.isEmpty(urlSet) ){
			urlSet=getTenantUrl();
			CacheUtil.addCache("tenantUrl_", urlSet);
		}
		return urlSet;
	}

	public Set<String> getPublicUrls() {
		return publicUrls;
	}

	
	public void reloadSecurityDataCache(){
		CacheUtil.delCache("menuMap_");
		CacheUtil.delCache("tenantUrl_");
	}
	
	/**
	 * 获得菜单映射对应的用户组Id
	 */
	public Map<String, Set<String>> getMenuGroupIdsMap() {
		Map<String, Set<String>> menuMap=(Map<String, Set<String>>) CacheUtil.getCache("menuMap_");
		if(menuMap==null){
			menuMap=sysMenuManager.getUrlGroupIdMap();
			CacheUtil.addCache("menuMap_", menuMap);
		}
		return menuMap;
	}

	/**
	 * 根据机构类型获取菜单地址Set
	 * @return
	 */
	public  Map<String, Set<String>> getTenantUrl(){
		Map<String, Set<String>> tenantUrlSet=new HashMap<String, Set<String>>();
		List<SysInstType> instTypes = sysInstTypeManager.getValidAll();
		for(SysInstType instType:instTypes){
			String type=instType.getTypeCode();
			Set<String> urlSet=new HashSet<String>();
			List<SysMenu> menus= sysMenuManager.getByInstType(type);
			for(SysMenu menu:menus){
				if(StringUtil.isEmpty(menu.getUrl())) continue;
				urlSet.add(menu.getUrl());
			}
			tenantUrlSet.put(type, urlSet);
		}
		return tenantUrlSet;
	}

	@Override
	public Set<String> getTadminUrlSet() {
		return tadminUrls;
	}

}
