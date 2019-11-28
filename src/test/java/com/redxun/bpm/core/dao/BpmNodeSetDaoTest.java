package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmNodeSetDao;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmNodeSet数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmNodeSetDaoTest extends BaseTestCase {

    @Resource
    private BpmNodeSetDao bpmNodeSetDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmNodeSet bpmNodeSet1 = new BpmNodeSet();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmNodeSet1.setSolId("SolId"+randNo);
																							bpmNodeSet1.setNodeId("NodeId"+randNo);
																							bpmNodeSet1.setName("Name"+randNo);
																							bpmNodeSet1.setDescp("Descp"+randNo);
																							bpmNodeSet1.setNodeType("NodeType"+randNo);
																							bpmNodeSet1.setSettings("Settings"+randNo);
																							bpmNodeSet1.setTenantId("TenantId"+randNo);
																							bpmNodeSet1.setCreateBy("CreateBy"+randNo);
																																					bpmNodeSet1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmNodeSetDao.create(bpmNodeSet1);
        
        bpmNodeSet1=bpmNodeSetDao.get(bpmNodeSet1.getSetId());
		
		System.out.println(" bpmNodeSet1:" +  bpmNodeSet1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmNodeSet1.setSolId("SolId"+randNo);
																							bpmNodeSet1.setNodeId("NodeId"+randNo);
																							bpmNodeSet1.setName("Name"+randNo);
																							bpmNodeSet1.setDescp("Descp"+randNo);
																							bpmNodeSet1.setNodeType("NodeType"+randNo);
																							bpmNodeSet1.setSettings("Settings"+randNo);
																							bpmNodeSet1.setTenantId("TenantId"+randNo);
																							bpmNodeSet1.setCreateBy("CreateBy"+randNo);
																																					bpmNodeSet1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmNodeSetDao.update(bpmNodeSet1);
		
		bpmNodeSet1=bpmNodeSetDao.get(bpmNodeSet1.getSetId());
		
		System.out.println(" bpmNodeSet2:" +  bpmNodeSet1.toString());
		
		bpmNodeSetDao.delete(bpmNodeSet1.getSetId());
    }
}