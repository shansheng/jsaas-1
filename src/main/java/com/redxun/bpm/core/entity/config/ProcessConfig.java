package com.redxun.bpm.core.entity.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.StringUtil;

/**
 *  流程定义的配置
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessConfig extends BaseConfig{
	/**
	 * 数据保存方式。
	 * 同时保存在实例表和物理表。
	 */
	public static final String DATA_SAVE_MODE_ALL="all";
	/**
	 * 数据保存到业务表。
	 */
	public static final String DATA_SAVE_MODE_DB="db";
	/**
	 * 数据使用json的方式存到实例表中。
	 */
	public static final String DATA_SAVE_MODE_JSON="json";
	
	
	/**
	 * 流程节点Id
	 */
	public final static String PROCESS_NODE_ID="_PROCESS";
	
	public final static String OPINION_TEXT="[{\"id\":\"AGREE\",text:\"同意\"},{id:\"REFUSE\",\"text\":\"反对\"},{\"id\":\"ABSTAIN\",\"text\":\"弃权\"}]";
	
	//是否跳过第一个节点，一般情况下，第一个节点是表单的填写节点，
	//以使表单驳回到发起人那里可以有效处理
	protected String isSkipFirst="false";
	//是否显示开始节点后续任务节点的执行人员
	protected String isShowStartUsers;
	
	//标题规则
	protected String subRule;
	
	//单号规则
	protected String noRule;
	
	//允许自由跳转
	protected String allowFreeJump="false";
	//是否在审批表单中显示审批意见
	protected String showCheckList="false";
	

	//通知类型。
	protected String notices="";
	//跳转设置。
	protected String jumpSetting="";
	
	/**
	 * 流程启动时确认。
	 */
	protected String confirmStart="true";
	/**
	 * 外部表单URL
	 */
	protected String extFormUrl;
	
	protected String selectUser="false";
	/**
	 * 是否显示执行路径。
	 */
	private String showExecPath="false";
	
	/**
	 * 子表权限
	 * {tableName1:{type:"user"},
	 * tableName2:{type:"group"},
	 * tableName3:{type:"all"}}
	 */
	protected String tableRightJson="";
	
	
	/**
	 * 流程结束时的事件
	 */
	protected String processEndHandle;
	
	/**
	 * 审批意见标识。
	 */
	protected String opinionText="";
	
	/**
	 * 启动时指定下一个节点的用户。
	 */
	protected String startUser="false";
	
	/**
	 * 跳过节点是是否填写意见。
	 */
	protected String needOpinion="false";
	
	protected List<ButtonConfig> buttons=new ArrayList<>();
	/**
	 *流程结束时执行的脚本。
	 */
	protected String endProcessScript="";
	
	/**
	 * 全局脚本
	 */
	protected String globalEvent="";
	
	public String getIsSkipFirst() {
		return isSkipFirst;
	}
	
	public void setIsSkipFirst(String isSkipFirst) {
		this.isSkipFirst = isSkipFirst;
	}
	
	public String getSubRule() {
		return subRule;
	}
	
	public void setSubRule(String subRule) {
		this.subRule = subRule;
	}
	
	public String getIsShowStartUsers() {
		return isShowStartUsers;
	}
	
	public void setIsShowStartUsers(String isShowStartUsers) {
		this.isShowStartUsers = isShowStartUsers;
	}

	public String getAllowFreeJump() {
		return allowFreeJump;
	}

	public void setAllowFreeJump(String allowFreeJump) {
		this.allowFreeJump = allowFreeJump;
	}

	public String getProcessEndHandle() {
		return processEndHandle;
	}

	public void setProcessEndHandle(String processEndHandle) {
		this.processEndHandle = processEndHandle;
	}

	public String getShowCheckList() {
		return showCheckList;
	}

	public void setShowCheckList(String showCheckList) {
		this.showCheckList = showCheckList;
	}

	

	public String getNotices() {
		return notices;
	}

	public void setNotices(String notices) {
		this.notices = notices;
	}

	public String getTableRightJson() {
		return tableRightJson;
	}

	public void setTableRightJson(String tableRightJson) {
		this.tableRightJson = tableRightJson;
	}

	public String getNoRule() {
		return noRule;
	}

	public void setNoRule(String noRule) {
		this.noRule = noRule;
	}

	public String getJumpSetting() {
		return jumpSetting;
	}

	public void setJumpSetting(String jumpSetting) {
		this.jumpSetting = jumpSetting;
	}
	

	public String getExtFormUrl() {
		return extFormUrl;
	}

	public void setExtFormUrl(String extFormUrl) {
		this.extFormUrl = extFormUrl;
	}

	public List<ButtonConfig> getButtons() {
		return buttons;
	}

	public void setButtons(List<ButtonConfig> buttons) {
		this.buttons = buttons;
	}

	public String getConfirmStart() {
		return confirmStart;
	}

	public void setConfirmStart(String confirmStart) {
		this.confirmStart = confirmStart;
	}

	public String getSelectUser() {
		return selectUser;
	}

	public void setSelectUser(String selectUser) {
		this.selectUser = selectUser;
	}

	public String getShowExecPath() {
		return showExecPath;
	}

	public void setShowExecPath(String showExecPath) {
		this.showExecPath = showExecPath;
	}

	public String getOpinionText() {
		if(StringUtil.isEmpty(opinionText)){
			return OPINION_TEXT;
		} 
		return opinionText;
	}
	
	public Map<String,String> getOpinionTextMap() {
		Map<String,String> map=new HashMap<>();
		String text=getOpinionText();
		JSONArray ary=JSONArray.parseArray(text);
		for(int i=0;i<ary.size();i++){
			JSONObject json= ary.getJSONObject(i);
			String id=json.getString("id");
			String val=json.getString("text");
			map.put(id, val);
		}
		return map;
	}

	public void setOpinionText(String opinionText) {
		this.opinionText = opinionText;
	}

	public String getNeedOpinion() {
		return needOpinion;
	}

	public void setNeedOpinion(String needOpinion) {
		this.needOpinion = needOpinion;
	}

	public String getStartUser() {
		return startUser;
	}

	public void setStartUser(String startUser) {
		this.startUser = startUser;
	}

	public String getEndProcessScript() {
		return endProcessScript;
	}

	public void setEndProcessScript(String endProcessScript) {
		this.endProcessScript = endProcessScript;
	}

	public String getGlobalEvent() {
		return globalEvent;
	}

	public void setGlobalEvent(String globalEvent) {
		this.globalEvent = globalEvent;
	}
	
	
	

	
	
	
}
