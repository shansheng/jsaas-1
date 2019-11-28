package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmSolCtlDao;
import com.redxun.bpm.core.entity.BpmSolCtl;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
/**
 * <pre> 
 * 描述：BpmSolCtl业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Service
public class BpmSolCtlManager extends BaseManager<BpmSolCtl>{
	@Resource
	private BpmSolCtlDao bpmSolCtlDao;
	@Resource
	private UserService  userService;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolCtlDao;
	}
	/**
	 * 通过sol和类型来查找解决方案里的权限设置
	 * @param solId
	 * @param type
	 * @return
	 */
	public List<BpmSolCtl> getBySolIdAndType(String solId,String type){
		return bpmSolCtlDao.getBySolIdAndType(solId, type);
	}
	/**
     * 通过solId和type以及right来查找模版设置具体权限
     * @param solId
     * @param type
     * @param right
     * @return
     */
    public List<BpmSolCtl> getBySolAndTypeAndRight(String solId,String type,String right){
    	return bpmSolCtlDao.getBySolAndTypeAndRight(solId, type, right);
    }
    
    /**
     * 判断附件权限
     * @param userId 用户Id
     * @param solId 解决方案Id
     * @param right 权限类型（down，print）
     * @return
     */
    //判断是否拥有附件权限
    public boolean sysFileCtl(String userId,String solId,String right){
    	List<BpmSolCtl> list = getBySolAndTypeAndRight(solId, BpmSolCtl.CTL_TYPE_FILE, right);
    	BpmSolCtl ctl = new BpmSolCtl();
    	if(list.size()>0){
    		ctl = list.get(0);
    		if(StringUtils.isNotEmpty(ctl.getUserIds())){
	    		String[] users = ctl.getUserIds().split(",");
	    		for(String user:users){
	    			if(userId.equals(user)){
	    				return true;
	    			}
	    		}
    		}else if(StringUtils.isNotEmpty(ctl.getGroupIds())){    		
	    		String[] groupIds = ctl.getGroupIds().split(",");
	    		for(String groupId:groupIds){
	    			List<IUser> osusers = userService.getByGroupId(groupId);
	    			for(IUser osuser:osusers){
	    				if(userId.equals(osuser.getUserId())){
	    					return true;
	    				}
	    			}
	    		}
    		}
    	}
    	  
    	return false;
    }
}