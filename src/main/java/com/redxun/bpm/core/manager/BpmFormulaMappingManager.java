
package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmFormulaMappingDao;
import com.redxun.bpm.core.entity.BpmFormulaMapping;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：公式映射 处理接口
 * 作者:ray
 * 日期:2018-08-21 23:31:54
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmFormulaMappingManager extends MybatisBaseManager<BpmFormulaMapping>{
	
	@Resource
	private BpmFormulaMappingDao bpmFormulaMappingDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormulaMappingDao;
	}
	
	
	
	public void saveFormulaMapping(String solId,String actDefId,String nodeId,String formulaId,String formulaName){
		bpmFormulaMappingDao.removeBySolId(solId, actDefId, nodeId);
		if(StringUtil.isEmpty(formulaId)) return;
		
		String[] formulaIds =formulaId.split("[,]");
		String[] formulaNames =formulaName.split("[,]");
		for(int i=0;i<formulaIds.length;i++){
			BpmFormulaMapping mapping=new BpmFormulaMapping();
			mapping.setId(IdUtil.getId());
			mapping.setActDefId(actDefId);
			mapping.setSolId(solId);
			mapping.setNodeId(nodeId);
			mapping.setFormulaId(formulaIds[i]);
			mapping.setFormulaName(formulaNames[i]);
			
			this.create(mapping);
		}
		
	}

	
	
}
