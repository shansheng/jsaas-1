package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;

/**
 * 启动流程参数对象。
 * <pre>
 * 	{
 * 		userAccount:"admin@redxun.cn",
 *		solId:"240000005458025",
 *		jsonData:
 *			"{bos:[{boDefId:\"240000006268000\",formKey:\"resume\",data:{xm: \"老子\",dz: \"广州\",nl: \"48\"}}]}",
 *		businessKey:"1234",
 *		vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]
 *	}
 *	
 *	userAccount:用户帐号
 *	solId:解决方案ID
 *	数据：一般二选一
 *		jsonData:表单数据
 *		businessKey:业务主键
 *	vars：流程变量
 *		{name:\'a\',type:\'String\',value:\'abc\'}
 *		name:变量名
 *		type:变量类型(Number,String,Date)
 *		value:变量值
 * </pre>
 * @author ray
 *
 */
public class StartModel implements Serializable {
	//{userAccount:"admin@redxun.cn",solId:"240000005458025",jsonData:"{bos:[{boDefId:\"240000006268000\",formKey:\"resume\",data:{xm: \"老子\",dz: \"广州\",nl: \"48\"}}]}"}
	//{userAccount:"admin@redxun.cn",solId:"240000005458025",businessKey:"1234"}
	//vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]
	
	/**
	 * 帐号
	 */
	private String userAccount="";
	
	/**
	 * 方案ID
	 */
	private String solId="";
	
	/**
	 * 表单数据
	 */
	private String jsonData="";
	
	/**
	 * 主键。
	 */
	private String businessKey="";
	
	private List<VarModel> vars=new ArrayList<VarModel>();
	

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getSolId() {
		return solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
	}

	public String getJsonData() {
		return jsonData;
	}

	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}

	public String getBusinessKey() {
		return businessKey;
	}

	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}

	public List<VarModel> getVars() {
		return vars;
	}

	public void setVars(List<VarModel> vars) {
		this.vars = vars;
	}
	
	public void addVar(VarModel var){
		this.vars.add(var);
	}
	
	public void addVar(String name,String value){
		this.addVar(new VarModel(name, "String", value));
	}
	
	public void addVar(String name,String type,String value){
		this.addVar(new VarModel(name, type, value));
	}

	@Override
	public String toString() {
		return JSONObject.toJSONString(this);
	}
	
	
	

}
