package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmLogDao;
import com.redxun.bpm.core.entity.BpmLog;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
/**
 * <pre> 
 * 描述：BpmLog业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmLogManager extends MybatisBaseManager<BpmLog>{
	@Resource
	private BpmLogDao bpmLogDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmLogDao;
	}
	
	
	/**
	 * 添加实例日志。
	 * @param solId
	 * @param instId
	 * @param logType
	 * @param opType
	 * @param opContent
	 */
	public void addInstLog(String solId,String instId,String opType,String opContent){
		BpmLog log=new BpmLog();
		log.setLogId(IdUtil.getId());
		log.setSolId(solId);
		log.setInstId(instId);
		log.setOpType(opType);
		log.setLogType(BpmLog.LOG_TYPE_INSTANCE);
		log.setOpContent(opContent);
		create(log);
	}
	
	/**
	 * 添加解决方案设置。
	 * @param solId
	 * @param logType
	 * @param opType
	 * @param opContent
	 */
	public void addSolLog(String solId,String opType,String opContent){
		BpmLog log=new BpmLog();
		log.setLogId(IdUtil.getId());
		log.setSolId(solId);
		log.setOpType(opType);
		log.setLogType(BpmLog.LOG_TYPE_SOLUTION);
		log.setOpContent(opContent);
		create(log);
	}
	
	/**
	 * 添加任务操作日志。
	 * @param solId
	 * @param instId
	 * @param taskId
	 * @param logType
	 * @param opType
	 * @param opContent
	 */
	public void addTaskLog(String solId,String instId,String taskId, String logType, String opType,String opContent){
		BpmLog log=new BpmLog();
		log.setLogId(IdUtil.getId());
		log.setSolId(solId);
		log.setInstId(instId);
		log.setTaskId(taskId);
		log.setOpType(opType);
		log.setLogType(BpmLog.LOG_TYPE_TASK);
		log.setOpContent(opContent);
		create(log);
	}
	
	
}