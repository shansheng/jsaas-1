package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmAgentDao;
import com.redxun.bpm.core.entity.BpmAgent;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 *  
 * 描述：BpmAgent数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmAgentDaoTest extends BaseTestCase {

	@Resource
	private BpmAgentDao bpmAgentDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmAgent bpmAgent1 = new BpmAgent();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmAgent1.setSubject("Subject" + randNo);
		bpmAgent1.setToUserId("ToUserId" + randNo);
		bpmAgent1.setAgentUserId("AgentUserId" + randNo);
		bpmAgent1.setStartTime(new java.util.Date());
		bpmAgent1.setEndTime(new java.util.Date());
		bpmAgent1.setType("Type" + randNo);
		bpmAgent1.setStatus("Status" + randNo);
		bpmAgent1.setDescp("Descp" + randNo);
		bpmAgent1.setTenantId("TenantId" + randNo);
		bpmAgent1.setCreateBy("CreateBy" + randNo);
		bpmAgent1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmAgentDao.create(bpmAgent1);

		bpmAgent1 = bpmAgentDao.get(bpmAgent1.getAgentId());

		System.out.println(" bpmAgent1:" + bpmAgent1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmAgent1.setSubject("Subject" + randNo);
		bpmAgent1.setToUserId("ToUserId" + randNo);
		bpmAgent1.setAgentUserId("AgentUserId" + randNo);
		bpmAgent1.setStartTime(new java.util.Date());
		bpmAgent1.setEndTime(new java.util.Date());
		bpmAgent1.setType("Type" + randNo);
		bpmAgent1.setStatus("Status" + randNo);
		bpmAgent1.setDescp("Descp" + randNo);
		bpmAgent1.setTenantId("TenantId" + randNo);
		bpmAgent1.setCreateBy("CreateBy" + randNo);
		bpmAgent1.setUpdateBy("UpdateBy" + randNo);

		bpmAgentDao.update(bpmAgent1);

		bpmAgent1 = bpmAgentDao.get(bpmAgent1.getAgentId());

		System.out.println(" bpmAgent2:" + bpmAgent1.toString());

		bpmAgentDao.delete(bpmAgent1.getAgentId());
	}
}