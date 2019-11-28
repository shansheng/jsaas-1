package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmSolVarDao;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmSolVar数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSolVarDaoTest extends BaseTestCase {

    @Resource
    private BpmSolVarDao bpmSolVarDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmSolVar bpmSolVar1 = new BpmSolVar();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmSolVar1.setSolId("SolId"+randNo);
																							bpmSolVar1.setKey("Key"+randNo);
																							bpmSolVar1.setName("Name"+randNo);
																							bpmSolVar1.setType("Type"+randNo);
																							bpmSolVar1.setScope("Scope"+randNo);
																							bpmSolVar1.setNodeName("NodeName"+randNo);
																							bpmSolVar1.setDefVal("DefVal"+randNo);
																							bpmSolVar1.setExpress("Express"+randNo);
																							bpmSolVar1.setSn(new Integer(randNo));
																							bpmSolVar1.setTenantId("TenantId"+randNo);
																							bpmSolVar1.setUpdateBy("UpdateBy"+randNo);
																							bpmSolVar1.setCreateBy("CreateBy"+randNo);
																																						        //1.Create
        bpmSolVarDao.create(bpmSolVar1);
        
        bpmSolVar1=bpmSolVarDao.get(bpmSolVar1.getVarId());
		
		System.out.println(" bpmSolVar1:" +  bpmSolVar1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmSolVar1.setSolId("SolId"+randNo);
																							bpmSolVar1.setKey("Key"+randNo);
																							bpmSolVar1.setName("Name"+randNo);
																							bpmSolVar1.setType("Type"+randNo);
																							bpmSolVar1.setScope("Scope"+randNo);
																							bpmSolVar1.setNodeName("NodeName"+randNo);
																							bpmSolVar1.setDefVal("DefVal"+randNo);
																							bpmSolVar1.setExpress("Express"+randNo);
																							bpmSolVar1.setSn(new Integer(randNo));
																							bpmSolVar1.setTenantId("TenantId"+randNo);
																							bpmSolVar1.setUpdateBy("UpdateBy"+randNo);
																							bpmSolVar1.setCreateBy("CreateBy"+randNo);
																																								
		bpmSolVarDao.update(bpmSolVar1);
		
		bpmSolVar1=bpmSolVarDao.get(bpmSolVar1.getVarId());
		
		System.out.println(" bpmSolVar2:" +  bpmSolVar1.toString());
		
		bpmSolVarDao.delete(bpmSolVar1.getVarId());
    }
}