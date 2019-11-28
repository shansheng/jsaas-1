package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.bpm.core.dao.BpmInstReadDao;
import com.redxun.bpm.core.entity.BpmInstRead;
/**
 * <pre> 
 * 描述：BpmInstRead业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmInstReadManager extends BaseManager<BpmInstRead>{
	@Resource
	private BpmInstReadDao bpmInstReadDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstReadDao;
	}
	
	/**
     * 判断是否已经存入阅读记录
     * @param userId
     * @param instId
     * @return
     */
	 public boolean isRead(String userId,String instId){
		 return bpmInstReadDao.isRead(userId, instId);
	 }
	 
	 /**
     * 获得该流程的所有阅读记录
     * @param instId
     * @return
     */
    public List<BpmInstRead> getAllByInstId(String instId){
    	return bpmInstReadDao.getAllByInstId(instId);
    }
    
    /**
     * 获得该流程的所有阅读记录
     * @param instId
     * @return
     */
    public List<BpmInstRead> getAllByInstId(String instId,Page page){
    	return bpmInstReadDao.getAllByInstId(instId);
    }
    
    public void removeByInst(String instId){
    	bpmInstReadDao.removeByInst(instId);
    }
}