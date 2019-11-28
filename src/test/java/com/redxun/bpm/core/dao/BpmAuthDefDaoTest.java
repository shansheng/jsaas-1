package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmAuthDefDao;
import com.redxun.bpm.core.entity.BpmAuthDef;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmAuthDef数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmAuthDefDaoTest extends BaseTestCase {

    @Resource
    private BpmAuthDefDao bpmAuthDefDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmAuthDef bpmAuthDef1 = new BpmAuthDef();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmAuthDef1.setSettingId("SettingId"+randNo);
																							bpmAuthDef1.setSolId("SolId"+randNo);
																							bpmAuthDef1.setRightJson("RightJson"+randNo);
										        //1.Create
        bpmAuthDefDao.create(bpmAuthDef1);
        
        bpmAuthDef1=bpmAuthDefDao.get(bpmAuthDef1.getId());
		
		System.out.println(" bpmAuthDef1:" +  bpmAuthDef1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmAuthDef1.setSettingId("SettingId"+randNo);
																							bpmAuthDef1.setSolId("SolId"+randNo);
																							bpmAuthDef1.setRightJson("RightJson"+randNo);
												
		bpmAuthDefDao.update(bpmAuthDef1);
		
		bpmAuthDef1=bpmAuthDefDao.get(bpmAuthDef1.getId());
		
		System.out.println(" bpmAuthDef2:" +  bpmAuthDef1.toString());
		
		bpmAuthDefDao.delete(bpmAuthDef1.getId());
    }
}