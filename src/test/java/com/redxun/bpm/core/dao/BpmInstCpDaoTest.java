package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmInstCpDao;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmInstCp数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmInstCpDaoTest extends BaseTestCase {

    @Resource
    private BpmInstCpDao bpmInstCpDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmInstCp bpmInstCp1 = new BpmInstCp();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmInstCp1.setUserId("UserId"+randNo);
																							bpmInstCp1.setGroupId("GroupId"+randNo);
																							bpmInstCp1.setCcId("CcId"+randNo);
																							bpmInstCp1.setTenantId("TenantId"+randNo);
																							bpmInstCp1.setCreateBy("CreateBy"+randNo);
																																					bpmInstCp1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmInstCpDao.create(bpmInstCp1);
        
        bpmInstCp1=bpmInstCpDao.get(bpmInstCp1.getId());
		
		System.out.println(" bpmInstCp1:" +  bpmInstCp1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmInstCp1.setUserId("UserId"+randNo);
																							bpmInstCp1.setGroupId("GroupId"+randNo);
																							bpmInstCp1.setCcId("CcId"+randNo);
																							bpmInstCp1.setTenantId("TenantId"+randNo);
																							bpmInstCp1.setCreateBy("CreateBy"+randNo);
																																					bpmInstCp1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmInstCpDao.update(bpmInstCp1);
		
		bpmInstCp1=bpmInstCpDao.get(bpmInstCp1.getId());
		
		System.out.println(" bpmInstCp2:" +  bpmInstCp1.toString());
		
		bpmInstCpDao.delete(bpmInstCp1.getId());
    }
}