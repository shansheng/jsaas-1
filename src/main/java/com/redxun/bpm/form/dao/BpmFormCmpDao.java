
/**
 * 
 * <pre> 
 * 描述：复合表单 DAO接口
 * 作者:mansan
 * 日期:2018-05-20 22:45:57
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.form.dao;

import com.redxun.bpm.form.entity.BpmFormCmp;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.jpa.BaseJpaDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BpmFormCmpDao extends BaseMybatisDao<BpmFormCmp> {

	@Override
	public String getNamespace() {
		return BpmFormCmp.class.getName();
	}

	/**
	 * 通过表单视图获得所有的组合表单项
	 * @param viewId
	 * @return
	 */
	public List<BpmFormCmp> getByViewId(String viewId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("viewId", viewId);
		return this.getBySqlKey("getByViewId", params);
	}


	public List<BpmFormCmp> getByPath(String path){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("path", path+"%");
		return this.getBySqlKey("getByPath", params);
	}

	public void delByPath(String path){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("path", path+"%");
		this.getBySqlKey("delByPath", params);
	}


}

