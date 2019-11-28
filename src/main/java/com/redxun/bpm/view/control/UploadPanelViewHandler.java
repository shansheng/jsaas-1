package com.redxun.bpm.view.control;

import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.bpm.core.manager.BpmInstCtlManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;


/**
 * 上传控件视图处理器
 * @author mansan
 *  @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class UploadPanelViewHandler implements MiniViewHanlder{
	@Resource
	BpmInstCtlManager bpmInstCtlManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Override
	public String getPluginName() {
		return "upload-panel";
	}
	
	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		
		String userId = ContextUtil.getCurrentUserId();
		String instId=(String)params.get(FormViewConsts.PARAM_INST_ID);
		String isDown = el.attr("isDown");
		if(StringUtil.isNotEmpty(isDown)){
			el.attr("isDown",isDown);
		}else{
			boolean isDown2 = bpmInstCtlManager.sysFileCtl(userId, instId, BpmInstCtl.CTL_RIGHT_DOWN);
			el.attr("isDown",String.valueOf(isDown2));
		}
		String isPrint = el.attr("isPrint");
		if(StringUtil.isNotEmpty(isPrint)){
			el.attr("isPrint",isPrint);
		}else{
			boolean isPrint2 = bpmInstCtlManager.sysFileCtl(userId, instId, BpmInstCtl.CTL_RIGHT_PRINT);
			el.attr("isPrint",String.valueOf(isPrint2));
		}		
		el.attr("value",val);
		
	}
	
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		el.attr("readOnly", "true");
	}

	
}
