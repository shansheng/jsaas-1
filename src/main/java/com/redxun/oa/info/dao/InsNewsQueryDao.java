
/**
 * 
 * <pre> 
 * 描述：信息公告 DAO接口
 * 作者:mansan
 * 日期:2018-04-16 17:14:23
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.IPage;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.info.entity.InsNews;

@Repository
public class InsNewsQueryDao extends BaseMybatisDao<InsNews> {

	@Override
	public String getNamespace() {
		return InsNews.class.getName();
	}

	public List<InsNews> getByColId(QueryFilter filter){
		List<InsNews> list= this.getPageBySqlKey("getByColId", filter);
		return list;
	} 
	/**
	 * 获得栏目里的新闻列表
	 * @param columnId
	 * @param page
	 * @return
	 */
	public List<InsNews> getByColumnId(String columnId,IPage page){
		Map<String,Object>params=new HashMap<String,Object>();
		params.put("columnId", columnId);
		return this.getBySqlKey("getByColumnId", params, page);
	}

	/**
	 * 获得栏目里的新闻列表(图片和文字列表)
	 * @param columnId
	 * @param page
	 * @return
	 */
	public List<InsNews> getImgAndFontByColumnId(String columnId,IPage page){
		Map<String,Object>params=new HashMap<String,Object>();
		params.put("columnId", columnId);
		return this.getBySqlKey("getImgAndFontByColumnId", params, page);
	}
	
	public void updColumn(String newId,String columnId){
		Map<String,Object>params=new HashMap<String,Object>();
		params.put("columnId", columnId);
		params.put("newId", newId);
		
		this.updateBySqlKey("updColumn", params);
	}
}

