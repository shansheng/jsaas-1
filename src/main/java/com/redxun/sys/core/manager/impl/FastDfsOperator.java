package com.redxun.sys.core.manager.impl;

import java.io.IOException;

import javax.annotation.Resource;

import org.csource.common.MyException;

import com.redxun.core.util.FastClient;
import com.redxun.core.util.FileUtil;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.manager.IFileOperator;

/**
 * fast dfs操作。
 * @author zhangyg
 *
 */
public class FastDfsOperator implements IFileOperator{
	
	@Resource
	private FastClient fastClient;
	

	

	@Override
	public int delFile(String path) {
		try {
			int rtn=fastClient.delFile(path);
			return rtn;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return 0;
	}

	@Override
	public byte[] getFile(String path) {
		try {
			byte[] bytes=fastClient.getFile(path);
			return bytes;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}

	@Override
	public FileModel createFile(String fileName, byte[] bytes) {
		String extName = FileUtil.getFileExt(fileName);
		String path="";
		try {
			path=fastClient.uploadFile(bytes, extName);
		} catch (IOException | MyException e) {
			e.printStackTrace();
		}
		
		FileModel model=new FileModel();
		model.setFileName(fileName);
		model.setExtName(extName);
		model.setRelPath(path);
		
		return model;
	}
	
	@Override
	public String getTitle() {
		return "fast分布式文件系统";
	}

	@Override
	public String getType() {
		return "fastdfs";
	}

}
