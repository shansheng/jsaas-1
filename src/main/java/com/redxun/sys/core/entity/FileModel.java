package com.redxun.sys.core.entity;

/**
 * 上传文件对象。
 * @author ray
 *
 */
public class FileModel {
	
	private String relPath="";
	
	private String fileName="";
	
	private String extName="";
	
	private byte[] bytes;

	public String getRelPath() {
		return relPath;
	}

	public void setRelPath(String relPath) {
		this.relPath = relPath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getExtName() {
		return extName;
	}

	public void setExtName(String extName) {
		this.extName = extName;
	}

	public byte[] getBytes() {
		return bytes;
	}

	public void setBytes(byte[] bytes) {
		this.bytes = bytes;
	}
	
	

}
