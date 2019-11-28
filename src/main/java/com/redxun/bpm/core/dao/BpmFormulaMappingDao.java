
/**
 * 
 * <pre> 
 * 描述：公式映射 DAO接口
 * 作者:ray
 * 日期:2018-08-21 23:31:54
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmFormulaMapping;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmFormulaMappingDao extends BaseMybatisDao<BpmFormulaMapping> {

	@Override
	public String getNamespace() {
		return BpmFormulaMapping.class.getName();
	}
	
	
	
	/**
	 * 删除公式配置。
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 */
	public void removeBySolId(String solId,String actDefId,String nodeId){
		Map<String,Object> params=new HashMap<>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		this.deleteBySqlKey("removeBySolId", params);
	}
	
	public void removeByFormulaId(String formulaId){
		this.deleteBySqlKey("removeByFormulaId", formulaId);
	}

}

