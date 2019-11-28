package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmTestSolDao;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmTestSol数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmTestSolDaoTest extends BaseTestCase {

    @Resource
    private BpmTestSolDao bpmTestSolDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmTestSol bpmTestSol1 = new BpmTestSol();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmTestSol1.setTestNo("TestNo"+randNo);
																							bpmTestSol1.setSolId("SolId"+randNo);
																							bpmTestSol1.setMemo("Memo"+randNo);
																							bpmTestSol1.setTenantId("TenantId"+randNo);
																							bpmTestSol1.setCreateBy("CreateBy"+randNo);
																																					bpmTestSol1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmTestSolDao.create(bpmTestSol1);
        
        bpmTestSol1=bpmTestSolDao.get(bpmTestSol1.getTestSolId());
		
		System.out.println(" bpmTestSol1:" +  bpmTestSol1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmTestSol1.setTestNo("TestNo"+randNo);
																							bpmTestSol1.setSolId("SolId"+randNo);
																							bpmTestSol1.setMemo("Memo"+randNo);
																							bpmTestSol1.setTenantId("TenantId"+randNo);
																							bpmTestSol1.setCreateBy("CreateBy"+randNo);
																																					bpmTestSol1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmTestSolDao.update(bpmTestSol1);
		
		bpmTestSol1=bpmTestSolDao.get(bpmTestSol1.getTestSolId());
		
		System.out.println(" bpmTestSol2:" +  bpmTestSol1.toString());
		
		bpmTestSolDao.delete(bpmTestSol1.getTestSolId());
    }
}