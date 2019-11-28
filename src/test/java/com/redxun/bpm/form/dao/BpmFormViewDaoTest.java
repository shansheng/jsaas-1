//package com.redxun.bpm.form.dao;
//
//import com.redxun.bpm.form.dao.BpmFormViewDao;
//import com.redxun.bpm.form.entity.BpmFormView;
//import com.redxun.test.BaseTestCase;
//import javax.annotation.Resource;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
///**
// * <pre> 
// * 描述：BpmFormView数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class BpmFormViewDaoTest extends BaseTestCase {
//
//    @Resource
//    private BpmFormViewDao bpmFormViewDao;
//
//    @Transactional(readOnly = false)
//    @Test
//    public void crud() {
//        BpmFormView bpmFormView1 = new BpmFormView();
//        Integer randNo = new Double(100000 * Math.random()).intValue();
//        
//																					bpmFormView1.setTreeId("TreeId"+randNo);
//																							bpmFormView1.setFmId("FmId"+randNo);
//																							bpmFormView1.setName("Name"+randNo);
//																							bpmFormView1.setKey("Key"+randNo);
//																							bpmFormView1.setType("Type"+randNo);
//																							bpmFormView1.setTemplateView("TemplateView"+randNo);
//																							bpmFormView1.setRenderUrl("RenderUrl"+randNo);
//																							bpmFormView1.setVersion(new Integer(randNo));
//																							bpmFormView1.setIsMain("IsMain"+randNo);
//																							bpmFormView1.setMainViewId("MainViewId"+randNo);
//																							bpmFormView1.setDescp("Descp"+randNo);
//																							bpmFormView1.setStatus("Status"+randNo);
//																							bpmFormView1.setTenantId("TenantId"+randNo);
//																							bpmFormView1.setCreateBy("CreateBy"+randNo);
//																																					bpmFormView1.setUpdateBy("UpdateBy"+randNo);
//																								        //1.Create
//        bpmFormViewDao.create(bpmFormView1);
//        
//        bpmFormView1=bpmFormViewDao.get(bpmFormView1.getViewId());
//		
//		System.out.println(" bpmFormView1:" +  bpmFormView1.toString());
//		
//		randNo = new Double(100000 * Math.random()).intValue();
//		
//																					bpmFormView1.setTreeId("TreeId"+randNo);
//																							bpmFormView1.setFmId("FmId"+randNo);
//																							bpmFormView1.setName("Name"+randNo);
//																							bpmFormView1.setKey("Key"+randNo);
//																							bpmFormView1.setType("Type"+randNo);
//																							bpmFormView1.setTemplateView("TemplateView"+randNo);
//																							bpmFormView1.setRenderUrl("RenderUrl"+randNo);
//																							bpmFormView1.setVersion(new Integer(randNo));
//																							bpmFormView1.setIsMain("IsMain"+randNo);
//																							bpmFormView1.setMainViewId("MainViewId"+randNo);
//																							bpmFormView1.setDescp("Descp"+randNo);
//																							bpmFormView1.setStatus("Status"+randNo);
//																							bpmFormView1.setTenantId("TenantId"+randNo);
//																							bpmFormView1.setCreateBy("CreateBy"+randNo);
//																																					bpmFormView1.setUpdateBy("UpdateBy"+randNo);
//																										
//		bpmFormViewDao.update(bpmFormView1);
//		
//		bpmFormView1=bpmFormViewDao.get(bpmFormView1.getViewId());
//		
//		System.out.println(" bpmFormView2:" +  bpmFormView1.toString());
//		
//		bpmFormViewDao.delete(bpmFormView1.getViewId());
//    }
//}