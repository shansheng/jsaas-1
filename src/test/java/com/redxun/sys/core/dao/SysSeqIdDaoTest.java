package com.redxun.sys.core.dao;

import com.redxun.sys.core.dao.SysSeqIdDao;
import com.redxun.sys.core.entity.SysSeqId;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：SysSeqId数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class SysSeqIdDaoTest extends BaseTestCase {

	@Resource
	private SysSeqIdDao sysSeqIdDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		SysSeqId sysSeqId1 = new SysSeqId();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		sysSeqId1.setName("Name" + randNo);
		sysSeqId1.setAlias("Alias" + randNo);
		sysSeqId1.setCurDate(new java.util.Date());
		sysSeqId1.setRule("Rule" + randNo);
		sysSeqId1.setInitVal(new Integer(randNo));
		sysSeqId1.setGenType("");
		sysSeqId1.setLen(new Integer(randNo));
		sysSeqId1.setCurVal(new Integer(randNo));
		sysSeqId1.setStep(new Short("1"));
		sysSeqId1.setMemo("Memo" + randNo);
		sysSeqId1.setTenantId("TenantId" + randNo);
		sysSeqId1.setCreateBy("CreateBy" + randNo);
		sysSeqId1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		sysSeqIdDao.create(sysSeqId1);

		sysSeqId1 = sysSeqIdDao.get(sysSeqId1.getSeqId());

		System.out.println(" sysSeqId1:" + sysSeqId1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		sysSeqId1.setName("Name" + randNo);
		sysSeqId1.setAlias("Alias" + randNo);
		sysSeqId1.setCurDate(new java.util.Date());
		sysSeqId1.setRule("Rule" + randNo);
		sysSeqId1.setInitVal(new Integer(randNo));
		sysSeqId1.setGenType("AUTO");
		sysSeqId1.setLen(new Integer(randNo));
		sysSeqId1.setCurVal(new Integer(randNo));
		sysSeqId1.setStep(new Short("1"));
		sysSeqId1.setMemo("Memo" + randNo);
		sysSeqId1.setTenantId("TenantId" + randNo);
		sysSeqId1.setCreateBy("CreateBy" + randNo);
		sysSeqId1.setUpdateBy("UpdateBy" + randNo);

		sysSeqIdDao.update(sysSeqId1);

		sysSeqId1 = sysSeqIdDao.get(sysSeqId1.getSeqId());

		System.out.println(" sysSeqId2:" + sysSeqId1.toString());

		sysSeqIdDao.delete(sysSeqId1.getSeqId());
	}
}