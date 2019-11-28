package com.redxun.bpm.form.service;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.sys.bo.manager.DataHolder;

/**
 * 表字段值
 * @author 
 *
 */
public interface ITableFieldValueHandler {
	/*
	 * 	var fieldEditors=[{mapType:'',mapTypeName:'',editor:null},{mapType:'field',mapTypeName:'从字段获取',editor:'mainFieldEditor'},
		{mapType:'pkValue',mapTypeName:'主键字段值',editor:null},{mapType:'mainPkValue',mapTypeName:'主表主键字段',editor:null},
		{mapType:'seqValue',mapTypeName:'由流水号产生',editor:'seqEditor'},{mapType:'curDate',mapTypeName:'获取当前时间',editor:null},
		{mapType:'curUserId',mapTypeName:'获取当前用户Id',editor:null},{mapType:'curUserName',mapTypeName:'获取当前用户姓名',editor:null},
		{mapType:'curDepId',mapTypeName:'获取当前部门Id',editor:null},{mapType:'curDepName',mapTypeName:'获取当前部门名称',editor:null},
		{mapType:'curInstId',mapTypeName:'获取当前机构Id',editor:null},{mapType:'curInstName',mapTypeName:'获取当前机构名称',editor:null},
		//{mapType:'sqlQuery',mapTypeName:'从Sql关联查询',editor:'textareaEditor'},
		{mapType:'fixValue',mapTypeName:'设置固定值',editor:'textboxEditor'},{mapType:'scriptValue',mapTypeName:'从脚本函数计算获取',editor:'textareaEditor'}];
	
	 */
	static String TYPE_FIELD="field";
	static String TYPE_MAIN_FIELD="mainField";
	static String TYPE_SUB_FIELD="subField";
	static String TYPE_PK_ID="pkId";
	static String TYPE_MAIN_PK_ID="mainPkId";
	static String TYPE_MAIN_PK="mainPk";
	static String TYPE_SRC_PK_ID="srcPkId";
	static String TYPE_SEQ_VALUE="seqValue";
	static String TYPE_CUR_DATE="curDate";
	static String TYPE_CUR_USER_ID="curUserId";
	static String TYPE_CUR_USER_NAME="curUserName";
	static String TYPE_CUR_DEP_ID="curDepId";
	static String TYPE_CUR_DEP_NAME="curDepName";
	static String TYPE_CUR_INST_ID="curInstId";
	static String TYPE_CUR_INST_NAME="curInstName";
	static String TYPE_FIX_VALUE="fixValue";
	static String TYPE_SCRIPT_VALUE="scriptValue";
	
	/**
	 * 获得映射类型
	 * @return
	 */
	String getMapType();
	/**
	 * 获得映射类型名称
	 * @return
	 */
	String getMapTypeName();
	
	/**
	 * 是否参数化。
	 * @return
	 */
	boolean isParameterize();
	
	
	/**
	 * 获得字段值
	 * @param dataType 目标字段类型  string ,date,number
	 * @param fieldName 目标字段名
	 * @param precision 目标字段精度
	 * @param srcPkId 原参考表主键值
	 * @param mainPkId 主表主键
	 * @param rowData 行数据
	 * @param mapValue 映射配值
	 * @return
	 */
	Object getFieldValue(String dataType,String newPkId,DataHolder dataHolder,JSONObject rowData,JSONObject oldRow,String mapValue,Map<String,Object> extParams);
}
