//package com.redxun.wx.ent.dao;
//
//import com.redxun.wx.ent.dao.WxEntMsgDao;
//import com.redxun.wx.ent.entity.WxEntMsg;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre> 
// * 描述：WxEntMsg数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class WxEntMsgDaoTest extends BaseTestCase {
//
//    @Resource
//    private WxEntMsgDao WxEntMsgDao;
//
//    @Transactional(readOnly = false)
//    @Test
//    public void crud() {
//        WxEntMsg WxEntMsg1 = new WxEntMsg();
//        Integer randNo = new Double(100000 * Math.random()).intValue();
//        
//																					WxEntMsg1.setAgentid("Agentid"+randNo);
//																							WxEntMsg1.setUserId("UserId"+randNo);
//																							WxEntMsg1.setContent("Content"+randNo);
//																							WxEntMsg1.setTenantId("TenantId"+randNo);
//																																					WxEntMsg1.setUpdateBy("UpdateBy"+randNo);
//																																					WxEntMsg1.setCreateBy("CreateBy"+randNo);
//																							WxEntMsg1.setStatus(new Integer(randNo));
//										        //1.Create
//        WxEntMsgDao.create(WxEntMsg1);
//        
//        WxEntMsg1=WxEntMsgDao.get(WxEntMsg1.getMsgId());
//		
//		System.out.println(" WxEntMsg1:" +  WxEntMsg1.toString());
//		
//		randNo = new Double(100000 * Math.random()).intValue();
//		
//																					WxEntMsg1.setAgentid("Agentid"+randNo);
//																							WxEntMsg1.setUserId("UserId"+randNo);
//																							WxEntMsg1.setContent("Content"+randNo);
//																							WxEntMsg1.setTenantId("TenantId"+randNo);
//																																					WxEntMsg1.setUpdateBy("UpdateBy"+randNo);
//																																					WxEntMsg1.setCreateBy("CreateBy"+randNo);
//																							WxEntMsg1.setStatus(new Integer(randNo));
//												
//		WxEntMsgDao.update(WxEntMsg1);
//		
//		WxEntMsg1=WxEntMsgDao.get(WxEntMsg1.getMsgId());
//		
//		System.out.println(" WxEntMsg2:" +  WxEntMsg1.toString());
//		
//		WxEntMsgDao.delete(WxEntMsg1.getMsgId());
//    }
//}