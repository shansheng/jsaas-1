//package com.redxun.wx.ent.dao;
//
//import com.redxun.wx.ent.dao.WxEntUserDao;
//import com.redxun.wx.ent.entity.WxEntUser;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre>
// * 描述：WxEntUser数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class WxEntUserDaoTest extends BaseTestCase {
//
//	@Resource
//	private WxEntUserDao WxEntUserDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		WxEntUser WxEntUser1 = new WxEntUser();
//		Integer randNo = new Double(100000 * Math.random()).intValue();
//
//		WxEntUser1.setUserId("UserId" + randNo);
//		WxEntUser1.setWeixinId("WeixinId" + randNo);
//		WxEntUser1.setTenantId("TenantId" + randNo);
//		WxEntUser1.setUpdateBy("UpdateBy" + randNo);
//		WxEntUser1.setCreateBy("CreateBy" + randNo);
//		WxEntUser1.setStatus(new Integer(randNo));
//		// 1.Create
//		WxEntUserDao.create(WxEntUser1);
//
//		//WxEntUser1 = WxEntUserDao.get(WxEntUser1.getMsgId());
//
//		System.out.println(" WxEntUser1:" + WxEntUser1.toString());
//
//		randNo = new Double(100000 * Math.random()).intValue();
//
//		WxEntUser1.setUserId("UserId" + randNo);
//		WxEntUser1.setWeixinId("WeixinId" + randNo);
//		WxEntUser1.setTenantId("TenantId" + randNo);
//		WxEntUser1.setUpdateBy("UpdateBy" + randNo);
//		WxEntUser1.setCreateBy("CreateBy" + randNo);
//		WxEntUser1.setStatus(new Integer(randNo));
//
//		WxEntUserDao.update(WxEntUser1);
//
//		///WxEntUser1 = WxEntUserDao.get(WxEntUser1.getMsgId());
//
//		System.out.println(" WxEntUser2:" + WxEntUser1.toString());
//
//		//WxEntUserDao.delete(WxEntUser1.getMsgId());
//	}
//}