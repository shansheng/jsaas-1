package com.redxun.microsvc.util;

import java.util.Collection;
import java.util.Map;

/**
 * 客户端工具类。
 * @author ray
 *
 */
public class Util {
	
	/**
	 * 判断字符串是否为空。
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str){
		if(str==null) return true;
		if(str.trim().length()==0) return true;
		return false;
	}
	
	/**
	 * 判断字符串不为空
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(String str){
		return !isEmpty(str);
	}
	
	/**
	 * 判断对象是否为空。
	 * @param o
	 * @return
	 */
	public static boolean isObjEmpty(Object o){
		if (o == null) return true;
		if (o instanceof String) {
			if (((String) o).trim().length() == 0)
				return true;
		} else if (o instanceof Collection) {
			if (((Collection<?>) o).size() == 0)
				return true;
		} else if (o.getClass().isArray()) {
			if (((Object[]) o).length == 0)
				return true;
		} else if (o instanceof Map) {
			if (((Map<?, ?>) o).size() == 0)
				return true;
		}
		return false;
	}
	
	/**
	 * 判断对象不为空。
	 * @param o
	 * @return
	 */
	public static boolean isObjNotEmpty(Object o){
		return !isObjEmpty(o);
	}
	
	


}
