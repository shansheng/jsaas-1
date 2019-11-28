//package com.redxun.wx.ent.dao;
//
//import com.redxun.wx.ent.dao.WxEntMenuDao;
//import com.redxun.wx.ent.entity.WxEntMenu;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre>
// * 描述：WxEntMenu数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class WxEntMenuDaoTest extends BaseTestCase {
//
//	@Resource
//	private WxEntMenuDao WxEntMenuDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		WxEntMenu WxEntMenu1 = new WxEntMenu();
//		Integer randNo = new Double(100000 * Math.random()).intValue();
//
//		WxEntMenu1.setAgentId("AgentId" + randNo);
//		WxEntMenu1.setName("Name" + randNo);
//		WxEntMenu1.setKey("Key" + randNo);
//		WxEntMenu1.setParentId("ParentId" + randNo);
//		WxEntMenu1.setSn(new Integer(randNo));
//		WxEntMenu1.setUrl("Url" + randNo);
//		WxEntMenu1.setType("Type" + randNo);
//		WxEntMenu1.setTreeCode("TreeCode" + randNo);
//		WxEntMenu1.setTenantId("TenantId" + randNo);
//		WxEntMenu1.setCreateBy("CreateBy" + randNo);
//		WxEntMenu1.setUpdateBy("UpdateBy" + randNo);
//		WxEntMenu1.setPath("Path" + randNo);
//		WxEntMenu1.setChilds(new Integer(randNo));
//	
//		WxEntMenu1.setIsMgr("IsMgr" + randNo);
//		// 1.Create
//		WxEntMenuDao.create(WxEntMenu1);
//
//		WxEntMenu1 = WxEntMenuDao.get(WxEntMenu1.getMenuId());
//
//		System.out.println(" WxEntMenu1:" + WxEntMenu1.toString());
//
//		randNo = new Double(100000 * Math.random()).intValue();
//
//		WxEntMenu1.setAgentId("AgentId" + randNo);
//		WxEntMenu1.setName("Name" + randNo);
//		WxEntMenu1.setKey("Key" + randNo);
//		WxEntMenu1.setParentId("ParentId" + randNo);
//		WxEntMenu1.setSn(new Integer(randNo));
//		WxEntMenu1.setUrl("Url" + randNo);
//		WxEntMenu1.setType("Type" + randNo);
//		WxEntMenu1.setTreeCode("TreeCode" + randNo);
//		WxEntMenu1.setTenantId("TenantId" + randNo);
//		WxEntMenu1.setCreateBy("CreateBy" + randNo);
//		WxEntMenu1.setUpdateBy("UpdateBy" + randNo);
//		WxEntMenu1.setPath("Path" + randNo);
//		WxEntMenu1.setChilds(new Integer(randNo));
//		
//		WxEntMenu1.setIsMgr("IsMgr" + randNo);
//
//		WxEntMenuDao.update(WxEntMenu1);
//
//		WxEntMenu1 = WxEntMenuDao.get(WxEntMenu1.getMenuId());
//
//		System.out.println(" WxEntMenu2:" + WxEntMenu1.toString());
//
//		WxEntMenuDao.delete(WxEntMenu1.getMenuId());
//	}
//}