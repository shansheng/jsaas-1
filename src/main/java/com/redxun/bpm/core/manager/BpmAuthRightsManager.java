package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.bpm.core.dao.BpmAuthRightsDao;
import com.redxun.bpm.core.dao.BpmAuthRightsDao;
import com.redxun.bpm.core.entity.BpmAuthRights;
/**
 * <pre> 
 * 描述：BpmAuthRights业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmAuthRightsManager extends MybatisBaseManager<BpmAuthRights>{
	@Resource
	private BpmAuthRightsDao bpmAuthRightsDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmAuthRightsDao;
	}
	
	public List<BpmAuthRights> getBySettingId(String settingId){
		 return bpmAuthRightsDao.getBySettingId(settingId);
	}
	
	public void delBySettingId(String settingId){
		bpmAuthRightsDao.delBySettingId(settingId);
	}
}