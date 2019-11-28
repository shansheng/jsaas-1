//package com.redxun.job.core.dao;
//
//import com.redxun.job.core.dao.SysQuartzJobDao;
//import com.redxun.job.core.entity.SysQuartzJob;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre>
// * 描述：SysQuartzJob数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class SysQuartzJobDaoTest extends BaseTestCase {
//
//	@Resource
//	private SysQuartzJobDao sysQuartzJobDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		SysQuartzJob sysQuartzJob1 = new SysQuartzJob();
//		Integer randNo = new Double(100000 * Math.random()).intValue();
//
//		sysQuartzJob1.setAlias("Alias" + randNo);
//		sysQuartzJob1.setJobName("JobName" + randNo);
//		sysQuartzJob1.setJobClass("JobClass" + randNo);
//		sysQuartzJob1.setTriggerName("TriggerName" + randNo);
//		sysQuartzJob1.setCronExpression("CronExpression" + randNo);
//		sysQuartzJob1.setDescp("Descp" + randNo);
//		sysQuartzJob1.setParams("Params" + randNo);
//		sysQuartzJob1.setStatus("Stautus" + randNo);
//		sysQuartzJob1.setInterval(new Long(randNo));
//		sysQuartzJob1.setCountRepeat(new Integer(randNo));
//		sysQuartzJob1.setStartTime(new java.util.Date("StartTime" + randNo));
//		sysQuartzJob1.setCronType(new Integer(randNo));
//		sysQuartzJob1.setSecond("Second" + randNo);
//		sysQuartzJob1.setMinute("Minute" + randNo);
//		sysQuartzJob1.setHour("Hour" + randNo);
//		sysQuartzJob1.setWeek("Week" + randNo);
//		sysQuartzJob1.setDay("Day" + randNo);
//		sysQuartzJob1.setMonth("Month" + randNo);
//		sysQuartzJob1.setYear("Year" + randNo);
//		sysQuartzJob1.setTenantId("TenantId" + randNo);
//		sysQuartzJob1.setCreateBy("CreateBy" + randNo);
//		sysQuartzJob1.setUpdateBy("UpdateBy" + randNo);
//		// 1.Create
//		sysQuartzJobDao.create(sysQuartzJob1);
//
//		sysQuartzJob1 = sysQuartzJobDao.get(sysQuartzJob1.getJobId());
//
//		System.out.println(" sysQuartzJob1:" + sysQuartzJob1.toString());
//
//		randNo = new Double(100000 * Math.random()).intValue();
//
//		sysQuartzJob1.setAlias("Alias" + randNo);
//		sysQuartzJob1.setJobName("JobName" + randNo);
//		sysQuartzJob1.setJobClass("JobClass" + randNo);
//		sysQuartzJob1.setTriggerName("TriggerName" + randNo);
//		sysQuartzJob1.setCronExpression("CronExpression" + randNo);
//		sysQuartzJob1.setDescp("Descp" + randNo);
//		sysQuartzJob1.setParams("Params" + randNo);
//		sysQuartzJob1.setStatus("Stautus" + randNo);
//		sysQuartzJob1.setInterval(new Long(randNo));
//		sysQuartzJob1.setCountRepeat(new Integer(randNo));
//		sysQuartzJob1.setStartTime(new java.util.Date("StartTime" + randNo));
//		sysQuartzJob1.setCronType(new Integer(randNo));
//		sysQuartzJob1.setSecond("Second" + randNo);
//		sysQuartzJob1.setMinute("Minute" + randNo);
//		sysQuartzJob1.setHour("Hour" + randNo);
//		sysQuartzJob1.setWeek("Week" + randNo);
//		sysQuartzJob1.setDay("Day" + randNo);
//		sysQuartzJob1.setMonth("Month" + randNo);
//		sysQuartzJob1.setYear("Year" + randNo);
//		sysQuartzJob1.setTenantId("TenantId" + randNo);
//		sysQuartzJob1.setCreateBy("CreateBy" + randNo);
//		sysQuartzJob1.setUpdateBy("UpdateBy" + randNo);
//
//		sysQuartzJobDao.update(sysQuartzJob1);
//
//		sysQuartzJob1 = sysQuartzJobDao.get(sysQuartzJob1.getJobId());
//
//		System.out.println(" sysQuartzJob2:" + sysQuartzJob1.toString());
//
//		sysQuartzJobDao.delete(sysQuartzJob1.getJobId());
//	}
//}