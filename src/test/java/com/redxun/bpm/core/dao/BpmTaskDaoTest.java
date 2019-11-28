package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmTaskDao;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：BpmTask数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmTaskDaoTest extends BaseTestCase {

	@Resource
	private BpmTaskDao bpmTaskDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmTask bpmTask1 = new BpmTask();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmTask1.setRev(new Integer(randNo));
		bpmTask1.setExecutionId("ExecutionId" + randNo);
		bpmTask1.setProcInstId("ProcInstId" + randNo);
		bpmTask1.setProcDefId("ProcDefId" + randNo);
		bpmTask1.setName("Name" + randNo);
		bpmTask1.setParentTaskId("ParentTaskId" + randNo);
		bpmTask1.setDescription("Description" + randNo);
		bpmTask1.setTaskDefKey("TaskDefKey" + randNo);
		bpmTask1.setOwner("Owner" + randNo);
		bpmTask1.setAssignee("Assignee" + randNo);
		bpmTask1.setDelegation("Delegation" + randNo);
		bpmTask1.setPriority(new Integer(randNo));
		bpmTask1.setDueDate(new java.util.Date());
		bpmTask1.setCategory("Category" + randNo);
		bpmTask1.setSuspensionState(new Integer(randNo));
		bpmTask1.setTenantId("TenantId" + randNo);
		bpmTask1.setFormKey("FormKey" + randNo);
		// 1.Create
		bpmTaskDao.create(bpmTask1);

		bpmTask1 = bpmTaskDao.get(bpmTask1.getId());

		System.out.println(" bpmTask1:" + bpmTask1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmTask1.setRev(new Integer(randNo));
		bpmTask1.setExecutionId("ExecutionId" + randNo);
		bpmTask1.setProcInstId("ProcInstId" + randNo);
		bpmTask1.setProcDefId("ProcDefId" + randNo);
		bpmTask1.setName("Name" + randNo);
		bpmTask1.setParentTaskId("ParentTaskId" + randNo);
		bpmTask1.setDescription("Description" + randNo);
		bpmTask1.setTaskDefKey("TaskDefKey" + randNo);
		bpmTask1.setOwner("Owner" + randNo);
		bpmTask1.setAssignee("Assignee" + randNo);
		bpmTask1.setDelegation("Delegation" + randNo);
		bpmTask1.setPriority(new Integer(randNo));
		bpmTask1.setDueDate(new java.util.Date());
		bpmTask1.setCategory("Category" + randNo);
		bpmTask1.setSuspensionState(new Integer(randNo));
		bpmTask1.setTenantId("TenantId" + randNo);
		bpmTask1.setFormKey("FormKey" + randNo);

		bpmTaskDao.update(bpmTask1);

		bpmTask1 = bpmTaskDao.get(bpmTask1.getId());

		System.out.println(" bpmTask2:" + bpmTask1.toString());

		bpmTaskDao.delete(bpmTask1.getId());
	}
}