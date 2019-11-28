package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmAuthSettingDao;
import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmAuthSetting数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmAuthSettingDaoTest extends BaseTestCase {

    @Resource
    private BpmAuthSettingDao bpmAuthSettingDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmAuthSetting bpmAuthSetting1 = new BpmAuthSetting();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmAuthSetting1.setName("Name"+randNo);
																							bpmAuthSetting1.setEnable("Enable"+randNo);
																							bpmAuthSetting1.setTenantId("TenantId"+randNo);
																																																			bpmAuthSetting1.setCreateBy("CreateBy"+randNo);
																							bpmAuthSetting1.setUpdateBy("UpdateBy"+randNo);
										        //1.Create
        bpmAuthSettingDao.create(bpmAuthSetting1);
        
        bpmAuthSetting1=bpmAuthSettingDao.get(bpmAuthSetting1.getId());
		
		System.out.println(" bpmAuthSetting1:" +  bpmAuthSetting1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmAuthSetting1.setName("Name"+randNo);
																							bpmAuthSetting1.setEnable("Enable"+randNo);
																							bpmAuthSetting1.setTenantId("TenantId"+randNo);
																																																			bpmAuthSetting1.setCreateBy("CreateBy"+randNo);
																							bpmAuthSetting1.setUpdateBy("UpdateBy"+randNo);
												
		bpmAuthSettingDao.update(bpmAuthSetting1);
		
		bpmAuthSetting1=bpmAuthSettingDao.get(bpmAuthSetting1.getId());
		
		System.out.println(" bpmAuthSetting2:" +  bpmAuthSetting1.toString());
		
		bpmAuthSettingDao.delete(bpmAuthSetting1.getId());
    }
}