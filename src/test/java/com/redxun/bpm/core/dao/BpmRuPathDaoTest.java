package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmRuPathDao;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：BpmRuPath数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmRuPathDaoTest extends BaseTestCase {

	@Resource
	private BpmRuPathDao bpmRuPathDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmRuPath bpmRuPath1 = new BpmRuPath();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmRuPath1.setInstId("InstId" + randNo);
		bpmRuPath1.setActDefId("ActDefId" + randNo);
		bpmRuPath1.setActInstId("ActInstId" + randNo);
		bpmRuPath1.setSolId("SolId" + randNo);
		bpmRuPath1.setNodeId("NodeId" + randNo);
		bpmRuPath1.setNodeName("NodeName" + randNo);
		bpmRuPath1.setNodeType("NodeType" + randNo);
		bpmRuPath1.setStartTime(new java.util.Date());
		bpmRuPath1.setEndTime(new java.util.Date());
		bpmRuPath1.setDuration(new Long(randNo));
		bpmRuPath1.setDurationVal(new Long(randNo));
		bpmRuPath1.setAssignee("Assignee" + randNo);
		bpmRuPath1.setToUserId("ToUserId" + randNo);
		bpmRuPath1.setIsMultiple("IsMultiple" + randNo);
		bpmRuPath1.setExecutionId("ExecutionId" + randNo);
		bpmRuPath1.setUserIds("UserIds" + randNo);
		bpmRuPath1.setParentId("ParentId" + randNo);
		bpmRuPath1.setLevel(new Integer(randNo));
		bpmRuPath1.setOutTranId("OutTranId" + randNo);
		bpmRuPath1.setToken("Token" + randNo);
		bpmRuPath1.setJumpType("JumpType" + randNo);
		bpmRuPath1.setOpinion("Opinion" + randNo);
		bpmRuPath1.setRefPathId("RefPathId" + randNo);
		// 1.Create
		bpmRuPathDao.create(bpmRuPath1);

		bpmRuPath1 = bpmRuPathDao.get(bpmRuPath1.getPathId());

		System.out.println(" bpmRuPath1:" + bpmRuPath1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmRuPath1.setInstId("InstId" + randNo);
		bpmRuPath1.setActDefId("ActDefId" + randNo);
		bpmRuPath1.setActInstId("ActInstId" + randNo);
		bpmRuPath1.setSolId("SolId" + randNo);
		bpmRuPath1.setNodeId("NodeId" + randNo);
		bpmRuPath1.setNodeName("NodeName" + randNo);
		bpmRuPath1.setNodeType("NodeType" + randNo);
		bpmRuPath1.setStartTime(new java.util.Date());
		bpmRuPath1.setEndTime(new java.util.Date());
		bpmRuPath1.setDuration(new Long(randNo));
		bpmRuPath1.setDurationVal(new Long(randNo));
		bpmRuPath1.setAssignee("Assignee" + randNo);
		bpmRuPath1.setToUserId("ToUserId" + randNo);
		bpmRuPath1.setIsMultiple("IsMultiple" + randNo);
		bpmRuPath1.setExecutionId("ExecutionId" + randNo);
		bpmRuPath1.setUserIds("UserIds" + randNo);
		bpmRuPath1.setParentId("ParentId" + randNo);
		bpmRuPath1.setLevel(new Integer(randNo));
		bpmRuPath1.setOutTranId("OutTranId" + randNo);
		bpmRuPath1.setToken("Token" + randNo);
		bpmRuPath1.setJumpType("JumpType" + randNo);
		bpmRuPath1.setOpinion("Opinion" + randNo);
		bpmRuPath1.setRefPathId("RefPathId" + randNo);

		bpmRuPathDao.update(bpmRuPath1);

		bpmRuPath1 = bpmRuPathDao.get(bpmRuPath1.getPathId());

		System.out.println(" bpmRuPath2:" + bpmRuPath1.toString());

		bpmRuPathDao.delete(bpmRuPath1.getPathId());
	}
}