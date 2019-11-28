package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;

/**
 * <pre> 
 * 描述：BpmInst数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmInstDao extends BaseMybatisDao<BpmInst> {

    @Override
    public String getNamespace() {
        return BpmInst.class.getName();
    }
    
    /**
     * 通过Activiti的流程实例ID获得扩展的流程实例列表
     * @param actInstId
     * @return
     */
    public BpmInst getByActInstId(String actInstId){
        Map<String,Object> params = new HashMap<>();
        params.put("actInstId" , actInstId);
        return this.getUnique("getByActInstId", params);
    }
    
    /**
     * 通过解决方案获得流程实例数
     * @param solId
     * @return
     */
    public int getCountsBySolId(String solId){
        return (Integer)this.getOne("getCountsBySolId", solId);
    }
    /**
     * 通过流程定义Id获得实例数
     * @param actDefId
     * @return
     */
    public int getCountsByActDefId(String actDefId){
        return (Integer) this.getOne("getCountsByActDefId", actDefId);
    }

    /**
     * 获得审批历史列表
     * @param filter
     * @return
     */
    public List<BpmInst> getMyCheckInst(SqlQueryFilter filter){
        return this.getBySqlKey("getMyCheckInst", filter.getParams(),filter.getPage());
    }
    /**
     * 获得我审批的实数总数
     * @param filter
     * @return
     */
    public Long getMyCheckInstCount(SqlQueryFilter filter){
        Object count=this.getUnique("getMyCheckInstCounts", filter.getParams());
        if(count!=null){
            return new Long(count.toString());
        }
        return 0L;
    }
    /**
     * 与解决方案分类进行联合查询
     * @param filter
     * @return
     */
    public List<BpmInst> getInstsByTreeId(QueryFilter filter){
        return this.getPageBySqlKey("getInstsByTreeId", filter);
    }


    public List<BpmInst> getInstsByAdminTreeId(QueryFilter filter){
        return this.getPageBySqlKey("getInstsByAdminTreeId", filter);
    }
    public List<BpmInst> getMyInstBySolutionId(QueryFilter filter){
        return this.getPageBySqlKey("getMyInstBySolutionId", filter);
    }

    public List<BpmInst> getInstsForSaasAdmin(QueryFilter queryFilter){
        return this.getPageBySqlKey("getInstsForSaasAdmin", queryFilter);
    }

    /**
     * 获取流程实例用过的分类数据。
     * @param tenantId
     * @param profileMap
     * @return
     */
    public List getCategoryTree(String tenantId, Map<String, Set<String>> profileMap){
        Map<String, Object> params=new HashMap<String, Object>();

        String grantType= BpmAuthSettingManager.getGrantType();
        params.put("tenantId", tenantId);
        params.put("profileMap", profileMap);
        params.put("grantType", grantType);
        return this.getBySqlKey("getCategoryTree", params);
    }

    /**
     * 根据主键获取流程。
     * @param busKey
     * @return
     */
    public BpmInst getByBusKey(String busKey){
        Map<String,Object> params=new HashMap<String,Object>();
        params.put("busKey", busKey);
        BpmInst inst=this.getUnique("getByBusKey", params);
        return inst;
    }

    /**
     * 获取我的实例。
     * @param filter
     * @return
     */
    public List<BpmInst> getMyInst(QueryFilter filter) {
        return this.getPageBySqlKey("getMyInst", filter);
    }

    /**
     * 获取我的实例。
     * @param filter
     * @return
     */
    public List<BpmInst> getMyDrafts(QueryFilter filter) {
        return this.getPageBySqlKey("getMyDrafts", filter);
    }

    /**
     * @author mical 2018年5月14日
     * describe：根据solId获取流程实例
     * @param solId
     * @return
     */
    public List<BpmInst> getBpmInstListBySolId(String solId) {
        return this.getBySqlKey("getBpmInstListBySolId", solId);
    }

    public Integer getMyInstCount(String userId,String status){
        Map<String,Object> params=new HashMap<String,Object>();
        params.put("userId", userId);
        params.put("status", status);
        return (Integer) this.getOne("getMyInstCount", params);
    }

	public List<BpmInst> getMyCommonInst(QueryFilter filter) {
		return this.getPageBySqlKey("getMyCommonInst", filter);
	}

}
