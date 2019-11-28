package com.redxun.restApi.sys.controller;

import com.redxun.core.cache.CacheUtil;

public class AppTokenUtil {
	
	public static String TOKEN_PRE="app_token_";
	
	public static String getTokenKey(String token){
		return TOKEN_PRE + token;
	}
	
	/**
	 * 验证token是否有效。
	 * @param accessToken
	 * @return
	 */
	public static boolean validToken(String accessToken){
		String key=getTokenKey(accessToken);
		boolean rtn=CacheUtil.getCache(key)!=null;
		return rtn;
	}
	
	/**
	 * 根据token获取APPID。
	 * @param accessToken
	 * @return
	 */
	public static String getAppId(String accessToken){
		String key=getTokenKey(accessToken);
		boolean rtn=CacheUtil.containKey(key);
		if(rtn){
			return (String) CacheUtil.getCache(key);
		}
		return "-1";
	}

}
