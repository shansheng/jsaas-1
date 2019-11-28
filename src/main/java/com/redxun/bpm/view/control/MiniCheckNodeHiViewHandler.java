package com.redxun.bpm.view.control;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.core.util.DateUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;



/**
 * 节点审批历史视图处理器
 * @author mansan
 *@Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniCheckNodeHiViewHandler implements MiniViewHanlder{
	@Resource
	private BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	private UserService userService;
	@Override
	public String getPluginName() {
		return "mini-checknodehi";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String nodeId=el.attr("nodeid");
		String actInstId=(String)params.get("actInstId");
		if(StringUtils.isNotBlank(nodeId)&& StringUtils.isNotEmpty(actInstId)){
			List<BpmNodeJump> jumpList= bpmNodeJumpManager.getByActInstIdNodeId(actInstId, nodeId);
			SimpleDateFormat df=new SimpleDateFormat(DateUtil.DATE_FORMAT_FULL);
			Element ulEl=new Element(Tag.valueOf("ul"),"");
			//替换为审批意见列表
			for(BpmNodeJump jump:jumpList){
				if(StringUtils.isNotEmpty(jump.getHandlerId())&& jump.getCompleteTime()!=null){
					IUser osUser=userService.getByUserId(jump.getHandlerId());
					String fullname=osUser!=null?osUser.getFullname():"用户("+jump.getHandlerId()+")";
					String datetime=df.format(jump.getCompleteTime());
					Element liEl=new Element(Tag.valueOf("li"),"").text(fullname+"进行了"+jump.getCheckStatusText()+"操作("+datetime+"),审批意见为："+jump.getRemark());
					ulEl.appendChild(liEl);
				}
			}
			el.replaceWith(ulEl);
		}else{
			el.replaceWith(new Element(Tag.valueOf("span"), "").text("暂无审批意见~"));
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		// TODO Auto-generated method stub
		
	}

	

}
