package com.redxun.bpm.core.entity.config;

import java.util.ArrayList;
import java.util.List;


/**
 *  人工任务节点的属性配置
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class UserTaskConfig extends BaseConfig{
	//可配置的审批按钮
	protected List<ButtonConfig> buttons=new ArrayList<ButtonConfig>();
	//配置的通知方式
	protected String notices="";
	//允许配置审批按钮
	protected String allowConfigButtons="false";
	//显示下一步的执行人，允许在界面更改下一步的执行人
	protected String allowNextExecutor="false";
	//是否允许执行任务时选择下一步的执行路径
	protected String allowPathSelect="false";
	//是否在审批表单中显示审批意见
	protected String showCheckList="false";
	
	protected String allowPrint="false";
	
	/**
	 * 是否允许执行人为空
	 */
	protected String allowEmptyExecutor="false";

	/**
	 * 允许执行的脚本
	 */
	protected String allowScript="";
	
	/**
	 * 允许执行的提示信息。
	 */
	protected String allowTipInfo="";
	
	/**
	 * 允许修改执行路径。
	 */
	protected String allowChangePath="false";
	
	/**
	 * 超时日历名称
	 */
	protected String calSettingName="";
	
	/**
	 * 超时日历ID
	 */
	protected String calSettingId="";
	
	/**
	 * 超时时间分钟
	 */
	protected Integer overTime=0;
	
	
	
	//若为多实例任务时，加上该配置
	protected MultiTaskConfig multiTaskConfig;
	
	/**
	 * 子表权限
	 * {tableName1:{type:"user"},
	 * tableName2:{type:"group"},
	 * tableName3:{type:"all"}}
	 */
	protected String tableRightJson="";
	
	
	/**
	 * 外部表单URL
	 */
	protected String extFormUrl;
	
	
	public UserTaskConfig() {
		
	}
	
	
	public List<ButtonConfig> getButtons() {
		return buttons;
	}

	public void setButtons(List<ButtonConfig> buttons) {
		this.buttons = buttons;
	}

	public String getAllowNextExecutor() {
		return allowNextExecutor;
	}

	public void setAllowNextExecutor(String allowNextExecutor) {
		this.allowNextExecutor = allowNextExecutor;
	}

	public String getAllowPathSelect() {
		return allowPathSelect;
	}

	public void setAllowPathSelect(String allowPathSelect) {
		this.allowPathSelect = allowPathSelect;
	}
	
	public String getNotices() {
		return notices;
	}

	public void setNotices(String notices) {
		this.notices = notices;
	}
	
	public String getAllowConfigButtons() {
		return allowConfigButtons;
	}

	public void setAllowConfigButtons(String allowConfigButtons) {
		this.allowConfigButtons = allowConfigButtons;
	}

	public MultiTaskConfig getMultiTaskConfig() {
		//如果没有设置则默认为100%;
		if(multiTaskConfig==null){
			return MultiTaskConfig.getDefaultConfig();
		}
		return multiTaskConfig;
	}

	public void setMultiTaskConfig(MultiTaskConfig multiTaskConfig) {
		this.multiTaskConfig = multiTaskConfig;
	}

	

	public String getShowCheckList() {
		return showCheckList;
	}

	public void setShowCheckList(String showCheckList) {
		this.showCheckList = showCheckList;
	}

	

	public String getAllowPrint() {
		return allowPrint;
	}

	public void setAllowPrint(String allowPrint) {
		this.allowPrint = allowPrint;
	}

	public String getTableRightJson() {
		return tableRightJson;
	}

	public void setTableRightJson(String tableRightJson) {
		this.tableRightJson = tableRightJson;
	}


	public String getAllowTipInfo() {
		return allowTipInfo;
	}

	public void setAllowTipInfo(String allowTipInfo) {
		this.allowTipInfo = allowTipInfo;
	}

	public String getAllowScript() {
		return allowScript;
	}

	public void setAllowScript(String allowScript) {
		this.allowScript = allowScript;
	}

	

	public String getExtFormUrl() {
		return extFormUrl;
	}

	public void setExtFormUrl(String extFormUrl) {
		this.extFormUrl = extFormUrl;
	}

	public String getAllowEmptyExecutor() {
		return allowEmptyExecutor;
	}

	public void setAllowEmptyExecutor(String allowEmptyExecutor) {
		this.allowEmptyExecutor = allowEmptyExecutor;
	}

	public String getAllowChangePath() {
		return allowChangePath;
	}

	public void setAllowChangePath(String allowChangePath) {
		this.allowChangePath = allowChangePath;
	}


	public String getCalSettingName() {
		return calSettingName;
	}


	public void setCalSettingName(String calSettingName) {
		this.calSettingName = calSettingName;
	}


	public String getCalSettingId() {
		return calSettingId;
	}


	public void setCalSettingId(String calSettingId) {
		this.calSettingId = calSettingId;
	}


	public Integer getOverTime() {
		return overTime;
	}


	public void setOverTime(Integer overTime) {
		this.overTime = overTime;
	}
}
