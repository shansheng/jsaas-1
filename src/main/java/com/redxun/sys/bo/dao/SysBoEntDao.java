
/**
 * 
 * <pre> 
 * 描述：表单实体对象 DAO接口
 * 作者:ray
 * 日期:2017-02-15 15:02:18
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.bo.dao;

import com.redxun.sys.bo.entity.SysBoEnt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.StringUtil;

@Repository
public class SysBoEntDao extends BaseMybatisDao<SysBoEnt> {

	@Override
	public String getNamespace() {
		return SysBoEnt.class.getName();
	}
	
	/**
	 * 根据boDefId 获取实体列表。
	 * @param boDefId
	 * @return
	 */
	public List<SysBoEnt> getByBoDefId(String boDefId){
		return  this.getBySqlKey("getByBoDefId", boDefId);
	}
	/**
	 * 判断系统中是否存在指定别名的实体。
	 * @param alias
	 * @param tenantId
	 * @param id
	 * @return
	 */
	public Integer getCountByAlias(String alias,String tenantId,String id){
		Map<String,Object>  params=new HashMap<String, Object>();
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		
		if(StringUtil.isNotEmpty(id)){
			params.put("id", id);
		}
		return (Integer) this.getOne("getCountByAlias", params);
		
	}
	

	
	/**
	 * 根据主实体获取获取关联实体的数据。
	 * @param entId
	 * @return
	 */
	public List<SysBoEnt> getByMainId(String entId){
		List<SysBoEnt> list= this.getBySqlKey("getByMainId", entId);
		return list;
	}

	public SysBoEnt getByName(String name) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("name", name);
		return (SysBoEnt) this.getOne("getByName", params);
	}
	
	public SysBoEnt getByTableName(String tableName) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("tableName", tableName);
		return (SysBoEnt) this.getOne("getByTableName", params);
	}


	/**
	 * 更新为生成/未生成物理表
	 */
	public void updateTableByKey(String entId,String isCreat){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("isCreat", isCreat);
		params.put("entId", entId);
		this.updateBySqlKey("updateTableByKey",params);
	}
}

