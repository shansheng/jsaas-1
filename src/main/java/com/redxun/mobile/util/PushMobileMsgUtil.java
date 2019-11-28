package com.redxun.mobile.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gexin.rp.sdk.base.IAliasResult;
import com.gexin.rp.sdk.base.IBatch;
import com.gexin.rp.sdk.base.IIGtPush;
import com.gexin.rp.sdk.base.impl.SingleMessage;
import com.gexin.rp.sdk.base.impl.Target;
import com.gexin.rp.sdk.base.payload.APNPayload;
import com.gexin.rp.sdk.http.IGtPush;
import com.gexin.rp.sdk.template.NotificationTemplate;
import com.gexin.rp.sdk.template.TransmissionTemplate;
import com.gexin.rp.sdk.template.style.Style0;
import com.redxun.bpm.core.entity.BpmMobileTag;
import com.redxun.bpm.core.manager.BpmMobileTagManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;



/**
 * 手机端消息推送工具类
 * @author Administrator
 *
 */
public class PushMobileMsgUtil {
		
	private static String GETUI_HOST;
	private static String GETUI_APPKEY  = "";
	private static String GETUI_MASTERSECRET  = "";
	private static String GETUI_APPID  = "";
	private final static String ANDROID = "Android"; 
	private final static String IOS = "iOS"; 
	
	static{
		try {
			GETUI_HOST = SysPropertiesUtil.getGlobalProperty("getui.host");			
			GETUI_APPKEY = SysPropertiesUtil.getGlobalProperty("getui.appkey");
			GETUI_MASTERSECRET = SysPropertiesUtil.getGlobalProperty("getui.mastersecret");
			GETUI_APPID = SysPropertiesUtil.getGlobalProperty("getui.appId");		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 将用户（别名）和CID绑定
	 * @author Stephen
	 * @param alais 别名，用户ID充当
	 * @param cid	CID，客户端APP标识码
	 * @return
	 */
	public static Boolean userBindCid(String alias,String cid){

		IGtPush push = new IGtPush(GETUI_HOST, GETUI_APPKEY, GETUI_MASTERSECRET);
    	IAliasResult bindSCid = push.bindAlias(GETUI_APPID, alias, cid);   	
    	if(bindSCid.getResult()){
    		return true;
    	}		
		return false;
	}
	
	
	
	/**
	 * 单推（少量用户建议使用单推提升性能）
	 * @author Stephen
	 * @param userList 待推送userId列表，相当于别名列表
	 * @param title	消息标题
	 * @param text 消息内容
	 * @param body 传到手机端的数据，json字符串 
	 * @param mobileType 手机类型
	 */
	public static void pushMsgToUser(String userList,String title,String text,String body) throws Exception{
		
		BpmMobileTagManager bpmMobileTagManager = AppBeanUtil.getBean(BpmMobileTagManager.class);
		
		Map<String,Object> cidMobileTypeMap = new HashMap<String, Object>();
		List<String> targetList =  Arrays.asList(userList);    	
		//cid列表
		List<String> cidList = PushMobileMsgUtil.getCidByAlias(targetList);
		for(String cid:cidList){
			BpmMobileTag mobileTag =  bpmMobileTagManager.getByCid(cid);
			if(mobileTag!=null){
				String mobileType = mobileTag.getMobileType();
				cidMobileTypeMap.put(cid, mobileType);				
			}
		}						
		batchSumit(cidMobileTypeMap,title,text,body);			
	}

	
	private static void batchSumit(Map<String,Object> cidMobileTypeMap,String title,String text,String body)  throws Exception{
		
		IIGtPush push = new IGtPush(GETUI_HOST, GETUI_APPKEY, GETUI_MASTERSECRET);
        IBatch batch = push.getBatch();
        for(Map.Entry<String, Object> entry:cidMobileTypeMap.entrySet()){
        	String cid = entry.getKey();
        	String mobileType = entry.getValue().toString();
        	if(StringUtil.isNotEmpty(cid)&&StringUtil.isNotEmpty(mobileType)){
        		//根据不同机型以不同模板发送消息
        		if(PushMobileMsgUtil.ANDROID.equals(mobileType)){
        			constructClientOpenMsgAndroid(cid,title,text,body,batch);
        		}else{
        			constructClientOpenMsgIOS(cid,title,text,body,batch);
        		}
        	}
        }
        batch.submit();	
	}
	
	
	
	public static List<String> getCidByAlias(List<String> userList){
		
        //需要推送的所有CID
        List<String> orderPushCidList = new ArrayList<String>(0);
        //根据用户列表获取客户端CID
        IGtPush pushAlias = new IGtPush(GETUI_HOST, GETUI_APPKEY, GETUI_MASTERSECRET);      
        for(String userIdAlias:userList){       	
        	IAliasResult queryClientId = pushAlias.queryClientId(GETUI_APPID, userIdAlias);        	
        	List<String> singleUserCids = queryClientId.getClientIdList();
        	if(singleUserCids!=null){
        		orderPushCidList.addAll(singleUserCids);
        	}       	       	
        }        
        return orderPushCidList;
        
	}
		
	//推送透传消息(安卓)
	private static void constructClientOpenMsgAndroid(String cid, String title,String text, String msg ,IBatch batch) throws Exception {		
		SingleMessage message = new SingleMessage();
		NotificationTemplate template = new NotificationTemplate();
		template.setTransmissionType(1);//强制启动应用
		template.setTransmissionContent(msg);
		template.setAppId(GETUI_APPID);
        template.setAppkey(GETUI_APPKEY);        
        
        Style0 style = new Style0();        
        style.setText(text);
        style.setTitle(title);
        template.setStyle(style);
        message.setData(template);
        message.setOffline(true);
        message.setOfflineExpireTime(3600* 1000);
       
        // 设置推送目标，填入appid和clientId
        Target target = new Target();
        target.setAppId(GETUI_APPID);
        target.setClientId(cid);
        batch.add(message, target);      
	}
	
	
	//推送透传消息(IOS APNs)
	private static void constructClientOpenMsgIOS(String cid, String title,String text, String body ,IBatch batch) throws Exception {		
		SingleMessage message = new SingleMessage();
		TransmissionTemplate template = new TransmissionTemplate();
		template.setTransmissionType(1);//强制启动应用
		template.setTransmissionContent(body);
		template.setAppId(GETUI_APPID);
        template.setAppkey(GETUI_APPKEY);        
        
        //设置消息样式等
        APNPayload apn = new APNPayload();
        APNPayload.DictionaryAlertMsg apnDic = new APNPayload.DictionaryAlertMsg();
        apnDic.setTitle(title);
        apnDic.setBody(text);
        apn.setAlertMsg(apnDic);
        apn.setContentAvailable(0);       
        
        Map<String,Object> forwardMsg = JSONUtil.json2Map(body);
        for(Map.Entry<String, Object> entry: forwardMsg.entrySet()){
        	apn.addCustomMsg(entry.getKey(),entry.getValue());
        }
        template.setAPNInfo(apn);
        message.setData(template);
        message.setOffline(true);
        message.setOfflineExpireTime(3600* 1000);
       
        // 设置推送目标，填入appid和clientId
        Target target = new Target();
        target.setAppId(GETUI_APPID);
        target.setClientId(cid);
        batch.add(message, target);      
	}
	
	/**
	 * 将用户与机器解绑
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public static Boolean unBindAllByAlias(String userId) throws Exception{
		
		IGtPush push = new IGtPush(GETUI_HOST, GETUI_APPKEY, GETUI_MASTERSECRET);
		IAliasResult AliasUnBindAll = push.unBindAliasAll(GETUI_APPID, userId);
	    System.out.println("解除绑定结果:" + AliasUnBindAll.getResult());		
		return AliasUnBindAll.getResult();
	}
	
	
}
