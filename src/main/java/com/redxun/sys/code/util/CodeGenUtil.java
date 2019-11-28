package com.redxun.sys.code.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.util.SysPropertiesUtil;

public class CodeGenUtil {
	private static String developer;
	private static String company;
	private static String domain;
	private static String email;
	private static String baseDir;
	private static HashMap<String,Object> varsMap = new HashMap<String,Object>();
	static {
		developer = SysPropertiesUtil.getGlobalProperty("variables.developer");
		company = SysPropertiesUtil.getGlobalProperty("variables.company");
		domain = SysPropertiesUtil.getGlobalProperty("variables.domain");
		email = SysPropertiesUtil.getGlobalProperty("variables.email");
		baseDir = SysPropertiesUtil.getGlobalProperty("baseDir");
		varsMap.put("developer", developer);
		varsMap.put("company", company);
		varsMap.put("domain", domain);
		varsMap.put("email", email);
	}
	
	private static JsonResult vaildVariables() {
		StringBuffer str = new StringBuffer();
		boolean flag = true;
		if(StringUtil.isEmpty(developer)) {
			flag = false;
			str.append("代码生成[作者]参数不存在<br/>");
		}
		if(StringUtil.isEmpty(company)) {
			flag = false;
			str.append("代码生成[公司]参数不存在<br/>");
		}
		if(StringUtil.isEmpty(domain)) {
			flag = false;
			str.append("代码生成[包根路径]参数不存在<br/>");
		}
		if(StringUtil.isEmpty(email)) {
			flag = false;
			str.append("代码生成[邮箱]参数不存在<br/>");
		}
		return new JsonResult(flag, str.toString());
	}
	
	public static JsonResult generate(JSONObject json) throws Exception {
		FreemarkEngine freemarkEngine = WebAppUtil.getBean(FreemarkEngine.class);
		SysBoEntManager sysBoEntManager = WebAppUtil.getBean(SysBoEntManager.class);
		SysBoAttrManager sysBoAttrManager = WebAppUtil.getBean(SysBoAttrManager.class);
		JsonResult result = vaildVariables();
		if(result.getSuccess()) {
			String bodefId = json.getString("bodefId");
			String moduleName = json.getString("moduleName");
			String packageName = json.getString("packageName");
			JSONArray template = json.getJSONArray("template");
			for (int i = 0; i < template.size(); i++) {
				HashMap<String,Object> localHashMap = new HashMap<String,Object>();
				JSONObject obj = template.getJSONObject(i);
				SysBoEnt ent = sysBoEntManager.getByBoDefId(bodefId);
				localHashMap.put("vars", varsMap);
	            localHashMap.put("model", ent);
	            localHashMap.put("moduleName", moduleName);
	            localHashMap.put("packageName", packageName);
	            localHashMap.put("date", new Date());
	            localHashMap.put("obj",obj);
				String html=freemarkEngine.mergeTemplateIntoString("template/"+obj.getString("path"), localHashMap);
				initFileData(html,localHashMap);
			}
		}
		return result;
	}
	
	
	private static void initFileData(String html, HashMap<String,Object> localHashMap) throws IOException {
		String path = baseDir+"\\src\\main\\java\\"+domain.replace(".", "\\")+"\\"
				+localHashMap.get("moduleName")+"\\"+localHashMap.get("packageName")+"\\"+((JSONObject)localHashMap.get("obj")).getString("alias")+"\\"
				+((SysBoEnt)localHashMap.get("model")).getUpperName()+((JSONObject)localHashMap.get("obj")).getString("suffix");
		File file = new File(path);
		File fileParent = file.getParentFile();  
		if(!fileParent.exists()){  
		    fileParent.mkdirs();  
		}  
		String suffix = path.substring(path.indexOf("."));
		//String name = path.substring(0, path.substring(beginIndex))
		int i = 1;
        //若文件存在重命名
       /* while(file.exists()) {
            String newFilename = name+"("+i+")"+suffix;
            i++;
        }*/
        if(!file.exists()) {
			file.createNewFile(); 
		}
		if(file.exists()) {
			FileWriter out = new FileWriter(file);
	        out.write(html);
	        out.close();
		}
	}

	public static JsonResult download(JSONObject json) throws Exception {
		FreemarkEngine freemarkEngine = WebAppUtil.getBean(FreemarkEngine.class);
		JsonResult result = vaildVariables();
		
		return result;
	}
	
}
