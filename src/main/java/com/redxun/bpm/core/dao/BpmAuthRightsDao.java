
/**
 * 
 * <pre> 
 * 描述：流程定义授权 DAO接口
 * 作者:ray
 * 日期:2017-01-10 16:57:01
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmAuthRights;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmAuthRightsDao extends BaseMybatisDao<BpmAuthRights> {

	@Override
	public String getNamespace() {
		return BpmAuthRights.class.getName();
	}

	/**
	 * 
	 * 根据设定删除权限。
	 * @param settingId
	 */
	public void delBySettingId(String settingId){
		
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("settingId", settingId);
		
    	this.deleteBySqlKey("delBySettingId", params);
    }
	
	/**
	 * 根据设定ID获取权限。
	 * @param settingId
	 * @return
	 */
	public List<BpmAuthRights> getBySettingId(String settingId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("settingId", settingId);
		
    	return this.getBySqlKey("getBySettingId", params);
    }
	
	
}

