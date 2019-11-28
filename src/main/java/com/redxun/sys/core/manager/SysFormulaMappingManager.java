
package com.redxun.sys.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.dao.SysFormulaMappingDao;
import com.redxun.sys.core.entity.SysFormulaMapping;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：表单方案公式映射 处理接口
 * 作者:ray
 * 日期:2018-08-21 23:31:09
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysFormulaMappingManager extends MybatisBaseManager<SysFormulaMapping>{
	
	@Resource
	private SysFormulaMappingDao sysFormulaMappingDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysFormulaMappingDao;
	}
	
	
	/**
	 * 添加表单方案和公式的映射。
	 * @param formSolId
	 * @param boDefId
	 * @param formulaIds
	 * @param formulaNames
	 */
	public void addMapping(String formSolId,String boDefId,String formulaIds,String formulaNames){
		//先删除
		sysFormulaMappingDao.removeBySolId(formSolId);
		
		if(StringUtil.isEmpty(formulaIds)) return;

		String[] aryFormulaId=formulaIds.split("[,]");
		String[] aryFormulaName=formulaNames.split("[,]");
		
		//添加关联映射。
		for(int i=0;i<aryFormulaId.length;i++){
			SysFormulaMapping mapping=new SysFormulaMapping();
			mapping.setId(IdUtil.getId());
			mapping.setBoDefId(boDefId);
			mapping.setFormSolId(formSolId);
			mapping.setFormulaId(aryFormulaId[i]);
			mapping.setFormulaName(aryFormulaName[i]);
			create(mapping);
		}
	}
	
	public List<SysFormulaMapping> getByFormSolId(String formSolId){
		return sysFormulaMappingDao.getByFormSolId(formSolId);
	}
	
}
