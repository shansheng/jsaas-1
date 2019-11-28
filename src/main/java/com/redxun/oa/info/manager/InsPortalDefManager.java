
package com.redxun.oa.info.manager;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.dao.InsPortalDefDao;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.dao.SysInstDao;
import com.redxun.sys.core.entity.SysInst;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.dao.InsPortalPermissionDao;
import com.redxun.oa.info.entity.InsPortalDef;
import com.redxun.oa.info.entity.InsPortalPermission;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.manager.OsGroupManager;

/**
 * 
 * <pre> 
 * 描述：ins_portal_def 处理接口
 * 作者:mansan
 * 日期:2017-08-15 16:07:14
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class InsPortalDefManager extends ExtBaseManager<InsPortalDef>{
	@Resource
	private InsPortalDefDao insPortalDefDao;
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private InsPortalPermissionDao insPortalPermissionDao;
	@Resource
	private SysInstDao sysInstDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return insPortalDefDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return insPortalDefDao;
	}
	

	public InsPortalDef getInsPortalDef(String uId){
		InsPortalDef insPortalDef = get(uId);
		return insPortalDef;
	}
	
	/**
	 * 更新主表
	 * @param insPortalDef
	 */
	public void update(InsPortalDef insPortalDef){
		super.update(insPortalDef);
	}
	
	/**
	 * 保存新的主表
	 * @param insPortalDef
	 */
	public void create(InsPortalDef insPortalDef){
		super.create(insPortalDef);
	}
	
    /**
     * 根据门户key，租户Id，用户Id查找是否有这个门户
     * @param key
     * @param tenantId
     * @param userId
     * @return 如果有则为这个门户portal，如果没则为空
     */
	 public InsPortalDef getByIdKey(String key, String tenantId,String userId){
		return insPortalDefDao.getByIdKey(key, tenantId, userId);
    }
	 
    /**
     * 根据门户Key，租户Id查找是否有这个门户
     * @param key
     * @param tenantId
     * @return 如果有则为这个门户portal，如果没则为空
     */
	public InsPortalDef getByKey(String key, String tenantId){
		return insPortalDefDao.getByKey(key, tenantId);
	}
	
	public InsPortalDef getPortalDef(){
		String userId = ContextUtil.getCurrentUserId();
		Map<String,Set<String>> profiles = ProfileUtil.getCurrentProfile();

		List<InsPortalDef>  owerAll = insPortalDefDao.getByOwner(profiles);

		List<InsPortalDef> portals = new ArrayList<InsPortalDef>();
		SysInst sysInst = sysInstDao.getByDomain(WebAppUtil.getOrgMgrDomain());
		String rootTenantId = sysInst.getTenantId();
		String currentTenantId = ContextUtil.getCurrentTenantId();
		for(InsPortalDef portal:owerAll){
			if(portal!=null){
				if(rootTenantId.equals(currentTenantId) && InsPortalDef.KEY_INSTPORT.equals(portal.getKey())){
					continue;
				}
				if(currentTenantId.equals(portal.getTenantId())){
					portals.add(portal);
				}
			}
		}
		if(portals.size()==0 && !rootTenantId.equals(currentTenantId)){
			//指定租户首页Port栏目信息，固定key:INSTPORT
			InsPortalDef portal = insPortalDefDao.getByOnlyKey(InsPortalDef.KEY_INSTPORT);
			if(portal!=null){
				portals.add(portal);
			}
		}

		InsPortalDef portal = getPriorityPortal(portals);

		return portal;
	}
	


	/**
	 * 计算优先级最高的布局
	 * @param portals
	 * @return
	 */
	public InsPortalDef getPriorityPortal(List<InsPortalDef> portals){
		InsPortalDef portal = new InsPortalDef();
		if(portals.size()==0){
			portal = insPortalDefDao.getDefaultPortal();
			return portal;
		}
		int i = 0;
		for(InsPortalDef p:portals){
			if(p.getPriority()>i){
				i = p.getPriority();
				portal = p;
			}
		}
		
		return portal;
	}
	
	private List<InsPortalDef> getPortalDefByUserId(String userId){
		List<InsPortalPermission> portalPermissions = insPortalPermissionDao.getByUserId(userId);
		List<InsPortalDef> portals = new ArrayList<InsPortalDef>();
		for(InsPortalPermission p:portalPermissions){
			InsPortalDef portal = get(p.getLayoutId());
			if(portal!=null){
				portals.add(portal);
			}			
		}		
		return portals;
	}
	
	private List<InsPortalDef> getPortalDefByGroupId(String groupId){
		List<InsPortalPermission> portalPermissions = insPortalPermissionDao.getByGroupId(groupId);
		List<InsPortalDef> portals = new ArrayList<InsPortalDef>();
		for(InsPortalPermission p:portalPermissions){
			InsPortalDef portal = get(p.getLayoutId());
			if(portal!=null){
				portals.add(portal);
			}			
		}		
		return portals;
	}
	
	private List<InsPortalDef> getPortalDefBySubGroupId(String subGroupId){
		List<InsPortalPermission> portalPermissions = insPortalPermissionDao.getBySubGroupId(subGroupId);
		List<InsPortalDef> portals = new ArrayList<InsPortalDef>();
		for(InsPortalPermission p:portalPermissions){
			InsPortalDef portal = get(p.getLayoutId());
			if(portal!=null){
				portals.add(portal);
			}			
		}		
		return portals;
	}
	
	/**
	 * 根据别名获取门户。
	 * @param tenantId
	 * @param alias
	 * @return
	 */
	public InsPortalDef getByAlias(String tenantId,String alias){
		InsPortalDef def= this.insPortalDefDao.getByAlias(tenantId, alias);
		return def;
		
	}
	
/**
	 * 获取手机端默认门户
	 * append by Louis
	 * @return
	 */
	public InsPortalDef getMobilePortalDef() {
		String userId = ContextUtil.getCurrentUserId();
		Map<String,Set<String>> profiles = ProfileUtil.getCurrentProfile();
		Set<String> groupIds = profiles.get("group");
		Set<String> subGroupIds = profiles.get("subGroup");
		List<InsPortalDef> portals = new ArrayList<InsPortalDef>();
		portals.addAll(getPortalDefByUserId(userId));
		if(groupIds!=null&&groupIds.size()>0){
			for(String ids:groupIds){
				portals.addAll(getPortalDefByGroupId(ids));
			}
		}
		if(subGroupIds!=null&&subGroupIds.size()>0){
			for(String ids:subGroupIds){
				portals.addAll(getPortalDefBySubGroupId(ids));
			}
		}
		
		InsPortalDef curPortal = null;
		int i = 0;
		if(portals.size() == 0) {
			curPortal = getPriorityPortal(portals);
		} else {
			for(InsPortalDef p:portals){
				if(p.getIsMobile() != null && p.getIsMobile().equals("YES") && p.getPriority()>i){
					i = p.getPriority();
					curPortal = p;
				}
			}
		}
		
		if(curPortal!=null&& StringUtil.isEmpty(curPortal.getPortId())) {
			curPortal = insPortalDefDao.getDefaultPortal();
		}
		return curPortal;
	}
}