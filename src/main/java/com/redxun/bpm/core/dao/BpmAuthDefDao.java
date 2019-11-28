
/**
 * 
 * <pre> 
 * 描述：授权流程定义 DAO接口
 * 作者:ray
 * 日期:2017-01-10 16:57:01
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmAuthDef;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.saweb.context.ContextUtil;

@Repository
public class BpmAuthDefDao extends BaseMybatisDao<BpmAuthDef> {

	@Override
	public String getNamespace() {
		return BpmAuthDef.class.getName();
	}
	
	/**
	 * 根据settingID删除授权流程。
	 * @param settingId
	 */
	public void delBySettingId(String settingId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("settingId", settingId);
		
		this.deleteBySqlKey("delBySettingId", params);
		
	}
	
	/**
	 * 获取流程定义。跟solution绑定
	 * @param settingId
	 * @return
	 */
	public List<BpmAuthDef> getBySettingId(String settingId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("settingId", settingId);
		return this.getBySqlKey("getBySettingId", params);
	}
	/**
	 * 获取流程定义。跟systree绑定
	 * @param settingId
	 * @return
	 */
	public List<BpmAuthDef> defTreeGetBySettingId(String settingId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("settingId", settingId);
		return this.getBySqlKey("defTreeGetBySettingId", params);
	}
	
	public  List<BpmAuthDef> getAllNotEmptyTreeId(){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", ContextUtil.getTenant());
		return this.getBySqlKey("getAllNotEmptyTreeId", params);
	}
	

	
}

