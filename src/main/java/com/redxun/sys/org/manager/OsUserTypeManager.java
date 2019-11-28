package com.redxun.sys.org.manager;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.org.dao.OsUserTypeDao;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUserType;
import java.util.Date;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：用户类型 处理接口
 * 作者:mansan
 * 日期:2018-09-03 14:01:53
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OsUserTypeManager extends MybatisBaseManager<OsUserType>{
	@Resource
	OsGroupManager osGroupManager;
	
	@Resource
	private OsUserTypeDao osUserTypeDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osUserTypeDao;
	}
	
	public OsUserType getOsUserType(String uId){
		OsUserType osUserType = get(uId);
		return osUserType;
	}
	
	/**
	 * 按编号获得用户类型
	 * @param code
	 * @return
	 */
	public OsUserType getByCode(String code){
		return osUserTypeDao.getByCode(code);
	}

	@Override
	public void create(OsUserType entity) {
		entity.setId(IdUtil.getId());
		entity.setCreateTime(new Date());
		entity.setCreateBy(ContextUtil.getCurrentUserId());
		entity.setTenantId(ContextUtil.getCurrentTenantId());
		
		String groupId=IdUtil.getId();
		entity.setGroupId(groupId);
		OsGroup group=new OsGroup();
		group.setGroupId(groupId);
		group.setKey(entity.getCode());
		group.setName(entity.getName());
		group.setTenantId(entity.getTenantId());
		group.setDimId(OsDimension.DIM_ROLE_ID);
		group.setStatus(MBoolean.ENABLED.name());
		group.setParentId("0");
		group.setSn(0);
		osGroupManager.create(group);
		super.create(entity);
	}

	@Override
	public void update(OsUserType entity) {
		entity.setUpdateTime(new Date());
		entity.setUpdateBy(ContextUtil.getCurrentUserId());
		super.update(entity);
	}

	public boolean isCodeExist(OsUserType osUserType) {
		if(StringUtil.isNotEmpty(osUserType.getCode())){
			OsUserType oldType= getByCode(osUserType.getCode());
			if(oldType!=null && !oldType.getId().equals(osUserType.getId())){
				return true;
			}
		}
		return false;
	}
	
}
