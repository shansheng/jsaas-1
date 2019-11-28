
/**
 * 
 * <pre> 
 * 描述：机构类型 DAO接口
 * 作者:mansan
 * 日期:2017-07-10 18:35:31
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysInstType;

@Repository
public class SysInstTypeDao extends BaseMybatisDao<SysInstType> {

	@Override
	public String getNamespace() {
		return SysInstType.class.getName();
	}
	
	public List<SysInstType> getValidExludePlatform(){
		List<SysInstType> list=this.getBySqlKey("getValidExludePlatform", MBoolean.YES.name());
		return list;
	}
	
	public List<SysInstType> getValidAll(){
		List<SysInstType> list=this.getBySqlKey("getValidAll", MBoolean.YES.name());
		return list;
	}
	
	public SysInstType getByCode(String typeCode){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("typeCode", typeCode);
		SysInstType instType=this.getUnique("getByCode", params);
		return instType;
	}
	
	

}

