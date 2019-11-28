package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmTestCaseDao;
import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmTestCase数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmTestCaseDaoTest extends BaseTestCase {

    @Resource
    private BpmTestCaseDao bpmTestCaseDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmTestCase bpmTestCase1 = new BpmTestCase();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmTestCase1.setTestSolId("TestSolId"+randNo);
																							bpmTestCase1.setCaseName("CaseName"+randNo);
																							bpmTestCase1.setParamsConf("ParamsConf"+randNo);
																							bpmTestCase1.setUserConf("UserConf"+randNo);
																							bpmTestCase1.setInstId("InstId"+randNo);
																							bpmTestCase1.setLastStatus("LastStatus"+randNo);
																							bpmTestCase1.setExeExceptions("ExeExceptions"+randNo);
																							bpmTestCase1.setTenantId("TenantId"+randNo);
																							bpmTestCase1.setCreateBy("CreateBy"+randNo);
																																					bpmTestCase1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmTestCaseDao.create(bpmTestCase1);
        
        bpmTestCase1=bpmTestCaseDao.get(bpmTestCase1.getTestId());
		
		System.out.println(" bpmTestCase1:" +  bpmTestCase1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmTestCase1.setTestSolId("TestSolId"+randNo);
																							bpmTestCase1.setCaseName("CaseName"+randNo);
																							bpmTestCase1.setParamsConf("ParamsConf"+randNo);
																							bpmTestCase1.setUserConf("UserConf"+randNo);
																							bpmTestCase1.setInstId("InstId"+randNo);
																							bpmTestCase1.setLastStatus("LastStatus"+randNo);
																							bpmTestCase1.setExeExceptions("ExeExceptions"+randNo);
																							bpmTestCase1.setTenantId("TenantId"+randNo);
																							bpmTestCase1.setCreateBy("CreateBy"+randNo);
																																					bpmTestCase1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmTestCaseDao.update(bpmTestCase1);
		
		bpmTestCase1=bpmTestCaseDao.get(bpmTestCase1.getTestId());
		
		System.out.println(" bpmTestCase2:" +  bpmTestCase1.toString());
		
		bpmTestCaseDao.delete(bpmTestCase1.getTestId());
    }
}