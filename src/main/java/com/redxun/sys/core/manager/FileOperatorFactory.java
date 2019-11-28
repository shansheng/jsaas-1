package com.redxun.sys.core.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FileOperatorFactory {
	
	
	private static Map<String ,IFileOperator> fileOperatorMap=new HashMap<>();
	
	public void setFileOperators(List<IFileOperator> operators){
		for(IFileOperator operator:operators){
			fileOperatorMap.put(operator.getType(), operator);
		}
	}
	
	/**
	 * 根据类型获取文件操作对象。
	 * @param type
	 * @return
	 */
	public static IFileOperator getByType(String type){
		if(fileOperatorMap.containsKey(type)){
			return fileOperatorMap.get(type);
		}
		return null;
	}
	

}
