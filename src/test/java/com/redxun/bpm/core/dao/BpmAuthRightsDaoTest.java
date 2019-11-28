package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmAuthRightsDao;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmAuthRights数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmAuthRightsDaoTest extends BaseTestCase {

    @Resource
    private BpmAuthRightsDao bpmAuthRightsDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmAuthRights bpmAuthRights1 = new BpmAuthRights();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmAuthRights1.setSettingId("SettingId"+randNo);
																							bpmAuthRights1.setRightType("RightType"+randNo);
																							bpmAuthRights1.setType("Type"+randNo);
																							bpmAuthRights1.setAuthId("AuthId"+randNo);
																							bpmAuthRights1.setAuthName("AuthName"+randNo);
										        //1.Create
        bpmAuthRightsDao.create(bpmAuthRights1);
        
        bpmAuthRights1=bpmAuthRightsDao.get(bpmAuthRights1.getId());
		
		System.out.println(" bpmAuthRights1:" +  bpmAuthRights1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmAuthRights1.setSettingId("SettingId"+randNo);
																							bpmAuthRights1.setRightType("RightType"+randNo);
																							bpmAuthRights1.setType("Type"+randNo);
																							bpmAuthRights1.setAuthId("AuthId"+randNo);
																							bpmAuthRights1.setAuthName("AuthName"+randNo);
												
		bpmAuthRightsDao.update(bpmAuthRights1);
		
		bpmAuthRights1=bpmAuthRightsDao.get(bpmAuthRights1.getId());
		
		System.out.println(" bpmAuthRights2:" +  bpmAuthRights1.toString());
		
		bpmAuthRightsDao.delete(bpmAuthRights1.getId());
    }
}