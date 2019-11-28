package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmCheckFile实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_CHECK_FILE")
@TableDefine(title = "")
public class BpmCheckFile extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "FILE_ID_")
	protected String fileId;
	
	@FieldDefine(title = "附件名")
	@Column(name = "FILE_NAME_")
	@Size(max = 255)
	protected String fileName;
	@FieldDefine(title = "任务处理跳转Id")
	@JoinColumn(name = "JUMP_ID_")
	protected String jumpId;

	/**
	 * Default Empty Constructor for class BpmCheckFile
	 */
	public BpmCheckFile() {
		super();
	}

	

	public BpmCheckFile(String fileId, String jumpId) {
		super();
		this.fileId = fileId;
		this.jumpId = jumpId;
	}

	public String getJumpId() {
		return jumpId;
	}

	public void setJumpId(String jumpId) {
		this.jumpId = jumpId;
	}


	@Override
	public String getIdentifyLabel() {
		return this.fileId;
	}
	

	public String getFileId() {
		return fileId;
	}



	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}



	@Override
	public Serializable getPkId() {
		return this.fileId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.fileId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */

	/**
	 * @see java.lang.Object#hashCode()
	 */


	/**
	 * @see java.lang.Object#toString()
	 */


	/**
	 * Return the primary key as a hashmap
	 */
	public Map getPrimaryKeyMap() {

		Map pkMap = new HashMap();
		pkMap.put("fileId", this.getFileId());
		pkMap.put("jumpId", this.getJumpId());
		return pkMap;
	}

	/**
	 * Return the primary key String as key value pairs
	 */
	public String getPrimaryKeyString() {

		java.lang.StringBuffer pkeyString = new java.lang.StringBuffer("[");
		pkeyString.append("fileId=");
		pkeyString.append(this.getFileId());
		pkeyString.append(",");
		pkeyString.append("jumpId=");
		pkeyString.append(this.getJumpId());
		pkeyString.append("]");
		return pkeyString.toString();
	}

}
