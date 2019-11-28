
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmAuthSettingDao extends BaseMybatisDao<BpmAuthSetting> {

	@Override
	public String getNamespace() {
		return BpmAuthSetting.class.getName();
	}

	
	public List getRights(String rightType,Map<String,Set<String>> profileMap){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("profileMap", profileMap);
		params.put("rightType", rightType);
		
		return this.getBySqlKey("getRights", params);
		
	}
	
	/**
	 * 根据solId 获取权限。
	 * @param solIds
	 * @return
	 */
	public List getRightsBySolId(List<String> solIds){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("solIds", solIds);
		return this.getBySqlKey("getRightsBySolId", params);
		
	}
	
	/**
	 * 根据solId 获取权限。
	 * @param solIds
	 * @return
	 */
	public List getRightsByTreeId(List<String> treeIds){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("treeIds", treeIds);
		return this.getBySqlKey("getRightsByTreeId", params);
		
	}
	
	public  BpmAuthSetting getSettingByDefTreeId(String treeId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("treeId", treeId);
		return this.getUnique("getSettingByDefTreeId", params);
	}
}

