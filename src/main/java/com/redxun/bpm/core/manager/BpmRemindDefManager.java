package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmRemindDefDao;
import com.redxun.bpm.core.dao.BpmRemindDefDao;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.manager.MybatisBaseManager;
/**
 * <pre> 
 * 描述：BpmRemindDef业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmRemindDefManager extends MybatisBaseManager<BpmRemindDef>{
	
	@Resource
	private BpmRemindDefDao bpmRemindDefDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmRemindDefDao;
	}
	
	public List<BpmRemindDef> getBySolNode(String solId,String actDefId,String nodeId){
		return bpmRemindDefDao.getBySolNode(solId,actDefId, nodeId);
	}
	
	/**
	 * 根据方案ID获取催办数据。
	 * @param solId
	 * @param actDefId
	 * @return
	 */
	public List<BpmRemindDef> getBySolId(String solId,String actDefId){
		return bpmRemindDefDao.getBySolId(solId, actDefId);
	}
	
	public void delBySolIdActDefId(String solId,String actDefId){
		bpmRemindDefDao.delBySolIdActDefId(solId,actDefId);
	}
}