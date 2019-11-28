package com.redxun.bpm.core.controller;

import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.identity.service.IdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityTypeService;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmSolUserManager;
import com.redxun.bpm.core.manager.BpmSolUsergroupManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * [BpmSolUser]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolUser/")
public class BpmSolUserController extends TenantListController{
    @Resource
    BpmSolUserManager bpmSolUserManager;
    @Resource
    IdentityTypeService identityTypeService;
    @Resource
    BpmSolUsergroupManager bpmSolUsergroupManager;
    @Resource 
    BpmDefManager bpmDefManager;


	/**
	 * 扩展属性预览
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getApproveUserList")
	@ResponseBody
	public Collection<TaskExecutor> getApproveUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String data = RequestUtil.getString(request, "config");
		IdentityCalService service=identityTypeService.getIdentityCalServicesMap().get("EXT-PROP");
		IdentityCalConfig idCalConfig=new IdentityCalConfig();
		idCalConfig.setJsonConfig(data);
		Collection<TaskExecutor> list=service.calIdentities(idCalConfig);
		return list;
	}
	/**
	 * 扩展属性预览
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getExtProp")
	public ModelAndView getExtProp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv=getPathView(request);
		return mv;
	}

    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "方案人员配置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmSolUserManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 获得某个节点的人员配置列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getUserBySolIdNodeId")
    @ResponseBody
    public List<BpmSolUser> getUserBySolIdNodeId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeId=request.getParameter("nodeId");
    	
    	String groupType=RequestUtil.getString(request,"groupType",BpmSolUsergroup.GROUP_TYPE_TASK) ;
    	
    	List<BpmSolUser> solUsers=bpmSolUserManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId, groupType);
    	return solUsers;
    }
    
    @RequestMapping("getUserByGroupId")
    @ResponseBody
    public List<BpmSolUser> getUserByGroupId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String groupId=request.getParameter("groupId");
    	List<BpmSolUser> solUsers=bpmSolUserManager.getByGroupId(groupId);
    	return solUsers;
    }
    
    /**
     * 返回流程任务中的人员配置类型列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getUserTypes")
    @ResponseBody
    public Collection<IdentityCalService> getUserTypes(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	return identityTypeService.getIdentityCalServices();
    }
    
    /**
     * 保存单个节点的用户配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveNodeUsers")
    @ResponseBody
    @LogEnt(action = "saveNodeUsers", module = "流程", submodule = "方案人员配置")
    public JsonResult saveNodeUsers(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeId=request.getParameter("nodeId");
    	String category=request.getParameter("category");
    	String nodeName=request.getParameter("nodeText");
    	String usersJson=request.getParameter("usersJson");
    	BpmDef bpmDef=null;
    	if(StringUtils.isNotEmpty(actDefId)){
    		bpmDef=bpmDefManager.getByActDefId(actDefId);
    	}
    	//先删除再添加
    	bpmSolUserManager.delBySolIdActDefIdNodeId(solId,bpmDef.getActDefId(), nodeId, category);
    	
    	//重新添加。
    	JSONArray jsonArr=JSONArray.fromObject(usersJson);
    	for(int i=0;i<jsonArr.size();i++){
    		JSONObject rowJson=jsonArr.getJSONObject(i);
    		Object configObj=rowJson.get("config");
    		if(configObj==null){
    			continue;
			}
    		String config=rowJson.getString("config");

    		rowJson.remove("config");
    		BpmSolUser solUser=(BpmSolUser)JSONObject.toBean(rowJson, BpmSolUser.class);
    		solUser.setConfig(JSONUtil.getString(rowJson, "config"));
    		solUser.setActDefId(bpmDef.getActDefId());
			solUser.setSolId(solId);
			solUser.setNodeId(nodeId);
			solUser.setConfig(config.toString());
			solUser.setCategory(category);
			solUser.setNodeName(nodeName);
			if(StringUtils.isEmpty(solUser.getIsCal())){
				solUser.setIsCal(MBoolean.NO.name());
			}
			solUser.setId(IdUtil.getId());
			bpmSolUserManager.create(solUser);
    	}
    	return new JsonResult(true, "成功保存节点用户！");
    }
    /**
     * 保存流程解决方案中的所有节点的用户配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveUsers")
    @ResponseBody
    @LogEnt(action = "saveUsers", module = "流程", submodule = "方案人员配置")
    public JsonResult saveUsers(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeUserJsons=request.getParameter("nodeUserJsons");
    	JSONArray nodeUserArr=JSONArray.fromObject(nodeUserJsons);
    	for(int i=0;i<nodeUserArr.size();i++){
    		JSONObject jsonNode=nodeUserArr.getJSONObject(i);
    		String nodeId=jsonNode.getString("nodeId");
    		String nodeName=jsonNode.getString("nodeText");
    		String nodeConfigs=jsonNode.getString("nodeConfigs");
    		JSONArray nodeConfigArr=JSONArray.fromObject(nodeConfigs);
    		for(int j=0;j<nodeConfigArr.size();j++){
    			JSONObject rowConfig=nodeConfigArr.getJSONObject(j);
    			BpmSolUser solUser=(BpmSolUser)JSONObject.toBean(rowConfig,BpmSolUser.class);
    			solUser.setActDefId(actDefId);
    			solUser.setConfig(JSONUtil.getString(rowConfig, "config"));
    			if(StringUtils.isNotEmpty(solUser.getId())){
    				BpmSolUser tmpSolUser=bpmSolUserManager.get(solUser.getId());
    				if(tmpSolUser==null) continue;
        			BeanUtil.copyNotNullProperties(tmpSolUser, solUser);
        			bpmSolUserManager.update(tmpSolUser);
        		}else{
        			solUser.setSolId(solId);
        			solUser.setNodeId(nodeId);
        			solUser.setNodeName(nodeName);
        			if(StringUtils.isEmpty(solUser.getIsCal())){
        				solUser.setIsCal(MBoolean.NO.name());
        			}
        			solUser.setId(IdUtil.getId());
        			bpmSolUserManager.create(solUser);
        			
        		}
    		}
    	}
    	return new JsonResult(true,"成功批量保存！");
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
        String pkId=request.getParameter("pkId");
        BpmSolUser bpmSolUser=null;
        if(StringUtils.isNotBlank(pkId)){
           bpmSolUser=bpmSolUserManager.get(pkId);
        }else{
        	bpmSolUser=new BpmSolUser();
        }
        return getPathView(request).addObject("bpmSolUser",bpmSolUser);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	
    	//复制添加
    	BpmSolUsergroup userGroup=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		userGroup=bpmSolUsergroupManager.get(pkId);
    	}else{
    		String groupType=RequestUtil.getString(request, "groupType",BpmSolUsergroup.GROUP_TYPE_TASK);
    		String solId=RequestUtil.getString(request, "solId");
    		String actDefId=RequestUtil.getString(request, "actDefId");
    		String nodeId=RequestUtil.getString(request, "nodeId");
    		String nodeName=RequestUtil.getString(request, "nodeName");
    		
    		userGroup=new BpmSolUsergroup();
    		userGroup.setNodeId(nodeId);
    		userGroup.setNodeName(nodeName);
    		userGroup.setActDefId(actDefId);
    		userGroup.setSolId(solId);
    		userGroup.setGroupType(groupType);
    		
    	}
    	return getPathView(request)
    			.addObject("userGroup",userGroup);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmSolUserManager;
	}

}
