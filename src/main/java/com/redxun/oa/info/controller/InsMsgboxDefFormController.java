
package com.redxun.oa.info.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.info.entity.InsMsgboxBoxDef;
import com.redxun.oa.info.entity.InsMsgboxDef;
import com.redxun.oa.info.manager.InsMsgboxBoxDefManager;
import com.redxun.oa.info.manager.InsMsgboxDefManager;

import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 栏目消息盒子表 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/insMsgboxDef/")
public class InsMsgboxDefFormController extends BaseFormController {

    @Resource
    private InsMsgboxDefManager insMsgboxDefManager;
    @Resource
    private InsMsgboxBoxDefManager insMsgboxBoxDefManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("insMsgboxDef")
    public InsMsgboxDef processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        InsMsgboxDef insMsgboxDef = null;
        if (StringUtils.isNotEmpty(id)) {
            insMsgboxDef = insMsgboxDefManager.get(id);
        } else {
            insMsgboxDef = new InsMsgboxDef();
        }

        return insMsgboxDef;
    }
    /**
     * 保存实体数据
     * @param request
     * @param orders
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult save(HttpServletRequest request, @ModelAttribute("insMsgboxDef") @Valid InsMsgboxDef insMsgboxDef, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(insMsgboxDef.getBoxId())) {
            insMsgboxDef.setBoxId(IdUtil.getId());
            insMsgboxDefManager.create(insMsgboxDef);
            msg = getMessage("insMsgboxDef.created", new Object[]{insMsgboxDef.getIdentifyLabel()}, "[栏目消息盒子表]成功创建!");
        } else {
            insMsgboxDefManager.update(insMsgboxDef);
            msg = getMessage("insMsgboxDef.updated", new Object[]{insMsgboxDef.getIdentifyLabel()}, "[栏目消息盒子表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    @RequestMapping("saveMsgEntity")
    @ResponseBody
    public JsonResult saveMsgEntity(HttpServletRequest request,HttpServletResponse response){
    	JSONObject obj = RequestUtil.getJSONObject(request, "obj");
    	InsMsgboxDef insMsgboxDef = JSONObject.toJavaObject(obj, InsMsgboxDef.class);
    	String msg = null;
    	String data = RequestUtil.getString(request, "data");
    	if(insMsgboxDefManager.isExsitKey(insMsgboxDef)) {
    		return new JsonResult(false, "消息盒子key不能重复");
    	};
    	if (StringUtils.isEmpty(insMsgboxDef.getBoxId())) {
            insMsgboxDef.setBoxId(IdUtil.getId());
            insMsgboxDefManager.create(insMsgboxDef);
            msg = getMessage("insMsgboxDef.created", new Object[]{insMsgboxDef.getIdentifyLabel()}, "[栏目消息盒子表]成功创建!");
        } else {
            insMsgboxDefManager.update(insMsgboxDef);
            msg = getMessage("insMsgboxDef.updated", new Object[]{insMsgboxDef.getIdentifyLabel()}, "[栏目消息盒子表]成功更新!");
        }
    	JSONArray arr = JSONArray.parseArray(data);
    	Iterator<Object> it = arr.iterator();
    	InsMsgboxBoxDef def = new InsMsgboxBoxDef();
    	insMsgboxBoxDefManager.delByBoxId(insMsgboxDef.getBoxId());
    	while(it.hasNext()){
    		JSONObject ob = (JSONObject) it.next();
    		String sn = ob.getString("sn");
    		String msgId = ob.getString("msgId");
    		if(StringUtils.isNotEmpty(sn)&&StringUtils.isNotEmpty(msgId)){    			
    			def.setSn(sn);
    			def.setMsgId(msgId);
    			def.setBoxId(insMsgboxDef.getBoxId());
    			def.setId(IdUtil.getId());
    			insMsgboxBoxDefManager.create(def);
    	    }
    	}
    	return new JsonResult(true, msg);
    }
}

