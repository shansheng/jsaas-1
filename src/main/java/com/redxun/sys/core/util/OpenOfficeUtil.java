package com.redxun.sys.core.util;

import java.io.File;
import java.io.IOException;
import java.net.ConnectException;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.listener.OpenofficeListener;
import com.redxun.sys.core.entity.SysFile;

/**
 * OpenOffice工具类。
 *
 */
public class OpenOfficeUtil {
	
	protected static Logger logger = LogManager.getLogger(OpenofficeListener.class);

	public static final String OPEN_OFFICE_CONFIG="openOfficeConfig";
	
	public static final String SERVICE_IP="service_ip";
	
	public static final String SERVICE_PORT="service_port";
	
	public static final String INSTALL_PATH="installPath";
	
	
	/**
	 * 是否允许office转换。
	 * @return
	 */
	public static boolean isOpenOfficeEnabled(){
		String openOfficeConfig = SysPropertiesUtil.getGlobalProperty(OPEN_OFFICE_CONFIG);
		JSONObject configJson = JSONObject.parseObject(openOfficeConfig);
		if(BeanUtil.isEmpty(configJson))return false;
		String enabled=configJson.getString("enabled");
		return "YES".equals(enabled);
	}
	
	
	
	/**
	 * 
	 * @param inputFilePath  D:\\outFile.doc 注意文件在不同系统内的区别,请使用File.separator作为分隔符
	 * @param outputFilePath D:\\intFile.pdf
	 * @return jsonObject   {success:false,reason:"openOffice系统参数缺失"}
	 */
	public static  JSONObject coverFromOffice2Pdf(String inputFilePath,String outputFilePath) {
		String openOfficeConfigProperty = SysPropertiesUtil.getGlobalProperty(OPEN_OFFICE_CONFIG);
		JSONObject configJson = JSONObject.parseObject(openOfficeConfigProperty);
		JSONObject jsonObject=new JSONObject();
		String opId="";//openOffice参数
		Integer opPort=null;//openOffice参数
		try {
			opId = configJson.getString(SERVICE_IP);//服务安装的的ip
			opPort= configJson.getIntValue(SERVICE_PORT);//服务安装的的端口
		} catch (Exception e) {
			jsonObject.put("success", false);
			jsonObject.put("reason", "openOffice系统参数缺失");
			return jsonObject;
		}
		
		File inputFile = new File(inputFilePath);
		File outputFile = new File(outputFilePath);
		if (!inputFile.exists()) {    
			jsonObject.put("success", false);
			jsonObject.put("reason", "找不到源文件");
            return jsonObject;// 找不到源文件, 则返回    
        }

		OpenOfficeConnection connection = new SocketOpenOfficeConnection(opId,opPort);
		try{
			connection.connect();
			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(inputFile, outputFile);
		}
	 	catch (Exception e) {
	 		jsonObject.put("success", false);
			jsonObject.put("reason", "连接错误");
			return jsonObject;
	 	}
		finally {
			if(connection!=null){
				connection.disconnect();
			}
		}
		
		jsonObject.put("success", true);
		jsonObject.put("reason", "成功执行,目标地址:"+outputFilePath);
        return jsonObject;
	}
	
	/**
	 * 获取连接状态
	 * @return
	 */
	public static JsonResult<String> getConnectStatus(){
		JsonResult<String> rtn=new JsonResult<>(true, "office服务已启动!");
		String opId="";//openOffice参数
		Integer opPort=null;//openOffice参数
		try {
			String openOfficeConfig = SysPropertiesUtil.getGlobalProperty(OPEN_OFFICE_CONFIG);
			JSONObject configJson = JSONObject.parseObject(openOfficeConfig);
			opId = configJson.getString(SERVICE_IP);
			opPort=configJson.getIntValue(SERVICE_PORT);
		} catch (Exception e) {
			rtn.setSuccess(false);
			rtn.setMessage("openoffice配置不全!");
			return rtn;
		}
		OpenOfficeConnection connection = new SocketOpenOfficeConnection(opId,opPort);
		try {
			connection.connect();
		} catch (ConnectException e) {
			rtn.setSuccess(false);
			rtn.setMessage("office服务未启动!");
		}
		return rtn;
		
	}
	
	/**
	 * 启动服务
	 * @return
	 */
	public static JsonResult<String> startService(){
		String openOfficeConfig = SysPropertiesUtil.getGlobalProperty(OPEN_OFFICE_CONFIG);
		if(StringUtil.isEmpty(openOfficeConfig))return new JsonResult<String>(true,"");
		JSONObject configJson=JSONObject.parseObject(openOfficeConfig);
		String installPath=configJson.getString(INSTALL_PATH);
		String ip=configJson.getString(SERVICE_IP);
		String port=configJson.getString(SERVICE_PORT);
		String enabled=configJson.getString("enabled");
		if(!"YES".equals(enabled)) {
			logger.debug("openoffice 服务没有设置自动启动!");
			return new JsonResult<String>(true,"");
		}
		
		JsonResult<String> result=startService(installPath, ip, port);
		return result;
	}
	
	/**
	 * 启动流程服务。
	 * @param installPath
	 * @param ip
	 * @param port
	 * @return
	 */
	public static JsonResult<String> startService(String installPath, String ip,String port){
		JsonResult<String> result=new JsonResult<String>(true,"启动服务成功!");
		String sys=System.getProperty("os.name");
		try {
			if(StringUtils.isBlank(installPath)||StringUtils.isBlank(ip)||StringUtils.isBlank(port)){
				return new JsonResult<String>(false,"系统参数不齐全!");
			}
			String command="";
			if(sys.toLowerCase().startsWith("win")){
				command= installPath   + "program\\soffice.exe -headless -accept=\"socket,host="+ip+",port="+port+";urp;StarOffice.ServiceManager\" -nofirststartwizard";
			}else{
				command=installPath+"program/soffice -headless -accept=\"socket,host="+ip+",port="+port+";urp;\" -nofirststartwizard &";
			}
			Runtime.getRuntime().exec(command);
			
		} catch (Exception e) {
			logger.debug(ExceptionUtil.getExceptionMessage(e));
			result.setSuccess(false);
			result.setMessage("启动失败!");
			result.setData(ExceptionUtil.getExceptionMessage(e));
		}
		return result;
		
	}
	
	
	/**
	 * 结束服务
	 * @return
	 */
	public static JsonResult<String> endService(){
		JsonResult<String> result=new JsonResult<String>(true,"停止服务成功!");
		try {
			if(System.getProperty("os.name").toLowerCase().startsWith("win")){
				Runtime.getRuntime().exec("taskkill /f /im soffice.exe");
			}
		} catch (IOException e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage("停止服务成功!");
			result.setData(ExceptionUtil.getExceptionMessage(e));
		}
		return result;
	}
	
	
	public static void  que2CoverOffice(SysFile file){
		IMessageProducer messageProducer=AppBeanUtil.getBean(IMessageProducer.class);
		messageProducer.send("officeCoverPdfMessageQueue", file);
	}
	
}
