package com.redxun.bpm.core.manager;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmAuthDefDao;
import com.redxun.bpm.core.entity.BpmAuthDef;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
/**
 * <pre> 
 * 描述：BpmAuthDef业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmAuthDefManager extends MybatisBaseManager<BpmAuthDef>{
	@Resource
	private BpmAuthDefDao bpmAuthDefDao;
	
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmAuthDefDao;
	}
	
	public void delBySettingId(String id){}
	
	
	public BpmAuthDef getUniqueByTreeIdAndSettingId(String treeId,String settingId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("treeId", treeId);
		params.put("settingId", settingId);
		return bpmAuthDefDao.getUnique("getUniqueByTreeIdAndSettingId", params);
	}
	
	
}