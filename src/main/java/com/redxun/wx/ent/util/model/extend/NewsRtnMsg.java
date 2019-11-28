package com.redxun.wx.ent.util.model.extend;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Element;

import com.redxun.wx.ent.util.model.BaseRtnMsg;

public class NewsRtnMsg extends BaseRtnMsg {

	
	private List<NewItem> items=new ArrayList<>();

	public List<NewItem> getItems() {
		return items;
	}

	public void setItems(List<NewItem> items) {
		this.items = items;
	}


	@Override
	protected void extToString(Element root) {
		
		root.addElement("ArticleCount").setText(String.valueOf(items.size()) );
		
		Element articles= root.addElement("Articles");

		for(NewItem item:items){
			Element el= articles.addElement("item");
			el.addElement("Title").addCDATA(item.getTitle());
			el.addElement("Description").addCDATA(item.getDescription());
			el.addElement("PicUrl").addCDATA(item.getPicUrl());
			el.addElement("Url").addCDATA(item.getUrl());
		}
		
		
	}

}
