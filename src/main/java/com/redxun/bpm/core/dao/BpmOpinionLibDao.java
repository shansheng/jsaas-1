package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmOpinionLib;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
/**
 * <pre>
 * 描述：BpmOpinionLib数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmOpinionLibDao extends BaseMybatisDao<BpmOpinionLib> {

	@Override
	public String getNamespace() {
		return BpmOpinionLib.class.getName();
	}


    public List<BpmOpinionLib> getByUserId(String userId){
		QueryFilter filter = new QueryFilter();
		filter.addFieldParam("USER_ID_",userId);
		return this.getBySqlKey("query",filter);
    }

    public boolean isOpinionSaved(String userId,String opText){

		Map<String,Object> params = new HashMap<>();
		params.put("userId",userId);
		params.put("opText",opText);
		Integer a = (Integer)this.getOne("isOpinionSaved",params);
    	if( a!=null && a>0){
    		return true;
    	}else{
    		return false;
    	}
    }

}
