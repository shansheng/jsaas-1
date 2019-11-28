
package com.redxun.sys.core.manager;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysTypeSubRefDao;
import com.redxun.sys.core.entity.SysInstTypeMenu;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.entity.SysTypeSubRef;

/**
 * 
 * <pre> 
 * 描述：机构--子系统关系 处理接口
 * 作者:陈茂昌
 * 日期:2017-09-13 15:57:55
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysTypeSubRefManager extends MybatisBaseManager<SysTypeSubRef>{
	@Resource
	private SysTypeSubRefDao sysTypeSubRefDao;
	@Resource
	private SysInstTypeMenuManager sysInstTypeMenuManager;

	@Resource
	private SysMenuManager sysMenuManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysTypeSubRefDao;
	}
	

	
	public SysTypeSubRef getSysTypeSubRef(String uId){
		SysTypeSubRef sysTypeSubRef = get(uId);
		return sysTypeSubRef;
	}

	public void deleteByInstType(String instTypeId) {
		sysTypeSubRefDao.deleteByInstType(instTypeId);
	}
	/**
	 * 通过子系统ID查找关系实体
	 * @param instId
	 * @return
	 */
	public List<SysTypeSubRef> getByInstId(String instId){
		return sysTypeSubRefDao.getByInstId(instId);
	}
	
	/**
	 * 通过子系统Id和机构类型Id获取唯一关系实体
	 * @param sysId
	 * @param typeId
	 * @return
	 */
	public SysTypeSubRef getBySysIdAndTypeId(String sysId,String typeId){
		return sysTypeSubRefDao.getBySysIdAndTypeId(sysId,typeId);
	}
	
	public List<SysTypeSubRef> getByTypeId(String typeId){
		return sysTypeSubRefDao.getByTypeId(typeId);
	}

	
	//保存机构类型授权菜单
	public void saveGrantMenus(String typeId, Set<String> includeSysIdMenuIds,
			Set<String> sysIdSet) {

		deleteByInstType(typeId);
		
		sysInstTypeMenuManager.deleteByInstTypeId(typeId);
		
		//生成可以访问的子系统
		for(String sysId:sysIdSet){
			SysTypeSubRef instTypeSys=new SysTypeSubRef(IdUtil.getId(), typeId, sysId);
			sysTypeSubRefDao.create(instTypeSys);
		}
		
		//生成可以访问的菜单
		for(String menuId:includeSysIdMenuIds){
			SysMenu sysMenu=sysMenuManager.get(menuId);
			if(sysMenu==null) continue;
			SysInstTypeMenu m=new SysInstTypeMenu(IdUtil.getId(), typeId, menuId,sysMenu.getSysId());
			sysInstTypeMenuManager.create(m);			
		}
		
	}
}
