package com.redxun.oa.ats.manager;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 考勤计算集合
 * 
 */
public class ExtCalcFactory {
	private Map<String, IAtsExtCalcService> atsCalculateMap = new LinkedHashMap<String, IAtsExtCalcService>();
	
	public Map<String, IAtsExtCalcService> getAtsCalculateMap() {
		return atsCalculateMap;
	}
	
	public void setAtsCalculateMap(Map<String, IAtsExtCalcService> atsCalculateMap) {
		this.atsCalculateMap = atsCalculateMap;
	}
	
	public IAtsExtCalcService getHandler(String key) {
		return atsCalculateMap.get(key);
	}
}
