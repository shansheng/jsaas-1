package com.redxun.restApi.sys.controller;

import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.redxun.saweb.config.upload.FileExt;
import com.redxun.saweb.config.upload.FileUploadConfig;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.controller.GenericController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDataHandler;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.FileOperatorFactory;
import com.redxun.sys.core.manager.IFileOperator;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;
import com.redxun.sys.db.manager.SysSqlCustomQueryUtil;

@RestController
@RequestMapping("/restApi/sys/")
public class SysController extends GenericController {
	
	@Resource
	private SysSqlCustomQueryManager sysSqlCustomQueryManager;
	@Resource
	private SysBoDefManager sysBoDefManager;
	@Resource
	private SysBoEntManager sysBoEntManager;
	@Resource
	SysBoDataHandler sysBoDataHandler;
	@Resource
	SysFileManager sysFileManager;
	@Resource
	FileUploadConfig fileUploadConfig;
	
	@RequestMapping(value = "queryForJson",method={RequestMethod.POST})
	@ResponseBody
	public JsonResult queryForJson(HttpServletRequest request) throws Exception {
		String alias=RequestUtil.getString(request, "alias");
		String jsonStr = RequestUtil.getString(request,"params");
		JsonResult result=SysSqlCustomQueryUtil.queryForJson(alias, jsonStr);
		return result;
	}
	
	/**
	 * 通过接口保存数据。
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "saveData",method={RequestMethod.POST})
	@ResponseBody
	public JsonResult saveData(HttpServletRequest request) throws Exception {
		try{
			String alias=RequestUtil.getString(request, "alias");
			String jsonStr = RequestUtil.getString(request,"data");
			SysBoDef def= sysBoDefManager.getByAlias(alias);
			String boDefId=def.getId();
			
			SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId) ;
			JSONObject jsonData=JSONObject.parseObject(jsonStr);
			BoResult result= sysBoDataHandler.handleData(ent, jsonData);
			result.setBoEnt(null);
			if(result.getIsSuccess()) {
				return new JsonResult (true, "保存成功", result);
			}else {
				return new JsonResult(false, "验证不通过", result.getMessage());
			}
		}
		catch (Exception e) {
			return new JsonResult (false, "保存失败", ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	
	/**
	 * 上传文件接口。
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "updFile")
	@ResponseBody
	public JsonResult updFile(MultipartHttpServletRequest request){
		JsonResult result=new JsonResult(true, "上传文件成功");
		try{
			Map<String, MultipartFile> files = request.getFileMap();
			Iterator<MultipartFile> it = files.values().iterator();

			String fileSystem=SysPropertiesUtil.getGlobalProperty("fileSystem","file");
			IFileOperator operator=FileOperatorFactory.getByType(fileSystem);
			 
			JSONArray fileAry=new JSONArray();
			while (it.hasNext()) {
				String fileId = IdUtil.getId();
				
				SysFile file = new SysFile();
				file.setFileId(fileId);
				
				MultipartFile f = it.next();
				String oriFileName = f.getOriginalFilename();

				String extName = FileUtil.getFileExt(oriFileName);
				// 新文件名
				String newFileName = fileId + "." + extName;

				InputStream is = f.getInputStream();
				byte[] bytes=FileUtil.input2byte(is);
				
				
				FileModel fileModel=operator.createFile(newFileName, bytes);
				file.setPath(fileModel.getRelPath());
				
				file.setFileSystem(fileSystem);
				file.setFileName(oriFileName);
				// 设置新的文件名
				file.setNewFname(newFileName);

				// 设置其来源
				file.setFrom("api");
				file.setExt(extName);
				// 设置上传文件的MINE TYPE
				file.setTotalBytes(f.getSize());
				file.setDelStatus("undeleted");

				setMineType(file,extName);

				sysFileManager.create(file);
				
				file.setFileContent(bytes);
				
				JSONObject fileObj=new JSONObject();
				
				fileObj.put("fileId", file.getFileId());
				fileObj.put("name", file.getFileName());
				
				fileAry.add(fileObj);
			}
			result=new JsonResult(true,"上文件成功");
			result.setData(fileAry);
			
		}
		catch(Exception ex){
			result=new JsonResult(false,"上文件出错");
			result.setData(ExceptionUtil.getExceptionMessage(ex));
		}
		return result;
	}

	void setMineType(SysFile file,String extName){
		FileExt fileExt = fileUploadConfig.getFileExtMap().get(extName.toLowerCase());
		if (fileExt != null) {
			file.setMineType(fileExt.getMineType());
		} else {
			file.setMineType("Unkown");
		}
	}

}
