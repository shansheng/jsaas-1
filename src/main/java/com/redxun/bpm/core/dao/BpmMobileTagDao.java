
/**
 * 
 * <pre> 
 * 描述：记录CID和机型 DAO接口
 * 作者:mansan
 * 日期:2017-11-29 22:29:36
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmMobileTag;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmMobileTagDao extends BaseMybatisDao<BpmMobileTag> {

	@Override
	public String getNamespace() {
		return BpmMobileTag.class.getName();
	}

	public BpmMobileTag getByCid(String cid) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("cid", cid);
		return (BpmMobileTag) this.getUnique("getByCid", params);
	}

}

