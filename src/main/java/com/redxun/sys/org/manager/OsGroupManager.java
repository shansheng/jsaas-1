package com.redxun.sys.org.manager;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Function;
import com.google.common.collect.Maps;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.seq.IdGenerator;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.tree.TreeNode;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysMenu;
import com.redxun.sys.core.manager.SysMenuManager;
import com.redxun.sys.org.dao.OsGroupDao;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsGroupMenu;
import com.redxun.sys.org.entity.OsGroupSys;
import com.redxun.sys.org.entity.OsRelType;
/**
 * <pre> 
 * 描述：OsGroup业务服务类
 * 构建组：saweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class OsGroupManager extends BaseManager<OsGroup>{
	@Resource
	private OsGroupDao osGroupDao;
	
	@Resource
	private IdGenerator idGenerator;
	
	@Resource
	private OsGroupSysManager osGroupSysManager;
	@Resource
	private SysMenuManager sysMenuManager;
	@Resource
	private OsGroupMenuManager osGroupMenuManager;
	@Resource
	private OsRelTypeManager osRelTypeManager;
	@Resource
	private OsRelInstManager osRelInstManager;
	
	@Resource
	OsDimensionManager osDimensionManager;
	@Resource
	SqlSessionTemplate sqlSessionTemplate;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osGroupDao;
	}
	
	public List<OsGroup> getByDepName(String depName){
		return osGroupDao.getByDepName(depName);
	}
	
	public List<OsGroup> getByGroupNameExcludeAdminDim(String groupName){
		return osGroupDao.getByGroupNameExcludeAdminDim(groupName);
	}


	public List<OsGroup> getByUserIdConfig(String userId) {
		return osGroupDao.getByUserIdConfig(userId);
	}

	public List<OsGroup> getByMyParentId(String parentId){
		return osGroupDao.getByMyParentId(parentId);
	}


	/**
	 *根据	SQL查询用户列表
	 */
	public List<OsGroup> getBySql(String sql){
		return  osGroupDao.getBySql(sql);
	}

	/**
	 * 获得组的全路径
	 * @param groupId
	 * @return
	 */
	public String getGroupFullPathNames(String groupId){
		OsGroup group=get(groupId);
		if(group==null) return "";
		if(StringUtils.isEmpty(group.getPath())){
			return group.getName();
		}
		
		String[]paths=group.getPath().split("[.]");
		
		StringBuffer sb=new StringBuffer();
		for(String id:paths){
			if("0".equals(id)){
				continue;
			}
			OsGroup p=get(id);
			if(p==null){
				continue;
			}
			if(sb.length()>0){
				sb.append("/");
			}
			sb.append(p.getName());
		}
		return sb.toString();
	}
	
	/**
	 * 删除用户组及更新父组的childs
	 * @param groupId
	 */
	public void delAndUpdateChilds(String groupId){
		OsGroup group=osGroupDao.get(groupId);
		if(group==null) return;
		
		if(group.getParentId()!=null && !"0".equals(group.getParentId())){
			OsGroup pGroup = get(group.getParentId());
			int i = osGroupDao.getCountByparentId(group.getParentId());
			pGroup.setChilds(i-1);
			update(pGroup);
		}
		osGroupDao.delete(groupId);
		//删除中间的关系
		osRelInstManager.delByGroupId(groupId);
		//按用户组Id删除
		osGroupMenuManager.deleteByGroupId(groupId);
	}
	/**
	 * 初始化一个人事部门
	 */
	public OsGroup addInitPersonalGroup(SysInst inst){
		OsGroup osGroup=new OsGroup();
		String id=IdUtil.getId();
		osGroup.setGroupId(id);
		osGroup.setName(inst.getNameCn());
		osGroup.setKey(inst.getInstNo());
		osGroup.setRankLevel(1);
		osGroup.setParentId("0");
		osGroup.setPath("0."+id+".");
		osGroup.setDimId(OsDimension.DIM_ADMIN_ID);
		osGroup.setTenantId(inst.getTenantId());
		osGroup.setStatus(MBoolean.ENABLED.name());
		osGroup.setSn(1);
		create(osGroup);
		return osGroup;
	}
	
	 /**
     * 按维度Id及name,key查找用户组列表
     * @param tenantId
     * @param dimId
     * @param name
     * @param key
     * @return
     */
    public List<OsGroup> getByDimIdNameKey(String tenantId,String dimId,String name,String key){
    	return osGroupDao.getByDimIdNameKey(tenantId, dimId, name, key);
    }
	
	/**
     * 取得该父节点下的所有子结节点
     * @param parentId 父Id
     * @param tenantId 租用机构ID
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByParentId(String parentId,String tenantId){
    	return osGroupDao.getByParentId(parentId, tenantId);
    }
    
    /**
     * 取得该父节点下的所有子结节点
     * @param parentId 父Id
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByParentId(String parentId){
    	return osGroupDao.getByParentId(parentId);
    }
    /**
     * 取得某组下的子组数，不包括下下级
     * @param parentId
     * @return 
     * Long
     * @exception 
     * @since  1.0.0
     */
    public Long getChildCounts(String parentId){
    	return osGroupDao.getChildCounts(parentId);
    }
	
	  /**
     * 按维度ID取得该维度下的所有用户组
     * @param dimId
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByDimId(String dimId){
    	return osGroupDao.getByDimId(dimId);
    }
    
    public List<OsGroup> getByDimIdGroupIdTenantId(String dimId,String parentId,String tenantId){
    	return osGroupDao.getByDimIdGroupIdTenantId(dimId, parentId, tenantId);
    }

	/**
	 * 权限分级管理
	 * @param dimId
	 * @param parentId
	 * @param tenantId
	 * @return
	 */
	public List<OsGroup> getRoleByDimIdGroupIdTenantId(String dimId,String parentId,String tenantId){
		if("1".equals(dimId)) {
			return osGroupDao.getByDimIdGroupIdTenantIdAdmin(dimId, parentId, tenantId);
		}else if("2".equals(dimId)) {
			return osGroupDao.getByDimIdGroupIdTenantIdRole(dimId, parentId, tenantId);
		}else {
			return osGroupDao.getByDimIdGroupIdTenantId(dimId, parentId, tenantId);
		}
	}

	/**
	 * 根据维度ID取得某用户所分配的分级行政维度
	 * @param groupIdList
	 * @return
	 */
	public List<OsGroup> getByGroupId(List<String> groupIdList){
		return this.osGroupDao.getByGroupId(groupIdList);
	}
 
    /**
     * 根据用户名及维度Key查找
     * @param dimKey
     * @param groupName
     * @return
     */
    public List<OsGroup> getByDimKeyGroupName(String dimKey,String groupName){
    	String tenantId=ContextUtil.getCurrentTenantId();
    	OsDimension osDimension=osDimensionManager.getByDimKeyTenantId(dimKey, tenantId);
    	if(osDimension==null){
    		return new ArrayList<OsGroup>();
    	}
    	List<OsGroup> osGroups=osGroupDao.getByDimIdNameKey(tenantId, osDimension.getDimId(), groupName, null);
    	return osGroups;
    }
    
    /**
     * 按维度ID及租户Id取得该维度下的所有用户组
     * @param dimId
     * @param tenantId
     * @return
     */
    public List<OsGroup> getByDimIdTenantId(String dimId,String tenantId){
    	return osGroupDao.getByDimIdTenantId(dimId, tenantId);
    }
    
    public List<TreeNode> getTreeNodes(String dimId){
		 List<TreeNode> treeNodes=new ArrayList<TreeNode>();
		 List<OsGroup> groups=osGroupDao.getByDimIdParentId(dimId, "0");
		 for(OsGroup group:groups){
			 TreeNode node=new TreeNode();
			 node.setId(group.getGroupId());
			 node.setText(group.getName());
			 node.setKey(group.getKey());
			 node.setSn(group.getSn());
			 List<TreeNode> childNodes=getChildNodes(group);
			 if(childNodes.size()>0){
				 node.setLeaf(false);
			 }else{
				 node.setLeaf(true);
			 }
			 node.setChildren(childNodes);
			 treeNodes.add(node);
		 } 
		 return treeNodes;
	 }
	 
	 /**
	  * 取得某个树节点下的所有子节点
	  * @param
	  * @return 
	  * List<TreeNode>
	  * @exception 
	  * @since  1.0.0
	  */
	 private List<TreeNode> getChildNodes(OsGroup group){
		 List<TreeNode> childNodes=new ArrayList<TreeNode>();
		 if(group.getChilds()==null || group.getChilds()<=0) return childNodes;
		 List<OsGroup> childs=osGroupDao.getByParentId(group.getGroupId());
		 for(OsGroup osGroup:childs){
			 TreeNode item=new TreeNode();
			 item.setId(osGroup.getGroupId());
			 item.setText(osGroup.getName());
			 item.setKey(osGroup.getKey());
			 item.setSn(osGroup.getSn());
			 if(osGroup.getChilds()>0){
				 item.setLeaf(false);
				 item.setChildren(getChildNodes(osGroup));
			 }else{
				 item.setLeaf(true);
			 }
			 childNodes.add(item);
		 }
		 return childNodes;
	 }
	 
	 /**
	 * 查找某个用户组下的用户,并且按条件过滤
	 * @param filter
	 * @return
	 */
	public List<OsGroup> getByGroupIdRelTypeId(SqlQueryFilter filter){
		return osGroupDao.getByGroupIdRelTypeId(filter);
	}
	
	/**
	 * 取得用户下有某种关系的所有用户组
	 * @param userId
	 * @param relTypeId
	 * @return
	 */
	public List<OsGroup> getByUserIdRelTypeId(String userId,String relTypeId){
		return osGroupDao.getByUserIdRelTypeId(userId, relTypeId);
	}
	
	/**
	 * 取得用户拥有的用户组
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getByUserId(String userId){
		return osGroupDao.getByUserId(userId);
	}
	
	/**
	 * 取得用户从属于的用户组列表
	 * @param userId
	 * @param
	 * @return
	 */
	public List<OsGroup> getBelongGroups(String userId){
		//OsRelType osRelType=osRelTypeManager.getBelongRelType(tenantId);
		//if(osRelType==null) return new ArrayList<OsGroup>();
		return getByUserIdRelTypeId(userId,OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
	}
	
	public Map<String,OsGroup> getBelongGroupsMap(String userId){
		List<OsGroup> groups=getBelongGroups(userId);
		Map<String, OsGroup> mappedGroups = Maps.uniqueIndex(groups, new Function<OsGroup, String>() {
			public String apply(OsGroup input) {
				return input.getGroupId();
			}
		});
		return mappedGroups;
	}
	
	/**
	 * 取得用户从属的部门组
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getBelongDeps(String userId){
		return osGroupDao.getByDimIdUserIdRelTypeId(OsDimension.DIM_ADMIN_ID,
				userId, OsRelType.REL_CAT_GROUP_USER_BELONG_ID);
	}
	
	public OsGroup getBelongDep(String userId){
		List<OsGroup> groups=getBelongDeps(userId);
		if(groups.size()>0){
			return groups.get(0);
		}
		return null;
	}
	
	/**
	 * 获得用户所在的部门的全路径名
	 * @param userId
	 * @return
	 */
	public String getMainDepFullNames(String userId){
		IUser curUser=ContextUtil.getCurrentUser();
		String logTenantId = curUser.getTenant().getTenantId();
		OsGroup mainDep=getMainDeps(userId,logTenantId);
		if(mainDep==null || StringUtils.isEmpty(mainDep.getPath())) return "";
		
		String[] mainDepIds=mainDep.getPath().split("[.]");
		StringBuffer depBuf=new StringBuffer();
		for(String depId:mainDepIds){
			if("0".equals(depId)){
				continue;
			}
			OsGroup group=get(depId);
			if(group!=null){
				depBuf.append(group.getName()).append("/");
			}
		}
			
		return depBuf.toString();
	}
	
	/**
	 * 取得用户的主部门
	 * @param userId
	 * @return
	 */
	public OsGroup getMainDeps(String userId,String tenantId){
		List<OsGroup> groups=osGroupDao.getByDimIdUserIdRelTypeIdIsMain(OsDimension.DIM_ADMIN_ID,
				userId, OsRelType.REL_CAT_GROUP_USER_BELONG_ID,MBoolean.YES.name(),tenantId);
		if(groups.size()>0){
			return groups.get(0);
		}
		return null;
	}
	
	public OsGroup getByParentIdGroupName(String parentId,String name){
		return osGroupDao.getByParentIdGroupName(parentId, name);
	}
	
	/**
	 * 获取该用户在某维度下的第一个用户组
	 * @param dimId
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getByDimIdAndUserId(String dimId,String userId,String tenantId){
		return osGroupDao.getByDimIdUserId(dimId, userId,tenantId);
	}
	/**
	 * 获得用户的从属部门
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getCanDeps(String userId,String tenantId){
		List<OsGroup> groups=osGroupDao.getByDimIdUserIdRelTypeIdIsMain(OsDimension.DIM_ADMIN_ID,
				userId, OsRelType.REL_CAT_GROUP_USER_BELONG_ID,MBoolean.NO.name(),tenantId);
		return groups;
	}
	
	/**
	 * 取得候选的用户组，不含部门
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getCanGroups(String userId,String tenantId){
		List<OsGroup> groups=osGroupDao.getByParty2RelType(userId, OsRelType.REL_TYPE_GROUP_USER,(StringUtil.isNotEmpty(tenantId)?tenantId:ContextUtil.getCurrentTenantId()));
		List<OsGroup> tps=new ArrayList<OsGroup>();
		for(OsGroup group:groups){
			if(group!=null && !OsRelType.REL_CAT_GROUP_USER_BELONG_ID.equals(group.getDimId())){
				tps.add(group);
			}
		}
		return tps;
	}
	
	/**
	 * 保存用户组的授权访问的子系统及菜单
	 * @param groupId
	 * @param menuIds 菜单Id
	 * @param sysIdSet 系统Id
	 */
	public void saveGrantMenus(String groupId,Set<String> menuIds,Set<String> sysIdSet){
		
		//删除该Group原授权的子系统
		osGroupSysManager.deleteByGroupId(groupId);
		
		//删除该Group原授权的子菜单
		osGroupMenuManager.deleteByGroupId(groupId);
		
		//生成可以访问的子系统
		for(String sysId:sysIdSet){
			OsGroupSys gs=new OsGroupSys(idGenerator.getSID(), groupId, sysId);
			osGroupSysManager.create(gs);
		}
		
		//生成可以访问的菜单
		for(String menuId:menuIds){
			SysMenu sysMenu=sysMenuManager.get(menuId);
			if(sysMenu==null || sysMenu.getSysId()==null) continue;
			OsGroupMenu m=new OsGroupMenu(idGenerator.getSID(), groupId, menuId,sysMenu.getSysId());
			osGroupMenuManager.create(m);
			
		}

	}
	
	public void create(OsGroup entity){
		super.create(entity);
		if(StringUtils.isNotEmpty(entity.getParentId())&&(!"0".equals(entity.getParentId()))){
			OsGroup pGroup = get(entity.getParentId());
			if(pGroup==null) return;
			int i = osGroupDao.getCountByparentId(entity.getParentId());
			pGroup.setChilds(i);
			update(pGroup);
		}
	}
	
	@Test
	public void setGroupChilds(){
		List<OsGroup> osGroups = getAll();
		for(OsGroup group:osGroups){
			String parentId = group.getGroupId();
				int i = osGroupDao.getCountByparentId(parentId);
				group.setChilds(i);
				update(group);
			}
		}
	
	/**
	 * 获取主部门以及在主部门路径上的所有的组(待优化:用foreach的in增加效率)
	 * @param groupId
	 * @return
	 */
	public List<OsGroup> getRelatedGroupByGroupId(String groupId){
		OsGroup osGroup=get(groupId);
		String path=osGroup.getPath();
		String[] pathArray=path.split("[.]");
		List<OsGroup> osGroups=new ArrayList<OsGroup>();
		for (String singleId : pathArray) {
			if(StringUtils.isNotBlank(singleId)){
				OsGroup group=get(singleId);
				if(group!=null){
					osGroups.add(group);
				}
			}
		}
		return osGroups;
	}
	
	
	

	
    /**
     *  获得该Id下的子类数
     * @param parentId
     * @return
     */
    public int getCountByparentId(String parentId){
    	return osGroupDao.getCountByparentId(parentId);
    }
	
	/**
	 * 通过groupId 获取name
	 * @param groupIds
	 * @return
	 */
	public String getNameByGroupId(String groupIds){
		String[] groupArray=groupIds.split(",");
		StringBuilder stringBuilder=new StringBuilder("");
		for (int i = 0; i < groupArray.length; i++) {
			String groupId=groupArray[i];
			OsGroup osGroup=get(groupId);
			if(osGroup!=null){
				stringBuilder.append(osGroup.getName());
				stringBuilder.append(",");
			}
		}
		if(stringBuilder.length()>0){
			stringBuilder.deleteCharAt(stringBuilder.length()-1);
		}
    	return stringBuilder.toString();
    }
	
	
	/**
	 * 根据返回指定等级的组织。
	 * @param groupId
	 * @param level
	 * @return
	 */
	public OsGroup getByLevel(String groupId,Integer level){
		OsGroup group=this.get(groupId);
		return getByLevel(group, level);
	}
	
	
	/**
	 * 根据返回指定等级的组织。
	 * @param group	组织
	 * @param level	级别
	 * @return
	 */
	public OsGroup getByLevel(OsGroup group,Integer level){
		if(level>=group.getRankLevel()) return group;
		String path=group.getPath();
		path=StringUtil.trimPrefix(path, "0.");
		path=StringUtil.trimSuffix(path, ".");
		String[] aryPath=path.split("[.]");
		int len=aryPath.length-2;
		if(len<0) return null;
		
		for(int i=len;i>=0;i--){
			String id=aryPath[i];
			group=get(id);
			if(group.getRankLevel().equals(level)) {
				return group;
			}
		}
		return null;
	}
	
	public Integer getMaxPid(){
		return osGroupDao.getMaxPid();
	}
	
	/**
	 * 根据菜单ID获取有权限的组。
	 * @param menuId
	 * @return
	 */
	public List<OsGroup> getByMenuId(String menuId){
		return osGroupDao.getByMenuId(menuId);
	}
	
	public OsGroup getByPath(String path){
		return osGroupDao.getByPath(path);
	}
	
	public List<OsGroup> getByPathLeftLike(String path,String tenantId){
		return osGroupDao.getByPathLeftLike(path,tenantId);
	}


	/**
	 * 根据指定维度和等级查找所有用户组，不含父子用户组
	 * @author Stephen
	 * @param dimId
	 * @param
	 * @return
	 */
	public List<OsGroup> getByDimAndLevel(String dimId, String rankLevel){
		return osGroupDao.getByDimAndLevel(dimId,rankLevel);

	}
	
	
	public List<OsGroup> getByDimAndParent(String tenantId,String dimId, String parentId){
		return osGroupDao.getByDimAndParent(tenantId,dimId,parentId);

	}
	
	

	/**
	 * 根据父用户组获取当前用户所属部门
	 * @param clickNodeId
	 * @param tenantId
	 * @param currentUserId
     * @return
     */
	public List<OsGroup> getByParentIdBelongs(String clickNodeId,String tenantId,String currentUserId){
		return osGroupDao.getByParentIdBelongs(clickNodeId,tenantId,currentUserId);
	}



	public OsGroup getByKeyTenantId(String key,String tenantId) {
		return osGroupDao.getByKeyTenantId(key,tenantId);
	}

	public void syncGroup(JSONArray jsonArray) throws Exception{
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json=jsonArray.getJSONObject(i);

			OsGroup group=new OsGroup();
			Long deptId=json.getLong("deptId");
			String deptName=json.getString("deptName");
			String deptCode=json.getString("deptCode");
			String status=json.getInteger("status")==1?"ENABLED":"DISABLED";
			Long parentDeptId=json.getLong("parentDeptId");
			boolean isParent=json.getBoolean("isParent");
			Integer sort=json.getInteger("sort");
			Date createTime=json.getDate("createTime");
			Date updateTime=json.getDate("updateTime");
			Long timestamp=json.getLong("timestamp");

			Long companyId=json.getLong("companyId");
			group.setPkId(String.valueOf(deptId));
			group.setGroupId(String.valueOf(deptId));
			group.setName(deptName);
			group.setDimId("1");
			group.setStatus(status);
			group.setSn(sort);
			group.setKey(deptCode);
			group.setTenantId(String.valueOf(companyId));
			group.setCreateTime(createTime);
			group.setUpdateTime(updateTime);
			
			group.setParentId(String.valueOf(parentDeptId));

			getParent(group,group.getGroupId(),group.getParentId(),isParent);

			this.saveOrUpdate(group);
		}
	}

	private String getParent(OsGroup group,String groupId,String parentId,boolean isParent) throws Exception{
		String msg="";
		OsGroup oldGroup=get(groupId);
		if(null==oldGroup) {
			if(Long.parseLong(parentId)==0L) {
				group.setParentId("0");
				group.setRankLevel(1);
				group.setPath("0."+groupId+".");
				group.setDepth(1);
			}else {
				OsGroup parentGroup=get(parentId);
				if(parentGroup==null) {
					msg="父部门（ID为"+parentId+"）还未插入!";
				}else {
					group.setParentId(parentId);
					group.setRankLevel(parentGroup.getRankLevel()+1);
					group.setPath(parentGroup.getPath()+groupId+".");
					group.setDepth(parentGroup.getDepth()+1);
					parentGroup.setChilds(parentGroup.getChilds()+1);
					update(parentGroup);
				}
			}
		}else {
			OsGroup oldParentGroup=get(oldGroup.getParentId());

			if(!isParent) {
				group.setParentId("0");
				group.setRankLevel(1);
				group.setPath("0."+groupId+".");
				group.setDepth(1);

			}


			if(Long.parseLong(parentId)==0L) {

			}else {
				OsGroup parentGroup=get(parentId);
				if(parentGroup==null) {
					msg="父部门（ID为"+parentId+"）还未插入!";
				}else {
					group.setParentId(parentId);
					group.setRankLevel(parentGroup.getRankLevel()+1);
					group.setPath(parentGroup.getPath()+groupId+".");
					group.setDepth(parentGroup.getDepth()+1);
					parentGroup.setChilds(parentGroup.getChilds()+1);
					update(parentGroup);
				}
			}
			oldParentGroup.setChilds(oldParentGroup.getChilds()-1);
			update(oldParentGroup);
		}
		return msg;
	}












	public void syncGroupSingle(JSONArray jsonArray) throws Exception{
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json=jsonArray.getJSONObject(i);

			OsGroup group=new OsGroup();
			Long deptId=json.getLong("deptId");
			String deptName=json.getString("deptName");
			String deptCode=json.getString("deptCode");
			String status=json.getInteger("status")==1?"ENABLED":"DISABLED";
			Long parentDeptId=json.getLong("parentDeptId");
			boolean isParent=json.getBoolean("parent");
			Integer sort=json.getInteger("sort");
			Date createTime=json.getDate("createTime");
			Date updateTime=json.getDate("updateTime");
			Long timestamp=json.getLong("timestamp");

			//Long companyId=json.getLong("companyId");
			group.setGroupId(String.valueOf(deptId));
			group.setName(deptName);
			group.setDimId("1");
			group.setStatus(status);
			group.setSn(sort);
			group.setKey(deptCode);
			group.setTenantId(SysInst.ADMIN_TENANT_ID);
			group.setCreateTime(createTime);
			group.setUpdateTime(updateTime);
			group.setParentId(String.valueOf(parentDeptId));

			OsGroup tmpGroup=getByKeyTenantId(String.valueOf(deptId), SysInst.ADMIN_TENANT_ID);
			if(tmpGroup==null)
				group.setChilds(0);
			else {
				List<OsGroup> childGroups=getByParentId(tmpGroup.getGroupId(), SysInst.ADMIN_TENANT_ID);
				group.setChilds(childGroups.size());
			}


			String msg=getParentSingle(group,group.getGroupId(),group.getParentId(),isParent);
			if(StringUtil.isEmpty(msg))
				sqlSessionTemplate.insert(OsGroup.class.getName() + ".insertOrUpdate", group);
			else
				throw new Exception(msg);
		}
	}

	private String getParentSingle(OsGroup group,String groupId,String parentId,boolean isParent) throws Exception{
		String msg="";
		OsGroup oldGroup=get(groupId);
		if(null==oldGroup) {
			if(Long.parseLong(parentId)==0L) {
				group.setParentId("0");
				group.setRankLevel(1);
				group.setPath("0."+groupId+".");
				group.setDepth(1);
				group.setChilds(0);
			}else {
				OsGroup parentGroup=get(parentId);
				if(parentGroup==null) {
					msg="父部门（ID为"+parentId+"）还未插入!";
				}else {
					group.setParentId(parentId);
					group.setRankLevel(parentGroup.getRankLevel()+1);
					group.setPath(parentGroup.getPath()+groupId+".");
					group.setDepth(parentGroup.getDepth()+1);
					group.setChilds(0);
					parentGroup.setChilds(parentGroup.getChilds()+1);
					update(parentGroup);
				}
			}
		}else {
			OsGroup oldParentGroup=get(oldGroup.getParentId());
			if(!oldGroup.getParentId().equals(parentId)) {
					Map<String,OsGroup> oldGroups=new HashMap<String,OsGroup>();

					Map<String,OsGroup> newGroups=new HashMap<String,OsGroup>();

					if(Long.parseLong(parentId)==0L) {
						group.setParentId("0");
						group.setRankLevel(1);
						group.setPath("0."+groupId+".");
						group.setDepth(1);
						List<OsGroup> updateGroups =getByPathLeftLike(oldGroup.getPath(), SysInst.ADMIN_TENANT_ID);
						oldGroups.put(group.getGroupId(), group);
						for (OsGroup osGroup : updateGroups) {
							oldGroups.put(osGroup.getGroupId(), osGroup);
						}
						for (Map.Entry<String, OsGroup> entry : oldGroups.entrySet()) {
							OsGroup record=(OsGroup)entry.getValue();

							OsGroup parentRecord=oldGroups.get(record.getParentId());

							if(parentRecord==null)
								continue;
							record.setPath(parentRecord.getPath()+record.getGroupId()+".");
							record.setDepth(parentRecord.getDepth()+1);
							newGroups.put(record.getGroupId(), record);
						}
						for (Map.Entry<String, OsGroup> entry : newGroups.entrySet()) {
							OsGroup newRecord=(OsGroup)entry.getValue();
							update(newRecord);
						}

					}else {
						OsGroup newParentGroup=get(parentId);
						if(newParentGroup==null)
							msg="父部门（ID为"+parentId+"）还未插入!";
						else {
							group.setParentId(parentId);
							group.setRankLevel(newParentGroup.getRankLevel()+1);
							group.setPath(newParentGroup.getPath()+groupId+".");
							group.setDepth(newParentGroup.getDepth()+1);
							//group.setDepth(newParentGroup.getDepth()+1);
							newParentGroup.setChilds(newParentGroup.getChilds()+1);

							List<OsGroup> updateGroups =getByPathLeftLike(oldGroup.getPath(), SysInst.ADMIN_TENANT_ID);
							oldGroups.put(group.getGroupId(), group);
							for (OsGroup osGroup : updateGroups) {
								oldGroups.put(osGroup.getGroupId(), osGroup);
							}
							for (Map.Entry<String, OsGroup> entry : oldGroups.entrySet()) {
								OsGroup record=(OsGroup)entry.getValue();

								OsGroup parentRecord=oldGroups.get(record.getParentId());

								if(parentRecord==null)
									continue;
								record.setPath(parentRecord.getPath()+record.getGroupId()+".");
								record.setDepth(parentRecord.getDepth()+1);
								newGroups.put(record.getGroupId(), record);
							}
							for (Map.Entry<String, OsGroup> entry : newGroups.entrySet()) {
								OsGroup newRecord=(OsGroup)entry.getValue();
								update(newRecord);
							}
							update(newParentGroup);
						}
					}
					if(!"0".equals(oldGroup.getParentId())) {
						oldParentGroup.setChilds(oldParentGroup.getChilds()-1);
						update(oldParentGroup);
					}


				/*else {    //叶子节点
					if(Long.parseLong(parentId)==0L) {
						group.setParentId("0");
						group.setRankLevel(1);
						group.setPath("0."+groupId+".");
						group.setDepth(1);
					}else {
						OsGroup newParentGroup=get(parentId);
						if(newParentGroup==null)
							msg="父部门（ID为"+parentId+"）还未插入!";
						else {
							group.setParentId(parentId);
							group.setRankLevel(newParentGroup.getRankLevel()+1);
							group.setPath(newParentGroup.getPath()+groupId+".");
							group.setDepth(newParentGroup.getDepth()+1);
							newParentGroup.setChilds(newParentGroup.getChilds()+1);
							update(newParentGroup);
						}
					}
					if(!"0".equals(oldGroup.getParentId()))
						oldParentGroup.setChilds(oldParentGroup.getChilds()-1);
						update(oldParentGroup);
				}*/
			}

		}
		return msg;
	}

	/**
	 * 根据范围选定所属组
	 * @param dimId
	 * @param initRankLevel
	 * @param currentUserId
	 * @param tenantId
     * @return
     */
	public List<OsGroup> getByDimAndLevelBelongs(String dimId,String initRankLevel,String currentUserId,String tenantId){
		return osGroupDao.getByDimAndLevelBelongs(dimId,initRankLevel,currentUserId,tenantId);
	}

	/**
	 * 根据dimId根据组列表
	 * @param dimId
	 * @param tenantId
	 * @return
	 */
	public boolean getByDimIAndkey(String dimId,String key,String tenantId){
		return osGroupDao.getByDimIAndkey(dimId,key,tenantId);
	}
}