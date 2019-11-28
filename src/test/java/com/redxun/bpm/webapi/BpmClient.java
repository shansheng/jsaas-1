package com.redxun.bpm.webapi;

import java.io.InputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.junit.Test;

import com.redxun.core.util.HttpClientUtil;

/**
 * 流程实例处理操作
 * @author mansan
 *
 */
public class BpmClient {
	/**
	 * 启动流程实例
	 * 
	 */
	@Test
	public void testStartProcess() throws Exception {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		//{userAmt:'abc@xce.com',solId:'111',jsonData:'{}',vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]'}
		HttpPost httpPost = new HttpPost("http://www.redxun.cn:8020/saweb/bpm/webapi/inst/startProcess.do");  
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();  
        nvps.add(new BasicNameValuePair("cmd", "{solId:'9640000000000081',userAccount:'admin@redxun.cn',jsonData:'{\"subject\":\"C009333xx\",\"type\":\"年假\",\"reqMan\":\"1\",\"startTime\":\"2016-03-03\",\"endTime\":\"2016-04-05\",\"nums\":\"2\",\"descp\":\"请假天数3天\"}',"
        		+ "vars:[{name:\'type2\',type:\'String\',value:\'001\'}]}"));  
          
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
		CloseableHttpResponse response = httpclient.execute(httpPost);
		InputStream instream=null;
		try {
		    	HttpEntity entity = response.getEntity();
			    if (entity != null) {
				     instream = entity.getContent();
				     StringWriter writer = new StringWriter();
				     IOUtils.copy(instream, writer, "UTF-8");
				     String theString = writer.toString();
				     System.out.println("str:"+theString);
			    }    
		} finally {
			if(instream!=null){
				instream.close();
			}
		    response.close();
		}
	}
	
	
	/**
	 * 获得流程实例的任务
	 * @throws Exception
	 */
	@Test
	public void getProcessTasks() throws Exception {
		Map<String,String> params=new HashMap<String, String>();
		params.put("instId","9400000000000044");
		String url="http://localhost:8080/jsaas/bpm/webapi/inst/getTasksByInstId.do";
		String content=HttpClientUtil.getFromUrl(url, params);
		System.out.println("content:"+content);
	}
	
	/**
	 * 取得我的任务列表
	 * @throws Exception
	 */
	@Test
	public void getMyTasks() throws Exception{
		String cmd="{userAccount:'admin@redxun.cn',pageIndex:0,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_description_S_LK:'23'}";
		Map<String,String> params=new HashMap<String, String>();
		params.put("cmd",cmd);
		String url="http://www.redxun.cn:8020/saweb/bpm/webapi/inst/getTasksByUserAccount.do";
		
		String result=HttpClientUtil.postFromUrl(url, params);
		
		System.out.println("result:"+ result);
		
	}
	
	/**
	 * 取得当前任务的后续任务节点
	 * @throws Exception
	 */
	@Test
	public void getOutNodes() throws Exception{
		String taskId="9400000000000058";
		
		Map<String,String> params=new HashMap<String, String>();
		params.put("taskId",taskId);
		String url="http://localhost:8080/jsaas/bpm/webapi/inst/getTaskOutNodes.do";
		
		String result=HttpClientUtil.getFromUrl(url, params);
		
		System.out.println("result:"+result);
	}
	
	/**
	 * 执行任务往下跳转
	 * {
			taskId:'10000303',
			userAccount:'admin@redxun.cn',
			jsonData:{},
			jumpType:'AGREE',//REFUSE，BACK，BACK_TO_STARTOR
			opinion:'同意',
			destNodeId:'Task2',
			destNodeUsers:[
				{
				 nodeId:'UserTask1'
				 userIds:'1,2',
				 priority:50,
				 expiretime:'2016-03-04'
				},{
				 nodeId:'UserTask2'
				 userIds:'1,2',
				 priority:50,
				 expiretime:'2016-03-04'
				}
			]
	 }
	 * @throws Exception
	 */
	@Test
	public void doNext() throws Exception{
		String taskId="8450000000000090";
		
		String cmd="{userAccount:'admin@redxun.cn',taskId:'"+taskId+"',jumpType:'AGREE',opinion:'我同意',jsonData:'{}'}}";
		Map<String,String> params=new HashMap<String, String>();
		params.put("cmd",cmd);

		String url="http://www.redxun.cn:8020/saweb/bpm/webapi/inst/doNext.do";
		
		String result=HttpClientUtil.postFromUrl(url, params);
		
		System.out.println("result:"+result);
	}
	
	
}
