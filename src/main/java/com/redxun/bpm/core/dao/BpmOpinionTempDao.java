
/**
 * 
 * <pre> 
 * 描述：BPM_OPINION_TEMP DAO接口
 * 作者:mansan
 * 日期:2017-09-26 18:02:24
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmOpinionTemp;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmOpinionTempDao extends BaseMybatisDao<BpmOpinionTemp> {

	@Override
	public String getNamespace() {
		return BpmOpinionTemp.class.getName();
	}
	
	public void delTemp(String type,String typeId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("typeId", typeId);
		this.deleteBySqlKey("delTemp", params);
		
	}
	
	public BpmOpinionTemp getByType(String type,String instId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("instId", instId);
		
		return this.getUnique("getByType", params);
	}

}

