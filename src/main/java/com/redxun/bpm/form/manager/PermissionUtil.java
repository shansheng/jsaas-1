package com.redxun.bpm.form.manager;

import java.util.Map;
import java.util.Set;

import com.redxun.bpm.form.entity.RightModel;

public class PermissionUtil {
	
	public static boolean hasRight(RightModel rightModel, Map<String,Set<String>> profileMap){
		if("all".equals(rightModel.getPermissionType())) return true;
		
		Set<String> set=profileMap.get(rightModel.getPermissionType());
		String[] aryId=rightModel.getIds() .split(",");
		for(int i=0;i<aryId.length;i++){
			if(set.contains(aryId[i])) return true;
		}
		return false;
	}
}
