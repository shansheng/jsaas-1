package com.redxun.bpm.core.manager;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmInstCcDao;
import com.redxun.bpm.core.dao.BpmInstCpDao;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
/**
 * <pre> 
 * 描述：BpmInstCc业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmInstCcManager extends MybatisBaseManager<BpmInstCc>{
	
	@Resource
	private BpmInstCcDao bpmInstCcDao;
	
	
	@Resource
	private BpmInstCpDao bpmInstCpDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstCcDao;
	}
	
	public List<BpmInstCc> getToMeInsts(QueryFilter filter){
		return bpmInstCcDao.getToMeCcInsts(filter);
	}
	

	
	@Override
	public void create(BpmInstCc entity) {
		Set<BpmInstCp> set=entity.getBpmInstCps();
		if(BeanUtil.isEmpty(set)) return;
		bpmInstCcDao.create(entity);
		for(Iterator<BpmInstCp> it=set.iterator();it.hasNext();){
			BpmInstCp cp=it.next();
			bpmInstCpDao.create(cp);
		}
		
	}
	
	 /**
     * 按流程实例删除抄送
     * @param instId
     */
    public void delByInstId(String instId){
    	bpmInstCpDao.delByInst(instId);
    	bpmInstCcDao.delByInstId(instId);
    	
    }

}