package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstTmp;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
/**
 * <pre> 
 * 描述：BpmInstTmp数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：
 * </pre>
 */
@Repository
public class BpmInstTmpDao extends BaseMybatisDao<BpmInstTmp> {

	@Override
	public String getNamespace() {
		return BpmInstTmp.class.getName();
	}

	public void deleteByInst(String instId){
    	this.deleteBySqlKey("deleteByInst",instId);
	}

	public BpmInstTmp getByInstId(String instId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("instId", instId);
		return this.getUnique("getByInstId", params);
	}

	public BpmInstTmp getByBusKey(String busKey) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("busKey", busKey);
		return this.getUnique("getByBusKey", params);
	}
    
}
