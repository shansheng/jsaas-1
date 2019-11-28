package com.redxun.bpm.core.manager;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;

/**
 * 表单在流程节点更新接口。
 * 作用：
 * 1.表单展示的时候取出json数据后，再根据设定修改json数据。
 * 2.在数据保存前时改json数据在进行保存。
 * @author ray
 *
 */
public interface IDataSettingHandler {
	
	/**
	 * 对数据进行处理。
	 * @param jsonData		表单数据
	 * <pre>
	 * {
	 * 	name:"ray",
	 * 	age:1
	 * 	SUB_子表1:[
	 * 		{name:'苹果',amount:1},
	 * 		{name:'梨',amount:2}
	 * 	],
	 * 	initData:{
	 * 		table1:{name:'ray'}
	 * 		table2:{name:'ray'}
	 * 	}
	 * }
	 * </pre>
	 * @param boDefId		bo定义
	 * @param setting		后端设定
	 * <pre>
	 *  {
		    "saveScript": " ",
		    "initScript": " ",
		    "boAttSettings": [
		        {
		            "save": {
		                "initdata": {
		                    "name": {
		                        "val": "[USERNAME]",
		                        "valType": "constant"
		                    }
		                },
		                "grid": {
		                    "address": {
		                        "val": "[USERNAME]",
		                        "valType": "constant"
		                    }
		                }
		            },
		            "boDefId": "240000007568000",
		            "init": {
		                "grid": {
		                    "name": {
		                        "val": "[USERID]",
		                        "valType": "constant"
		                    }
		                }
		            }
		        }
		    ]
		}
	 * 
	 * valType :
	 * manual : 固定值
	 * constant :常量
	 * 这个常量在spring-bean.xml 中进行定义，用户可以扩展这个常量列表。 
	 * script : 脚本
	 * 在脚本中可以引用其他字段的值。
	 * [userid] 中括号表示表字段。
	 * 
	 */
	void handSetting(JSONObject jsonData,String boDefId,JSONObject setting,boolean isSave,Map<String,Object> vars);
	
	
	
	

}
