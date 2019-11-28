
/**
 * 
 * <pre> 
 * 描述：流程抄送人员 DAO接口
 * 作者:ray
 * 日期:2017-01-03 10:46:24
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import com.redxun.bpm.core.entity.BpmInstCp;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstCpDao extends BaseMybatisDao<BpmInstCp> {

	@Override
	public String getNamespace() {
		return BpmInstCp.class.getName();
	}
	
	/**
	 * 根据流程实例删除抄送人员。
	 * @param instId
	 */
	public void delByInst(String instId){
		this.deleteBySqlKey("delByInst", instId);
	}

	public void updRead(String id){
    	Map<String,Object> params=new HashMap<>();
    	params.put("id", id);
    	this.updateBySqlKey("updRead", params);
    }
}

