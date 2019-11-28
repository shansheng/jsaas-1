
package com.redxun.bpm.core.manager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.service.CallModel;
import com.redxun.bpm.core.dao.BpmInstDao;
import com.redxun.bpm.core.dao.BpmInstStartLogDao;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstStartLog;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：启动流程日志 处理接口
 * 作者:ray
 * 日期:2018-06-29 17:37:16
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmInstStartLogManager extends MybatisBaseManager<BpmInstStartLog>{
	
	@Resource
	private BpmInstStartLogDao bpmInstStartLogDao;
	
	@Resource
	BpmInstDao bpmInstDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstStartLogDao;
	}
	
	
	
	public BpmInstStartLog getBpmInstStartLog(String uId){
		BpmInstStartLog bpmInstStartLog = get(uId);
		return bpmInstStartLog;
	}
	

	
	
	@Override
	public void create(BpmInstStartLog entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(BpmInstStartLog entity) {
		super.update(entity);
	}
	
	/**
	 * 添加日志
	 * @param bpmInst
	 * @param callModel
	 */
	public void addLog(BpmInst bpmInst,CallModel callModel){
		if(callModel==null) return;
		IUser user=ContextUtil.getCurrentUser();
		BpmInst fromBpmInst=bpmInstDao.get(callModel.getInstId());
		BpmInstStartLog log=new BpmInstStartLog();
		log.setFromActDefId(fromBpmInst.getActDefId());
		log.setFromSubject(fromBpmInst.getSubject());
		log.setFromInstId(fromBpmInst.getInstId());
		log.setFromNodeId(callModel.getNodeId());
		log.setFromSolId(fromBpmInst.getSolId());
		log.setFromNodeName(callModel.getNodeName());
		
		log.setToActDefId(bpmInst.getActDefId());
		log.setToSolId(bpmInst.getSolId());
		log.setToActInstId(bpmInst.getActInstId());
		log.setToSubject(bpmInst.getSubject());
		log.setTenantId(bpmInst.getTenantId());
		//子流程实例ID
		log.setToInstId(bpmInst.getInstId());
		log.setCreateUser(user.getFullname());
		create(log);
	}
	
	/**
	 * 获取流程启动日志。
	 * @param instId
	 * @param subSolId
	 * @return
	 */
	public BpmInstStartLog getByInstSubSolId(String instId,String subSolId){
		BpmInstStartLog startLog=bpmInstStartLogDao.getByInstSubSolId(instId, subSolId);
		return startLog;
	}
}
