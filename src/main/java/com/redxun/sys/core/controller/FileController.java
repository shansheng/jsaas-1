package com.redxun.sys.core.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.artofsolving.jodconverter.DocumentFormat;
import com.artofsolving.jodconverter.DocumentFormatRegistry;
import com.redxun.core.json.IJson;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.config.upload.FileExt;
import com.redxun.saweb.config.upload.FileUploadConfig;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.ImageUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.FileOperatorFactory;
import com.redxun.sys.core.manager.IFileOperator;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.manager.SysOfficeManager;
import com.redxun.sys.core.manager.SysOfficeVerManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.core.util.OpenOfficeUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 文件上传及下载控件器
 * 
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@RequestMapping("/sys/core/file/")
@Controller
public class FileController extends BaseController {
	@Resource
	SysFileManager sysFileManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	FileUploadConfig fileUploadConfig;
	@Resource
	SysOfficeManager sysOfficeManager;
	@Resource
	SysOfficeVerManager sysOfficeVerManager;
	@Resource
	DocumentFormatRegistry documentFormatRegistry;
	@Resource(name = "iJsonLazy")
	IJson iJson;


	private static final int BUFFER_SIZE = 100 * 1024;
	
	/**
	 * 获得文件的绝对路径
	 * 
	 * @param sysFile
	 * @return
	 * @throws Exception 
	 */
	private String getFilePath(SysFile sysFile) throws Exception {
		String fullPath = WebAppUtil.getUploadPath() + "/" + sysFile.getPath();
		return fullPath;
	}

	@RequestMapping("upload")
	@LogEnt(action = "upload", module = "系统内核", submodule = "文件")
	public void upload(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResult jsonResult = new JsonResult();
		// 附件是针对哪一分类
		String sysTreeId = request.getParameter("sysTreeId");
		// 文件上传的来源，表示为应用级的附件还是个性化附件
		String from = request.getParameter("from");
		// 上传的文件类型
		String types = request.getParameter("types");
	

		Map<String, MultipartFile> files = request.getFileMap();
		Iterator<MultipartFile> it = files.values().iterator();

		String fileSystem=SysPropertiesUtil.getGlobalProperty("fileSystem","file");
		IFileOperator operator=FileOperatorFactory.getByType(fileSystem);
		 
		
		response.setContentType(" text/html");
		

		List<SysFile> fileList = new ArrayList<SysFile>();

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
			
			// 如果为图片，则生成图片的缩略图
			if ("Image".equals(types)) {
				fileId = IdUtil.getId();
				String imgName = fileId + "." + extName;
				byte[] imgBytes= ImageUtil.thumbnailImage(bytes, 150, 150, extName);
				FileModel imgModel=operator.createFile(imgName, imgBytes);
				file.setThumbnail(imgModel.getRelPath());
			}
			
			file.setFileSystem(fileSystem);
			file.setFileName(oriFileName);
			// 设置新的文件名
			file.setNewFname(newFileName);

			file.setTypeId(sysTreeId);
			// 设置其来源
			file.setFrom(from);
			file.setExt(extName);
			// 设置上传文件的MINE TYPE
			file.setTotalBytes(f.getSize());
			file.setDelStatus("undeleted");
			
			setMineType(file,extName);
			
			sysFileManager.create(file);
			
			file.setFileContent(bytes);
			//转换OFFICE
			convertOffice(file);
			
			file.setFileContent(null);
		
			fileList.add(file);
		}
		jsonResult.setSuccess(true);
		jsonResult.setData(fileList);
		jsonResult.setMessage("成功上传!");

		response.getWriter().print(iJson.toJson(jsonResult));
	}
	
	void setMineType(SysFile file,String extName){
		FileExt fileExt = fileUploadConfig.getFileExtMap().get(extName.toLowerCase());
		if (fileExt != null) {
			file.setMineType(fileExt.getMineType());
		} else {
			file.setMineType("Unkown");
		}
	}
		
	/**
	 * 将office文件置入转换队列
	 * @param file
	 * @throws Exception
	 */
	private void convertOffice(SysFile file) throws Exception{
		String ext=file.getExt();
		if(!isOfficeDoc(ext)) return;
		boolean enableOpenOffice=OpenOfficeUtil.isOpenOfficeEnabled();
		if (!enableOpenOffice) return;
		//用消息队列处理doc转换成pdf
		OpenOfficeUtil.que2CoverOffice(file);
	}
	
	
	/**
	 * 下载单个文件
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("downloadOne")
	public void downloadOne(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		download(response,fileId,false);
	}
	
	
	@RequestMapping("download/{fileId}")
	public void downloadOne(HttpServletResponse response,@PathVariable("fileId") String fileId) throws Exception {
		download(response,fileId,true);
	}
	
	
	
	private void download(HttpServletResponse response,String fileId,boolean transPdf) throws Exception{
		SysFile sysFile = sysFileManager.get(fileId);
		String fileSystem=sysFile.getFileSystem();
		if("file".equals(fileSystem)){
			downFileSystem( response, sysFile,  transPdf);
		}
		else if("fastdfs".equals(fileSystem)){
			downFastDfs( response, sysFile,  transPdf);
		}
	}
	
	private void downFastDfs(HttpServletResponse response,SysFile sysFile, boolean transPdf) throws IOException{
		String pdfPath=sysFile.getPdfPath();
		boolean  enableOpenOffice=OpenOfficeUtil.isOpenOfficeEnabled();
		IFileOperator operator= FileOperatorFactory.getByType("fastdfs");
		String ext=sysFile.getExt();
		byte[] bytes=null;
		String fileName=sysFile.getFileName();
		if(isOfficeDoc(ext) && enableOpenOffice && transPdf){
			fileName=fileName.replace("." +ext, ".pdf");
			bytes=operator.getFile(pdfPath);
		}
		else{
			bytes=operator.getFile(sysFile.getPath());
		}
		response.setHeader("Content-Disposition", "attachment;filename=" +fileName);
		response.getOutputStream().write(bytes);
	}
	
	private void downFileSystem(HttpServletResponse response,SysFile sysFile, boolean transPdf) throws Exception{
		// 创建file对象
		String path=getFilePath(sysFile);
		
		String fileName=sysFile.getFileName();
		
		String ext=sysFile.getExt();
		//是否允许openoffice 转换。
		boolean  enableOpenOffice=OpenOfficeUtil.isOpenOfficeEnabled();
		
		if(isOfficeDoc(ext) && enableOpenOffice && transPdf){
			//判断对应的pdf是否存在
			String pdfPath=path.replace("."+ext, ".pdf");
			fileName=fileName.replace("."+ext, ".pdf");
			path=pdfPath;
			File fileTemp = new File(pdfPath);
			if(!fileTemp.exists()){
				try{
					OpenOfficeUtil.coverFromOffice2Pdf(path, pdfPath);
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		
		File file = new File(path);
		fileName = URLEncoder.encode(fileName,"UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=" +fileName);
		
		FileUtil.downLoad(file,response);
	}
	
	private boolean isOfficeDoc(String ext){
		if ("docx".equals(ext)||"doc".equals(ext)||"pptx".equals(ext)
					||"ppt".equals(ext)||"xlsx".equals(ext)||"xls".equals(ext)){
			return true;
		}
		return false;
	}
	
	

	@RequestMapping("previewImage")
	public void previewImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		SysFile sysFile = sysFileManager.get(fileId);
		// 创建file对象
		File file = new File(getFilePath(sysFile));
		// 设置response的编码方式
		response.setContentType("image/" + sysFile.getExt());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + sysFile.getFileName() + "\"");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		
		FileUtil.downLoad(file,response);
	}

	/**
	 * 用于显示单图片上传
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("imageView")
	public void imageView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 文件ID
		String fileId = request.getParameter("fileId");
		// 是否为缩略图，true表示展示缩略图，可不传
		String thumb = request.getParameter("thumb");
		// 用于在明细页中展示图片，可不传
		String view = request.getParameter("view");

		SysFile sysFile = sysFileManager.get(fileId);
		String filePath = null;

		// 文件来用户上传
		if (sysFile != null) {
			String basePath = null;
			if (sysFile.getFrom().equals(SysFile.FROM_APP)) {
				basePath = WebAppUtil.getAppAbsolutePath();
			} else if (sysFile.getFrom().equals(SysFile.FROM_ANONY)) {
				basePath = WebAppUtil.getAnonymusUploadDir();
			} else {
				basePath = WebAppUtil.getUploadPath();
			}
			// 展示缩略图
			if ("true".equals(thumb)) {
				filePath = basePath + "/" + sysFile.getThumbnail();
			} else {
				filePath = basePath + "/" + sysFile.getPath();
			}

			// 设置response的编码方式
			response.setContentType("image/" + sysFile.getExt());
		} else {
			if ("true".equals(view)) {
				// 为系统预设的上传图标
				filePath = WebAppUtil.getAppAbsolutePath() + "/styles/images/no-photo.png";
			} else {
				// 为系统预设的上传图标
				filePath = WebAppUtil.getAppAbsolutePath() + "/styles/images/upload-file.png";
			}
			// 设置response的编码方式
			response.setContentType("image/PNG");
		}
		// 创建file对象
		File file = new File(filePath);
		if(file.exists()) {
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);

			FileUtil.downLoad(file, response);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	@RequestMapping("previewXml")
	public void previewXml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		SysFile sysFile = sysFileManager.get(fileId);

		response.setContentType("text/xml;");
		File file= new File(WebAppUtil.getUploadPath() + "/" + sysFile.getPath());
		
		FileUtil.downLoad(file,response);
	}

	@RequestMapping("previewHtml")
	public void previewHtml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		SysFile sysFile = sysFileManager.get(fileId);
		response.setContentType("text/html;");
		
		File file =new File(WebAppUtil.getUploadPath() + "/" + sysFile.getPath());
		FileUtil.downLoad(file,response);
	}

	@RequestMapping("previewFile")
	public void previewFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		SysFile sysFile = sysFileManager.get(fileId);
		if (sysFile == null) 	return;
		if ("Document".equals(sysFile.getMineType())) {
			// previewDocument(request, response);
			downloadOne(request, response);
		} else if ("Xml".equals(sysFile.getMineType())) {
			previewXml(request, response);
		} else if ("Image".equals(sysFile.getMineType()) || "Icon".equals(sysFile.getMineType())) {
			downloadOne(request, response);
		} else {
			downloadOne(request, response);
		}
	}
 

	/**
	 * 下载某个记录的多个文件
	 * 
	 * @param request
	 * @param reponse
	 * @throws Exception
	 */
	@RequestMapping("downloadRecordFiles")
	public void downloadRecordFiles(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String recordId = request.getParameter("recordId");
		String entityName = request.getParameter("entityName");

		List<SysFile> files = sysFileManager.getByModelNameRecordId(entityName, recordId);
		ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream());
		response.setContentType("application/zip");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + recordId + ".zip\"");
		for (SysFile sysFile : files) {
			File file = new File(WebAppUtil.getUploadPath() + "/" + sysFile.getPath());
			FileUtil.zipFile(file, zipOutputStream);
		}
		zipOutputStream.close();
	}

	/**
	 * 下载我的上传的附件
	 * 
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("downloadFiles")
	public void downloadFiles(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileIds = request.getParameter("fileIds");
		if (StringUtils.isEmpty(fileIds)) {
			return;
		}

		ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream());
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "AttachFile-" + sdf.format(new Date());
		String[] fIds = fileIds.split("[,]");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		for (String fId : fIds) {
			SysFile sysFile = sysFileManager.get(fId);
			if (sysFile == null)
				continue;

			File file = new File(getFilePath(sysFile));
			FileUtil.zipFile(file, zipOutputStream);

		}
		zipOutputStream.close();
	}

	@RequestMapping("previewOffice")
	public ModelAndView previewOffice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileId = request.getParameter("fileId");
		String print = request.getParameter("print");
		SysFile file = sysFileManager.get(fileId);
		String type = "";
		String fileName = file.getFileName();
		String name = file.getFileName().split("\\.")[1];
		name = name.toLowerCase();
		if (StringUtils.isNotEmpty(name)) {
			if ("png".equals(name) || "jpg".equals(name) || "jpeg".equals(name) || "gif".equals(name) || "bmp".equals(name)) {
				return new ModelAndView("sys/core/filePreviewPic.jsp").addObject("fileId", fileId);
			}else if("pdf".equals(name)){
				return new ModelAndView("sys/core/filePreviewPdf.jsp").addObject("fileId", fileId).addObject("fileName", fileName).addObject("print", print);
			}else{
				type = "." + name;
			}
		}
		return getPathView(request).addObject("fileId", fileId).addObject("type", type).addObject("print", print).addObject("fileName", fileName);
	}
	
	
	@RequestMapping("iconSelectDialog")
	public ModelAndView iconSelectDialog(HttpServletRequest request,HttpServletResponse response){
		List<String> matchList = new ArrayList<String>();
		String path=WebAppUtil.getAppAbsolutePath()+"/styles/icons.css";
		String type=RequestUtil.getString(request, "type","pc");
		if("mobile".equals(type)){
			path=WebAppUtil.getAppAbsolutePath()+"/styles/mobile.css";
		}
		String icon=FileUtil.readFile(path);
		Pattern regex = Pattern.compile("\\.(icon-[\\w-]*?):\\s*before\\s*\\{.*?\\}", Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE | Pattern.DOTALL);
		Matcher regexMatcher = regex.matcher(icon);
			while (regexMatcher.find()) {
				matchList.add(regexMatcher.group(1));
			}
		return this.getPathView(request).addObject("matchList", matchList);
	}
	
	
	

}
