
package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmInstUserDao;
import com.redxun.bpm.core.entity.BpmInstUser;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：流程实例用户设置 处理接口
 * 作者:ray
 * 日期:2018-06-14 15:11:19
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmInstUserManager extends MybatisBaseManager<BpmInstUser>{
	
	@Resource
	private BpmInstUserDao bpmInstUserDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstUserDao;
	}
	
	
	
	public BpmInstUser getBpmInstUser(String uId){
		BpmInstUser bpmInstUser = get(uId);
		return bpmInstUser;
	}
	

	
	
	@Override
	public void create(BpmInstUser entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(BpmInstUser entity) {
		super.update(entity);
	}
	
	/**
	 * 根据实例删除节点配置。
	 * @param instId
	 */
	public void delByInstId(String instId){
		this.bpmInstUserDao.delByInstId(instId);
	}
	
	/**
	 * 添加节点用户。
	 * @param instId
	 * @param nodeId
	 * @param userIds	使用逗号分隔指定多个人。
	 * @param userNames
	 */
	public void addNodeUser(String instId,String nodeId,String userIds,String userNames){
		BpmInstUser user=new BpmInstUser();
		user.setId(IdUtil.getId());
		user.setActDefId("");
		user.setIsSub(0);
		user.setNodeId(nodeId);
		user.setInstId(instId);
		user.setUserIds(userIds);
		user.setUserNames(userNames);
		super.create(user);
	}
	
	public void addNodeUser(String instId,String nodeId,String userIds){
		BpmInstUser user=new BpmInstUser();
		user.setId(IdUtil.getId());
		user.setActDefId("");
		user.setIsSub(0);
		user.setNodeId(nodeId);
		user.setInstId(instId);
		user.setUserIds(userIds);
		super.create(user);
	}
	
	/**
	 * 添加节点用户。
	 * @param actDefId
	 * @param instId
	 * @param nodeId
	 * @param userIds	使用逗号分隔指定多个人
	 * @param userNames
	 */
	public void addSubNodeUser(String actDefId, String instId,String nodeId,String userIds,String userNames){
		BpmInstUser user=new BpmInstUser();
		user.setId(IdUtil.getId());
		user.setActDefId(actDefId);
		user.setIsSub(1);
		user.setNodeId(nodeId);
		user.setInstId(instId);
		user.setUserIds(userIds);
		user.setUserNames(userNames);
		super.create(user);
	}
	
	public void addSubNodeUser(String actDefId, String instId,String nodeId,String userIds){
		BpmInstUser user=new BpmInstUser();
		user.setId(IdUtil.getId());
		user.setActDefId(actDefId);
		user.setIsSub(1);
		user.setNodeId(nodeId);
		user.setInstId(instId);
		user.setUserIds(userIds);
		super.create(user);
	}
}
