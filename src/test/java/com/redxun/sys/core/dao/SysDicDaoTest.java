package com.redxun.sys.core.dao;

import com.redxun.sys.core.dao.SysDicDao;
import com.redxun.sys.core.entity.SysDic;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre>
 * 描述：SysDic数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class SysDicDaoTest extends BaseTestCase {

	@Resource
	private SysDicDao sysDicDao;

	@Transactional(readOnly = false)
	@Test
	public void crud() {
		SysDic sysDic1 = new SysDic();
		Integer randNo = new Double(100000 * Math.random()).intValue();

		sysDic1.setTypeId("TypeId" + randNo);
		sysDic1.setKey("Key" + randNo);
		sysDic1.setName("Name" + randNo);
		sysDic1.setValue("Value" + randNo);
		sysDic1.setDescp("Descp" + randNo);
		sysDic1.setSn(new Integer(randNo));
		sysDic1.setPath("Path" + randNo);
		sysDic1.setParentId("ParentId" + randNo);
		sysDic1.setTenantId("TenantId" + randNo);
		sysDic1.setCreateBy("CreateBy" + randNo);
		sysDic1.setUpdateBy("UpdateBy" + randNo);
		// 1.Create
		sysDicDao.create(sysDic1);

		sysDic1 = sysDicDao.get(sysDic1.getDicId());

		System.out.println(" sysDic1:" + sysDic1.toString());

		randNo = new Double(100000 * Math.random()).intValue();

		sysDic1.setTypeId("TypeId" + randNo);
		sysDic1.setKey("Key" + randNo);
		sysDic1.setName("Name" + randNo);
		sysDic1.setValue("Value" + randNo);
		sysDic1.setDescp("Descp" + randNo);
		sysDic1.setSn(new Integer(randNo));
		sysDic1.setPath("Path" + randNo);
		sysDic1.setParentId("ParentId" + randNo);
		sysDic1.setTenantId("TenantId" + randNo);
		sysDic1.setCreateBy("CreateBy" + randNo);
		sysDic1.setUpdateBy("UpdateBy" + randNo);

		sysDicDao.update(sysDic1);

		sysDic1 = sysDicDao.get(sysDic1.getDicId());

		System.out.println(" sysDic2:" + sysDic1.toString());

		sysDicDao.delete(sysDic1.getDicId());
	}
}