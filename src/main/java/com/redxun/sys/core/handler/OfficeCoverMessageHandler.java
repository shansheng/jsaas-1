package com.redxun.sys.core.handler;

import java.util.UUID;

import com.redxun.core.jms.IMessageHandler;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.FileOperatorFactory;
import com.redxun.sys.core.manager.IFileOperator;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.util.OpenOfficeUtil;

/**
 * 将office 文档转换成 PDF 文档。
 * @author cmc
 *
 */
public class OfficeCoverMessageHandler implements IMessageHandler{

	@Override
	public void handMessage(Object messageObj) {
		SysFile sysFile=(SysFile) messageObj;
		String filePath=WebAppUtil.getUploadPath() + "/"+ sysFile.getPath();
		if("file".equals(sysFile.getFileSystem())){
			String newFilePath=filePath.substring(0, filePath.lastIndexOf("."));
			OpenOfficeUtil.coverFromOffice2Pdf(filePath, newFilePath+".pdf");
		}
		else if ("fastdfs".equals(sysFile.getFileSystem())){
			handFastDfs(sysFile);
		}
		
		sysFile.setCoverStatus("YES");//转换后将转换状态设置成YES
		SysFileManager sysFileManager=WebAppUtil.getBean(SysFileManager.class);
		sysFileManager.update(sysFile);
	}
	
	/*
	 * 1.生成源文件
	 * 2.生成pdf文件
	 * 3.将pdf上传到fastdfs
	 * 4.删除源文件
	 * 5.删除PDF文件
	*/
	private void handFastDfs(SysFile sysFile){
		
		String tmpId= UUID.randomUUID().toString();
		String filePath=WebAppUtil.getUploadPath() +"/" +tmpId + "." + sysFile.getExt();
		String pdfPath=WebAppUtil.getUploadPath() +"/" + tmpId +".pdf";
		
		FileUtil.writeByte(filePath, sysFile.getFileContent());
		OpenOfficeUtil.coverFromOffice2Pdf(filePath, pdfPath);
		
		IFileOperator operator= FileOperatorFactory.getByType("fastdfs");
		byte[] bytes=FileUtil.readByte(pdfPath);
		
		FileModel model= operator.createFile(tmpId +".pdf", bytes);
		sysFile.setPdfPath(model.getRelPath());
		
		FileUtil.deleteFile(filePath);
		FileUtil.deleteFile(pdfPath);
	}

}
