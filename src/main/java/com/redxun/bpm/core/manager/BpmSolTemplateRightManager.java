package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.bpm.core.dao.BpmSolTemplateRightDao;
import com.redxun.bpm.core.entity.BpmSolTemplateRight;
/**
 * <pre> 
 * 描述：BpmSolTemplateRight业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Service
public class BpmSolTemplateRightManager extends BaseManager<BpmSolTemplateRight>{
	@Resource
	private BpmSolTemplateRightDao bpmSolTemplateRightDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolTemplateRightDao;
	}
	/**
     * 通过treeId获取唯一的权限
     * @param treeId
     * @return
     */
    public BpmSolTemplateRight getByTreeId(String treeId){
    	return bpmSolTemplateRightDao.getByTreeId(treeId);
    }
	
}