package com.redxun.bpm.view.control;

import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.core.util.StringUtil;



public class MiniCheckHiListViewHandler implements MiniViewHanlder{

	@Override
	public String getPluginName() {
		return "mini-checkhilist";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String actInstId=(String)params.get("actInstId");
		if(StringUtil.isEmpty(actInstId)) {
			el.remove();
			return;
		};
		String gridUrl=params.get(FormViewConsts.PARAM_CTX_PATH)+"/bpm/core/bpmNodeJump/listForInst.do?actInstId="+actInstId;
		String gridDiv=" <div id='checkhilist' class='mini-datagrid' ondrawcell='drawNodeJump' "
				+ " style='width:100%;height:auto;' allowResize='true'  showPager='false'  "
				+ "url='"+gridUrl+"'  idField='jumpId' >"
				+ "<div property='columns'>"
				+ "<div field='createTime' dateFormat='yyyy-MM-dd HH:mm' width='80' headerAlign='center'  >发送时间</div>"
				+ "<div field='completeTime' dateFormat='yyyy-MM-dd HH:mm' width='80' headerAlign='center' >处理时间</div>"
				+ "<div field='durationFormat' width='60'>停留时间</div>"
				+ "<div field='nodeName' width='90' headerAlign='center'  >审批步骤</div>"
				+ "<div field='handlerId' width='70' headerAlign='center'>操作者</div>"
				+ "<div field='checkStatusText' width='60' headerAlign='center'  >类型</div>"
				+ "<div field='remark'  width='160' headerAlign='center' >意见</div>"
				+ "</div>"
				+ "</div>";
		
				
		Document doc = Jsoup.parseBodyFragment(gridDiv);
		el.after(doc.body().html());
		el.remove();
		
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		
	}

	

}
