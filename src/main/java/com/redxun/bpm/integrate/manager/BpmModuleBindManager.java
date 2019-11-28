package com.redxun.bpm.integrate.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.integrate.dao.BpmModuleBindDao;
import com.redxun.bpm.integrate.entity.BpmModuleBind;
/**
 * <pre> 
 * 描述：BpmModuleBind业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmModuleBindManager extends BaseManager<BpmModuleBind>{
	@Resource
	private BpmModuleBindDao bpmModuleBindDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmModuleBindDao;
	}
	
	 /**
     * 按模块Key获得绑定
     * @param moduleKey
     * @return
     */
    public BpmModuleBind getByModuleKey(String moduleKey){
    	return bpmModuleBindDao.getByModuleKey(moduleKey);
    }
    
    /**
     * 如果流程模块ID为空，则删除该下的数据
     * @param solId
     * */
    public void delBySolId(String solId){
    	bpmModuleBindDao.delBySolId(solId);
    }
    
    
}