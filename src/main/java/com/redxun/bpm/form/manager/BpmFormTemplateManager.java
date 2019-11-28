

package com.redxun.bpm.form.manager;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.redxun.bpm.form.dao.BpmFormTemplateDao;
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;

/**
 * 
 * <pre> 
 * 描述：表单模版 处理接口
 * 作者:ray
 * 日期:2016-12-01 15:05:06
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmFormTemplateManager extends BaseManager<BpmFormTemplate> {
	
	@Resource
	BpmFormTemplateDao bpmFormTemplateDao;

	@Override
	protected IDao getDao() {
		return bpmFormTemplateDao;
	}
	
	
	/**
	 * 初始化表单模版。
	 * <pre>
	 * 1.删除初始化添加进去的模版。
	 * 2.读取模版并插入数据库。
	 * </pre>
	 * @throws IOException
	 */
	public void init() throws IOException{
		bpmFormTemplateDao.delByInit();
		
		List<BpmFormTemplate> templates= getJson();
		
		for(BpmFormTemplate template:templates){
			addTemplate(template);
		}
    }
	
	/**
	 * 根据分类和类型获取模版列表。
	 * @param categroy	main,sub,field
	 * @param type	pc,mobile
	 * @return
	 */
	public List<BpmFormTemplate> getTemplateByType(String categroy,String type){
		return bpmFormTemplateDao.getTemplateByType(categroy, type);
	}
	
	/**
	 * 根据别名和类型获取表单模版。
	 * @param alias
	 * @param type
	 * @return
	 */
	public BpmFormTemplate getTemplateByAlias(String alias,String type){
		return bpmFormTemplateDao.getTemplateByAlias(alias, type);
	}
	
	/**
	 * 获取字段模版。
	 * @param type
	 * @return
	 */
	public BpmFormTemplate getFieldTemplateByType(String type){
		List<BpmFormTemplate> list= bpmFormTemplateDao.getTemplateByType("field", type);
		if(list.size()==1){
			return list.get(0);
		}
		return null;
	}
		
	
	/**
	 * 添加表单模版。
	 * @param formTemplate
	 */
	private void addTemplate(BpmFormTemplate formTemplate){
		formTemplate.setId(IdUtil.getId());
		
		String path=WebAppUtil.getClassPath() + File.separator + "templates" 
				+ File.separator + "form" +File.separator + formTemplate.getType() +File.separator +  formTemplate.getAlias() + ".ftl";
		
		String  content=FileUtil.readFile(path);
		formTemplate.setInit(1);
		formTemplate.setTemplate(content);
		bpmFormTemplateDao.create(formTemplate);
	}

	/**
	 * 读取模版。
	 * @return
	 * @throws IOException
	 */
	private List<BpmFormTemplate> getJson() throws IOException{
		String path=WebAppUtil.getClassPath() + File.separator + "templates" 
				+ File.separator + "form" +File.separator +"form.json";
		
		String json= FileUtil.readFile(path);
		List<BpmFormTemplate> ary=JSONArray.parseArray(json,BpmFormTemplate.class);
		return ary;
	}
	
}
