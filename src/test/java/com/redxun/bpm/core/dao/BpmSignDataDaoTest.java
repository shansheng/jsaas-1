package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.dao.BpmSignDataDao;
import com.redxun.bpm.core.entity.BpmSignData;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmSignData数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSignDataDaoTest extends BaseTestCase {

    @Resource
    private BpmSignDataDao bpmSignDataDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmSignData bpmSignData1 = new BpmSignData();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmSignData1.setActDefId("ActDefId"+randNo);
																							bpmSignData1.setActInstId("ActInstId"+randNo);
																							bpmSignData1.setNodeId("NodeId"+randNo);
																							bpmSignData1.setUserId("UserId"+randNo);
																							bpmSignData1.setVoteStatus("VoteStatus"+randNo);
																							bpmSignData1.setTenantId("TenantId"+randNo);
																							bpmSignData1.setCreateBy("CreateBy"+randNo);
																																					bpmSignData1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmSignDataDao.create(bpmSignData1);
        
        bpmSignData1=bpmSignDataDao.get(bpmSignData1.getDataId());
		
		System.out.println(" bpmSignData1:" +  bpmSignData1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmSignData1.setActDefId("ActDefId"+randNo);
																							bpmSignData1.setActInstId("ActInstId"+randNo);
																							bpmSignData1.setNodeId("NodeId"+randNo);
																							bpmSignData1.setUserId("UserId"+randNo);
																							bpmSignData1.setVoteStatus("VoteStatus"+randNo);
																							bpmSignData1.setTenantId("TenantId"+randNo);
																							bpmSignData1.setCreateBy("CreateBy"+randNo);
																																					bpmSignData1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmSignDataDao.update(bpmSignData1);
		
		bpmSignData1=bpmSignDataDao.get(bpmSignData1.getDataId());
		
		System.out.println(" bpmSignData2:" +  bpmSignData1.toString());
		
		bpmSignDataDao.delete(bpmSignData1.getDataId());
    }
}