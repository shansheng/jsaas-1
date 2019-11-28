
/**
 * 
 * <pre> 
 * 描述：流程附件权限 DAO接口
 * 作者:ray
 * 日期:2019-02-12 10:18:55
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.core.query.QueryFilter;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstCtlDao extends BaseMybatisDao<BpmInstCtl> {

	@Override
	public String getNamespace() {
		return BpmInstCtl.class.getName();
	}


	/**
	 * 通过solId和类型来查找模版设置的权限
	 * @param solId
	 * @param type
	 * @return
	 */
	public List<BpmInstCtl> getBySolIdAndType(String instId,String type){
		Map<String,Object> params = new HashMap<>();
		params.put("instId",instId);
		params.put("type",type);
		return this.getBySqlKey("getBySolIdAndType", params);
	}

	/**
	 * 通过solId和type以及right来查找模版设置具体权限
	 * @param solId
	 * @param type
	 * @param right
	 * @return
	 */
	public List<BpmInstCtl> getBySolAndTypeAndRight(String instId,String type,String right){
		Map<String,Object> params = new HashMap<>();
		params.put("instId",instId);
		params.put("type",type);
		params.put("right",right);
		return this.getBySqlKey("getBySolAndTypeAndRight", params);
	}

}

