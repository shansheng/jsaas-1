package com.redxun.job;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;

import com.redxun.bpm.core.entity.BpmHttpInvokeResult;
import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.bpm.core.manager.BpmHttpInvokeResultManager;
import com.redxun.bpm.core.manager.BpmHttpTaskManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JsonResult;
import com.redxun.core.scheduler.BaseJob;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.webreq.manager.SysWebReqDefManager;


public class InvokeJob extends BaseJob {


    private GroovyEngine groovyEngine= WebAppUtil.getBean(GroovyEngine.class);
    private BpmHttpTaskManager bpmHttpTaskManager= WebAppUtil.getBean(BpmHttpTaskManager.class);
    private SysWebReqDefManager sysWebReqDefManager= WebAppUtil.getBean(SysWebReqDefManager.class);
    private BpmHttpInvokeResultManager bpmHttpInvokeResultManager= WebAppUtil.getBean(BpmHttpInvokeResultManager.class);


    @Override
    public void executeJob(JobExecutionContext context){
        //取得未完成的调用http任务
        List<BpmHttpTask> tasks= bpmHttpTaskManager.getUnfinishedTask();
        for (BpmHttpTask task:tasks){
            int times=task.getTimes();
            int invokeTimes=task.getInvokeTimes();
            if(times>invokeTimes+1)   continue;

            int period=task.getPeriod();
            Date createTime=task.getCreateTime();

            Date nowDate=new Date();
            if(createTime.getTime()+period*times>=nowDate.getTime()){
            	invokeTask(task);
            }
        }
    }

    private void invokeTask(BpmHttpTask task){
        String paramsData=task.getParamsData();
        byte [] bytes=task.getParams();

        JsonResult<String> jr =null;
        try{
        	Map<String, Object>  params = (Map<String, Object>) FileUtil.bytesToObject(bytes);
            jr= sysWebReqDefManager.executeStart(task.getKey(), paramsData,params);

            BpmHttpInvokeResult bpmHttpInvokeResult=new BpmHttpInvokeResult();

            if(!jr.getSuccess()) {
                bpmHttpInvokeResult.setContent(MBoolean.FALSE.name());
            }else {
                task.setResult(1);
                task.setFinish(1);
                bpmHttpInvokeResult.setContent(jr.getData());
                
                String script=task.getScript();
                if(StringUtil.isEmpty(script)) return;
                params.put("result", jr.getData());
                groovyEngine.executeScripts(script, params);
            }

            task.setTimes(task.getTimes()+1);
            if(task.getInvokeTimes()==task.getTimes()){
            	task.setFinish(1);
            }
            bpmHttpTaskManager.update(task);

            bpmHttpInvokeResult.setId(IdUtil.getId());
            bpmHttpInvokeResult.setTaskId(task.getId());
            bpmHttpInvokeResultManager.create(bpmHttpInvokeResult);

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
