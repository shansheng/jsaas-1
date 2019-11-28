package com.redxun.test.sys.manager;

import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysField;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysModule;
import com.redxun.sys.core.manager.SysModuleManager;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.test.BaseTestCase;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.test.annotation.Rollback;


public class SysModuleManagerTest extends BaseTestCase{
	@Resource
	SysModuleManager sysModuleManager;
	
	@Test
	public void testCreateModuleFromClass(){
            SysModule sysModule=sysModuleManager.getFromEntityClass(OsUser.class);
            if(sysModule!=null){
                    System.out.println("sysModel"+ sysModule.toString());
                    for(SysField field:sysModule.getSysFields()){
                            System.out.println("f:"+ field.toString());
                    }
            }
	}
	/**
	 * 
	 * TODO方法名称描述 
	 * void
	 * @exception 
	 * @since  1.0.0
	 */
	@Test
	@Rollback(false)
	public void testCreateModuleClass(){
		//sysModuleManager.createOrUpdateFromEntityClass(OsGroup.class);
		//sysModuleManager.createOrUpdateFromEntityClass(OsRelType.class);
		//sysModuleManager.createOrUpdateFromEntityClass(SysButton.class);
		//sysModuleManager.createOrUpdateFromEntityClass(SysInst.class);
		//sysModuleManager.createOrUpdateFromEntityClass(Subsystem.class);
		//sysModuleManager.createOrUpdateFromEntityClass(SysModule.class);
		//sysModuleManager.createOrUpdateFromEntityClass(com.redxun.inst.info.entity.InsNews.class);
		//sysModuleManager.createOrUpdateFromEntityClass(SysFormSchema.class);
		//sysModuleManager.createOrUpdateFromEntityClass(TsUser.class);
	}
}
