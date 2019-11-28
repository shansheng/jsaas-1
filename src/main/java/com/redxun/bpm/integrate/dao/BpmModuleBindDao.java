package com.redxun.bpm.integrate.dao;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.bpm.integrate.entity.BpmModuleBind;
/**
 * <pre> 
 * 描述：业务流程模块绑定数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmModuleBindDao extends BaseJpaDao<BpmModuleBind> {

    @SuppressWarnings("rawtypes")
	@Override
    protected Class getEntityClass() {
        return BpmModuleBind.class;
    }
    
    /**
     * 按模块Key获得绑定
     * @param moduleKey
     * @return
     */
    public BpmModuleBind getByModuleKey(String moduleKey){
    	String ql="from BpmModuleBind b where b.moduleKey=?";
    	return (BpmModuleBind)this.getUnique(ql, new Object[]{moduleKey});
    }
    
    /**
     * 如果流程模块ID为空，则删除该下的数据
     * @param solId
     * */
    public void delBySolId(String solId){
    	String ql="delete from BpmModuleBind r where r.solId=?";
    	this.delete(ql, new Object[]{solId});
    }
    
}
