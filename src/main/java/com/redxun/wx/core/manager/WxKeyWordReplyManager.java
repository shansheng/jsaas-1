
package com.redxun.wx.core.manager;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.wx.core.dao.WxKeyWordReplyDao;
import com.redxun.wx.core.entity.WxKeyWordReply;

/**
 * 
 * <pre> 
 * 描述：公众号关键字回复 处理接口
 * 作者:陈茂昌
 * 日期:2017-08-30 11:39:20
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class WxKeyWordReplyManager extends MybatisBaseManager<WxKeyWordReply>{
	@Resource
	private WxKeyWordReplyDao wxKeyWordReplyDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return wxKeyWordReplyDao;
	}
	
	
	
	public WxKeyWordReply getWxKeyWordReply(String uId){
		WxKeyWordReply wxKeyWordReply = get(uId);
		return wxKeyWordReply;
	}
	public WxKeyWordReply getWxKeyWordReplyByKeyWord(String keyWord,String pubId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("keyWord", keyWord);
		params.put("pubId", pubId);
		return wxKeyWordReplyDao.getUnique("getWxKeyWordReplyByKeyWord", params);
	}
}
