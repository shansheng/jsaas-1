package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmSolUsergroupDao;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmSolUsergroup数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSolUsergroupDaoTest extends BaseTestCase {

    @Resource
    private BpmSolUsergroupDao bpmSolUsergroupDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmSolUsergroup bpmSolUsergroup1 = new BpmSolUsergroup();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmSolUsergroup1.setGroupName("GroupName"+randNo);
																							bpmSolUsergroup1.setSolId("SolId"+randNo);
																							bpmSolUsergroup1.setGroupType("GroupType"+randNo);
																							bpmSolUsergroup1.setNodeId("NodeId"+randNo);
																							bpmSolUsergroup1.setNodeName("NodeName"+randNo);
																							bpmSolUsergroup1.setTenantId("TenantId"+randNo);
																							bpmSolUsergroup1.setSetting("Setting"+randNo);
																							bpmSolUsergroup1.setSn(new Integer(randNo));
																							bpmSolUsergroup1.setNotifyType("NotifyType"+randNo);
																							bpmSolUsergroup1.setCreateBy("CreateBy"+randNo);
																																					bpmSolUsergroup1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmSolUsergroupDao.create(bpmSolUsergroup1);
        
        bpmSolUsergroup1=bpmSolUsergroupDao.get(bpmSolUsergroup1.getId());
		
		System.out.println(" bpmSolUsergroup1:" +  bpmSolUsergroup1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmSolUsergroup1.setGroupName("GroupName"+randNo);
																							bpmSolUsergroup1.setSolId("SolId"+randNo);
																							bpmSolUsergroup1.setGroupType("GroupType"+randNo);
																							bpmSolUsergroup1.setNodeId("NodeId"+randNo);
																							bpmSolUsergroup1.setNodeName("NodeName"+randNo);
																							bpmSolUsergroup1.setTenantId("TenantId"+randNo);
																							bpmSolUsergroup1.setSetting("Setting"+randNo);
																							bpmSolUsergroup1.setSn(new Integer(randNo));
																							bpmSolUsergroup1.setNotifyType("NotifyType"+randNo);
																							bpmSolUsergroup1.setCreateBy("CreateBy"+randNo);
																																					bpmSolUsergroup1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmSolUsergroupDao.update(bpmSolUsergroup1);
		
		bpmSolUsergroup1=bpmSolUsergroupDao.get(bpmSolUsergroup1.getId());
		
		System.out.println(" bpmSolUsergroup2:" +  bpmSolUsergroup1.toString());
		
		bpmSolUsergroupDao.delete(bpmSolUsergroup1.getId());
    }
}