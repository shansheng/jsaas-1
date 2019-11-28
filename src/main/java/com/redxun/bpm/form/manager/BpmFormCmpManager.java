
package com.redxun.bpm.form.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.bpm.form.dao.BpmFormCmpDao;
import com.redxun.bpm.form.entity.BpmFormCmp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：复合表单 处理接口
 * 作者:mansan
 * 日期:2018-05-20 22:45:57
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmFormCmpManager extends MybatisBaseManager<BpmFormCmp>{
	
	@Resource
	private BpmFormCmpDao bpmFormCmpDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormCmpDao;
	}
	
	
	
	public BpmFormCmp getBpmFormCmp(String uId){
		BpmFormCmp bpmFormCmp = get(uId);
		return bpmFormCmp;
	}
	
	@Override
	public void create(BpmFormCmp entity) {
		if(entity.getPkId()==null){
			entity.setPkId(IdUtil.getId());
		}
		super.create(entity);
		
	}

	/**
	 * 通过表单视图获得所有的组合表单项
	 * @param viewId
	 * @return
	 */
	public List<BpmFormCmp> getByViewId(String viewId){
		return bpmFormCmpDao.getByViewId(viewId);
	}
	
	public List<BpmFormCmp> getByPath(String path){
		return bpmFormCmpDao.getByPath(path);
	}
	
	public void delByPath(String path){
		bpmFormCmpDao.delByPath(path);
	}

}
