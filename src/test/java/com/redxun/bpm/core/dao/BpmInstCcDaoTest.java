package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmInstCcDao;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：BpmInstCc数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmInstCcDaoTest extends BaseTestCase {

	@Resource
	private BpmInstCcDao bpmInstCcDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmInstCc bpmInstCc1 = new BpmInstCc();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmInstCc1.setInstId("InstId" + randNo);
		bpmInstCc1.setSubject("Subject" + randNo);
		bpmInstCc1.setNodeId("NodeId" + randNo);
		bpmInstCc1.setNodeName("NodeName" + randNo);
		bpmInstCc1.setFromUserId("FromUserId" + randNo);
		bpmInstCc1.setTenantId("TenantId" + randNo);
		bpmInstCc1.setCreateBy("CreateBy" + randNo);
		bpmInstCc1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmInstCcDao.create(bpmInstCc1);

		bpmInstCc1 = bpmInstCcDao.get(bpmInstCc1.getCcId());

		System.out.println(" bpmInstCc1:" + bpmInstCc1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmInstCc1.setInstId("InstId" + randNo);
		bpmInstCc1.setSubject("Subject" + randNo);
		bpmInstCc1.setNodeId("NodeId" + randNo);
		bpmInstCc1.setNodeName("NodeName" + randNo);
		bpmInstCc1.setFromUserId("FromUserId" + randNo);
		bpmInstCc1.setTenantId("TenantId" + randNo);
		bpmInstCc1.setCreateBy("CreateBy" + randNo);
		bpmInstCc1.setUpdateBy("UpdateBy" + randNo);

		bpmInstCcDao.update(bpmInstCc1);

		bpmInstCc1 = bpmInstCcDao.get(bpmInstCc1.getCcId());

		System.out.println(" bpmInstCc2:" + bpmInstCc1.toString());

		bpmInstCcDao.delete(bpmInstCc1.getCcId());
	}
}