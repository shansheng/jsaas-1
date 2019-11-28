package com.redxun.bpm.core.dao;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.BeanUtil;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.query.Page;
/**
 * <pre> 
 * 描述：BpmNodeJump数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class BpmNodeJumpDao extends BaseMybatisDao<BpmNodeJump> {

    @Override
    public String getNamespace() {
        return BpmNodeJump.class.getName();
    }
  
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addSortParam("COMPLETE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @param page
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId,Page page){
        Map<String,Object> params = new HashMap<>();
        params.put("actInstId",actInstId);
        return this.getBySqlKey("getByActInstId",params,page);
    }
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @param status
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId,String status){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addFieldParam("STATUS_",status);
        filter.addSortParam("COMPLETE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 按Activiti流程实例ID获得流转记录
     * @param actInstId
     * @param status
     * @param page
     * @return
     */
    public List<BpmNodeJump> getByActInstId(String actInstId,String status,Page page){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addFieldParam("STATUS_",status);
        filter.addSortParam("COMPLETE_TIME_","DESC");
        filter.setPage(page);
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 取得任务实例中的跳转记录
     * @param taskId
     * @return
     */
    public BpmNodeJump getByTaskId(String taskId){
        Map<String,Object> params = new HashMap<>();
        params.put("taskId",taskId);
        return this.getUnique("getByTaskId",params);
    }
    /**
     * 获得某个节点的审批记录
     * @param actInstId
     * @param nodeId
     * @return
     */
    public List<BpmNodeJump> getByActInstIdNodeId(String actInstId,String nodeId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addFieldParam("NODE_ID_",nodeId);
        filter.addSortParam("COMPLETE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }
    
    
    /**
     * 找到最新的回退记录列表
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getLatestBackStart(String actInstId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addLikeFieldParam("JUMP_TYPE_",TaskOptionType.BACK.name()+"%");
        filter.addSortParam("COMPLETE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 查找该实例中传入参数的时间大的最新审批记录
     * @param actInstId
     * @param createTime
     * @return
     */
    public List<BpmNodeJump> getByActInstIdGtCreateTinme(String actInstId,Date createTime){
        Map<String,Object> params = new HashMap<>();
        params.put("actInstId",actInstId);
        params.put("createTime",createTime);
        return this.getBySqlKey("getByActInstIdGtCreateTinme",params);
    }
    
    /**
     * 
     * @param actInstId
     * @param jumpType
     * @return
     */
    public List<BpmNodeJump> getByActInstIdJumpType(String actInstId,String jumpType){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actInstId);
        filter.addLikeFieldParam("JUMP_TYPE_",jumpType);
        filter.addSortParam("COMPLETE_TIME_","DESC");
        return this.getBySqlKey("query",filter);
    }
    
    /**
     * 获取表单意见。
     * @param actInstId
     * @return
     */
    public List<BpmNodeJump> getFormOpinionByActInstId(String actInstId){
        return this.getBySqlKey("getFormOpinionByActInstId",actInstId);
    }
    
    public List<BpmNodeJump> getNodeIdByActIdUserId(String actId,String userId){
        QueryFilter filter = new QueryFilter();
        filter.addFieldParam("ACT_INST_ID_",actId);
        filter.addLikeFieldParam("HANDLER_ID_",userId);
        return this.getBySqlKey("query",filter);
    }


    /**
     * ----------------------
     */



    public List<BpmNodeJump> getMyCheckInst(SqlQueryFilter filter) {
        Map<String,Object> params=filter.getParams();
        return this.getBySqlKey("getMyCheckInst", params,filter.getPage());
    }

    /**
     * 获取最新的审批意见。
     * @param actInstId
     * @param nodeId
     * @return
     */
    public BpmNodeJump getLastByInstNode(String instId,String nodeId){
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("instId", instId);
        params.put("nodeId", nodeId);

        List<BpmNodeJump> list=this.getBySqlKey("getLastByInstNode", params);
        if(BeanUtil.isEmpty(list)){
            return null;
        }
        return list.get(0);

    }

    public void removeByActInst(String actInstId) {
        this.deleteBySqlKey("removeByActInst", actInstId);
    }

    public List<BpmNodeJump> getNodejumpByInstId(String instId) {
        Map<String,Object> params=new HashMap<String, Object>();
        params.put("instId", instId);

        List<BpmNodeJump> list=this.getBySqlKey("getNodejumpByInstId", params);
        return list;

    }



}
