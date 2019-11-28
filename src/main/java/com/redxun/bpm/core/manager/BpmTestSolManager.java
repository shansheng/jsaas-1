package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmTestSolDao;
import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
/**
 * <pre> 
 * 描述：BpmTestSol业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmTestSolManager extends BaseManager<BpmTestSol>{
	@Resource
	private BpmTestSolDao bpmTestSolDao;
	@Resource
	BpmTestCaseManager bpmTestCaseManager;
	@Resource
	BpmInstManager bpmInstManager;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmTestSolDao;
	}
//	
//	public List<BpmTestSol> getBySolId(String solId,Page page){
//		return bpmTestSolDao.getBySolId(solId, page);
//	}
	
	 /**
     * 按方案及流程定义获得测试方案
     * @param solId
     * @param actDefId
     * @param page
     * @return
     */
    public List<BpmTestSol> getBySolIdActDefId(String solId,String actDefId,Page page){
    	return bpmTestSolDao.getBySolIdActDefId(solId, actDefId, page);
    }
	
	
	/**
	 * 级联删除需要的数据
	 * @param testSolId
	 */
	public void deleteCascade(String testSolId){
		List<BpmTestCase> testCases=bpmTestCaseManager.getByTestSolId(testSolId);
		for(BpmTestCase bpmTestCase:testCases){
	    	if(StringUtils.isNotEmpty(bpmTestCase.getInstId())){
	    		try{
	    			bpmInstManager.deleteCascade(bpmTestCase.getInstId(), "");
	    		}catch(Exception ex){
	    			logger.error(ex.getMessage());
	    		}
	    	}else{
	    		bpmTestCaseManager.delete(bpmTestCase.getTestId());
	    	}
		}
        delete(testSolId);
	}
}