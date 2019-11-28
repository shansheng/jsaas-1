package com.redxun.saweb.security.cas;

import java.util.HashMap;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.Dom4jUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.HttpClientUtil.HttpRtnModel;
import com.redxun.core.util.PropertiesUtil;

public class CasRestClient {

	/**
	 * 登录验证
	 * @param account
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public static JsonResult<String> login(String account,String password) throws Exception{
		JsonResult<String> result= new JsonResult(true,"验证成功","");
		String url=PropertiesUtil.getProperty("cas.server") +"/v1/tickets";
		Map<String, String> params=new HashMap<>();
		params.put("username", account);
		params.put("password", password);
		HttpRtnModel rtn=HttpClientUtil.postFromUrl(url,null, params);
		if(201==rtn.getStatusCode()){
			Document doc= Jsoup.parse(rtn.getContent());
			Element  el=   doc.select("form").first();
			String tgtid=el.attr("action").replace(url+"/", "");
			result.setData(tgtid);
		}
		else{
			result.setSuccess(false);
			result.setMessage("验证失败");
			result.setData(rtn.getContent());
		}
		return result;
	}
	
	public static JsonResult<String> getStByTgtId(String tgtId) throws Exception{
		String url=PropertiesUtil.getProperty("cas.server") +"/v1/tickets/" +tgtId;
		String service=PropertiesUtil.getProperty("cas.client") +"/j_spring_cas_security_check" ;
		Map<String, String> params=new HashMap<>();
		params.put("service", service);
		JsonResult<String> result= new JsonResult(true,"获取ST成功","");
		HttpRtnModel rtn=HttpClientUtil.postFromUrl(url,null, params);
		if(200==rtn.getStatusCode()){
			result.setData(rtn.getContent());
		}
		else{
			result.setSuccess(false);
			result.setMessage("获取ST失败");
			result.setData(rtn.getContent());
		}
		return result;
	}
	
	public static JsonResult<String> serviceValidate(String ticket) throws Exception{
		String url=PropertiesUtil.getProperty("cas.server") +"/serviceValidate";
		String service=PropertiesUtil.getProperty("cas.client")  +"/j_spring_cas_security_check" ;
		Map<String, String> params=new HashMap<>();
		params.put("service", service);
		params.put("ticket", ticket);
		JsonResult<String> result= new JsonResult(true,"验证成功","");
		HttpRtnModel rtn=HttpClientUtil.postFromUrl(url,null, params);
		if(200==rtn.getStatusCode()){
			String account= getAccount(rtn.getContent());
			result.setData(account);
		}
		else{
			result.setSuccess(false);
			result.setMessage("验证失败");
			result.setData(rtn.getContent());
		}
		return result;
	}
	
	/**
	 * 成功返回数据为  tgtId +"," +st
	 * @param account
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public static JsonResult<String> loginCas(String account,String password) throws Exception{
		JsonResult<String> rtnLogin= login(account, password);
		
		if(!rtnLogin.getSuccess()) return rtnLogin;
		String tgtId=rtnLogin.getData();
		JsonResult<String> rtnTgt =getStByTgtId(tgtId);
		String st=rtnTgt.getData();
		if(!rtnTgt.getSuccess()) return rtnTgt;
		
		rtnTgt.setData(tgtId+"," + st);
		return rtnTgt;
		
	}
	
	public static JsonResult<String> logout(String tgtId) throws Exception{
		JsonResult<String> rtn= new JsonResult<>(true, "登出成功");
		String url=PropertiesUtil.getProperty("cas.server") +"/v1/tickets/" +tgtId;
		HttpRtnModel model= HttpClientUtil.delFromUrl(url, null);
		if(model.getStatusCode()==200){
			return rtn;
		}
		rtn.setSuccess(false);
		rtn.setMessage("登出失败");
		return rtn;
	}
	
	private static String getAccount(String content){
		org.dom4j.Document doc= Dom4jUtil.stringToDocument(content);
		org.dom4j.Element root=doc.getRootElement();
		root.addNamespace("cas", "");
		org.dom4j.Element el= (org.dom4j.Element) doc.selectSingleNode("//cas:user");
		return el.getText();
	}
	
}
