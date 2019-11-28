package com.redxun.ui.grid;

import java.util.Map;

import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;

public class GdMiniButtonEditHandler implements GridColEditParseHandler{

	@Override
	public String getPluginName() {
		return "mini-buttonedit";
	}

	@Override
	public Element parse(Element columnEl,JSONObject elJson, Map<String, Object> params) {
		Element el=new Element(Tag.valueOf("INPUT"),"");
		el.attr("class",getPluginName()+" rxc");
		el.attr("plugins",getPluginName());
		el.attr("property","editor");
		el.attr("data-options",elJson.toString());
		el.attr("allowinput",FastjsonUtil.getString(elJson,"allowinput","false"));
		el.attr("showclose",FastjsonUtil.getString(elJson,"showclose","false"));

//		Map<String,Object> map=FastjsonUtil.json2Map(elJson);
//		for(Entry<String,Object> entry:map.entrySet()){
//			el.attr(entry.getKey(), entry.getValue()+"");
//		}
		el.attr("onbuttonclick", "_OnGridEditDialogShow");
		el.attr("oncloseclick", "_OnButtonEditClear");
//		el.attr("value",FastjsonUtil.getString(elJson,"value",""));
//		el.attr("required",FastjsonUtil.getString(elJson,"required",""));
		return el;
	}
	
}
