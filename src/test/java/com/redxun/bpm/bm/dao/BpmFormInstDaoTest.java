package com.redxun.bpm.bm.dao;

import com.redxun.bpm.bm.dao.BpmFormInstDao;
import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmFormInst数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmFormInstDaoTest extends BaseTestCase {

    @Resource
    private BpmFormInstDao bpmFormInstDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmFormInst bpmFormInst1 = new BpmFormInst();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmFormInst1.setSubject("Subject"+randNo);
																							bpmFormInst1.setInstId("InstId"+randNo);
																							bpmFormInst1.setActInstId("ActInstId"+randNo);
																							bpmFormInst1.setActDefId("ActDefId"+randNo);
																							bpmFormInst1.setDefId("DefId"+randNo);
																							bpmFormInst1.setSolId("SolId"+randNo);
																							bpmFormInst1.setFmId("FmId"+randNo);
																							bpmFormInst1.setFmViewId("FmViewId"+randNo);
																							bpmFormInst1.setStatus("Status"+randNo);
																							bpmFormInst1.setJsonData("JsonData"+randNo);
																							bpmFormInst1.setIsPersist("IsPersist"+randNo);
																							bpmFormInst1.setTenantId("TenantId"+randNo);
																							bpmFormInst1.setCreateBy("CreateBy"+randNo);
																																					bpmFormInst1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmFormInstDao.create(bpmFormInst1);
        
        bpmFormInst1=bpmFormInstDao.get(bpmFormInst1.getFormInstId());
		
		System.out.println(" bpmFormInst1:" +  bpmFormInst1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmFormInst1.setSubject("Subject"+randNo);
																							bpmFormInst1.setInstId("InstId"+randNo);
																							bpmFormInst1.setActInstId("ActInstId"+randNo);
																							bpmFormInst1.setActDefId("ActDefId"+randNo);
																							bpmFormInst1.setDefId("DefId"+randNo);
																							bpmFormInst1.setSolId("SolId"+randNo);
																							bpmFormInst1.setFmId("FmId"+randNo);
																							bpmFormInst1.setFmViewId("FmViewId"+randNo);
																							bpmFormInst1.setStatus("Status"+randNo);
																							bpmFormInst1.setJsonData("JsonData"+randNo);
																							bpmFormInst1.setIsPersist("IsPersist"+randNo);
																							bpmFormInst1.setTenantId("TenantId"+randNo);
																							bpmFormInst1.setCreateBy("CreateBy"+randNo);
																																					bpmFormInst1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmFormInstDao.update(bpmFormInst1);
		
		bpmFormInst1=bpmFormInstDao.get(bpmFormInst1.getFormInstId());
		
		System.out.println(" bpmFormInst2:" +  bpmFormInst1.toString());
		
		bpmFormInstDao.delete(bpmFormInst1.getFormInstId());
    }
}