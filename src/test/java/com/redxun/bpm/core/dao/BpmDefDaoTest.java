package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmDefDao;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：BpmDef数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmDefDaoTest extends BaseTestCase {

	@Resource
	private BpmDefDao bpmDefDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		BpmDef bpmDef1 = new BpmDef();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		bpmDef1.setSubject("Subject" + randNo);
		bpmDef1.setDescp("Descp" + randNo);
		bpmDef1.setKey("Key" + randNo);
		bpmDef1.setActDefId("ActDefId" + randNo);
		bpmDef1.setActDepId("ActDepId" + randNo);
		
		bpmDef1.setStatus("Status" + randNo);
		bpmDef1.setVersion(new Integer(randNo));
		bpmDef1.setIsMain("IsMain" + randNo);
		bpmDef1.setSetting("Setting" + randNo);
		bpmDef1.setModelId("ModelId" + randNo);
		bpmDef1.setMainDefId("MainDefId" + randNo);
		bpmDef1.setTenantId("TenantId" + randNo);
		bpmDef1.setCreateBy("CreateBy" + randNo);
		bpmDef1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		bpmDefDao.create(bpmDef1);

		bpmDef1 = bpmDefDao.get(bpmDef1.getDefId());

		System.out.println(" bpmDef1:" + bpmDef1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		bpmDef1.setSubject("Subject" + randNo);
		bpmDef1.setDescp("Descp" + randNo);
		bpmDef1.setKey("Key" + randNo);
		bpmDef1.setActDefId("ActDefId" + randNo);
		bpmDef1.setActDepId("ActDepId" + randNo);

		bpmDef1.setStatus("Status" + randNo);
		bpmDef1.setVersion(new Integer(randNo));
		bpmDef1.setIsMain("IsMain" + randNo);
		bpmDef1.setSetting("Setting" + randNo);
		bpmDef1.setModelId("ModelId" + randNo);
		bpmDef1.setMainDefId("MainDefId" + randNo);
		bpmDef1.setTenantId("TenantId" + randNo);
		bpmDef1.setCreateBy("CreateBy" + randNo);
		bpmDef1.setUpdateBy("UpdateBy" + randNo);

		bpmDefDao.update(bpmDef1);

		bpmDef1 = bpmDefDao.get(bpmDef1.getDefId());

		System.out.println(" bpmDef2:" + bpmDef1.toString());

		bpmDefDao.delete(bpmDef1.getDefId());
	}
}