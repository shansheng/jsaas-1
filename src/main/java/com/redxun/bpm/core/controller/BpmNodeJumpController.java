package com.redxun.bpm.core.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmCheckFile;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmCheckFileManager;
import com.redxun.bpm.core.manager.BpmInstCtlManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 流程任务流转记录管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmNodeJump/")
public class BpmNodeJumpController extends BaseListController{
    @Resource
    BpmNodeJumpManager bpmNodeJumpManager;
    @Resource
    BpmTaskManager bpmTaskManager;
    @Resource
    BpmInstManager bpmInstManager;
    @Resource
    UserService userService;
    @Resource
    BpmCheckFileManager bpmCheckFileManager;
    @Resource
    BpmInstCtlManager bpmInstCtlManager;
    @Resource
    OsUserManager osUserManager;
    @Resource
    GroupService groupService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程流转记录")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmNodeJumpManager.delete(id);
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
        BpmNodeJump bpmNodeJump=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmNodeJump=bpmNodeJumpManager.get(pkId);
        }else{
        	bpmNodeJump=new BpmNodeJump();
        }
        return getPathView(request).addObject("bpmNodeJump",bpmNodeJump);
    }
    
    /**
     * 
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listForInst")
    @ResponseBody
    public JsonPageResult<BpmNodeJump> listForInst(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actInstId=request.getParameter("actInstId");
    	String taskId=request.getParameter("taskId");
    	String instId=request.getParameter("instId");
    	String isDown = request.getParameter("isDown");
    	String isPrint = request.getParameter("isPrint");
    	String more=request.getParameter("more");
    	Page page=QueryFilterBuilder.createPage(request);
    	List<BpmNodeJump> list=null;
    	if(StringUtils.isNotEmpty(taskId)){
    		BpmTask bpmTask=bpmTaskManager.get(taskId);
    		list=bpmNodeJumpManager.getByActInstId(bpmTask.getProcInstId());
    	}else if(StringUtils.isNotEmpty(instId)){
    		BpmInst bpmInst=bpmInstManager.get(instId);
    		list=bpmNodeJumpManager.getByActInstId(bpmInst.getActInstId());
    	}else{
    		list=bpmNodeJumpManager.getByActInstId(actInstId,page);
    	}
    	
    	List<BpmNodeJump> lists = new ArrayList<BpmNodeJump>();
    	
    	for(BpmNodeJump node:list){
    		if(node.getJumpType()==null || "UNHANDLE".equals(node.getJumpType())) continue;
    		//需要显示更多的干预项，进行干预
    		if(TaskOptionType.INTERPOSE.name().equals(node.getJumpType())){
    			if("true".equals(more)){
    				lists.add(node);
    			}
    		}else{
    			lists.add(node);
    		}
    		String handlerId=node.getHandlerId();
    		if(StringUtil.isNotEmpty(handlerId)){
    			IUser user= userService.getByUserId(handlerId);
    			node.setHandler(user.getFullname());
    		}
    	}
    	
    	//审批意见附件回显
    	for(BpmNodeJump nodeJump:lists){
    		List<BpmCheckFile> files = bpmCheckFileManager.getByNodeId(nodeJump.getJumpId());
    		if(BeanUtil.isEmpty(files)) continue;
    		JSONArray attachments=new JSONArray();
    		for(BpmCheckFile nodefile : files){
				String fileId = nodefile.getFileId();
				String fileName = nodefile.getFileName();
				String extName=fileName.substring(fileName.lastIndexOf(".")+1);
				
				String type = extName.toLowerCase();
				
				JSONObject obj=new JSONObject();
				obj.put("type", type);
				obj.put("fileId", fileId);
				obj.put("fileName", fileName);
				obj.put("isDown", isDown);
				obj.put("isPrint", isPrint);
				attachments.add(obj);
			}
			nodeJump.setAttachments(attachments);
    	}
    	return new JsonPageResult<BpmNodeJump>(lists, page.getTotalItems());
    }
   
    
    @RequestMapping("listForInstMobile")
    @ResponseBody
    public JsonPageResult<BpmNodeJump> listForInstMobile(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actInstId=request.getParameter("actInstId");
    	String taskId=request.getParameter("taskId");
    	String instId=request.getParameter("instId");
    	String isDown = request.getParameter("isDown");
    	String isPrint = request.getParameter("isPrint");
    	String more=request.getParameter("more");
    	Page page=QueryFilterBuilder.createPage(request);
    	page.setPageSize(100);
    	List<BpmNodeJump> list=null;
    	if(StringUtils.isNotEmpty(taskId)){
    		BpmTask bpmTask=bpmTaskManager.get(taskId);
    		list=bpmNodeJumpManager.getByActInstId(bpmTask.getProcInstId());
    	}else if(StringUtils.isNotEmpty(instId)){
    		BpmInst bpmInst=bpmInstManager.get(instId);
    		list=bpmNodeJumpManager.getByActInstId(bpmInst.getActInstId());
    	}else{
    		list=bpmNodeJumpManager.getByActInstId(actInstId,page);
    	}
    	
    	List<BpmNodeJump> lists = new ArrayList<BpmNodeJump>();
    	
    	for(BpmNodeJump node:list){
    		if(node.getJumpType()==null || "UNHANDLE".equals(node.getJumpType())){
    			continue;
    		}
    		
    		//需要显示更多的干预项，进行干预
    		if(TaskOptionType.INTERPOSE.name().equals(node.getJumpType())){
    			if("true".equals(more)){
    				lists.add(node);
    			}
    		}else{
    			lists.add(node);
    		}
    		String handlerId=node.getHandlerId();
			JSONObject handerInfo=new JSONObject();
    		if(StringUtil.isNotEmpty(handlerId)){
    			OsUser osUser=osUserManager.get(handlerId);
    			if(osUser!=null){
    				userSetDeptName(osUser);
    				handerInfo.put("handler", osUser.getFullname());
    				handerInfo.put("deptName", osUser.getDepPathNames());
    				handerInfo.put("photoId", osUser.getPhoto());
    			}
    		}
			node.setHandlerInfo(handerInfo);    			
    	}
    	
    	//审批意见附件回显
    	for(BpmNodeJump nodeJump:lists){
    		List<BpmCheckFile> files = bpmCheckFileManager.getByNodeId(nodeJump.getJumpId());
    		if(BeanUtil.isEmpty(files)) continue;
    		JSONArray attachments=new JSONArray();
			for(BpmCheckFile nodefile : files){
				String fileId = nodefile.getFileId();
				String fileName = nodefile.getFileName();
				
				String extName=fileName.substring(fileName.lastIndexOf(".")+1);
				JSONObject file=new JSONObject();
				file.put("fileId", fileId);
				file.put("fileName", fileName);
				file.put("extName", extName);
				attachments.add(file);
			}
    		nodeJump.setAttachments(attachments);
    	}
    	
    	return new JsonPageResult<BpmNodeJump>(lists, page.getTotalItems());
    }
    
    //设置部门
    private void userSetDeptName(OsUser user){
    	IGroup mainGroup=groupService.getMainByUserId(user.getUserId());
    	StringBuffer pSb=new StringBuffer();
    	if(mainGroup!=null){
    		OsGroup mainGp=(OsGroup)mainGroup;
    		user.setMainDep(mainGp);
    		String path=mainGp.getPath();
    		String[]paths=path.split("[.]");
    		for(String p : paths){
    			if("0".equals(p)){
    				continue;
    			}
    			IGroup cp=groupService.getById(p);
    			if(cp!=null){
    				pSb.append(cp.getIdentityName()).append("/");
    			}
    		}
    	}
    	
    	if(pSb.length()>0){
    		pSb.deleteCharAt(pSb.length()-1);
    	}
    	user.setDepPathNames(pSb.toString());
    	
    }
    
    /**
     * 
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listForInstShowName")
    @ResponseBody
    public JsonPageResult<BpmNodeJump> listForInstShowName(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actInstId=request.getParameter("actInstId");
    	Page page=QueryFilterBuilder.createPage(request);
    	List<BpmNodeJump> list=bpmNodeJumpManager.getByActInstId(actInstId,page);
    	for (BpmNodeJump bpmNodeJump : list) {
			bpmNodeJump.setCreateBy(userService.getByUserId(bpmNodeJump.getCreateBy()).getFullname());
			if(bpmNodeJump.getHandlerId()!=null){
				bpmNodeJump.setHandlerId(userService.getByUserId(bpmNodeJump.getHandlerId()).getFullname());
			}else{
				bpmNodeJump.setHandlerId("暂无");
			}
			
		}
    	return new JsonPageResult<BpmNodeJump>(list, page.getTotalItems());
    }
    
    /**
     * 流转日志
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("actLlistData")
    @ResponseBody
    public JsonPageResult<BpmNodeJump> actLlistData(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actInstId=request.getParameter("actInstId");
    	Page page=QueryFilterBuilder.createPage(request);
    	List<BpmNodeJump> list=bpmNodeJumpManager.getByActInstId(actInstId,page);
    	for (BpmNodeJump bpmNodeJump : list) {
			bpmNodeJump.setCreateBy(userService.getByUserId(bpmNodeJump.getCreateBy()).getFullname());
			if(bpmNodeJump.getHandlerId()!=null){
				bpmNodeJump.setHandlerId(userService.getByUserId(bpmNodeJump.getHandlerId()).getFullname());
			}else{
				bpmNodeJump.setHandlerId("暂无");
			}
			
		}
    	return new JsonPageResult<BpmNodeJump>(list, page.getTotalItems());
    }
    
    /**
     * 按节点Id查找审批实例中的审批历史
     */
    @RequestMapping("byNodeId")
    public ModelAndView byNodeId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actInstId=request.getParameter("actInstId");
    	String nodeId=request.getParameter("nodeId");
    	String taskId=request.getParameter("taskId");
    	
    	if(StringUtils.isNotEmpty(taskId)){
    		BpmTask bpmTask=bpmTaskManager.get(taskId);
    		actInstId=bpmTask.getProcInstId();
    	}
    	
    	List<BpmNodeJump> bpmNodeJumps=bpmNodeJumpManager.getByActInstIdNodeId(actInstId, nodeId);
    	return getPathView(request).addObject("bpmNodeJumps",bpmNodeJumps);
    }
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmNodeJump bpmNodeJump=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmNodeJump=bpmNodeJumpManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmNodeJump.setJumpId(null);
    		}
    	}else{
    		bpmNodeJump=new BpmNodeJump();
    	}
    	return getPathView(request).addObject("bpmNodeJump",bpmNodeJump);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmNodeJumpManager;
	}

}
