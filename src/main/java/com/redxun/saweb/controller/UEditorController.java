package com.redxun.saweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.redxun.core.util.FileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.config.upload.FileExt;
import com.redxun.saweb.config.upload.FileUploadConfig;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.ImageUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.FileOperatorFactory;
import com.redxun.sys.core.manager.IFileOperator;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
/**
 * UEditor的上传处理
 * @author mansan
 *
 */
@Controller
@RequestMapping("/ueditor")
public class UEditorController extends BaseController {
	@Resource
	SysFileManager sysFileManager;
	@Resource
	FileUploadConfig fileUploadConfig;
	
	@RequestMapping
	public String index() {
		return "/ueditor/index";
	}

	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	@ResponseBody
	public void upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String action = request.getParameter("action");
		if ("config".equals(action)) {
			OutputStream os = response.getOutputStream();
			FileInputStream is=new FileInputStream(ResourceUtils.getFile("classpath:ueditor-config.json"));
			IOUtils.copy(is, os);
		}
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> upload(HttpServletRequest request, @RequestParam CommonsMultipartFile upfile) throws Exception {
		String action=RequestUtil.getString(request, "action");
		String fileSystem=SysPropertiesUtil.getGlobalProperty("fileSystem","file");
		IFileOperator operator=FileOperatorFactory.getByType(fileSystem);
		Map<String, String> result = new HashMap<String, String>();
		
		SysFile sysFile = new SysFile();
		
		InputStream is = upfile.getInputStream();
		byte[] bytes=FileUtil.input2byte(is);
		
		String fileId=IdUtil.getId();
		String oriFileName = upfile.getOriginalFilename();
		String extName = FileUtil.getFileExt(oriFileName);
		// 新文件名
		String newFileName = fileId + "." + extName;
		
		
		FileModel fileModel=operator.createFile(newFileName, bytes);
		sysFile.setPath(fileModel.getRelPath());
		
		// 如果为图片，则生成图片的缩略图
		if ("uploadimage".equals(action)) {
			fileId = IdUtil.getId();
			String imgName = fileId + "." + extName;
			byte[] imgBytes= ImageUtil.thumbnailImage(bytes, 150, 150, extName);
			FileModel imgModel=operator.createFile(imgName, imgBytes);
			sysFile.setThumbnail(imgModel.getRelPath());
		}
		
		
		sysFile.setFileId(fileId);
		sysFile.setFileName(newFileName);
		//设置新的文件名
		sysFile.setNewFname(newFileName);
		//设置其来源
		sysFile.setFrom(SysFile.FROM_UEDITOR);
		sysFile.setExt(extName);
		sysFile.setTotalBytes(upfile.getSize());
		sysFile.setDelStatus("undeleted");
		setMineType(sysFile,extName);
		sysFile.setFileSystem(fileSystem);
		sysFileManager.create(sysFile);
	
		String host=SysPropertiesUtil.getGlobalProperty("install.host");
		result.put("url", host +  "/sys/core/file/previewFile.do?fileId=" + sysFile.getFileId());
		result.put("size", String.valueOf(bytes.length));
		result.put("title", sysFile.getFileName());
		result.put("text", sysFile.getFileName() );
		result.put("alt", sysFile.getFileName());
		result.put("type",extName);
		result.put("state", "SUCCESS");
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

	@RequestMapping(value = "/show", method = RequestMethod.GET)
	public void show(String filePath, HttpServletResponse response) throws IOException {

		File file = getFile(filePath);

		response.setDateHeader("Expires", System.currentTimeMillis() + 1000 * 60 * 60 * 24);
		response.setHeader("Cache-Control", "max-age=60");
		OutputStream os = response.getOutputStream();

		FileInputStream is = null;
		try {
			is = new FileInputStream(file);
			IOUtils.copy(is, os);
		} catch (FileNotFoundException e) {
			response.setStatus(404);
			return;
		} finally {
			if (null != is) {
				is.close();
			}
			if (null != os) {
				os.flush();
				os.close();
			}
		}
	}

	protected String getFilePath(CommonsMultipartFile uploadFile) throws Exception {
		String absolutePath = WebAppUtil.getUeditorUploadPath();
		File folder = new File(absolutePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		String rawName = uploadFile.getFileItem().getName();
		String fileExt = rawName.substring(rawName.lastIndexOf("."));
		String newName = System.currentTimeMillis() + UUID.randomUUID().toString() + fileExt;
		File saveFile = new File(absolutePath + File.separator + newName);
		try {
			uploadFile.getFileItem().write(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return absolutePath + "/" + newName;
	}

	protected File getFile(String path) {
		File file = new File(path);
		return file;
	}

}
