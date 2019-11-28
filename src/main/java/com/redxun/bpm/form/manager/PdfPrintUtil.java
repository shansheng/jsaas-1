package com.redxun.bpm.form.manager;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.context.HttpServletContext;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysFileManager;

public class PdfPrintUtil {
	

	
	public static String displayFile(String file){
		//[{"fileId":"1","fileName":"a.doc","totalBytes":22016}
		if(BeanUtil.isEmpty(file)) return "";
		JSONArray ary=JSONArray.parseArray(file);
		if(ary.size()==0) return "";
		StringBuilder sb=new StringBuilder();
		sb.append("<ul class=\"file\">");
		for(int i=0;i<ary.size();i++){
			JSONObject json=ary.getJSONObject(i);
			sb.append("<li>");
			sb.append(json.getString("fileName"));
			sb.append("</li>");
		}
		sb.append("</ul>");
		
		return sb.toString();
	}
	
	/**
	 * 显示office 文件。
	 * @param file
	 * @return
	 */
	public static String displayOffice(String file){
		if(BeanUtil.isEmpty(file)) return "";
		JSONObject json=JSONObject.parseObject(file);
		String fileId=json.getString("id");
		SysFileManager fileManager=AppBeanUtil.getBean(SysFileManager.class);
		SysFile fileObj=fileManager.get(fileId);
		return fileObj.getFileName();
	}
	
	/**
	 * 显示图片。
	 * @param str
	 * @return
	 */
	public static String displayImg(String str){
		if(BeanUtil.isEmpty(str)) return "";
		HttpServletRequest request=HttpServletContext.getRequest();
		String ctxPath=request.getContextPath();
		//{imgtype:'upload',val:""} 
		//__rootPath+'/sys/core/file/imageView.do?thumb=true&fileId=' + imgVal
		JSONObject json=JSONObject.parseObject(str);
		String imgtype=json.getString("imgtype");
		String val=json.getString("val");
		String url="";
		//url
		if("upload".equals(imgtype)){
			url=ctxPath + "/sys/core/file/imageView.do?thumb=true&fileId="+ val;
		}
		else{
			if(!url.startsWith("http")){
				url=ctxPath +  val;
			}
		}
		return "<img src=\""+url+"\"/>";
	}
	
	/**
	 * 显示日期。
	 * @param str
	 * @return
	 */
	public static String displayDate(String str){
		if(BeanUtil.isEmpty(str)) return "";
		String rtn=str.replace("T", " ");
		String[] aryTime=rtn.split(" ");
		String time="";
		if(aryTime.length==2){
			time=aryTime[1];
			if("00:00".equals(time)){
				return  aryTime[0] ;
			}
			else if("00:00:00".equals(time)){
				return aryTime[0] ;
			}
		}
		return rtn;
	}


}
