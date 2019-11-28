
/**
 * 
 * <pre> 
 * 描述：BPM_REG_LIB DAO接口
 * 作者:ray
 * 日期:2018-12-25 15:49:05
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmRegLib;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.StringUtil;

@Repository
public class BpmRegLibDao extends BaseMybatisDao<BpmRegLib> {

	@Override
	public String getNamespace() {
		return BpmRegLib.class.getName();
	}

	public List<BpmRegLib> getRegByType(String type) {
		return this.getBySqlKey("getRegByType", type);
	}

	public Integer getCountByKey(String id,String key) {
		Map<String,Object> params=new HashMap<>();
		params.put("key", key);
		if(StringUtil.isNotEmpty(id)){
			params.put("id", id);
		}
		return (Integer)this.getOne("getCountByKey", params);
	}

	public BpmRegLib getRegByKey(String key) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("key", key);
		return this.getUnique("getRegByKey", params);
	}
	

}

