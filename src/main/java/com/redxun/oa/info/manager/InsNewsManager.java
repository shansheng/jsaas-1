package com.redxun.oa.info.manager;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.IPage;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.info.dao.InsColNewDefDao;
import com.redxun.oa.info.dao.InsNewsDao;
import com.redxun.oa.info.dao.InsNewsQueryDao;
import com.redxun.oa.info.entity.InsColNewDef;
import com.redxun.oa.info.entity.InsNews;

/**
 * <pre>
 * 描述：InsNews业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class InsNewsManager extends BaseManager<InsNews> {
	@Resource
	private InsNewsDao insNewsDao;

	
	@Resource
	InsColNewDefDao insColNewDefDao;
	@Resource
	InsColNewDefManager insColNewDefManager;
	@Resource
	InsNewsManager insNewsManager;
	@Resource
	InsNewsQueryDao insNewsQueryDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return insNewsDao;
	}

	/**
	 * 创建信息公告
	 * 
	 * @param insNews
	 * @param selColIds
	 *            选择的栏目IDS，如1,2
	 * @param startTime
	 *            有效的开始时间
	 * @param endTime
	 *            有效的结束时间
	 */
	public void create(InsNews insNews) {
		insNewsDao.create(insNews);
	}

	/**
	 * 发布新闻
	 * 
	 * @param insNews
	 *            新闻
	 * @param selColIds
	 *            要发布的栏目
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @param isLongValid
	 *            是否长期
	 *            @deprecated
	 */
	public void doPublish(InsNews insNews, String selColIds, Date startTime, Date endTime, String isLongValid) {
		insNewsDao.update(insNews);
		if (InsNews.STATUS_ISSUED.equals(insNews.getStatus())) {
			String[] selIds = selColIds.split(",");
			int sn = 0;
			for (String colId : selIds) {
				if (insColNewDefDao.booleanByColIdNewId(colId, insNews.getNewId())) {
					return;
				}
				InsColNewDef colNew = new InsColNewDef();
				colNew.setColId(colId);
				colNew.setNewId(insNews.getNewId());
				insColNewDefDao.create(colNew);
			}
		}
	}

	
	/**
	 * 发布新闻
	 * 
	 * @param insNews
	 *            新闻
	 * @param selColIds
	 *            要发布的栏目
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @param isLongValid
	 *            是否长期
	 *             @deprecated
	 */
	public void doPublish(InsNews insNews, String selColIds) {
		insNewsDao.update(insNews);
		if (InsNews.STATUS_DRAFT.equals(insNews.getStatus())) {
			String[] selIds = selColIds.split(",");
			//int sn = 0;
			for (String colId : selIds) {
				if (insColNewDefDao.booleanByColIdNewId(colId, insNews.getNewId())) {
					return;
				}
				InsColNewDef colNew = new InsColNewDef();
				colNew.setColId(colId);
				colNew.setNewId(insNews.getNewId());
				insColNewDefDao.create(colNew);
			}
		}
	}
	/**
	 * 更新消息
	 * 
	 * @param insNews
	 * @param selColIds
	 * @param startTime
	 * @param endTime
	 */
	public void update(InsNews insNews) {
		insNewsDao.update(insNews);
	}
	
	/**
	 * 获得Portal首页公司公告列表
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<InsNews> getPortalNews(QueryFilter queryFilter){
		
		List<InsNews> insNews = insNewsQueryDao.getByColId(queryFilter);
	
		return insNews;
	}
	
	
	/**
	 * 获得栏目里的新闻列表(文字列表)
	 * @param columnId
	 * @param page
	 * @return
	 */
	public List<InsNews> getByColumnId(String columnId,IPage page){
		return insNewsQueryDao.getByColumnId(columnId, page);
	}

	/**
	 * 获得栏目里的新闻列表(图片和文字列表)
	 * @param columnId
	 * @param page
	 * @return
	 */
	public List<InsNews> getImgAndFontByColumnId(String columnId,IPage page){
		return insNewsQueryDao.getImgAndFontByColumnId(columnId, page);
	}

}
