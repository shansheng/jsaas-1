
package com.redxun.bpm.core.manager;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.gexin.fastjson.JSON;
import com.redxun.bpm.core.dao.BpmBatchApprovalDao;
import com.redxun.bpm.core.entity.BpmBatchApproval;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.entity.OsUser;

/**
 * 
 * <pre> 
 * 描述：流程批量审批设置表 处理接口
 * 作者:mansan
 * 日期:2018-06-27 15:19:53
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmBatchApprovalManager extends MybatisBaseManager<BpmBatchApproval>{
	
	@Resource
	private BpmBatchApprovalDao bpmBatchApprovalDao;
	@Resource
	private BpmSolutionManager bpmSolutionManager;
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmBatchApprovalDao;
	}
	
	
	
	
	public boolean isExist(String solId,String nodeId,String id){
		Integer rtn= bpmBatchApprovalDao.getCountBySolNodeId(solId, nodeId, id);
		
		return rtn>0;
	}
	

	
	
	@Override
	public void create(BpmBatchApproval entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}


	public List<BpmBatchApproval> getInvailAll() {
		return bpmBatchApprovalDao.getInvailAll();
	}
	
	public String formFieldSort(String json) {
		JSONArray ary= (JSONArray) JSONArray.parse(json);
		List<JSONObject> list= ary.toJavaList(JSONObject.class);
		Collections.sort(list, new Comparator<JSONObject>() {
			public int compare(JSONObject arg0, JSONObject arg1) {
				int sn1 = (int) arg0.getInteger("sn");
				int sn2 = (int) arg1.getInteger("sn");
				if (sn1 == sn2) {
					return 0;
				} else if (sn1 > sn2) {
					return 1;
				} else {
					return -1;
				}
			}
		});
		return JSON.toJSONString(list);
	}
	
	public String handlerField(BpmBatchApproval bpmBatchApproval) {
		StringBuffer disField = new StringBuffer();
	
		JSONArray ary = JSONArray.parseArray(bpmBatchApproval.getFieldJson());
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
				String fieldName = (String) obj.getString("name");
			disField.append(" a."+ fieldName +",");
		}
		
		disField.deleteCharAt(disField.length()-1);
		return disField.toString();
	}
	

	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getTaskByUser(BpmBatchApproval bpmBatchApproval, String userId) {
		String actDefId = bpmBatchApproval.getActDefId();
		String nodeId = bpmBatchApproval.getNodeId();
		String tableName = bpmBatchApproval.getTableName();
		String fields = handlerField(bpmBatchApproval);
		return  bpmBatchApprovalDao.getTaskByUser(fields, userId, actDefId, nodeId, tableName);
	}

}
