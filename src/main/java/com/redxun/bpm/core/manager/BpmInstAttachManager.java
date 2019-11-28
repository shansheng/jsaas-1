package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.core.dao.BpmInstAttachDao;
import com.redxun.bpm.core.entity.BpmInstAttach;
/**
 * <pre> 
 * 描述：BpmInstAttach业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmInstAttachManager extends BaseManager<BpmInstAttach>{
	@Resource
	private BpmInstAttachDao bpmInstAttachDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstAttachDao;
	}
	
    public void delByInstId(String instId){
    	bpmInstAttachDao.delByInstId(instId);
    }
    
    public List<BpmInstAttach> getByInstId(String instId){
    	return bpmInstAttachDao.getByInstId(instId);
    }
}