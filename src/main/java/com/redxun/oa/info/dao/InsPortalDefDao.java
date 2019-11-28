
/**
 *
 * <pre>
 * 描述：ins_portal_def DAO接口
 * 作者:mansan
 * 日期:2017-08-15 16:07:14
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import com.redxun.oa.info.entity.InsPortalDef;

import java.util.*;

import com.redxun.oa.info.entity.InsPortalPermission;
import com.redxun.saweb.context.ContextUtil;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class InsPortalDefDao extends BaseMybatisDao<InsPortalDef> {

	@Override
	public String getNamespace() {
		return InsPortalDef.class.getName();
	}


	/**
	 * 根据别名获取布局。
	 * @param alias
	 * @param tenantId
	 * @return
	 */
	public InsPortalDef getByAlias(String tenantId,String alias){
		Map<String,Object> params=new HashMap<>();
		params.put("tenantId", tenantId);
		params.put("key", alias);
		InsPortalDef portalDef=this.getUnique("getByAlias", params);
		return portalDef;
	}

	/**
	 * 根据门户key，租户Id，用户Id查找是否有这个门户
	 * @param key
	 * @param tenantId
	 * @param userId
	 * @return 如果有则为这个门户portal，如果没则为空
	 */
	public InsPortalDef getByIdKey(String key, String tenantId,String userId){
    	/*String ql="from InsPortalDef insp where insp.key=? and insp.tenantId=? and insp.userId=? ";
    	return (InsPortalDef)this.getUnique(ql, new Object[]{key, tenantId,userId});*/
		Map<String,Object> params=new HashMap<>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		params.put("userId", userId);
		InsPortalDef portalDef=this.getUnique("getByIdKey", params);
		return portalDef;
	}

	/**
	 * 根据门户Key，租户Id查找是否有这个门户
	 * @param key
	 * @param tenantId
	 * @return 如果有则为这个门户portal，如果没则为空
	 */
	public InsPortalDef getByKey(String key, String tenantId){
    	/*String ql="from InsPortalDef insp where insp.key=? and insp.tenantId=? ";
    	return (InsPortalDef)this.getUnique(ql, new Object[]{key, tenantId});*/
		Map<String,Object> params=new HashMap<>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		InsPortalDef portalDef=this.getUnique("getByKey", params);
		return portalDef;
	}

	public InsPortalDef getDefaultPortal(){
    	/*String ql="from InsPortalDef insp where insp.isDefault='YES'";
    	return (InsPortalDef)this.getUnique(ql, new Object[]{});*/
		Map<String,Object> params=new HashMap<>();;
		InsPortalDef portalDef=this.getUnique("getDefaultPortal", params);
		return portalDef;
	}

	/**
	 * 根据门户key，是否有这个门户
	 * 指定租户首页Port栏目默认信息，固定key:INSTPORT
	 * @param key
	 * @return 如果有则为这个门户portal，如果没则为空
	 */
	public InsPortalDef getByOnlyKey(String key){
		/*String ql="from InsPortalDef insp where insp.key=? ";
		return (InsPortalDef)this.getUnique(ql, new Object[]{key});*/
		Map<String,Object> params=new HashMap<>();
		params.put("key", key);
		InsPortalDef portalDef=this.getUnique("getByOnlyKey", params);
		return portalDef;
	}

	/**
	 * 根据solId 获取权限。
	 * @return
	 */
	public List<InsPortalDef> getByOwner(Map<String, Set<String>> profiles){

		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", ContextUtil.getCurrentTenantId());
		params.put("profileMap", profiles);
		List<InsPortalDef>  owerAll  =  this.getBySqlKey("getByOwner", params);
		return  owerAll;
	}
	
	/**
	 * 获取手机默认栏目
	 * Append by Louis
	 * @param isDef
	 * @return
	 */
	public List<InsPortalDef> getMobilePortal(String isDef){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("isMobile", "YES");
		params.put("isDef", isDef);
		return this.getBySqlKey("getMobilePortal", params);
	}
}