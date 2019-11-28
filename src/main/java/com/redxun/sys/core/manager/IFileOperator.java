package com.redxun.sys.core.manager;

import com.redxun.sys.core.entity.FileModel;

public interface IFileOperator {
	
	String getTitle();
	
	String getType();
	
	/**
	 * 创建文件，传入扩展名和文件内容写入文件。
	 * @param extName
	 * @param bytes
	 * @return
	 */
	FileModel createFile(String fileName,byte[] bytes);
	/**
	 * 删除文件。
	 * @param path
	 * @return
	 */
	int delFile(String path);
	/**
	 * 根据path读取文件。
	 * @param path
	 * @return
	 */
	byte[] getFile(String path);

}
