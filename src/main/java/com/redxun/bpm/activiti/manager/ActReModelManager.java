package com.redxun.bpm.activiti.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.activiti.dao.ActReModelDao;
import com.redxun.bpm.activiti.entity.ActReModel;
/**
 * <pre> 
 * 描述：ActReModel业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class ActReModelManager extends BaseManager<ActReModel>{
	@Resource
	private ActReModelDao actReModelDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return actReModelDao;
	}
}