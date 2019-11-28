
/**
 * 
 * <pre> 
 * 描述：表单方案公式映射 DAO接口
 * 作者:ray
 * 日期:2018-08-21 23:31:09
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysFormulaMapping;

@Repository
public class SysFormulaMappingDao extends BaseMybatisDao<SysFormulaMapping> {

	@Override
	public String getNamespace() {
		return SysFormulaMapping.class.getName();
	}
	
	
	
	public void removeBySolId(String solId){
		this.deleteBySqlKey("removeBySolId", solId);
	}
	

	
	/**
	 * 根据公式删除映射
	 * @param formulaId
	 */
	public void removeByFormulaId(String formulaId){
		this.deleteBySqlKey("removeByFormulaId", formulaId);
	}
	
	public List<SysFormulaMapping> getByFormSolId(String formSolId){
		Map<String, String> params = new HashMap<String, String>();
		params.put("formSolId", formSolId);
		return this.getBySqlKey("getByFormSolId", params);
	}

}

