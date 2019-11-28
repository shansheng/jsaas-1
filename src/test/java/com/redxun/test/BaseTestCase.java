package com.redxun.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

/**
 * 单元测试的基础类
 * @author csx
 */
@RunWith(JUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-test.xml"})
/*
@TransactionConfiguration(transactionManager="jpaTranManager", defaultRollback=false)
@Transactional*/
public class BaseTestCase /*extends AbstractTransactionalJUnit4SpringContextTests*/{

	
    @Test
    public void test(){
    	System.out.println ("test"); 
    	
    }
    
}