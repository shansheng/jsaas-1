
package com.redxun.bpm.core.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.org.api.model.ITenant;
import com.redxun.sys.core.entity.SysInstType;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmBatchApproval;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmBatchApprovalManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.database.util.DbUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.log.LogEnt;


/**
 * 流程批量审批设置表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/bpm/core/bpmBatchApproval/")
public class BpmBatchApprovalController extends MybatisListController{
    @Resource
    BpmBatchApprovalManager bpmBatchApprovalManager;
    @Resource
    BpmSolutionManager bpmSolutionManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter filter= QueryFilterBuilder.createQueryFilter(request);
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam("TENANT_ID_", tenantId);
		return filter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "流程批量审批设置表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmBatchApprovalManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=RequestUtil.getString(request, "pkId");
        BpmBatchApproval  bpmBatchApproval=bpmBatchApprovalManager.get(pkId);
        return getPathView(request)
        		.addObject("bpmBatchApproval",bpmBatchApproval);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	return getPathView(request).addObject("pkId",pkId);
    }
    
    @RequestMapping("toApprove")
    public ModelAndView toStartAll(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String taskId=RequestUtil.getString(request, "taskId");
    	return getPathView(request).addObject("taskId",taskId);
    }
    
    @RequestMapping("fieldSet")
    public ModelAndView fieldSet(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=RequestUtil.getString(request, "solId");
    	ModelAndView mv= getPathView(request);
    	mv.addObject("solId",solId);
    	return mv;
    }
    
    /**
     * 获取BO数据，用于选择字段。
     * [{
     * 	comment:"",
     * 	tableName:"",
     * 	attrs:[{
     * 		isShow:false,name:"",comment:"",sn:"1"
     * 	}]
     * }]
     * @param request
     * @return
     */
    @RequestMapping("getBoEnts")
    @ResponseBody
    public JSONArray getBoEnts(HttpServletRequest request) {
    	String solId=RequestUtil.getString(request, "solId");
    	BpmSolution solution=bpmSolutionManager.get(solId);
    	String boDefIds=solution.getBoDefId();
    	String[] aryBoDefId=boDefIds.split(",");
    	
    	String tablePre= DbUtil.getTablePre();
		String columnPre= DbUtil.getColumnPre();
		JSONArray aryEnt=new JSONArray();
    	for(String boDefId:aryBoDefId){
    		SysBoEnt ent= sysBoEntManager.getByBoDefId(boDefId, true);
    		JSONObject json=new JSONObject();
    		json.put("comment", ent.getComment());
    		json.put("tableName",tablePre +  ent.getName());
    		
    		JSONArray ary=new JSONArray();
    		int sn=1;
    		for(SysBoAttr attr:ent.getSysBoAttrs()){
    			JSONObject attrObj=new JSONObject();
    			attrObj.put("name",columnPre +  attr.getName());
    			attrObj.put("comment", attr.getComment());
    			attrObj.put("sn", sn);
    			ary.add(attrObj);
    			sn++;
    		}
    		json.put("attrs", ary);
    		
    		aryEnt.add(json);
    	}
    	return aryEnt;
    }
    
    
    /**
     * 有子表的情况下编辑明细的json
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getJson")
    @ResponseBody
    public BpmBatchApproval getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmBatchApproval bpmBatchApproval = bpmBatchApprovalManager.get(uId);
        return bpmBatchApproval;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "流程批量审批设置表")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmBatchApproval bpmBatchApproval, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        
        boolean rtn=bpmBatchApprovalManager.isExist(bpmBatchApproval.getSolId(), bpmBatchApproval.getNodeId(), bpmBatchApproval.getId());
        if(rtn){
        	return new JsonResult(false, "配置已经添加!");
        }
        String fieldJson =bpmBatchApprovalManager.formFieldSort( bpmBatchApproval.getFieldJson());
        bpmBatchApproval.setFieldJson(fieldJson);
        ITenant tenant=ContextUtil.getTenant();

        String msg = null;
        if (StringUtils.isEmpty(bpmBatchApproval.getId())) {
            if(tenant!=null&&!SysInstType.INST_TYPE_PLATFORM.equals(ContextUtil.getTenant().getInstType()))
                bpmBatchApproval.setTableName(bpmBatchApproval.getTableName()+"_"+tenant.getIdSn());
            bpmBatchApprovalManager.create(bpmBatchApproval);
            msg = getMessage("bpmBatchApproval.created", new Object[]{bpmBatchApproval.getIdentifyLabel()}, "[流程批量审批设置表]成功创建!");
        } else {
        	String id=bpmBatchApproval.getId();
        	BpmBatchApproval oldEnt=bpmBatchApprovalManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmBatchApproval);
            bpmBatchApprovalManager.update(oldEnt);
       
            msg = getMessage("bpmBatchApproval.updated", new Object[]{bpmBatchApproval.getIdentifyLabel()}, "[流程批量审批设置表]成功更新!");
        }
        return new JsonResult(true, msg);
    }

    /**
     * 构建批量查询定义。
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("jsonAll")
	@ResponseBody
	public JSONArray jsonAll(HttpServletRequest request,HttpServletResponse response){
		List<BpmBatchApproval> batchApprovals=bpmBatchApprovalManager.getInvailAll();
		
		Set<String> set=new HashSet<>();
		
		JSONArray array=new JSONArray();
		
		for(BpmBatchApproval approval:batchApprovals){
			if(!set.contains(approval.getSolId())){
				JSONObject parent=new JSONObject();
				parent.put("id", approval.getSolId());
				parent.put("name", approval.getSolName());
				parent.put("parentId", "0");
				array.add(parent);
				
				set.add(approval.getSolId());
			}
			
			JSONObject node=new JSONObject();
			node.put("parentId", approval.getSolId());
			node.put("id",approval.getId());
			node.put("name",approval.getTaskName());
			
			array.add(node);
		}
		
		return array;
	}
    
    @RequestMapping("getColumns")
	@ResponseBody
	public JSONObject excuteSelectSql(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String pkId = RequestUtil.getString(request, "pkId");
		
		BpmBatchApproval bpmBatchApproval = bpmBatchApprovalManager.get(pkId);
		
		String jsonFields= bpmBatchApproval.getFieldJson();
		JSONArray ary=JSONArray.parseArray(jsonFields);
		
		JSONObject json = new JSONObject();
		
		JSONArray resultList = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("type", "checkcolumn");
		obj.put("width", "20");
		resultList.add(obj);
		
		JSONObject nameCol = new JSONObject();
		nameCol.put("field", "DESCRIPTION_");
		nameCol.put("header", "事项名称");
		resultList.add(nameCol);
		
		for(int i=0;i<ary.size();i++){
			JSONObject fieldObj=ary.getJSONObject(i);
			JSONObject item = new JSONObject();
			item.put("field", fieldObj.getString("name"));
			item.put("header", fieldObj.getString("comment"));
			item.put("headerAlign", "center");
			resultList.add(item);
		}
		
		json.put("columns", resultList);
		return json;
	}
    
    @RequestMapping("getTasks")
    @ResponseBody
   	public List excuteSelectSqlData(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String pkId = RequestUtil.getString(request, "pkId");
		String userId =ContextUtil.getCurrentUserId();
		BpmBatchApproval bpmBatchApproval = bpmBatchApprovalManager.get(pkId);
		List  list = bpmBatchApprovalManager.getTaskByUser(bpmBatchApproval, userId);
		return list;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmBatchApprovalManager;
	}
}
