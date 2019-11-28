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

import com.redxun.bpm.core.entity.BpmInstRead;
import com.redxun.bpm.core.entity.BpmTaskRead;
import com.redxun.bpm.core.manager.BpmInstReadManager;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmInstRead]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstRead/")
public class BpmInstReadController extends BaseListController{
    @Resource
    BpmInstReadManager bpmInstReadManager;
    @Resource
	GroupService groupService;  
	@Resource
	UserService userService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程阅读记录")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmInstReadManager.delete(id);
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
        BpmInstRead bpmInstRead=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmInstRead=bpmInstReadManager.get(pkId);
        }else{
        	bpmInstRead=new BpmInstRead();
        }
        return getPathView(request).addObject("bpmInstRead",bpmInstRead);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmInstRead bpmInstRead=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmInstRead=bpmInstReadManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmInstRead.setReadId(null);
    		}
    	}else{
    		bpmInstRead=new BpmInstRead();
    	}
    	return getPathView(request).addObject("bpmInstRead",bpmInstRead);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmInstReadManager;
	}
	
   
    
    
    @RequestMapping("readList")
    @ResponseBody
    public JsonPageResult<BpmTaskRead> readList(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String instId = request.getParameter("instId");
    	QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
    	//防止直接取所有的数据
    	if(StringUtils.isEmpty(instId)){
    		instId="0";
    	}
    	filter.addFieldParam("bpmInst.instId", instId);
    	filter.addSortParam("createTime", "desc");
    	
    	List<BpmInstRead> lists = bpmInstReadManager.getAll(filter);
    	List<BpmTaskRead> readLists=new ArrayList<BpmTaskRead>();
    
    	for(BpmInstRead list:lists){
    		BpmTaskRead read = new BpmTaskRead();
    		read.setCreateTime(list.getCreateTime());
    		read.setReadId(list.getReadId());
    		String groupId=list.getDepId();
    		if(StringUtil.isNotEmpty(groupId)){
    			IGroup iGroup=groupService.getById(groupId);
        		if(BeanUtil.isNotEmpty(iGroup)){
        			read.setDepName(iGroup.getIdentityName());
        		}
    		}
    		String userId=list.getUserId();
    		if(StringUtil.isNotEmpty(userId)){
    			IUser user=userService.getByUserId(list.getUserId());
    			if(BeanUtil.isNotEmpty(user)){
    				read.setUserName(user.getFullname() );
    			}
    		}
    		read.setState(list.getState());
    		readLists.add(read);
    	}
    	
    	JsonPageResult<BpmTaskRead> pagelist = new JsonPageResult<BpmTaskRead>(readLists, filter.getPage().getTotalItems());
    	return pagelist;
    }

}
