package com.redxun.bpm.core.dao;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.test.BaseTestCase;

/**
 * <pre>
 * 描述：BpmInst数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmInstDaoTest extends BaseTestCase {

	@Resource
	private BpmInstDao bpmInstDao;
	
	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmInst bpmInst1 = new BpmInst();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmInst1.setDefId("DefId" + randNo);
		bpmInst1.setActInstId("ActInstId" + randNo);
		bpmInst1.setActDefId("ActDefId" + randNo);
		bpmInst1.setSolId("SolId" + randNo);
		bpmInst1.setSubject("Subject" + randNo);
		bpmInst1.setStatus("Status" + randNo);
		bpmInst1.setVersion(new Integer(randNo));
		bpmInst1.setBusKey("BusKey" + randNo);
		bpmInst1.setIsTest("IsTest" + randNo);
		bpmInst1.setEndTime(new java.util.Date());
		bpmInst1.setTenantId("TenantId" + randNo);
		bpmInst1.setCreateBy("CreateBy" + randNo);
		bpmInst1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmInstDao.create(bpmInst1);

		bpmInst1 = bpmInstDao.get(bpmInst1.getInstId());

		System.out.println(" bpmInst1:" + bpmInst1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmInst1.setDefId("DefId" + randNo);
		bpmInst1.setActInstId("ActInstId" + randNo);
		bpmInst1.setActDefId("ActDefId" + randNo);
		bpmInst1.setSolId("SolId" + randNo);
		bpmInst1.setSubject("Subject" + randNo);
		bpmInst1.setStatus("Status" + randNo);
		bpmInst1.setVersion(new Integer(randNo));
		bpmInst1.setBusKey("BusKey" + randNo);
		bpmInst1.setIsTest("IsTest" + randNo);
		bpmInst1.setEndTime(new java.util.Date());
		bpmInst1.setTenantId("TenantId" + randNo);
		bpmInst1.setCreateBy("CreateBy" + randNo);
		bpmInst1.setUpdateBy("UpdateBy" + randNo);

		bpmInstDao.update(bpmInst1);

		bpmInst1 = bpmInstDao.get(bpmInst1.getInstId());

		System.out.println(" bpmInst2:" + bpmInst1.toString());

		bpmInstDao.delete(bpmInst1.getInstId());
	}
}