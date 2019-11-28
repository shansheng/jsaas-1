
/**
 * 
 * <pre> 
 * 描述：流程数据模型实例 DAO接口
 * 作者:ray
 * 日期:2018-10-27 21:12:32
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.bm.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmFormInstDao extends BaseMybatisDao<BpmFormInst> {

	@Override
	public String getNamespace() {
		return BpmFormInst.class.getName();
	}

	/**
     * 通过流程实例Id获得流程表单实例
     * @param bpmInstId
     * @return
     */
    public BpmFormInst getByBpmInstId(String bpmInstId){
    	String ql="from BpmFormInst inst where inst.instId=?";
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("bpmInstId", bpmInstId);
    	return this.getUnique("getByBpmInstId", params);
    }

}

