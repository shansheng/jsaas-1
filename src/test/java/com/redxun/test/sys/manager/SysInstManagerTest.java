/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.redxun.test.sys.manager;

import com.redxun.core.query.Page;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.test.BaseTestCase;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Test;
import org.springframework.test.annotation.Rollback;

/**
 *
 * @author csx
 */
public class SysInstManagerTest extends BaseTestCase{
    
    @Resource
    private SysInstManager sysInstManager;
    /**
     * 批量插入
     */
    //@Test
    @Rollback(false)
    public void testBatchInstertSysInst(){
        NumberFormat nf=new DecimalFormat("00000000");
        for(int i=0;i<1000;i++){
            SysInst sysInst=new SysInst();
            sysInst.setNameCn("CN Name_"+ i);
            sysInst.setNameEn("EN Name_" + i);
            sysInst.setInstNo(nf.format(new Long(i)));
            sysInst.setAddress("EX_"+i);
            sysInstManager.create(sysInst);
        }
    }

    @Test
    public void testGetQueryAllPage(){
        int i=0;
        Page page=new Page(0,100);
        
        List<SysInst> list=sysInstManager.getAll(page);
        int totalPage=page.getTotalPages();
        System.out.println("1size:" + list.size());
        for(;i<totalPage;i++){
           page=new Page(i,100);
           list=sysInstManager.getAll(page);
           System.out.println("size:" + list.size());
        }
    }
   
}
