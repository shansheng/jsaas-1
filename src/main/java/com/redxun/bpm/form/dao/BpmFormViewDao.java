package com.redxun.bpm.form.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.sys.core.entity.SysInst;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.query.Page;
import com.redxun.saweb.context.ContextUtil;
/**
 * <pre> 
 * 描述：BpmFormView数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmFormViewDao extends BaseMybatisDao<BpmFormView> {

    @Override
    public String getNamespace() {
        return BpmFormView.class.getName();
    }
    /**
     * 更新IsMain属性
     * @param viewId
     * @param isMain
     */
    public void updateIsMain(String viewId){
    	BpmFormView formView= this.get(viewId);
    	updateIsNotMain(formView.getKey(),formView.getTenantId());

    	Map<String,Object> params = new HashMap<>();
        params.put("isMain",MBoolean.YES.name());
        params.put("viewId",viewId);
        this.updateBySqlKey("updateIsMain",params);
    }
    
    /**
     * 获得表单视图中的所有版本
     * @param mainViewId
     * @param page
     * @return
     */
    public List<BpmFormView> getAllVersionsByKey(String key,String tenantId,Page page){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("KEY_",key);
        filter.addFieldParam("TENANT_ID_",tenantId);
        filter.setPage(page);

        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 更新IsMain属性
     * @param mainViewId
     * @param isMain
     */
    public void updateIsNotMain(String key,String tenantId){
        Map<String,Object> params = new HashMap<>();
        params.put("isMain",MBoolean.NO.name());
        params.put("key",key);
        params.put("tenantId",tenantId);
        this.updateBySqlKey("updateIsNotMain",params);

    }
    
  
    
    
    
    /**
     * 根据key获取系统中最大的版本号。
     * @param key
     * @param tenantId
     * @return
     */
    public Integer getMaxVersion(String key,String tenantId){
        Map<String,Object> params = new HashMap<>();
        params.put("key",key);
        params.put("status",BpmFormView.STATUS_DEPLOYED);
        params.put("tenantId",tenantId);
        Integer maxVersion = (Integer) this.getOne("getMaxVersion",params);
    	if(maxVersion==null){
    		maxVersion=1;
    	}
    	return maxVersion;
    }
    
    
    
    /**
     * 根据别名获取表单。
     * @param alias
     * @param tenantId
     * @return
     */
    public BpmFormView getByAlias(String alias){
    	String tenantId=ContextUtil.getCurrentTenantId();
        Map<String,Object> params = new HashMap<>();
        params.put("key",alias);
        params.put("tenantId",tenantId);
        return this.getUnique("findByAlias",params);
    }
    
    /**
     * 根据key删除表单。
     * @param alias
     * @param tenantId
     * @return
     */
    public void deletByKey(String key,String tenantId){
        Map<String,Object> params = new HashMap<>();
        params.put("key",key);
        params.put("tenantId",tenantId);
        this.deleteBySqlKey("deletByKey",params);
    }


    /**
     * -------------------------------------------
     */


    /**
     * 根据别名查询数量
     * @param tenantId
     * @param alias
     * @param viewId
     * @return
     */
    public Integer getCountByAlias(String tenantId,String alias){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("tenantId", tenantId);
        params.put("key", alias);
        Integer rtn=(Integer) this.getOne("getCountByAlias", params);
        return rtn;

    }

    public List<BpmFormView> getByFilter(QueryFilter filter){
        return this.getPageBySqlKey("getByFilter", filter);
    }


    public List<BpmFormView> getByTreeFilter(QueryFilter filter){
        return this.getPageBySqlKey("getByTreeFilter", filter);
    }

    public List<BpmFormView> getByBoId(String boDefId){
        Map<String, Object> params=new HashMap<String, Object>();
        params.put("boDefId", boDefId);
        return this.getBySqlKey("getByBoId", params);
    }

    /**
     * 清除bo定义。
     * @param boDefId
     */
    public void removeBoDef(String boDefId){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("boDefId", boDefId);
        this.updateBySqlKey("removeBoDef", params);
    }


    public List<BpmFormView>  getAllForms(){
        List<BpmFormView> views= this.sqlSessionTemplate.selectList("getAll");
        return views;
    }

    public BpmFormView getByAlias(String formAlias,String tenantId){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("key", formAlias);
        params.put("tenantId", tenantId);
        params.put("isMain", "YES");
        BpmFormView formView= this.getUnique("getByAlias", params);
        if(formView==null && !SysInst.ADMIN_TENANT_ID.equals(tenantId)){
            params.put("tenantId", SysInst.ADMIN_TENANT_ID);
            formView= this.getUnique("getByAlias", params);
        }
        return formView;
    }

    public List getAliasByBoId(String boDefId) {
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("boDefId", boDefId);
        return this.getBySqlKey("getAliasByBoId", params);
    }

    public List getAliasByBoIdMainVersion(String boDefId) {
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("boDefId", boDefId);
        return this.getBySqlKey("getAliasByBoIdMainVersion", params);
    }

    public List<BpmFormView> query(QueryFilter filter){
        return this.getPageBySqlKey("query", filter);
    }


}
