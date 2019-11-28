
package com.redxun.bpm.core.controller;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.b;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmMessageBoard;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmMessageBoardManager;
import com.thoughtworks.xstream.core.ReferenceByIdMarshaller.IDGenerator;

/**
 * 流程沟通留言板控制器
 * @author mansan
 */
@Controller
@RequestMapping("/bpm/core/bpmMessageBoard/")
public class BpmMessageBoardController extends BaseMybatisListController{
    @Resource
    BpmMessageBoardManager bpmMessageBoardManager;
   
    @Resource
    BpmInstManager bpmInstManager;
    
    @Resource
    OsUserManager osUserManager;
    
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmMessageBoardManager.delete(id);
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
        BpmMessageBoard bpmMessageBoard=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmMessageBoard=bpmMessageBoardManager.get(pkId);
        }else{
        	bpmMessageBoard=new BpmMessageBoard();
        }
        return getPathView(request).addObject("bpmMessageBoard",bpmMessageBoard);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	String instId=RequestUtil.getString(request, "instId");
    	List<BpmMessageBoard> bpmMessageBoards = new ArrayList<BpmMessageBoard>(0);
    	QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmMessageBoard bpmMessageBoard=null;
    	BpmInst bpmInst = null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmMessageBoard=bpmMessageBoardManager.get(pkId);
     		if("true".equals(forCopy)){
    			bpmMessageBoard.setId(null);
    		}
    	}else{
    		if(StringUtils.isNotEmpty(instId)){
    			bpmInst = bpmInstManager.get(instId);
    			bpmMessageBoards = bpmMessageBoardManager.getMessageBoardByInstId(instId,filter);
    			bpmMessageBoard=new BpmMessageBoard();
        		String newBoardId = idGenerator.getSID();   		
        		bpmMessageBoard.setInstId(instId);
        		bpmMessageBoard.setId(newBoardId);
        		bpmMessageBoardManager.create(bpmMessageBoard);
    		}else{
    			bpmMessageBoardManager.update(bpmMessageBoard);
    		}
    		
    	}
    	return getPathView(request).addObject("bpmMessageBoard",bpmMessageBoard).addObject("bpmInst", bpmInst).addObject("bpmMessageBoards", bpmMessageBoards);
    }
      
    
    /**
     * 根据实例ID获取留言板
     * @author Stephen
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getMessageBoardByInstId")
    @ResponseBody
    public JsonResult getMessageBoardByInstId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String instId = RequestUtil.getString(request, "instId");
    	QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
    	((Page)(filter.getPage())).setPageSize(10000);
    	List<BpmMessageBoard> bpmMessageBoard = new ArrayList<BpmMessageBoard>(0);
    	if(StringUtils.isNotEmpty(instId)){
    		bpmMessageBoard = bpmMessageBoardManager.getMessageBoardByInstId(instId,filter);
    		if(bpmMessageBoard==null){
    			return new JsonResult(false, "该流程没有留言", bpmMessageBoard);
    		}
     	}
    	return new JsonResult(true, "获取留言版成功", bpmMessageBoard);
    }
 
    /**
     * 增加留言页面
     * @author Stephen
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("addMessage")
    public ModelAndView addMessage(HttpServletRequest request,HttpServletResponse response) throws Exception{ 	
    	String instId = RequestUtil.getString(request, "instId");
    	BpmInst bpmInst = null;
    	String currentUserId = "";
    	List<BpmMessageBoard> bpmMessageBoards = new ArrayList<BpmMessageBoard>(0);
    	QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
    	((Page)(filter.getPage())).setPageSize(10000);
    	if(StringUtil.isNotEmpty(instId)){
    		bpmInst = bpmInstManager.get(instId);
    		bpmMessageBoards = bpmMessageBoardManager.getMessageBoardByInstId(instId,filter);    		
    		currentUserId = ContextUtil.getCurrentUserId();
     	}    	
    	Collections.reverse(bpmMessageBoards);
    	
    	
    	return getPathView(request).addObject("bpmInst", bpmInst).addObject("bpmMessageBoards",bpmMessageBoards).addObject("currentUserId", currentUserId);
    }
    
    
    //留言
    @RequestMapping("leaveMessage")
 	@ResponseBody
    public JsonResult leaveMessage(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String instId = RequestUtil.getString(request, "instId");
    	String messageContent = RequestUtil.getString(request, "messageContent");
    	
    	if(StringUtil.isEmpty(instId)){
    		return new JsonResult(false,"该留言没有绑定到流程，请检查数据");
    	}   
    	BpmMessageBoard bpmMessageBoard = new BpmMessageBoard();
    	bpmMessageBoard.setId(idGenerator.getSID());
    	bpmMessageBoard.setInstId(instId);
    	bpmMessageBoard.setMessageContent(messageContent);
    	bpmMessageBoard.setMessageAuthor(ContextUtil.getCurrentUser().getFullname());
    	bpmMessageBoard.setMessageAuthorId(ContextUtil.getCurrentUserId());
    	bpmMessageBoardManager.create(bpmMessageBoard);
    	return new JsonResult(true,"留言成功");
    }
    
    
  //选择留言板内留言过的人员
    @SuppressWarnings("unchecked")
    @RequestMapping("getInstUser")
 	@ResponseBody
    public JsonResult getInstUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String procInstId = RequestUtil.getString(request, "procInstId");
    	if(StringUtil.isEmpty(procInstId)){
    		return new JsonResult(false,"该留言没有绑定到流程，请检查数据");
    	}    	
    	BpmInst bpmInst = bpmInstManager.getByActInstId(procInstId);
    	
    	if(bpmInst==null){
    		return new JsonResult(false,"流程实例为空，请检查procInstId");
    	}
    	
    	List<BpmMessageBoard> msgUserIds =  bpmMessageBoardManager.getInstUser(bpmInst.getInstId()); 
    	List<String> ids = new ArrayList<String>();
    	for(BpmMessageBoard bpmMessageBoard : msgUserIds){
    		ids.add(bpmMessageBoard.getMessageAuthorId());
    	}
   	
		Object[] userIds = ids.toArray();
    	if(msgUserIds!=null&&msgUserIds.size()>0){   		
    		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
    		queryFilter.addFieldParam("userId", QueryParam.OP_IN, userIds);
    		List<OsUser> instUsers = osUserManager.getAll(queryFilter);
    		if(instUsers!=null&&instUsers.size()>0){
    			return new JsonResult(true,"获取数据成功",instUsers);
    		}
    	}
    	
    	return new JsonResult(true,"获取数据成功");
    }
    
     

	@SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return bpmMessageBoardManager;
	}

}
