package com.redxun.bpm.activiti.jms;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.bpm.core.manager.BpmHttpInvokeResultManager;
import com.redxun.bpm.core.manager.BpmHttpTaskManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.jms.IMessageHandler;
import com.redxun.core.json.JsonResult;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.webreq.manager.SysWebReqDefManager;

/**
 * 处理调用http请求消息。
 * @author ray
 *
 */
public class BpmHttpCallMessageHandler implements IMessageHandler{
    @Resource
    GroovyEngine groovyEngine;
    @Resource
    SysWebReqDefManager sysWebReqDefManager;
    @Resource
    BpmHttpTaskManager bpmHttpTaskManager;
    @Resource
    BpmHttpInvokeResultManager bpmHttpInvokeResultManager;


    @Override
    public void handMessage(Object messageObj) {
        BpmHttpCallMessage bpmHttpCallMessage=(BpmHttpCallMessage)messageObj;
        JSONObject setting = JSONObject.parseObject(bpmHttpCallMessage.getSetting());
        String script=setting.getString("script");
        String key=setting.getString("key");
        String paramsData=setting.getString("paramsData");
        Map<String,Object> params=bpmHttpCallMessage.getVariables();
      
        try{
        	JsonResult<String> jr = sysWebReqDefManager.executeStart(key, paramsData,params);
        	
            BpmHttpTask task=new BpmHttpTask();
            task.setId(IdUtil.getId());
            task.setKey(key);
            task.setParamsData(paramsData);
            task.setParams(FileUtil.objToBytes(params));

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
                params.put("data", jr.getData());
                groovyEngine.executeScripts(script, params);
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

}
