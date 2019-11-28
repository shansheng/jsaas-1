package com.redxun.bpm.activiti.listener.call.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.util.SysUtil;
/**
 * 流程事件配置，HTTP请求服务调用
 * @author mansan
 *
 */
public class BpmEventCallHandlerSubProcess extends AbstractBpmEventCallHandler{
    @Resource
    GroovyEngine groovyEngine;
    @Resource
    BpmInstManager bpmInstManager;
    @Resource
    BpmSolutionManager bpmSolutionManager;
    @Resource(name="iJson")
	ObjectMapper objectMapper;
    @Resource
    BpmNodeSetManager bpmNodeSetManager;
    @Resource
	FormHandlerFactory formHandlerFactory;
    @Resource
	BpmTableFormulaManager bpmTableFormulaManager;

    @Override
    public void handle(BpmEventCallMessage callMessage){
    	BpmEventCallSetting eventSetting= callMessage.getBpmEventCallSetting();
		String str=eventSetting.getScript();
		JSONObject obj = JSONObject.parseObject(str);
		String script = obj.getString("script");
		String subProcess = obj.getString("subProcess");
		Boolean flag = true;
		if(StringUtils.isNotEmpty(script)) {
			Map<String,Object> vars=getVariables(callMessage);
			script=SysUtil.parseScript(script, vars);
			flag = (Boolean)groovyEngine.executeScripts(script, vars);
		}
		//不满足条件不启动子流程
		if(!flag || StringUtil.isEmpty(subProcess))return;
		//加上处理的消息提示
		ProcessMessage handleMessage=new ProcessMessage();
    	BpmInst bpmInst=null;
    	try{
	    	ProcessHandleHelper.setProcessMessage(handleMessage);
	    	ProcessStartCmd cmd=getProcessStartCmd(callMessage,subProcess);
	    	//启动流程
			bpmInst=bpmInstManager.doStartProcess(cmd);
			
    	}catch(Exception ex){
    		//把具体的错误放置在内部处理，以显示正确的错误信息提示，在此不作任何的错误处理
    		logger.error(ExceptionUtil.getExceptionMessage(ex));
    		if(handleMessage.getErrorMsges().size()==0){
    			handleMessage.addErrorMsg(ExceptionUtil.getExceptionMessage(ex));
    		}
    	}finally{
    		//在处理过程中，是否有错误的消息抛出
    		if(handleMessage.getErrorMsges().size()>0){
    			//记录出错信息
    			if(bpmInst!=null){
    				bpmInstManager.update(bpmInst);
    			}
    		}
    		ProcessHandleHelper.clearProcessMessage();
    	} 
    }
    
    private ProcessStartCmd getProcessStartCmd(BpmEventCallMessage callMessage,String solKey) throws Exception{
		ProcessStartCmd cmd=new ProcessStartCmd();
		String actInstId = callMessage.getActInstId();
		String mainSolId=(String)callMessage.getVars().get("solId");
		String jsonData=callMessage.getExecutionCmd().getJsonData();
		String solId="";
		if(StringUtils.isNotEmpty(solKey)){
			BpmSolution bpmSol=bpmSolutionManager.getByKey(solKey, ContextUtil.getCurrentTenantId());
			if(bpmSol!=null){
				solId=bpmSol.getSolId();
			}
		}
		if(StringUtil.isNotEmpty(actInstId)) {
			cmd.getVars().put("actInstId", actInstId);

		}
		if(StringUtil.isNotEmpty(mainSolId)) {
			cmd.getVars().put("mainSolId", mainSolId);
		}
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		JSONObject formData = new JSONObject();
		if(StringUtil.isNotEmpty(mainSolId)) {
			DataHolder dataHolder = new DataHolder();
			dataHolder.setCurMain(JSONObject.parseObject(jsonData).getJSONArray("bos").getJSONObject(0).getJSONObject("data"));
			BpmSolution mainBpmSolution=bpmSolutionManager.get(mainSolId);
			BpmNodeSet set = bpmNodeSetManager.getBySolIdActDefIdNodeId(mainSolId, mainBpmSolution.getActDefId(),ProcessConfig.PROCESS_NODE_ID);
			JsonNode jsonObject=objectMapper.readTree(set.getSettings());
			JsonNode configsNode=jsonObject.get("configs");
			Map<String,Object> configMap=JSONUtil.jsonNode2Map(configsNode);
			JSONArray ary = JSONArray.parseArray((String)configMap.get("bpmDefs"));
			for (Object object : ary) {
				JSONObject obj = (JSONObject) object;
				if (bpmSolution.getKey().equals(obj.getString("alias"))) {
					JSONObject data = obj.getJSONObject("config").getJSONObject("data");
					JSONArray array = data.getJSONArray("subList");
					for (int i = 0; i < array.size(); i++) {
						JSONObject json = array.getJSONObject(i);
						formData.putAll(bpmTableFormulaManager.getTableFieldValueHandler(dataHolder, json,false));
					}
					cmd.getVars().putAll(setVarData(obj.getJSONObject("config").getJSONArray("varData"),formData.toJSONString()));
				}
			}
		}
		

		cmd.setSolId(solId);
		if(StringUtils.isEmpty(jsonData)){
			jsonData="{}";
		}else {
			IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
    		List<FormModel> formModels= formHandler.getStartForm(solId, "", jsonData);
    		JSONObject cmdData=new JSONObject();
    		if( formModels!=null &&formModels.size()>0 ){
    			JSONArray boArr=new JSONArray();
    			for(FormModel fm:formModels){
    				JSONObject bo=new JSONObject();
    				bo.put("boDefId", fm.getBoDefId());
    				bo.put("formKey", fm.getFormKey());
    				bo.put("data", formData);
    				boArr.add(bo);
    			}
    			cmdData.put("bos", boArr);
    			jsonData = cmdData.toJSONString();
    		}
		}
		//转成json值，以在后续中使用
		cmd.setJsonData(jsonData);
    	return cmd;
	}
    
    private Map<String,Object> setVarData(JSONArray configVars,String jsonData) {
		Map<String,Object> vars = new HashMap<String,Object>();
		JSONObject params = JSONObject.parseObject(jsonData);
		for (Object obj : configVars) {
			JSONObject var = (JSONObject) obj;
			String formField=var.getString("formField");
			String key=var.getString("key");
			
			Object val=null;
			//优先从表单字段映射
			if(StringUtils.isNotEmpty(formField)){
				val= (Object) params.get(formField);
			}
			if(val==null) {
				val= (Object) params.get(key);	
			}
			if (val == null) {
				val=var.getString("defVal");
			}
			//防止全局变量没传值也会被清空
			if(val==null) continue;
			try {
				// 计算后的变量值
				Object exeVal = null;
				// 计算表达式以获得值
				if (StringUtils.isNotEmpty(var.getString("express"))) {
					exeVal = groovyEngine.executeScripts(var.getString("express"), null);
				} else if (BpmSolVar.TYPE_DATE.equals(var.getString("type"))) {// 直接从页面中获得值进行转化
					exeVal = DateUtil.parseDate((String)val);
				} else if (BpmSolVar.TYPE_NUMBER.equals(var.getString("type"))) {
					exeVal = new Double((String)val);
				} else {
					exeVal = val;
				}
				vars.put(var.getString("key"), exeVal);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
		}
		return vars;
	}

    @Override
    public String getHandlerType() {
        return BpmEventCallHandler.HANDLER_TYPE_SUBPROCESS;
    }

}
