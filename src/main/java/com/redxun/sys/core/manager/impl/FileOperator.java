package com.redxun.sys.core.manager.impl;

import java.io.File;
import java.util.Date;

import com.redxun.core.util.DateUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.manager.IFileOperator;

/**
 * 文件操作。
 * @author ray
 *
 */
public class FileOperator implements IFileOperator {

	@Override
	public int delFile(String path) {
		String fullPath = WebAppUtil.getUploadPath() + "/" + path;
		File file=new File(fullPath);
		file.delete();
		return 0;
	}

	@Override
	public byte[] getFile(String path) {
		String fullPath = WebAppUtil.getUploadPath() + "/" + path;
		byte[]  bytes=FileUtil.readByte(fullPath);
		return bytes;
	}

	@Override
	public FileModel createFile(String fileName, byte[] bytes) {
		
		
		String extName=FileUtil.getFileExt(fileName);
		// 上传的相对路径
		String tempPath=DateUtil.formatDate(new Date(), "yyyyMM");
		String	relFilePath=tempPath;
		IUser curUser = ContextUtil.getCurrentUser();
		if(curUser!=null){
			String account = curUser.getUsername();
			relFilePath = account + "/" + tempPath  ;
		}
		else{
			relFilePath = tempPath=DateUtil.formatDate(new Date(), "yyyyMMdd");
		}
		
		String fullPath = WebAppUtil.getUploadPath() + "/" + relFilePath;
		
		File dirFile = new File(fullPath);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		relFilePath+="/" +fileName;
		String filePath=fullPath + "/" +fileName;
		try {
			FileUtil.writeByte(filePath, bytes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		FileModel model=new FileModel();
		model.setFileName(fileName);
		model.setExtName(extName);
		model.setRelPath(relFilePath);
		
		
		return model;
	}

	@Override
	public String getTitle() {
		return "文件系统";
	}

	@Override
	public String getType() {
		return "file";
	}

}
