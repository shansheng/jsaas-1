
/**
 * 
 * <pre> 
 * 描述：系统对象授权表 DAO接口
 * 作者:mansan
 * 日期:2018-05-02 09:55:15
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.oa.info.entity.InsColNewDef;
import com.redxun.oa.info.entity.SysObjectAuthPermission;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;

@Repository
public class SysObjectAuthPermissionQueryDao extends BaseMybatisDao<SysObjectAuthPermission> {

	@Override
	public String getNamespace() {
		return SysObjectAuthPermission.class.getName();
	}
	
	
	public void delbyObjectId(String objectId, String authType){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("objectId", objectId);
		params.put("authType", authType);
		this.deleteBySqlKey("delbyObjectId", params);
	}
	
	public void delByObjectIdAndAuthType(SysObjectAuthPermission entity){
		this.delByObjectIdAndAuthType(entity);
	}
	
	
	public List<SysObjectAuthPermission> getAllByObjectIdAndAuthType(String objectId ,String authType ){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("objectId", objectId);
		params.put("authType", authType);
		return this.getBySqlKey("getAllByObjectIdAndAuthType",params);
	}

}

