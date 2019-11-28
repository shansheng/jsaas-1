
/**
 * 
 * <pre> 
 * 描述：表间公式 DAO接口
 * 作者:mansan
 * 日期:2018-08-07 09:06:53
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.form.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmTableFormulaDao extends BaseMybatisDao<BpmTableFormula> {

	@Override
	public String getNamespace() {
		return BpmTableFormula.class.getName();
	}
	
	public List<BpmTableFormula> getByFormSolId(String formSolId){
		List<BpmTableFormula> list= this.getBySqlKey("getByFormSolId", formSolId);
		return list;
	}
	
	public List<BpmTableFormula> getBySolIdNode(String solId,String actDefId,String nodeId){
		Map<String, Object> params=new HashMap<>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		
		List<BpmTableFormula> list=this.getBySqlKey("getBySolIdNode", params);
		
		return list;
	}
	
	
}

