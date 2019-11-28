package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.dao.BpmInstTmpDao;
import com.redxun.bpm.core.entity.BpmInstTmp;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
/**
 * <pre> 
 * 描述：BpmInstTmp业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：
 * </pre>
 */
@Service
public class BpmInstTmpManager extends BaseManager<BpmInstTmp>{
	@Resource
	private BpmInstTmpDao bpmInstTmpDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstTmpDao;
	}
	/**
	 * @author mical 2018年5月10日
	 * describe：根据流程实例Id清除对象信息
	 * @param instId
	 */
	public void deleteByInst(String instId) {
		bpmInstTmpDao.deleteByInst(instId);
	}
	public JSONObject getByInstId(String instId) {
		BpmInstTmp tmp = bpmInstTmpDao.getByInstId(instId);
		if(BeanUtil.isEmpty(tmp)) {
			return new JSONObject();
		}
		return JSONObject.parseObject(tmp.getFormJson());
	}
	public JSONObject getByBusKey(String busKey) {
		BpmInstTmp tmp = bpmInstTmpDao.getByBusKey(busKey);
		if(BeanUtil.isEmpty(tmp)) {
			return new JSONObject();
		}
		return JSONObject.parseObject(tmp.getFormJson());
	}
}