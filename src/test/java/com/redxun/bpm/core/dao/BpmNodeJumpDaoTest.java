package com.redxun.bpm.core.dao;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.test.BaseTestCase;

/**
 * <pre>
 * 描述：BpmNodeJump数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmNodeJumpDaoTest extends BaseTestCase {
	@Resource
	private BpmNodeJumpDao bpmNodeJumpDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmNodeJump bpmNodeJump1 = new BpmNodeJump();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		
		bpmNodeJump1.setActDefId("ActDefId" + randNo);

		bpmNodeJump1.setActInstId("ActInstId" + randNo);
		bpmNodeJump1.setNodeName("NodeName" + randNo);
		bpmNodeJump1.setNodeId("NodeId" + randNo);
		bpmNodeJump1.setTaskId("TaskId" + randNo);
		bpmNodeJump1
				.setCompleteTime(new java.util.Date());
		bpmNodeJump1.setDuration(new Long(randNo));
		bpmNodeJump1.setDurationVal(new Integer(randNo));
		bpmNodeJump1.setHandlerId("HandlerId" + randNo);
		bpmNodeJump1.setCheckStatus("CheckStatus" + randNo);
		bpmNodeJump1.setJumpType("JumpType" + randNo);
		bpmNodeJump1.setRemark("Remark" + randNo);
		bpmNodeJump1.setTenantId("TenantId" + randNo);
		bpmNodeJump1.setCreateBy("CreateBy" + randNo);
		bpmNodeJump1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmNodeJumpDao.create(bpmNodeJump1);

		bpmNodeJump1 = bpmNodeJumpDao.get(bpmNodeJump1.getJumpId());

		System.out.println(" bpmNodeJump1:" + bpmNodeJump1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmNodeJump1.setActDefId("ActDefId" + randNo);
	
		bpmNodeJump1.setActInstId("ActInstId" + randNo);
		bpmNodeJump1.setNodeName("NodeName" + randNo);
		bpmNodeJump1.setNodeId("NodeId" + randNo);
		bpmNodeJump1.setTaskId("TaskId" + randNo);
		bpmNodeJump1
				.setCompleteTime(new java.util.Date());
		bpmNodeJump1.setDuration(new Long(randNo));
		bpmNodeJump1.setDurationVal(new Integer(randNo));
		bpmNodeJump1.setHandlerId("HandlerId" + randNo);
		bpmNodeJump1.setCheckStatus("CheckStatus" + randNo);
		bpmNodeJump1.setJumpType("JumpType" + randNo);
		bpmNodeJump1.setRemark("Remark" + randNo);
		bpmNodeJump1.setTenantId("TenantId" + randNo);
		bpmNodeJump1.setCreateBy("CreateBy" + randNo);
		bpmNodeJump1.setUpdateBy("UpdateBy" + randNo);

		bpmNodeJumpDao.update(bpmNodeJump1);

		bpmNodeJump1 = bpmNodeJumpDao.get(bpmNodeJump1.getJumpId());

		System.out.println(" bpmNodeJump2:" + bpmNodeJump1.toString());

		bpmNodeJumpDao.delete(bpmNodeJump1.getJumpId());
	}
}