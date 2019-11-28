package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmSolUserDao;
import com.redxun.bpm.core.dao.BpmSolUsergroupDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
/**
 * <pre> 
 * 描述：BpmSolUsergroup业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmSolUsergroupManager extends BaseManager<BpmSolUsergroup>{
	@Resource
	private BpmSolUsergroupDao  bpmSolUsergroupDao;
	@Resource
	private BpmSolUserDao bpmSolUserDao;
	@Resource
	private BpmSolutionDao bpmSolutionDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolUsergroupDao;
	}
	
	/**
	 * 根据方案ID节点ID类型获取分组数据。
	 * @param solId
	 * @param nodeId
	 * @param type
	 * @return
	 */
	public List<BpmSolUsergroup> getBySolNode(String solId,String actDefId,  String nodeId,String type){
		List<BpmSolUsergroup> list=bpmSolUsergroupDao.getBySolNode( solId,actDefId, nodeId, type);
		for (BpmSolUsergroup bpmSolUsergroup : list) {
			bpmSolUsergroup.setUserList(bpmSolUserDao.getByGroupId(bpmSolUsergroup.getId()));
		}
		return list;
	}
	
	
	public List<BpmSolUsergroup> getBySolActDefId(String solId,String actDefId){
		String tenantId=ContextUtil.getCurrentTenantId();
		List<BpmSolUsergroup> list=bpmSolUsergroupDao.getBySolActDefId(tenantId, solId,actDefId);
		return list;
	}

	@Override
	public void create(BpmSolUsergroup entity) {
		
		String tenantId=ContextUtil.getCurrentTenantId();
		Integer maxId=bpmSolUsergroupDao.getMaxSn(tenantId, entity.getSolId(),entity.getActDefId(),entity.getNodeId(), entity.getGroupType());
		
		entity.setSn(maxId);
		super.create(entity);
		List<BpmSolUser> userList=entity.getUserList();
		String solId=entity.getSolId();
		
		for(BpmSolUser user:userList){
			user.setId(IdUtil.getId());
			user.setGroupId(entity.getId());
			user.setSolId(solId);
			user.setActDefId(entity.getActDefId());
			user.setNodeId(entity.getNodeId());
			user.setCategory(entity.getGroupType());
			bpmSolUserDao.create(user);
		}
	}

	@Override
	public void update(BpmSolUsergroup entity) {
	
	
		super.update(entity);
		
		//删除
		bpmSolUserDao.delByGroupId(entity.getId());
		
		for(BpmSolUser user:entity.getUserList()){
			user.setId(IdUtil.getId());
			user.setGroupId(entity.getId());
			user.setSolId(entity.getSolId());
			user.setNodeId(entity.getNodeId());
			user.setCategory(entity.getGroupType());
			bpmSolUserDao.create(user);
		}
	}

	@Override
	public void delete(String id) {
		super.delete(id);
		bpmSolUserDao.delByGroupId(id);
	}

	public void delBySolIdActDefId(String solId, String actDefId) {
		bpmSolUsergroupDao.delBySolIdActDefId(solId, actDefId);
		bpmSolUserDao.delBySolIdActDefId(solId, actDefId);
	}
	
	
	
}