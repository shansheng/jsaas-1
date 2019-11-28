package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：BpmSolution数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSolutionDaoTest extends BaseTestCase {

	@Resource
	private BpmSolutionDao bpmSolutionDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmSolution bpmSolution1 = new BpmSolution();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmSolution1.setTreeId("TreeId" + randNo);
		bpmSolution1.setName("Name" + randNo);
		bpmSolution1.setKey("Key" + randNo);
		bpmSolution1.setDefKey("DefKey" + randNo);
		bpmSolution1.setDescp("Descp" + randNo);
		bpmSolution1.setStatus("Status" + randNo);
		bpmSolution1.setHelpId("HelpId" + randNo);
		bpmSolution1.setTenantId("TenantId" + randNo);
		bpmSolution1.setCreateBy("CreateBy" + randNo);
		bpmSolution1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmSolutionDao.create(bpmSolution1);

		bpmSolution1 = bpmSolutionDao.get(bpmSolution1.getSolId());

		System.out.println(" bpmSolution1:" + bpmSolution1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmSolution1.setTreeId("TreeId" + randNo);
		bpmSolution1.setName("Name" + randNo);
		bpmSolution1.setKey("Key" + randNo);
		bpmSolution1.setDefKey("DefKey" + randNo);
		bpmSolution1.setDescp("Descp" + randNo);
		bpmSolution1.setStatus("Status" + randNo);
		bpmSolution1.setHelpId("HelpId" + randNo);
		bpmSolution1.setTenantId("TenantId" + randNo);
		bpmSolution1.setCreateBy("CreateBy" + randNo);
		bpmSolution1.setUpdateBy("UpdateBy" + randNo);

		bpmSolutionDao.update(bpmSolution1);

		bpmSolution1 = bpmSolutionDao.get(bpmSolution1.getSolId());

		System.out.println(" bpmSolution2:" + bpmSolution1.toString());

		bpmSolutionDao.delete(bpmSolution1.getSolId());
	}
}