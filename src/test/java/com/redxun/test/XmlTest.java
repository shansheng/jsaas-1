package com.redxun.test;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;

import com.redxun.core.util.Dom4jUtil;

public class XmlTest {
	
	public static void main(String[] args) {
		
		Document doc= Dom4jUtil.load("d:\\doc.xml");
		Element root= doc.getRootElement();
		Element userEl= (Element) root.selectSingleNode("//user");
		
		Element name= (Element) userEl.selectSingleNode("name");
		
		
		
		System.out.println(name.getText());
		
	}

}
