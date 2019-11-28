//package com.redxun.sys.core.dao;
//
//import javax.annotation.Resource;
//
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.redxun.sys.db.dao.SysDatasourceDao;
//import com.redxun.sys.db.entity.SysDatasource;
//import com.redxun.test.BaseTestCase;
//
///**
// * <pre>
// * 描述：SysDatasource数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class SysDatasourceDaoTest extends BaseTestCase {
//
//	@Resource
//	private SysDataSourceDao sysDatasourceDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		SysDataSourceDao sysDatasource1 = new SysDataSourceDao();
//		Integer randNo = new Double(100000 * Math.random()).intValue();
//
//		sysDatasource1.setName("Name" + randNo);
//		sysDatasource1.setKey("Key" + randNo);
//		sysDatasource1.setDriver("Driver" + randNo);
//		sysDatasource1.setUrl("Url" + randNo);
//		sysDatasource1.setUser("User" + randNo);
//		sysDatasource1.setPwd("Pwd" + randNo);
//		sysDatasource1.setDbType("DbType" + randNo);
//		// 1.Create
//		sysDatasourceDao.create(sysDatasource1);
//
//		sysDatasource1 = sysDatasourceDao.get(sysDatasource1.getSourceId());
//
//		System.out.println(" sysDatasource1:" + sysDatasource1.toString());
//
//		randNo = new Double(100000 * Math.random()).intValue();
//
//		sysDatasource1.setName("Name" + randNo);
//		sysDatasource1.setKey("Key" + randNo);
//		sysDatasource1.setDriver("Driver" + randNo);
//		sysDatasource1.setUrl("Url" + randNo);
//		sysDatasource1.setUser("User" + randNo);
//		sysDatasource1.setPwd("Pwd" + randNo);
//		sysDatasource1.setDbType("DbType" + randNo);
//
//		sysDatasourceDao.update(sysDatasource1);
//
//		sysDatasource1 = sysDatasourceDao.get(sysDatasource1.getSourceId());
//
//		System.out.println(" sysDatasource2:" + sysDatasource1.toString());
//
//		sysDatasourceDao.delete(sysDatasource1.getSourceId());
//	}
//}