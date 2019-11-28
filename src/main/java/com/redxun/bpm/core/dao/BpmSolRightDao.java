//package com.redxun.bpm.core.dao;
//import java.util.List;
//
//import org.springframework.stereotype.Repository;
//
//import com.redxun.bpm.core.entity.BpmSolRight;
//import com.redxun.core.dao.jpa.BaseJpaDao;
///**
// * <pre> 
// * 描述：BpmSolRight数据访问类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: chshxuan@163.com
// * 日期:2014-2-1-上午12:52:41
// * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
// * </pre>
// */
//@Repository
//public class BpmSolRightDao extends BaseJpaDao<BpmSolRight> {
//
//    @SuppressWarnings("rawtypes")
//	@Override
//    protected Class getEntityClass() {
//        return BpmSolRight.class;
//    }
//    
//    /**
//     * 获得解决方案的授权
//     * @param solId
//     * @return
//     */
//    public List<BpmSolRight> getBySolId(String solId){
//    	String ql="from BpmSolRight r where r.bpmSolution.solId=?";
//    	return this.getByJpql(ql, new Object[]{solId});
//    }
//    
//    /**
//     * 按解决方案Id及用户组分类获得分类
//     * @param solId
//     * @param identityType
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdIdentityType(String solId,String identityType){
//    	String ql="from BpmSolRight r where r.bpmSolution.solId=? and r.identityType=?";
//    	return this.getByJpql(ql,new Object[]{solId,identityType});
//    }
//    
//    /**
//     * 获得解决方案的用户授权
//     * @param solId
//     * @param userId
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdUserId(String solId,String userId){
//    	String ql="from BpmSolRight r where r.bpmSolution.solId=? and r.identityType=? and r.identityId=?";
//    	return this.getByJpql(ql, new Object[]{solId,BpmSolRight.ID_TYPE_USER,userId});
//    }
//    /**
//     * 获得解决方案的用户组的授权
//     * @param solId
//     * @param groupId
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdGroupId(String solId,String groupId){
//    	String ql="from BpmSolRight r where r.bpmSolution.solId=? and r.identityType=? and r.identityId=?";
//    	return this.getByJpql(ql, new Object[]{solId,BpmSolRight.ID_TYPE_GROUP,groupId});
//    }
//    /**
//     * 删除解决方案下的授权
//     * @param solId
//     */
//    public void delBySolId(String solId){
//    	String ql="delete from BpmSolRight r where r.bpmSolution.solId=?";
//    	this.delete(ql, new Object[]{solId});
//    }
//}
