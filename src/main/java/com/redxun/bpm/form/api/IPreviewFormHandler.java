package com.redxun.bpm.form.api;

import com.alibaba.fastjson.JSONObject;
import com.redxun.sys.bo.entity.SysBoEnt;

public interface IPreviewFormHandler {
	
	/**
	 * 预览表单。
	 * @param viewId		表单ID
	 * @param title			TAB表单标题
	 * @param displayType   展示模式
	 * @param formTemplate	表单模版
	 * @return
	 * @throws Exception
	 */
	String previewForm(String viewId,String title,String displayType,String formTemplate) throws Exception;
	
	
	/**
	 * 根据viewId进行预览。
	 * @param viewId
	 * @return
	 * @throws Exception 
	 */
	String previewFormById(String viewId) throws Exception;
	
	
	/**
	 * 根据表单提取表单初始化数据。
	 * @param formContent
	 * @return
	 */
	JSONObject getInitDataByForm(String formContent);
	
	
	SysBoEnt  getBoEnt(String formContent);

}
