package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmAgentSolDao;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmAgentSol数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmAgentSolDaoTest extends BaseTestCase {

    @Resource
    private BpmAgentSolDao bpmAgentSolDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmAgentSol bpmAgentSol1 = new BpmAgentSol();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmAgentSol1.setAgentId("AgentId"+randNo);
																							bpmAgentSol1.setSolId("SolId"+randNo);
																							bpmAgentSol1.setSolName("SolName"+randNo);
																							bpmAgentSol1.setAgentType("AgentType"+randNo);
																							bpmAgentSol1.setCondition("Condition"+randNo);
																							bpmAgentSol1.setTenantId("TenantId"+randNo);
																							bpmAgentSol1.setCreateBy("CreateBy"+randNo);
																																					bpmAgentSol1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmAgentSolDao.create(bpmAgentSol1);
        
        bpmAgentSol1=bpmAgentSolDao.get(bpmAgentSol1.getAsId());
		
		System.out.println(" bpmAgentSol1:" +  bpmAgentSol1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmAgentSol1.setAgentId("AgentId"+randNo);
																							bpmAgentSol1.setSolId("SolId"+randNo);
																							bpmAgentSol1.setSolName("SolName"+randNo);
																							bpmAgentSol1.setAgentType("AgentType"+randNo);
																							bpmAgentSol1.setCondition("Condition"+randNo);
																							bpmAgentSol1.setTenantId("TenantId"+randNo);
																							bpmAgentSol1.setCreateBy("CreateBy"+randNo);
																																					bpmAgentSol1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmAgentSolDao.update(bpmAgentSol1);
		
		bpmAgentSol1=bpmAgentSolDao.get(bpmAgentSol1.getAsId());
		
		System.out.println(" bpmAgentSol2:" +  bpmAgentSol1.toString());
		
		bpmAgentSolDao.delete(bpmAgentSol1.getAsId());
    }
}