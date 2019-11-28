package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 属性表达式:
 * {
 *   "extProType":"user,group",
 *   "configData":
 *     [
 *      {
 *       "type":"orgRule",
 *       "rule":"or",
 *       "children":
 *         [{
 *           "type": "rule",
 *           "treeIdValue": "2610000001100118",
 *           "treeIdName": "技术",
 *           "attrType": "combobox",
 *           "sourceType": "CUSTOM",
 *           "arrtTreeValue": "2610000001400015",
 *           "attrName": "学历",
 *           "operatorValue": "=",
 *           "operatorName": "等于",
 *           "valValue": "3",
 *           "valName": "大专"
 *           },{
 *               "type":"orgRule",
 *               "rule":"and",
 *               "children":
 *                 [{
 *                  "type": "rule",
 *                  "treeIdValue": "2610000001100118",
 *                  "treeIdName": "技术",
 *                  "attrType": "combobox",
 *                  "sourceType": "CUSTOM",
 *                  "arrtTreeValue": "2610000001400015",
 *                  "attrName": "学历",
 *                  "operatorValue": "=",
 *                  "operatorName": "等于",
 *                  "valValue": "3",
 *                  "valName": "大专"
 *                  }]
 *           }] }]}
 *
 * @author ray
 *
 */
public class ExtPropertiesCalServiceImpl extends AbstractIdentityCalService {
	@Resource
	private OsUserManager osUserManager;
    @Resource
    private OsGroupManager osGroupManager;

	private  static final  String EXTPROTYPE="extProType";
    private  static final  String KEY="key";
    private  static final  String TYPE="type";
    private  static final  String VALUE="value";
    private  static final  String VALVALUE="valValue";
    private  static final  String CONDITION="condition";
    private  static final  String USER="user";
    private  static final  String AND="and";
    private  static final  String RULE="rule";
    private  static final  String CHILDREN="children";
    private  static final  String ATTRTYPE="attrType";
    private  static final  String ARRTTREEVALUE="arrtTreeValue";
    private  static final  String OPERATORVALUE="operatorValue";

    private  static final  String ANDAVALUE="' AND a.VALUE_";

    private JSONArray selectSqlList=new JSONArray();

	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		String jsonConfig=idCalConfig.getJsonConfig();
		JSONObject jsonObject =JSONObject.parseObject(jsonConfig);
		JSONArray jsonArray = jsonObject.getJSONArray("configData");
		String extProType = jsonObject.getString(EXTPROTYPE);
        JSONObject sqlConfig =getRuls(jsonArray,extProType);
		return getByExtProperties( sqlConfig);
	}

	private JSONObject getRuls(JSONArray jsonArray,String extProType){
        selectSqlList=new JSONArray();
        JSONObject jsonObject = (JSONObject) jsonArray.get(0);
        JSONArray data = (JSONArray)jsonObject.get(CHILDREN);
        if(!data.isEmpty()){
            JSONObject sqlObj =new JSONObject();
            sqlObj.put(TYPE,CONDITION);
            sqlObj.put(VALUE,jsonObject.getString(RULE));
            selectSqlList.add(sqlObj);

            for(int i=0;i<data.size();i++){
                JSONObject node = (JSONObject)data.get(i);
                setRuleSql(node);
            }
        }
        JSONObject sqlConfig = new JSONObject();
        sqlConfig.put(KEY,selectSqlList);
        sqlConfig.put(EXTPROTYPE,extProType);
        return  sqlConfig;
    }
    private void setRuleSql(JSONObject node){
        String sql ="";
        if("orgRule".equals(node.getString(TYPE))){
            sql =setOrgRule(node);
        }else{
            sql =setSql(node);
        }
        JSONObject sqlObj = new JSONObject();
        sqlObj.put(TYPE,"sql");
        sqlObj.put(VALUE,sql);
        selectSqlList.add(sqlObj);
    }
    private String setOrgRule(JSONObject node){
        String rule =node.getString(RULE);
        JSONArray children = (JSONArray)node.get(CHILDREN);
        StringBuilder sql =new StringBuilder();
        List<String> tableNameList =new ArrayList<>();
        String sqlFirst ="select a.TARGET_ID_ from os_attribute_value a where ";
        int chilDrenLength = children.size();
        if(chilDrenLength==1){
            return setSql((JSONObject)children.get(0));
        }
        for(int i=0;i<chilDrenLength;i++){
            JSONObject chilNode = (JSONObject)children.get(i);
            if(AND.equals(rule)){
                String tableName ="a_"+i;
                tableNameList.add(tableName);
                String sqlAnd ="("+sqlFirst+" a.ATTRIBUTE_ID_='"+chilNode.getString(ARRTTREEVALUE) +ANDAVALUE+chilNode.getString(OPERATORVALUE)+getTypeOfVal(chilNode)+") "+tableName+" ";
                if(StringUtil.isEmpty(sql.toString())){
                    sql.append("select "+tableName+".TARGET_ID_ from  "+sqlAnd);
                }else{
                    sql.append(" INNER JOIN "+ sqlAnd +" ON "+tableNameList.get(i-1)+".TARGET_ID_="+tableName+".TARGET_ID_ ");
                }
            }else{
                String sqlOr ="( a.ATTRIBUTE_ID_='"+chilNode.getString(ARRTTREEVALUE) +ANDAVALUE+chilNode.getString(OPERATORVALUE)+getTypeOfVal(chilNode)+")";
                if(StringUtil.isEmpty(sql.toString())){
                    sql.append(sqlFirst+sqlOr+" ");
                }else{
                    sql.append(" or "+sqlOr);
                }
            }
        }
        return sql.toString();
    }
    private String setSql(JSONObject node){
        return "select a.TARGET_ID_ from os_attribute_value a where "+" a.ATTRIBUTE_ID_='"+node.getString(ARRTTREEVALUE) +ANDAVALUE+node.getString(OPERATORVALUE)+getTypeOfVal(node);
    }
	private String getTypeOfVal(JSONObject node){
        if("datepicker".equals(node.getString(ATTRTYPE))){
            return "'"+node.getString("valName")+"'";
        }
        if("spinner".equals(node.getString(ATTRTYPE))){
            return node.getString(VALVALUE);
        }
        return "'"+node.getString(VALVALUE)+"'";
    }

	public List<TaskExecutor> getByExtProperties(JSONObject configObj){
		String condition ="";
		List<String> sqlList = new ArrayList<>();
		List<TaskExecutor> identityList=new ArrayList<>();
		String extPropId=configObj.getString(EXTPROTYPE);
		JSONArray array = (JSONArray)configObj.get(KEY);
		for(int i=0;array!=null && i<array.size();i++){
			JSONObject jsonObject =array.getJSONObject(i);
			String type =jsonObject.getString(TYPE);
			String sql = jsonObject.getString(VALUE);
			if(StringUtil.isNotEmpty(type) &&CONDITION.equals(type)){
				condition=sql;
			}else {
				sqlList.add(sql);
			}
		}
		if(USER.equals(extPropId)){
            identityList =getUserList(sqlList,condition,identityList);
        }else {
            identityList =getOrgList(sqlList,condition,identityList);
        }
		return identityList;
	}

    private List<TaskExecutor> getOrgList(List<String> sqlList,String condition,List<TaskExecutor> identityList){
        List<List<OsGroup>> result=new ArrayList<>();
        List<OsGroup> osUserList =new ArrayList<>();
        for(int i=0;i<sqlList.size();i++){
                List<OsGroup> userList=osGroupManager.getBySql(sqlList.get(i));
                if(AND.equals(condition)){
                    if(userList.isEmpty()){
                        return  new ArrayList<>();
                    }else if(1==sqlList.size()){
                        osUserList.addAll(userList);
                    }else {
                        result.add(userList);
                    }
                }else {
                    if(userList!=null){
                        osUserList.addAll(userList);
                    }
                }
        }

        if(!result.isEmpty()){
            int length =result.size();
            for(int i=0;i<length-1;i++){
                result.get(i+1).retainAll(result.get(i));
            }
            length =result.size();
            List<OsGroup> userList = result.get(length-1);
            for (OsGroup org:userList) {
                identityList.add(TaskExecutor.getGroupExecutor(org));
            }
        }
        for (OsGroup org:osUserList) {
            identityList.add(TaskExecutor.getGroupExecutor(org));
        }
        return  identityList;
    }

	private List<TaskExecutor> getUserList(List<String> sqlList,String condition,List<TaskExecutor> identityList){
        List<List<OsUser>> result=new ArrayList<>();
        List<OsUser> osUserList =new ArrayList<>();
        for(int i=0;i<sqlList.size();i++){
            List<OsUser> userList=osUserManager.getBySql(sqlList.get(i));
            if(AND.equals(condition)){
                if(userList.isEmpty()){
                    return  new ArrayList<>();
                }else if(1==sqlList.size()){
                    osUserList.addAll(userList);
                }else {
                    result.add(userList);
                }
            }else {
                if(userList!=null){
                    osUserList.addAll(userList);
                }
            }
        }

        if(!result.isEmpty()){
            int length = result.size();
            for(int i=0;i<length-1;i++){
                result.get(i+1).retainAll(result.get(i));
            }
            length = result.size();
            List<OsUser> userList = result.get(length-1);
            for (OsUser ou:userList) {
                identityList.add(TaskExecutor.getUserExecutor(ou));
            }
        }
        for (OsUser ou:osUserList) {
            identityList.add(TaskExecutor.getUserExecutor(ou));
        }
        return  identityList;
    }

}
