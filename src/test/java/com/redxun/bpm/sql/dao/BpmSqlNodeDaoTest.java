package com.redxun.bpm.sql.dao;

import com.redxun.bpm.sql.dao.BpmSqlNodeDao;
import com.redxun.bpm.sql.entity.BpmSqlNode;
import com.redxun.test.BaseTestCase;
import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

/**
 * <pre> 
 * 描述：BpmSqlNode数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSqlNodeDaoTest extends BaseTestCase {

    @Resource
    private BpmSqlNodeDao bpmSqlNodeDao;

    @Transactional(readOnly = false)
    @Test
    public void crud() {
        BpmSqlNode bpmSqlNode1 = new BpmSqlNode();
        Integer randNo = new Double(100000 * Math.random()).intValue();
        
																					bpmSqlNode1.setSolId("SolId"+randNo);
																							bpmSqlNode1.setNodeId("NodeId"+randNo);
																							bpmSqlNode1.setNodeText("NodeText"+randNo);
																							bpmSqlNode1.setSql("Sql"+randNo);
																							bpmSqlNode1.setDsId("DsId"+randNo);
																							bpmSqlNode1.setDsName("DsName"+randNo);
																							bpmSqlNode1.setTenantId("TenantId"+randNo);
																							bpmSqlNode1.setCreateBy("CreateBy"+randNo);
																																					bpmSqlNode1.setUpdateBy("UpdateBy"+randNo);
																								        //1.Create
        bpmSqlNodeDao.create(bpmSqlNode1);
        
        bpmSqlNode1=bpmSqlNodeDao.get(bpmSqlNode1.getBpmSqlNodeId());
		
		System.out.println(" bpmSqlNode1:" +  bpmSqlNode1.toString());
		
		randNo = new Double(100000 * Math.random()).intValue();
		
																					bpmSqlNode1.setSolId("SolId"+randNo);
																							bpmSqlNode1.setNodeId("NodeId"+randNo);
																							bpmSqlNode1.setNodeText("NodeText"+randNo);
																							bpmSqlNode1.setSql("Sql"+randNo);
																							bpmSqlNode1.setDsId("DsId"+randNo);
																							bpmSqlNode1.setDsName("DsName"+randNo);
																							bpmSqlNode1.setTenantId("TenantId"+randNo);
																							bpmSqlNode1.setCreateBy("CreateBy"+randNo);
																																					bpmSqlNode1.setUpdateBy("UpdateBy"+randNo);
																										
		bpmSqlNodeDao.update(bpmSqlNode1);
		
		bpmSqlNode1=bpmSqlNodeDao.get(bpmSqlNode1.getBpmSqlNodeId());
		
		System.out.println(" bpmSqlNode2:" +  bpmSqlNode1.toString());
		
		bpmSqlNodeDao.delete(bpmSqlNode1.getBpmSqlNodeId());
    }
}