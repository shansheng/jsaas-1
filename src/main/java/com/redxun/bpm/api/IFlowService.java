package com.redxun.bpm.api;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.core.json.JsonResult;

/**
 * 流程外部接口。
 * @author ray
 *
 */
public interface IFlowService {
	
	final static String ACC_ACCOUNT="account";
	final static String SOL_KEY="solKey";
	final static String BUS_KEY="busKey";
	final static String JSON_DATA="jsonData";
	final static String VARS="vars";
	
	
	/**
	 * 启动流程接口。
	 * {
	 * 	solId:"",
	 * 	account:""
	 * }
	 * @param json
	 * @return
	 */
	JsonResult<BpmInst> startProcess(String json);
	/**
	 * 启动流程接口
	 * @param account 启动用户账号
	 * @param solKey  解决方案Key
	 * @param busKey 业务主键Key
	 * @param jsonData JSON数据
	 * @param vars 流程变量
	 * @return
	 */
	JsonResult<BpmInst> startProcessByAccount(String account,String solKey,String busKey,String jsonData,String vars);
	
	/**
	 * 启动流程接口
	 * @param userId 启动用户Id
	 * @param solKey  解决方案Key
	 * @param busKey 业务主键Key
	 * @param jsonData JSON数据
	 * @param vars 流程变量
	 * @return
	 */
	JsonResult<BpmInst> startProcessByUserId(String userId,String solKey,String busKey,String jsonData,String vars);
	
	/**
	 * 启动流程接口。
	 * @param userId
	 * @param solId
	 * @param busKey
	 * @param jsonData
	 * @param vars
	 * @return
	 */
	JsonResult<BpmInst> startProcess(String userId,String solId,String busKey,String jsonData,String vars,boolean startFlow,String from);
	
	/**
	 * 根据用户帐号获取任务列表。
	 * @param account
	 * @return
	 */
	List<BpmTask> getTaskByUser(String account);
	
	/**
	 * 根据帐号和解决方案获取流程任务列表。
	 * @param account
	 * @param solId
	 * @return
	 */
	List<BpmTask> getTaskByUser(String account,String solId);
	
	/**
	 * 根据用户帐号和实例ID列表返回对应的任务和示例映射。
	 * <pre>
	 * 	这个功能主要是用于确定用户能够审批哪些任务。
	 * </pre>
	 * @param account
	 * @param instIds
	 * @return
	 */
	List<JSONObject> getTaskMapByInsts(String account,List<String> instIds);
	
	
	/**
	 * 完成任务。
	 * @param json
	 * @return
	 */
	JsonResult<Void> complete(String json);
	
}
