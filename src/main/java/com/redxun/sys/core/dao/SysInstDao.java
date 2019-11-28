package com.redxun.sys.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.util.StringUtil;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysInst;
@Repository
public class SysInstDao extends  BaseMybatisDao<SysInst>{

  
    @Override
	public String getNamespace() {
		return SysInst.class.getName();
	}



	/**
	 * 根据登陆用户ID获取用户的所有可以登陆的机构
	 */
	public List<SysInst> getByUserIdAndStatus(String userId,String status){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("userId", userId);
		if(StringUtil.isNotEmpty(status)){
			params.put("status", status);
		}
		return this.getBySqlKey("getByUserIdAndStatus", params);
	}

	/**
	 * 获取所有机构
	 */
	public List<SysInst> getALL(){
		return this.getBySqlKey("getALL", null);
	};

	/**
	 * 根据登陆账号ID获取用户的所有机构
	 */
	public List<SysInst> getByAccountId(String accountId){
		return this.getBySqlKey("getByAccountId", accountId);
	}

    /**
     * 根据域名查找机构
     * @param domain
     * @return
     */
    public SysInst getByDomain(String domain){
    	Map<String,Object> params=new HashMap<String,Object>();
		params.put("domain", domain);
    	SysInst inst=this.getUnique("getByDomain", params);
    	return inst;
    }
    
    /**
     * 根据外部公司Id查询
     * @param
     * @return
     */
    public SysInst getByCompId(String compId){
    	Map<String,Object> params=new HashMap<String,Object>();
		params.put("compId", compId);
    	SysInst inst=this.getUnique("getByCompId", params);
    	return inst;
    }
    
    /**
     * 获得最大的Max序列号
     * @return
     */
    public Integer getMaxIdSn(){
    	Object result=this.getUnique("getMaxIdSn", new HashMap<String,Object>());
    	if(result==null) return 0;
    	return new Integer(result.toString());
    }
    
    /**
     * 按状态获得机构
     * @param status
     * @return
     */
    public List<SysInst> getByStatus(String status){
    	List<SysInst> list=this.getBySqlKey("getByStatus", status);
    	return list;
    }
    
    
    public SysInst getByNameCn(String nameCn){
    	Map<String,Object> params=new HashMap<String,Object>();
		params.put("nameCn", nameCn);
    	SysInst inst=this.getUnique("getByNameCn", params);
    	return inst;
	}
	
	public SysInst getByShortNameCn(String shortNameCn){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("nameCn", shortNameCn);
		SysInst inst=this.getUnique("getByShortNameCn", params);
    	return inst;
	}
    
}
