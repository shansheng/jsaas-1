package com.redxun.sys.core.manager;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.Base64Util;
import com.redxun.core.util.EncryptUtil;
import com.redxun.sys.core.dao.SubsystemDao;
import com.redxun.sys.core.dao.SysMenuDao;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysInstType;
/**
 * <pre> 
 * 描述：Subsystem业务服务类
 * 构建组：saweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SubsystemManager extends MybatisBaseManager<Subsystem>{
	
	@Resource
	private SysMenuDao sysMenuDao;
	
	@Resource
	private SubsystemDao subsystemDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return subsystemDao;
	}
	
	/**
	 * 
	 * 按Key与tenantId获取其值
	 * @param key
	 * @param tenantId
	 * @return SysTreeCat
	 * @exception
	 * @since 1.0.0
	 */
	public Subsystem getByKey(String key){
		return subsystemDao.getByKey(key);
	}
	
	 
    /**
     * 获得所有子系统并排序
     * @return
     */
    public List<Subsystem> getAllOrderBySn(){
    	return subsystemDao.getAllOrderBySn();
    }
	
	/**
	 * 级联删除，同时删除该系统下的所有子菜单
	 * @param sysId 
	 * void
	 * @exception 
	 * @since  1.0.0
	 */
	public void deleteCascade(String sysId){
		sysMenuDao.delBySysId(sysId);
		delete(sysId);
	}
	/**
	 * 获得有效的系统
	 * @return
	 */
	public List<Subsystem> getByValidSystem(){
		return subsystemDao.getByStatus(MBoolean.ENABLED.toString());
	}
	
	public List<Subsystem> getPlatformValidSystem(){
		return subsystemDao.getByInstTypeStatus(SysInstType.INST_TYPE_PLATFORM, MBoolean.ENABLED.name());
	}
	
	
	/**
	 * 获得有效的子系统
	 * @param instType
	 * @return
	 */
	public List<Subsystem> getInstTypeValidSystem(String instType){
		return subsystemDao.getByInstTypeStatus(instType, MBoolean.ENABLED.toString());
	}
	
	public List<Subsystem> getByInstTypeStatus(String instType,String status){
		return subsystemDao.getByInstTypeStatus(instType, status);
	}

	/**
	 * 获得用户组授权的子系统
	 * @param groupId
	 * @return
	 */
	public List<Subsystem> getGrantSubsByGroupId(String groupId){
		return subsystemDao.getGrantSubsByGroupId(groupId);
	}
	
	public List<Subsystem> getGrantSubsByUserId(String userId,String tenantId,String instType){
		return subsystemDao.getGrantSubsByUserId(userId,tenantId,instType);
	}
	
	/**
	 * 获得用户组授权下访问的子系统
	 * @param groupIds
	 * @return
	 */
	public List<Subsystem> getGrantSubsByGroupIds(Collection<String> groupIds){
		if(groupIds==null || groupIds.size()==0){
			return new ArrayList<Subsystem>();
		}
		return subsystemDao.getGrantSubsByGroupIds(groupIds);
	}
	

	/**获取所有某状态的租户下的子系统
	 * @param status
	 * @param tenantId
	 * @return
	 */
	public List<Subsystem> getByStatus(String status,String tenantId){
		return subsystemDao.getByTenantStatus(status,tenantId);
	}
	
	/**
	 * 产生子系统密钥。
	 * @return
	 */
	public String genSecret(){
		String str="";
		try {
			String uuid=UUID.randomUUID().toString();
			str = Base64Util.encodeUtf8(uuid).toLowerCase();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}
	
	
		
	
	
}