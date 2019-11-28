package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.core.dao.BpmCheckFileDao;
import com.redxun.bpm.core.entity.BpmCheckFile;
/**
 * <pre> 
 * 描述：BpmCheckFile业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmCheckFileManager extends BaseManager<BpmCheckFile>{
	@Resource
	private BpmCheckFileDao bpmCheckFileDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmCheckFileDao;
	}
	
    public List<BpmCheckFile> getByNodeId(String nodeId){
    	return bpmCheckFileDao.getByNodeId(nodeId);
    }
    
    public void removeByInst(String actInstId){
    	bpmCheckFileDao.removeByInst(actInstId);
    }
}