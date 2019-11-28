//package com.redxun.wx.ent.dao;
//
//import com.redxun.wx.ent.dao.WxEntAgentDao;
//import com.redxun.wx.ent.entity.WxEntAgent;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre> 
// * 描述：WxEntAgent数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class WxEntAgentDaoTest extends BaseTestCase {
//
//    @Resource
//    private WxEntAgentDao WxEntAgentDao;
//
//    @Transactional(readOnly = false)
//    @Test
//    public void crud() {
//        WxEntAgent WxEntAgent1 = new WxEntAgent();
//        Integer randNo = new Double(100000 * Math.random()).intValue();
//        
//																					WxEntAgent1.setAgentid("Agentid"+randNo);
//																							WxEntAgent1.setName("Name"+randNo);
//																							WxEntAgent1.setSquareLogoUrl("SquareLogoUrl"+randNo);
//																							WxEntAgent1.setRoundLogoUrl("RoundLogoUrl"+randNo);
//																							WxEntAgent1.setTenantId("TenantId"+randNo);
//																							WxEntAgent1.setCreateBy("CreateBy"+randNo);
//																																					WxEntAgent1.setUpdateBy("UpdateBy"+randNo);
//																								        //1.Create
//        WxEntAgentDao.create(WxEntAgent1);
//        
//        WxEntAgent1=WxEntAgentDao.get(WxEntAgent1.getId());
//		
//		System.out.println(" WxEntAgent1:" +  WxEntAgent1.toString());
//		
//		randNo = new Double(100000 * Math.random()).intValue();
//		
//																					WxEntAgent1.setAgentid("Agentid"+randNo);
//																							WxEntAgent1.setName("Name"+randNo);
//																							WxEntAgent1.setSquareLogoUrl("SquareLogoUrl"+randNo);
//																							WxEntAgent1.setRoundLogoUrl("RoundLogoUrl"+randNo);
//																							WxEntAgent1.setTenantId("TenantId"+randNo);
//																							WxEntAgent1.setCreateBy("CreateBy"+randNo);
//																																					WxEntAgent1.setUpdateBy("UpdateBy"+randNo);
//																										
//		WxEntAgentDao.update(WxEntAgent1);
//		
//		WxEntAgent1=WxEntAgentDao.get(WxEntAgent1.getId());
//		
//		System.out.println(" WxEntAgent2:" +  WxEntAgent1.toString());
//		
//		WxEntAgentDao.delete(WxEntAgent1.getId());
//    }
//}