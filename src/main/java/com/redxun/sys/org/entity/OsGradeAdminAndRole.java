



package com.redxun.sys.org.entity;

import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;


import java.util.List;

/**
 * <pre>
 *  
 * 描述：分级管理角色表实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "分级管理角色表")
public class OsGradeAdminAndRole{

	private List<OsGradeAdmin> osGradeAdmin;
	private  List<OsGradeRole> osGradeRole;


	private String gradeAdminId ="";

	public String getGradeAdminId() {
		return gradeAdminId;
	}

	public void setGradeAdminId(String gradeAdminId) {
		this.gradeAdminId = gradeAdminId;
	}

	public List<OsGradeAdmin> getOsGradeAdmin() {
		return osGradeAdmin;
	}

	public void setOsGradeAdmin(List<OsGradeAdmin> osGradeAdmin) {
		this.osGradeAdmin = osGradeAdmin;
	}

	public List<OsGradeRole> getOsGradeRole() {
		return osGradeRole;
	}

	public void setOsGradeRole(List<OsGradeRole> osGradeRole) {
		this.osGradeRole = osGradeRole;
	}
}



