//package com.redxun.bpm.core.manager;
//import java.util.List;
//
//import javax.annotation.Resource;
//
//import org.apache.commons.lang.StringUtils;
//import org.springframework.stereotype.Service;
//
//import com.redxun.core.dao.IDao;
//import com.redxun.core.manager.BaseManager;
//import com.redxun.bpm.core.dao.BpmSolRightDao;
//import com.redxun.bpm.core.entity.BpmSolRight;
//import com.redxun.bpm.core.entity.BpmSolution;
///**
// * <pre> 
// * 描述：BpmSolRight业务服务类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: chshxuan@163.com
// * 日期:2014-2-1-上午12:52:41
// * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
// * </pre>
// */
//@Service
//public class BpmSolRightManager extends BaseManager<BpmSolRight>{
//	@Resource
//	private BpmSolRightDao bpmSolRightDao;
//	@SuppressWarnings("rawtypes")
//	@Override
//	protected IDao getDao() {
//		return bpmSolRightDao;
//	}
//
//    /**
//     * 获得解决方案的授权
//     * @param solId
//     * @return
//     */
//    public List<BpmSolRight> getBySolId(String solId){
//    	return bpmSolRightDao.getBySolId(solId);
//    }
//    /**
//     * 获得解决方案的用户授权
//     * @param solId
//     * @param userId
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdUserId(String solId,String userId){
//    	return bpmSolRightDao.getBySolIdUserId(solId, userId);
//    }
//    /**
//     * 获得解决方案的用户组的授权
//     * @param solId
//     * @param groupId
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdGroupId(String solId,String groupId){
//    	return bpmSolRightDao.getBySolIdGroupId(solId,groupId);
//    }
//    /**
//     * 删除解决方案下的授权
//     * @param solId
//     */
//    public void delBySolId(String solId){
//    	bpmSolRightDao.delBySolId(solId);
//    }
//    
//    /**
//     * 按解决方案Id及用户组分类获得分类
//     * @param solId
//     * @param identityType
//     * @return
//     */
//    public List<BpmSolRight> getBySolIdIdentityType(String solId,String identityType){
//    	return bpmSolRightDao.getBySolIdIdentityType(solId, identityType);
//    }
//    /**
//     * 保存授权
//     * @param bpmSolution
//     * @param userIds
//     * @param groupIds
//     */
//    public void saveGrants(BpmSolution bpmSolution,String userIds,String groupIds){
//    	delBySolId(bpmSolution.getSolId());
//    	if(StringUtils.isNotEmpty(userIds)){
//	    	String[]uIds=userIds.split("[,]");
//	    	for(String userId:uIds){
//	    		BpmSolRight right=new BpmSolRight();
//	    		right.setRight("ALL");
//	    		right.setBpmSolution(bpmSolution);
//	    		right.setIdentityId(userId);
//	    		right.setIdentityType(BpmSolRight.ID_TYPE_USER);
//	    		create(right);
//	    	}
//    	}
//    	if(StringUtils.isNotEmpty(groupIds)){
//	    	String[]gIds=groupIds.split("[,]");
//	    	for(String groupId:gIds){
//	    		BpmSolRight right=new BpmSolRight();
//	    		right.setRight("ALL");
//	    		right.setBpmSolution(bpmSolution);
//	    		right.setIdentityId(groupId);
//	    		right.setIdentityType(BpmSolRight.ID_TYPE_GROUP);
//	    		create(right);
//	    	}
//    	}
//    }
//}