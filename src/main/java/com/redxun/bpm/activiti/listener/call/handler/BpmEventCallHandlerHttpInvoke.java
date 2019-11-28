package com.redxun.bpm.activiti.listener.call.handler;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmHttpInvokeResultManager;
import com.redxun.bpm.core.manager.BpmHttpTaskManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.webreq.manager.SysWebReqDefManager;
/**
 * 流程事件配置，HTTP请求服务调用
 * @author mansan
 *
 */
public class BpmEventCallHandlerHttpInvoke extends AbstractBpmEventCallHandler{
    @Resource
    GroovyEngine groovyEngine;
    @Resource
    SysWebReqDefManager sysWebReqDefManager;
    @Resource
    BpmHttpTaskManager bpmHttpTaskManager;
    @Resource
    BpmHttpInvokeResultManager bpmHttpInvokeResultManager;


    @Override
    public void handle(BpmEventCallMessage callMessage){
        BpmEventCallSetting eventSetting= callMessage.getBpmEventCallSetting();
        logger.debug("===============enter BpmEventCallHandlerHttpInvoke handle method=============== ");
        String set=eventSetting.getScript();
        if(StringUtils.isEmpty(set)) return;
        JSONObject setting = JSONObject.parseObject(set);
        String script=setting.getString("script");
        String key=setting.getString("key");
        String paramsData=setting.getString("paramsData");
        IExecutionCmd cmd=callMessage.getExecutionCmd();
        Map<String,Object> params=new HashMap<>();
        params.put("bpmParam",getRunVariables(callMessage));
        params.put("actInstId",callMessage.getActInstId());
        if(cmd.getJsonDataObject()!=null){
            Map<String,Object> map =BoDataUtil.getModelFieldsFromBoJsons(cmd.getJsonDataObject());
            params.put("formParam",map);
        }

        JsonResult<String> jr =null;
        try{
            if(logger.isDebugEnabled()){
                logger.debug("call web request============="+key + "params:"+params.toString());
            }
            jr= sysWebReqDefManager.executeStart(key, paramsData,params);
            BpmHttpTask task=new BpmHttpTask();
            task.setId(IdUtil.getId());
            task.setKey(key);
            task.setParamsData(paramsData);

            byte[] b =FileUtil.objToBytes(params);
            task.setParams(b);

            int times=setting.getIntValue("times")<=0?0:setting.getIntValue("times");
            task.setInvokeTimes(times);

            int period=setting.getIntValue("period")<=0?0:setting.getIntValue("period");
            task.setPeriod(period);

            BpmHttpInvokeResult bpmHttpInvokeResult=new BpmHttpInvokeResult();
            if(!jr.getSuccess()) {
                task.setResult(0);
                task.setFinish(0);
                bpmHttpInvokeResult.setContent(jr.getData());
                task.setScript(script);
            }else {
                task.setResult(1);
                task.setFinish(1);
                bpmHttpInvokeResult.setContent(jr.getData());
                if(StringUtil.isEmpty(script)) return;
                params.put("result", jr.getData());
                try{
                    groovyEngine.executeScripts(script, params);
                }catch(Exception e){
                    e.printStackTrace();
                    throw new RuntimeException("执行调用Web服务后的脚本：（"+script+",参数："+params.toString()+"），出错原因："+e.getMessage());
                }
            }

            task.setTimes(1);

            bpmHttpTaskManager.create(task);

            bpmHttpInvokeResult.setId(IdUtil.getId());
            bpmHttpInvokeResult.setTaskId(task.getId());
            bpmHttpInvokeResultManager.create(bpmHttpInvokeResult);

        }catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException("执行Web请求（"+"）调用出现异常："+e.getMessage());
        }


    }

    @Override
    public String getHandlerType() {
        return BpmEventCallHandler.HANDLER_TYPE_HTTPINVOKE;
    }

}
