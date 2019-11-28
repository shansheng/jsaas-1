package com.redxun.saweb.security.provider;

import java.util.Map;
import java.util.Set;

/**
 * 安全数据源处理接口
 * @author X230
 *  @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
public interface ISecurityDataProvider {
	/**
	 * 获得匿名的URL
	 * @return
	 */
	Set<String> getAnonymousUrls();
	/**
	 * 取得当前租户管理 员允许访问的权限地址
	 * @return
	 */
	Set<String> getTadminUrlSet();
	
	/**
	 * 获得租户的URL集合
	 * @return
	 */
	Map<String,  Set<String>> getTenantUrlSet();
	/**
	 * 获得登录后的公共URL集合
	 * @return
	 */
	Set<String> getPublicUrls() ;
	/**
	 * 重新加载安全的数据源
	 */
	void reloadSecurityDataCache();
	/**
	 * 获得菜单与用户组ID集合的映射
	 * @return
	 */
	Map<String, Set<String>> getMenuGroupIdsMap();
	
}
