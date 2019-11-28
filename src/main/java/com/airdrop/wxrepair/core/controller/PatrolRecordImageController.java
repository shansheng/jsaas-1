
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolRecordImage;
import com.airdrop.wxrepair.core.manager.PatrolRecordImageManager;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 巡检图片上传控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolRecordImage/")
public class PatrolRecordImageController extends MybatisListController{
    @Resource
    PatrolRecordImageManager patrolRecordImageManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "巡检图片上传")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolRecordImageManager.delete(id);
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
        PatrolRecordImage patrolRecordImage=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolRecordImage=patrolRecordImageManager.get(pkId);
        }else{
        	patrolRecordImage=new PatrolRecordImage();
        }
        return getPathView(request).addObject("patrolRecordImage",patrolRecordImage);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolRecordImage patrolRecordImage=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolRecordImage=patrolRecordImageManager.get(pkId);
    	}else{
    		patrolRecordImage=new PatrolRecordImage();
    	}
    	return getPathView(request).addObject("patrolRecordImage",patrolRecordImage);
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
    public PatrolRecordImage getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolRecordImage patrolRecordImage = patrolRecordImageManager.getPatrolRecordImage(uId);
        return patrolRecordImage;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "巡检图片上传")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolRecordImage patrolRecordImage, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolRecordImage.getId())) {
            patrolRecordImageManager.create(patrolRecordImage);
            msg = getMessage("patrolRecordImage.created", new Object[]{patrolRecordImage.getIdentifyLabel()}, "[巡检图片上传]成功创建!");
        } else {
        	String id=patrolRecordImage.getId();
        	PatrolRecordImage oldEnt=patrolRecordImageManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolRecordImage);
            patrolRecordImageManager.update(oldEnt);
       
            msg = getMessage("patrolRecordImage.updated", new Object[]{patrolRecordImage.getIdentifyLabel()}, "[巡检图片上传]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolRecordImageManager;
	}

    @RequestMapping("getImageByRefId")
    @ResponseBody
    public ResResult getImageByRefId(HttpServletRequest request,HttpServletResponse response){
        String refId = request.getParameter("refId");
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        List<PatrolRecordImage> images = patrolRecordImageManager.getImageByRefId(refId);
        ArrayList<Object> list = new ArrayList<>();
        for (int i = 0; i < images.size(); i++) {
            PatrolRecordImage image = images.get(i);
            String imageStr = image.getImage();
            JSONObject jsonObject = JSONObject.parseObject(imageStr);
            list.add(jsonObject.getString("val"));
        }
        res.setData(list);
        res.setResMsg("获取图片");
        res.setResCode(0);
        result.setResult(res);
        result.setResMsg("请求成功");
        result.setResCode(0);
        return result;
    }
}
