package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
/**
 * 
 * @author csx
 * 关系实例查询
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Repository
public class OsRelInstDao extends BaseMybatisDao<OsRelInst>{
	
	@Override
	public String getNamespace() {
		return OsRelInst.class.getName();
	}


	public List<OsRelInst> getByGroupIdRelTypeId(String groupId,String relTypeId,SqlQueryFilter filter){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("groupId", groupId);
		params.put("relTypeId", relTypeId);
		//
		if(filter!=null){
			params.putAll(filter.getParams());
		}
		return this.getBySqlKey("getByGroupIdRelTypeId", params);
	}
	
	
	public List<OsRelInst> getByGroupIdRelTypeId(String groupId,String relTypeId){
		return getByGroupIdRelTypeId(groupId,relTypeId,null);
	}

	/**
	 * 按关系类型来和租户ID删除关系实例
	 *@param userId
	 * @param tenantId
	 */
	public void delByParty2AndTenantId(String userId,String tenantId) {
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("party2", userId);
		params.put("tenantId", tenantId);
		this.deleteBySqlKey("delByParty2AndTenantId", params);
	}

	/**
	 * 按关系类型来删除关系实例
	 * 
	 * @param relTypeId
	 */
	public void deleteByRelTypeId(String relTypeId) {
		this.deleteBySqlKey("deleteByRelTypeId", relTypeId);
	}

	/**
	 * 按party2方来删除关系记录
	 * 
	 * @param party2
	 */
	public void delByParty2(String party2) {
		this.deleteBySqlKey("delByParty2", party2);
	}
	
	public OsRelInst getByParty1RelTypeId(String party1,String relTypeId){
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party1", party1);
		params.put("relTypeId", relTypeId);
		return this.getUnique("getByParty1RelTypeId", params);
	}
	 
	 public List<OsRelInst> getByParty2RelTypeId(String party2,String relTypeId){
		 Map<String,Object> params = new HashMap<String,Object>();
	 	 params.put("party2", party2);
		 params.put("relTypeId", relTypeId);
		 return this.getBySqlKey("getByParty2RelTypeId", params);
	 }
	 

	/**
	 * 删除用户组
	 * 
	 * @param groupId
	 */
	public void delByGroupId(String groupId) {
		String key = "delByGroupId";
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party1", groupId);
		params.put("relType", OsRelType.REL_TYPE_GROUP_USER);
		this.deleteBySqlKey(key, params);

		params.put("relType", OsRelType.REL_TYPE_GROUP_GROUP);
		this.deleteBySqlKey(key, params);

		params = new HashMap<String,Object>();
		params.put("party2", groupId);
		params.put("relType", OsRelType.REL_TYPE_GROUP_GROUP);
		this.deleteBySqlKey(key, params);
	}

	/**
	 * 删除用户组与用户有某种类型关系的关系实例
	 * 
	 * @param groupId
	 * @param userId
	 * @param relTypeId
	 */
	public void delByGroupIdUserIdRelTypeId(String groupId, String userId,
			String relTypeId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party1", groupId);
		params.put("party2", userId);
		params.put("relTypeId", relTypeId);
		this.deleteBySqlKey("delByGroupIdUserIdRelTypeId",params);
	}

	/**
	 * 取得某种关系的根节点，只针对用户间的关系及用户组的关系
	 * 
	 * @param typeId
	 * @return
	 */
	public OsRelInst getByRootInstByTypeId(String typeId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party1", "0");
		params.put("relTypeId", typeId);
		return this.getUnique("getByRootInstByTypeId", params);
	}

	/**
	 * 通过用户Id来删除关系
	 * 
	 * @param userId
	 */
	public void delByUserId(String userId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party2", userId);
		params.put("relType", OsRelType.REL_TYPE_GROUP_USER);
		this.deleteBySqlKey("delByGroupId", params);
		params.put("relType", OsRelType.REL_TYPE_GROUP_GROUP);
		this.deleteBySqlKey("delByGroupId", params);
	}

	/**
	 * 查找某个租户下的实体关系列表
	 * 
	 * @param relTypeId
	 * @param tenantId
	 * @return
	 */
	public List<OsRelInst> getByRelTypeIdTenantId(String relTypeId,
			String tenantId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByRelTypeIdTenantId", params);
	}
	
	/**
	 * 是否存在于关系中
	 * @param relTypeId
	 * @param party
	 * @return
	 */
	public boolean isPartyExistInRelation(String relTypeId,String party){
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("party1", party);
		params.put("party2", party);
		Long cnt=(Long)this.getOne("isPartyExistInRelation", params);
		if(cnt!=null && cnt>0){
			return true;
		}
		return false;
	}

	/**
	 * 按关系双方及关系类型查找
	 * 
	 * @param party1
	 * @param party2
	 * @param relTypeId
	 * @return
	 */
	public OsRelInst getByParty1Party2RelTypeId(String party1, String party2,
			String relTypeId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("party1", party1);
		params.put("party2", party2);
		List<OsRelInst> list = this.getBySqlKey("getByParty1Party2RelTypeId", params);
		if (list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	/**
	 * 获得用户组下的所有从属关系的所有用户
	 * 
	 * @param userId
	 * @param tenantId
	 * @return
	 */
	public List<OsRelInst> getBelongGroupsByUserId(String userId,
			String tenantId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeKey", OsRelType.REL_CAT_GROUP_USER_BELONG);
		params.put("party2", userId);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getBelongGroupsByUserId", params);
	}
	/**
	 * 按关系分类ID及关系方1查找实例
	 * 
	 * @param relTypeId
	 * @param party1
	 * @return
	 */
	public List<OsRelInst> getByRelTypeIdParty1(String relTypeId, String party1,String tenantId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("party1", party1);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByRelTypeIdParty1", params);
	}

	/**
	 * 按关系分类ID及关系方2查找实例
	 * 
	 * @param relTypeId
	 * @param party2
	 * @return
	 */
	public List<OsRelInst> getByRelTypeIdParty2(String relTypeId, String party2) {
		String tenantId = ContextUtil.getCurrentTenantId();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("party2", party2);
		if(StringUtil.isNotEmpty(tenantId))
			params.put("tenantId", tenantId);
		return this.getBySqlKey("getByRelTypeIdParty2", params);
	}

	/**
	 * 获得用户其他关系的实例
	 * 
	 * @param userId
	 * @return
	 */
	public List<OsRelInst> getUserOtherRelInsts(String userId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party2", userId);
		params.put("relType1", OsRelType.REL_TYPE_GROUP_USER);
		params.put("relType2", OsRelType.REL_TYPE_USER_USER);
		params.put("relTypeKey", OsRelType.REL_CAT_GROUP_USER_BELONG);
		return this.getBySqlKey("getUserOtherRelInsts", params);
	}

	/**
	 * 按关系方1 关系类型 是否主关系查找实例
	 * 
	 * @param party1
	 * @param
	 * @param isMain
	 * @return
	 */
	public List<OsRelInst> getByParty1RelTypeIsMain(String party1,
			String relType, String isMain) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("party1", party1);
		params.put("relTypeKey", relType);
		params.put("isMain", isMain);
		return this.getBySqlKey("getByParty1RelTypeIsMain", params);
	}

	/**
	 * 按关系方1 类型 查找实例
	 * 
	 * @param type
	 * @param part1
	 * @return
	 */
	public List<OsRelInst> getByTypePart1(String type, String part1) {

		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeKey", type);
		params.put("part1", part1);
		return this.getBySqlKey("getByTypePart1", params);
	}

	/**
	 * 按关系方1 关系方2 类型 查找实例
	 * 
	 * @param type
	 * @param part1
	 * @param part2
	 * @return
	 */
	public List<OsRelInst> getByTypePart1Part2(String type, String part1,
			String part2) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relType", type);
		params.put("part1", part1);
		params.put("part2", part2);
		return this.getBySqlKey("getByTypePart1Part2", params);
	}

	/**
	 * 按关系分类ID 维度ID及关系方2查找实例
	 * 
	 * @param relTypeId
	 * @param party2
	 * @param dim1
	 * @return
	 */
	public List<OsRelInst> getByRelTypeIdParty2Dim1(String relTypeId,
			String party2, String dim1) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("party2", party2);
		params.put("dim1", dim1);
		return this.getBySqlKey("getByRelTypeIdParty2Dim1", params);
	}
	
	public List<OsRelInst> getByPathRelTypeId(String relTypeId,
			String path) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("relTypeId", relTypeId);
		params.put("path", path);
		return this.getBySqlKey("getByPathRelTypeId", params);
	}
	
}
