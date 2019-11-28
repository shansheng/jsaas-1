//package com.redxun.wx.ent.dao;
//
//import com.redxun.wx.ent.dao.WxEntConfigDao;
//import com.redxun.wx.ent.entity.WxEntConfig;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre> 
// * 描述：WxEntConfig数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class WxEntConfigDaoTest extends BaseTestCase {
//
//    @Resource
//    private WxEntConfigDao WxEntConfigDao;
//
//    @Transactional(readOnly = false)
//    @Test
//    public void crud() {
//        WxEntConfig WxEntConfig1 = new WxEntConfig();
//        Integer randNo = new Double(100000 * Math.random()).intValue();
//        
//																					WxEntConfig1.setTenantNameCn("TenantNameCn"+randNo);
//																							WxEntConfig1.setAppToken("AppToken"+randNo);
//																							WxEntConfig1.setCorpId("CorpId"+randNo);
//																							WxEntConfig1.setCorpSecret("CorpSecret"+randNo);
//																							WxEntConfig1.setAccessToken("AccessToken"+randNo);
//																							WxEntConfig1.setExpiresIn("ExpiresIn"+randNo);
//																							WxEntConfig1.setExpiresTime(new Long(randNo));
//																							WxEntConfig1.setTenantId("TenantId"+randNo);
//																							WxEntConfig1.setCreateBy("CreateBy"+randNo);
//																																					WxEntConfig1.setUpdateBy("UpdateBy"+randNo);
//																								        //1.Create
//        WxEntConfigDao.create(WxEntConfig1);
//        
//        WxEntConfig1=WxEntConfigDao.get(WxEntConfig1.getConfigId());
//		
//		System.out.println(" WxEntConfig1:" +  WxEntConfig1.toString());
//		
//		randNo = new Double(100000 * Math.random()).intValue();
//		
//																					WxEntConfig1.setTenantNameCn("TenantNameCn"+randNo);
//																							WxEntConfig1.setAppToken("AppToken"+randNo);
//																							WxEntConfig1.setCorpId("CorpId"+randNo);
//																							WxEntConfig1.setCorpSecret("CorpSecret"+randNo);
//																							WxEntConfig1.setAccessToken("AccessToken"+randNo);
//																							WxEntConfig1.setExpiresIn("ExpiresIn"+randNo);
//																							WxEntConfig1.setExpiresTime(new Long(randNo));
//																							WxEntConfig1.setTenantId("TenantId"+randNo);
//																							WxEntConfig1.setCreateBy("CreateBy"+randNo);
//																																					WxEntConfig1.setUpdateBy("UpdateBy"+randNo);
//																										
//		WxEntConfigDao.update(WxEntConfig1);
//		
//		WxEntConfig1=WxEntConfigDao.get(WxEntConfig1.getConfigId());
//		
//		System.out.println(" WxEntConfig2:" +  WxEntConfig1.toString());
//		
//		WxEntConfigDao.delete(WxEntConfig1.getConfigId());
//    }
//}