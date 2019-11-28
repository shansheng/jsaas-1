package com.redxun.bpm.form.api;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.entity.FormModel;

public interface IFormHandler {
	
	public static final String FORM_TYPE_MOBILE="mobile";
	
	public static final String FORM_TYPE_PC="pc";
	
	public static final String FORM_TYPE_PRINT="print";
	
	public static final String PK_VAR="pk";
	
	
	
	
	/**
	 * 表单类型。
	 * pc: PC表单
	 * mobile: 手机表单
	 * @return
	 */
	String getType();
	

	/**
	 * 发起流程时获获取表单。
	 * <pre>
	 * 	1.获取表单配置。
	 * 		1.首先获取发起节点的表单配置。
	 * 		2.如果没有获取到则获取全局的表单。
	 * 	2.构建表单
	 * 		1.如果为在线表单
	 * 			1.获取表单数据
	 * 			2.获取表单权限
	 * 			3.解析表单输出HTML
	 * 		2.url表单
	 * 			直接返回到前端
	 * </pre>
	 * @param solId			方案ID
	 * @param jsonData		json数据
	 * @return
	 * @throws Exception 
	 */
	List<FormModel> getStartForm(String solId,String instId,String jsonData) throws Exception;
	
	
	/**
	 * 审批表单接口。
	 * 	1.获取表单配置。
	 * 		1.首先获取发起节点的表单配置。
	 * 		2.如果没有获取到则获取全局的表单。
	 * 	2.构建表单
	 * 		1.如果为在线表单
	 * 			1.获取表单数据
	 * 			2.获取表单权限
	 * 			3.解析表单输出HTML
	 * 		2.url表单
	 * 			直接返回到前端
	 * @param taskId
	 * @param jsonData 
	 * @return
	 * @throws Exception 
	 */
	List<FormModel> getByTaskId(String taskId,String jsonData) throws Exception;
	
	
	/**
	 * 获取流程实例表单。
	 * 	1.获取表单配置。
	 * 		1.首先获取发起节点的表单配置。
	 * 		2.如果没有获取到则获取全局的表单。
	 * 	2.构建表单
	 * 		1.如果为在线表单
	 * 			1.获取表单数据
	 * 			2.获取表单权限
	 * 			3.解析表单输出HTML
	 * 		2.url表单
	 * 			直接返回到前端
	 * @param taskId
	 * @param jsonData
	 * @return
	 * @throws Exception 
	 */
	List<FormModel> getByInstId(String instId) throws Exception;
	
	
	/**
	 * 根据表单名称获取表单。
	 * @param alias
	 * @param pk
	 * @param readOnly
	 * @return
	 */
	FormModel getFormByFormAlias(String alias, String pk,boolean readOnly,Map<String,Object> params) throws Exception;
	
	/**
	 * 根据表单名称获取表单对象。
	 * @param alias		别名
	 * @param jsonData	数据
	 * @param readOnly	是否只读
	 * @param params	外部参数
	 * @return
	 * @throws Exception
	 */
	FormModel getFormByFormAlias(String alias, JSONObject jsonData,boolean readOnly,Map<String,Object> params) throws Exception;
}
