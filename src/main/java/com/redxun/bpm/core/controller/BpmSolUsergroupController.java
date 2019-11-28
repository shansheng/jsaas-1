package com.redxun.bpm.core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.manager.BpmSolUsergroupManager;

/**
 * [BpmSolUsergroup]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmSolUsergroup/")
public class BpmSolUsergroupController extends BaseListController{
    @Resource
    BpmSolUsergroupManager bpmSolUsergroupManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "方案用户组配置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmSolUsergroupManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        BpmSolUsergroup bpmSolUsergroup=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmSolUsergroup=bpmSolUsergroupManager.get(pkId);
        }else{
        	bpmSolUsergroup=new BpmSolUsergroup();
        }
        return getPathView(request).addObject("bpmSolUsergroup",bpmSolUsergroup);
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
		return bpmSolUsergroupManager;
	}
	
	@RequestMapping("getBySolNode")
	@ResponseBody
    public List<BpmSolUsergroup> getBySolNode(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String solId=RequestUtil.getString(request, "solId");
        String actDefId=RequestUtil.getString(request, "actDefId");
        String nodeId=RequestUtil.getString(request, "nodeId");
        String groupType=RequestUtil.getString(request, "groupType",BpmSolUsergroup.GROUP_TYPE_TASK);
        
        List<BpmSolUsergroup> list= bpmSolUsergroupManager.getBySolNode(solId,actDefId, nodeId, groupType);
		return list;
    }

}
