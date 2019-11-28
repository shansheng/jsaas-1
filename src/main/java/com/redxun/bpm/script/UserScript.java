package com.redxun.bpm.script;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;

/**
 * 用户脚本。
 * @author ray
 *
 */
public class UserScript implements GroovyScript {

	@Resource
	private CommonDao commonDao;
	@Resource
	private UserService userService;
	
	
	/**
	 * 根据主键 字段 表名获取人员对象。
	 * @param pk		主键值
	 * @param pkName	主键名称
	 * @param fieldName	对应的字段名称
	 * @param tableName	需要查询的表
	 * @return
	 */
	@MethodDefine(title = "主键字段表名获取人员对象",category="用户", params = {@ParamDefine(title = "主键值", varName = "pk"),
			@ParamDefine(title = "主键名称", varName = "pkName"),
			@ParamDefine(title = "对应的字段名称", varName = "fieldName"),
			@ParamDefine(title = "需要查询的表", varName = "tableName")})
	public Collection<IUser> getUserFromTable(String pk,String pkName,String fieldName,String tableName){
		fieldName=fieldName.toUpperCase();
		String sql="select " + fieldName + " from " + tableName +" where " + pkName +"=#{pk}";
		SqlModel sqlModel=new SqlModel(sql);
		sqlModel.addParam("pk", pk);
		List list= commonDao.query(sqlModel);
		Collection<IUser> users=new ArrayList<IUser>();
		if(BeanUtil.isEmpty(list)) {
			return users;
		}
		Map<String, Object> map=(Map<String, Object>) list.get(0);
		String userIds=(String) map.get(fieldName);
		String[] aryUser=userIds.split(",");
		for(int i=0;i<aryUser.length;i++){
			IUser user=userService.getByUserId(aryUser[i]);
			users.add(user);
		}
		return users;
	}
}
