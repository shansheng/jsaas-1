package com.redxun.saweb.config.ui;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.util.Dom4jUtil;

/**
 * UI配置类
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 *
 */
public class UiConfig implements InitializingBean{
	
	protected  Logger logger=LogManager.getLogger(UiConfig.class);
	
	@javax.annotation.Resource
	FreemarkEngine freemarkEngine;
	

	
	
	/**
	 * 系统皮肤配置
	 */
	private static List<UiSkin> skins=new ArrayList<UiSkin>();
	/**
	 * UEditor扩展的miniui控件的配置
	 */
	private static Map<String,String> ueditorControls=new HashMap<String,String>();
	
	@Override
	public void afterPropertiesSet() throws Exception{
		loadSkins();
		loadUeditorControls();
	}
	
	/**
	 * 加载系统皮肤
	 * @throws Exception
	 */
	public void loadSkins() throws Exception {
		Resource resource = new ClassPathResource("config/miniui-skins.properties");
		 Properties pros=new Properties();
		 pros.load(resource.getInputStream());
		 Iterator<Object> keyIt=pros.keySet().iterator();
		 while(keyIt.hasNext()){
			 String key=(String)keyIt.next();
			 if(StringUtils.isEmpty(key)) continue;
			 String val=pros.getProperty(key);
			 UiSkin skin=new UiSkin(key,val);
			 skins.add(skin);
		 }
	}
	
	public void loadUeditorControls() throws Exception{
		Resource resource = new ClassPathResource("config/miniui-control-defs.xml");
		Document doc=Dom4jUtil.load(resource.getInputStream());
		Element rootEl=doc.getRootElement();
		Iterator<Element> conEls=rootEl.elementIterator();
		while(conEls.hasNext()){
			Element el=conEls.next();
			String id=el.attributeValue("id");
			String config=(String)el.getData();
			ueditorControls.put(id, config.trim());
		}
	}

	public List<UiSkin> getSkins() {
		return skins;
	}

	public static Map<String, String> getUeditorControls() {
		return ueditorControls;
	}
	
	
	
	
}
