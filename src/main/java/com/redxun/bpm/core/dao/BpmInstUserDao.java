
/**
 * 
 * <pre> 
 * 描述：流程实例用户设置 DAO接口
 * 作者:ray
 * 日期:2018-06-14 15:11:19
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstUser;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmInstUserDao extends BaseMybatisDao<BpmInstUser> {

	@Override
	public String getNamespace() {
		return BpmInstUser.class.getName();
	}
	
	
	/**
	 * 根据流程实例获取人员定义。
	 * @param instId	流程实例ID
	 * @param nodeId	节点ID
	 * @param isSub		是否子流程
	 * @param actDefId	流程定义
	 * @return
	 */
	public BpmInstUser getByInst(String instId,String nodeId,int isSub,String actDefId){
		Map<String,Object> params=new HashMap<>();
		params.put("instId", instId);
		params.put("nodeId", nodeId);
		params.put("isSub", isSub);
		if(isSub==1){
			params.put("actDefId", actDefId);
		}
		BpmInstUser bpmInstUser=this.getUnique("getByInst", params);
		return bpmInstUser;
		
	}
	
	/**
	 * 根据实例删除节点配置。
	 * @param instId
	 */
	public void delByInstId(String instId){
		this.deleteBySqlKey("delByInstId", instId);
	}
	

}

