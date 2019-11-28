package com.redxun.bpm.core.manager;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmSolVarDao;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskVarType;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
/**
 * <pre> 
 * 描述：BpmSolVar业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmSolVarManager extends BaseManager<BpmSolVar>{
	@Resource
	private BpmSolVarDao bpmSolVarDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmSolVarDao;
	}
	
//	/**
//     * 获得解决方案下某作用域下的变量
//     * @param solId
//     * @param scope
//     * @return
//     */
//    public List<BpmSolVar> getBySolIdScope(String solId,String scope){
//    	return bpmSolVarDao.getBySolIdScope(solId, scope);
//    }
    
    /**
     * 获得解决方案中的流程定义的某个节点的变量配置
     * @param solId
     * @param actDefId
     * @param nodeId
     * @return
     */
    public List<BpmSolVar> getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
    	return bpmSolVarDao.getBySolIdActDefIdScope(solId, actDefId, nodeId);
    }
    
  
    /**
     * 获得解决方案中流程定义所有变量配置
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmSolVar> getBySolIdActDefId(String solId,String actDefId){
    	return bpmSolVarDao.getBySolIdActDefId(solId, actDefId);
    }
    
    
    /**
     * 按解决方案及流程定义Id删除
     * @param solId
     * @param actDefId
     */
    public void delBySolIdActDefId(String solId,String actDefId){
    	bpmSolVarDao.delBySolIdActDefId(solId, actDefId);
    }
    
    /**
     * 按解决方案Id删除
     * @param solId
     */
    public void delBySolId(String solId){
    	bpmSolVarDao.delBySolId(solId);
    }
    /**
     * 取得某个节点有效的所有变量
     * @param solId
     * @param actDefId
     * @param nodeId
     * @return
     */
     public List<BpmSolVar> getNodeAllVars(String solId,String actDefId,String nodeType,String nodeId){
     	List<BpmSolVar> vars=new ArrayList<BpmSolVar>();
     	
     	
     // 加上默认的流程变量
    	for(ProcessVarType type:ProcessVarType.values()){
    		BpmSolVar varDef = new BpmSolVar(type.getName(), type.getKey(),BpmSolVar.TYPE_STRING, BpmSolVar.SCOPE_PROCESS);
    		vars.add(varDef);
    	}
    	
     	List<BpmSolVar> processVars=getBySolIdActDefIdNodeId(solId, actDefId, BpmSolVar.SCOPE_PROCESS);
     	vars.addAll(processVars);
     	
     	if("userTask".equals(nodeType)) {
     		List<BpmSolVar> nodeVars=getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
     		vars.addAll(nodeVars);
     		BpmSolVar taskId=new BpmSolVar(TaskVarType.TASKID.getName(),TaskVarType.TASKID.getKey(),BpmSolVar.TYPE_STRING,"_NODE");
     		BpmSolVar taskEntity=new BpmSolVar(TaskVarType.TASK_ENTITY.getName(),TaskVarType.TASK_ENTITY.getKey(),BpmSolVar.TYPE_STRING,"_NODE");
     		BpmSolVar variables=new BpmSolVar(TaskVarType.TASK_VARS.getName(),TaskVarType.TASK_VARS.getKey(),BpmSolVar.TYPE_MAP,"_NODE");
     		vars.add(taskId);
     		vars.add(taskEntity);
     		vars.add(variables);
     		BpmSolVar jsonData=new BpmSolVar(TaskVarType.JSON_DATA.getName(),TaskVarType.JSON_DATA.getKey(),BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
     		vars.add(jsonData);
     	}
     	return vars;
     }
     
    
    
}