package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.core.dao.BpmOpinionLibDao;
import com.redxun.bpm.core.entity.BpmOpinionLib;
/**
 * <pre> 
 * 描述：BpmOpinionLib业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmOpinionLibManager extends BaseManager<BpmOpinionLib>{
	@Resource
	private BpmOpinionLibDao bpmOpinionLibDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmOpinionLibDao;
	}
	
	/**
	 * 获得这个用户的所有收藏审批意见
	 * @param userId
	 * @return
	 */
    public List<BpmOpinionLib> getByUserId(String userId){
    	List<BpmOpinionLib> alllist = bpmOpinionLibDao.getByUserId(BpmOpinionLib.PUBLIC_OPINION);
    	List<BpmOpinionLib> userlist = bpmOpinionLibDao.getByUserId(userId);
    	
    	alllist.addAll(userlist);
    	return alllist;
    }
    
    /**
     * 判断是否已经收藏过了
     * @param userId
     * @param opText
     * @return
     */
    public boolean isOpinionSaved(String userId,String opText){
    	boolean a = bpmOpinionLibDao.isOpinionSaved(userId, opText);
    	boolean b =bpmOpinionLibDao.isOpinionSaved(BpmOpinionLib.PUBLIC_OPINION, opText);
    	boolean c = a||b;
    	return c;
    }
}