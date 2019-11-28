//package com.redxun.job.core.dao;
//
//import com.redxun.job.core.dao.SysQuartzLogDao;
//import com.redxun.job.core.entity.SysQuartzLog;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre>
// * 描述：SysQuartzLog数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class SysQuartzLogDaoTest extends BaseTestCase {
//
//	@Resource
//	private SysQuartzLogDao sysQuartzLogDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		SysQuartzLog sysQuartzLog1 = new SysQuartzLog();
//		Integer randNo = new Double(100000 * Math.random()).intValue();
//
//		sysQuartzLog1.setAlias("Alias" + randNo);
//		sysQuartzLog1.setJobName("JobName" + randNo);
//		sysQuartzLog1.setTriggerName("TriggerName" + randNo);
//		sysQuartzLog1.setContent("Content" + randNo);
//		sysQuartzLog1.setStartTime(new java.util.Date("StartTime" + randNo));
//		sysQuartzLog1.setEndTime(new java.util.Date("EndTime" + randNo));
//		sysQuartzLog1.setRunTime(new Long(randNo));
//		sysQuartzLog1.setStatus("Stautus" + randNo);
//		sysQuartzLog1.setTenantId("TenantId" + randNo);
//		sysQuartzLog1.setCreateBy("CreateBy" + randNo);
//		sysQuartzLog1.setUpdateBy("UpdateBy" + randNo);
//		// 1.Create
//		sysQuartzLogDao.create(sysQuartzLog1);
//
//		sysQuartzLog1 = sysQuartzLogDao.get(sysQuartzLog1.getLogId());
//
//		System.out.println(" sysQuartzLog1:" + sysQuartzLog1.toString());
//
//		randNo = new Double(100000 * Math.random()).intValue();
//
//		sysQuartzLog1.setAlias("Alias" + randNo);
//		sysQuartzLog1.setJobName("JobName" + randNo);
//		sysQuartzLog1.setTriggerName("TriggerName" + randNo);
//		sysQuartzLog1.setContent("Content" + randNo);
//		sysQuartzLog1.setStartTime(new java.util.Date("StartTime" + randNo));
//		sysQuartzLog1.setEndTime(new java.util.Date("EndTime" + randNo));
//		sysQuartzLog1.setRunTime(new Long(randNo));
//		sysQuartzLog1.setStatus("Stautus" + randNo);
//		sysQuartzLog1.setTenantId("TenantId" + randNo);
//		sysQuartzLog1.setCreateBy("CreateBy" + randNo);
//		sysQuartzLog1.setUpdateBy("UpdateBy" + randNo);
//
//		sysQuartzLogDao.update(sysQuartzLog1);
//
//		sysQuartzLog1 = sysQuartzLogDao.get(sysQuartzLog1.getLogId());
//
//		System.out.println(" sysQuartzLog2:" + sysQuartzLog1.toString());
//
//		sysQuartzLogDao.delete(sysQuartzLog1.getLogId());
//	}
//}