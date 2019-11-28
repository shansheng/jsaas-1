package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmInstCtlDao;
import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
/**
 * <pre> 
 * 描述：BpmInstCtl业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Service
public class BpmInstCtlManager extends BaseManager<BpmInstCtl>{
	@Resource
	private BpmInstCtlDao bpmInstCtlDao;
	@Resource
	private UserService userService;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstCtlDao;
	}
	
	/**
     * 通过solId和type以及right来查找模版设置具体权限
     * @param instId
     * @param type
     * @param right
     * @return
     */
    public List<BpmInstCtl> getBySolAndTypeAndRight(String instId,String type,String right){
    	return bpmInstCtlDao.getBySolAndTypeAndRight(instId, type, right);
    }
	
	/**
     * 判断附件权限
     * @param userId 用户Id
     * @param solId 解决方案Id
     * @param right 权限类型（down，print）
     * @return
     */
    //判断是否拥有附件权限
    public boolean sysFileCtl(String userId,String instId,String right){
    	List<BpmInstCtl> list = getBySolAndTypeAndRight(instId, BpmInstCtl.CTL_TYPE_FILE, right);
    	BpmInstCtl ctl = new BpmInstCtl();
    	if(list !=null && list.size()>0 ){
    		ctl = list.get(0);
    		if(StringUtils.isNotEmpty(ctl.getUserIds())){
	    		String[] users = ctl.getUserIds().split(",");
	    		for(String user:users){
	    			if(userId.equals(user)){
	    				return true;
	    			}
	    		}
    		}
    		if(StringUtils.isNotEmpty(ctl.getGroupIds())){    		
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
    	}else{
    		return true;
    	}
    	  
    	return false;
    }
}