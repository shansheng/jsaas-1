
/**
 * 
 * <pre> 
 * 描述：微信用户标签 DAO接口
 * 作者:ray
 * 日期:2017-06-29 17:55:30
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.wx.core.dao;

import com.redxun.wx.core.entity.WxTagUser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class WxTagUserDao extends BaseMybatisDao<WxTagUser> {

	@Override
	public String getNamespace() {
		return WxTagUser.class.getName();
	}

	
	public List<WxTagUser> getByTagId(String tagId,String pubId){
		Map<String,Object> params=new HashMap<>();
		params.put("tagId", tagId);
		params.put("pubId", pubId);
		return this.getBySqlKey("getByTagId", params);
	}
	
	public WxTagUser getByTagIdAndUserId(String tagId,String userId){
		Map<String,Object> params=new HashMap<>();
		params.put("tagId", tagId);
		params.put("userId", userId);
		
		return (WxTagUser) this.getUnique("getByTagIdAndUserId",params);
	}
}

