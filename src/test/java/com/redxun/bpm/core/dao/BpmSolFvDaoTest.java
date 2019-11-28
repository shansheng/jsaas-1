package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmSolFvDao;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmSolFv数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSolFvDaoTest extends BaseTestCase {

    @Resource
    private BpmSolFvDao bpmSolFvDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmSolFv bpmSolFv1 = new BpmSolFv();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmSolFv1.setSolId("SolId"+randNo);
																							bpmSolFv1.setNodeId("NodeId"+randNo);
																							bpmSolFv1.setNodeText("NodeText"+randNo);
																							bpmSolFv1.setFormType("FormType"+randNo);
																							bpmSolFv1.setFormUri("FormUri"+randNo);
																							bpmSolFv1.setTenantId("TenantId"+randNo);
																							bpmSolFv1.setUpdateBy("UpdateBy"+randNo);
																							bpmSolFv1.setCreateBy("CreateBy"+randNo);
																																						        //1.Create
        bpmSolFvDao.create(bpmSolFv1);
        
        bpmSolFv1=bpmSolFvDao.get(bpmSolFv1.getId());
		
		System.out.println(" bpmSolFv1:" +  bpmSolFv1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmSolFv1.setSolId("SolId"+randNo);
																							bpmSolFv1.setNodeId("NodeId"+randNo);
																							bpmSolFv1.setNodeText("NodeText"+randNo);
																							bpmSolFv1.setFormType("FormType"+randNo);
																							bpmSolFv1.setFormUri("FormUri"+randNo);
																							bpmSolFv1.setTenantId("TenantId"+randNo);
																							bpmSolFv1.setUpdateBy("UpdateBy"+randNo);
																							bpmSolFv1.setCreateBy("CreateBy"+randNo);
																																								
		bpmSolFvDao.update(bpmSolFv1);
		
		bpmSolFv1=bpmSolFvDao.get(bpmSolFv1.getId());
		
		System.out.println(" bpmSolFv2:" +  bpmSolFv1.toString());
		
		bpmSolFvDao.delete(bpmSolFv1.getId());
    }
}