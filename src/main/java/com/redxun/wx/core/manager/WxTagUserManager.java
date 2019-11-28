
package com.redxun.wx.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.wx.core.dao.WxTagUserDao;
import com.redxun.wx.core.dao.WxTagUserDao;
import com.redxun.wx.core.entity.WxTagUser;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;

/**
 * 
 * <pre> 
 * 描述：微信用户标签 处理接口
 * 作者:ray
 * 日期:2017-06-29 17:55:30
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class WxTagUserManager extends MybatisBaseManager<WxTagUser>{
	@Resource
	private WxTagUserDao wxTagUserDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return wxTagUserDao;
	}
	
	
	public List<WxTagUser> getByTagId(String tagId,String pubId){
		return  wxTagUserDao.getByTagId(tagId,pubId);
	}
	public WxTagUser getByTagIdAndUserId(String tagId,String userId){
		return wxTagUserDao.getByTagIdAndUserId(tagId,userId);
	}
}
