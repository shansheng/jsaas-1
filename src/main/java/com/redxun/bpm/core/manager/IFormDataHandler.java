package com.redxun.bpm.core.manager;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.sys.bo.entity.BoResult;

/**
 * 表单数据接口。
 * @author ray
 *
 */
public interface IFormDataHandler {
	
	
	
	/**
	 * 获取表单初始化数据。
	 * 从bo定义数据获取初始化数据。
	 * <pre>
	 * json数据格式如下:
	 * {
	 * 	name:"ray",
	 * 	age:1
	 * 	SUB_子表1:[
	 * 		{name:'苹果',amount:1},
	 * 		{name:'梨',amount:2}
	 * 	]
	 * }
	 * </pre>
	 * @param boDefId
	 * @return
	 */
	JSONObject getInitData(String boDefId);
	
	/**
	 * 根据实例ID获取数据。
	 * <pre>
	 * json数据格式如下:
	 * {
	 * 	name:"ray",
	 * 	age:1
	 * 	SUB_子表1:[
	 * 		{name:'苹果',amount:1},
	 * 		{name:'梨',amount:2}
	 * 	]
	 * }
	 * </pre>
	 * @param boDefId		bo定义ID
	 * @param id			实例数据ID ，如果使用DB存储，那么是主表的主键，
	 * 	如果使用JSON存储，那么数据为BPM_FORM_INST的主键
	 * @return
	 */
	JSONObject getData(String boDefId,String formInstIdOrPkId);
	
	/**
	 * 保存数据接口。
	 * <pre>
	 * json数据格式如下:
	 * {
	 * 	name:"ray",
	 * 	age:1
	 * 	SUB_子表1:[
	 * 		{name:'苹果',amount:1},
	 * 		{name:'梨',amount:2}
	 * 	]
	 * }
	 * </pre>
	 * @param boDefId	bo定义ID
	 * @param instId	实例数据ID ，如果使用DB存储，那么是主表的主键，
	 * 	如果使用JSON存储，那么数据为BPM_FORM_INST的主键
	 * @param json		需要存储的JSON格式数据。
	 * @return 返回业务主键。
	 */
	BoResult saveData(String boDefId,String formInstIdOrPkId, JSONObject json);
	
	
	/**
	 * 根据boDefId 和参数获取表单数据。
	 * @param boDefId
	 * @param params
	 * @return
	 */
	JSONObject getData(String boDefId,Map<String,Object> params);

}
