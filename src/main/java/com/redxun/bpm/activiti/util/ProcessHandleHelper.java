package com.redxun.bpm.activiti.util;


import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.form.entity.FormulaSetting;

/**
 * 流程处理线程辅助类
 * @author mansan
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessHandleHelper {
	
	private static ThreadLocal<FormulaSetting> formulaSettingLocal	=new ThreadLocal<FormulaSetting>();
	
	private static ThreadLocal<IExecutionCmd> processCmdLocal=new ThreadLocal<IExecutionCmd>();
	
	private static ThreadLocal<ProcessMessage> processMessageLocal=new ThreadLocal<ProcessMessage>();
	//回退的线程变量
	private static ThreadLocal<BpmRuPath> backPathLocal=new ThreadLocal<BpmRuPath>();
	
	/**
	 * 上下文线程变量。
	 */
	private static ThreadLocal<Object> objectLocal=new ThreadLocal<Object>();
	
	
	
	/**
	 * 在上下文增加错误消息。
	 * @param message
	 */
	public static void addErrorMsg(String message){
		ProcessMessage msg=getProcessMessage();
		if(msg!=null){
			msg.getErrorMsges().add(message);
		}
	}
	
	public static void addDifferMsg(String message) {
		ProcessMessage msg = getProcessMessage();
		if(msg != null) {
			msg.getDifferMsgs().add(message);
		}
	}
	
	public static void setProcessCmd(IExecutionCmd cmd){
		processCmdLocal.set(cmd);
	}
	
	public static IExecutionCmd getProcessCmd(){
		return processCmdLocal.get();
	}
	
	public static void clearProcessCmd(){
		processCmdLocal.remove();
	}
	
	public static ProcessMessage getProcessMessage(){
		return processMessageLocal.get();
	}
	
	public static void setProcessMessage(ProcessMessage processMessage){
		processMessageLocal.set(processMessage);
	}
	
	/**
	 * 初始化信息。
	 */
	public static void initProcessMessage(){
		ProcessMessage processMessage=new ProcessMessage();
		processMessageLocal.set(processMessage);
	}
	
	public static void clearProcessMessage(){
		processMessageLocal.remove();
	}
	
	public static void setBackPath(BpmRuPath bpmRuPath){
		backPathLocal.set(bpmRuPath);
	}
	
	public static BpmRuPath getBackPath(){
		return backPathLocal.get();
	}
	
	public static void clearBackPath(){
		backPathLocal.remove();
	}
	

	public static void setObjectLocal(Object obj){
		objectLocal.set(obj);
	}
	
	public static Object getObjectLocal(){
		return objectLocal.get();
	}
	
	public static void clearObjectLocal(){
		objectLocal.remove();
	}
	
	public static void setFormulaSetting(FormulaSetting setting){
		formulaSettingLocal.set(setting);
	}
	
	public  static FormulaSetting getFormulaSetting(){
		return formulaSettingLocal.get();
	}
	
	public  static void clearFormulaSetting(){
		formulaSettingLocal.remove();
	}
}
