package com.redxun.job;

import org.quartz.JobExecutionContext;

import com.redxun.bpm.script.SqlScript;
import com.redxun.core.scheduler.BaseJob;
import com.redxun.core.util.AppBeanUtil;

/**
 * 任务实例。
 * @author redxun
 *
 */
public class SampleJob extends BaseJob {

	@Override
	public void executeJob(JobExecutionContext context) {
		//String arg1=context.getJobDetail().getJobDataMap().getString("name");
		
		//System.err.println("hello " + arg1);
		SqlScript sqlScript=AppBeanUtil.getBean(SqlScript.class);
		System.out.println("ok");
	}

}
