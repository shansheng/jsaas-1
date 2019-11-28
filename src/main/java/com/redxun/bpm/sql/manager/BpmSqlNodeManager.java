package com.redxun.bpm.sql.manager;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.sql.dao.BpmSqlNodeDao;
import com.redxun.bpm.sql.entity.BpmSqlNode;
/**
 * <pre>
 * 描述：BpmSqlNode业务服务类
 * @author cjx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * </pre>
 */
@Service
public class BpmSqlNodeManager extends BaseManager<BpmSqlNode> {
	@Resource
	private BpmSqlNodeDao bpmSqlNodeDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSqlNodeDao;
	}
	public void insertFormData2PhTable(String busKey, String formJson, String formInstId, String nodeId, String solId) {
		//System.out.println("formJson=" + formJson);
	}
	public void updateFormData2PhTable() {
	}
	/**
	 * 通过业务解决方案ID及节点Id获得节点的sql
	 * 
	 * @param solId
	 * @param nodeId
	 * @return
	 */
	public BpmSqlNode getBySolIdNodeId(String solId, String nodeId) {
		return this.bpmSqlNodeDao.getBySolIdNodeId(solId, nodeId);
	}
}