package com.redxun.bpm.form.manager;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.core.util.StringUtil;
import com.redxun.test.BaseTestCase;

import freemarker.template.TemplateException;

public class BpmFormViewManagerTest extends BaseTestCase {
	
	@Resource
	BpmFormViewDao bpmFormViewQueryDao;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	
	@SuppressWarnings("unused")
	@Test
	public void convertForms() throws IOException, TemplateException{
		List<BpmFormView> list=bpmFormViewQueryDao.getAllForms();
		for(BpmFormView formView:list){
			if(StringUtil.isEmpty(formView.getTemplateView())) continue;
//			//String html=bpmFormViewManager.convertToFreemakTemplate(formView.getTemplateView());
//			formView.setTemplate(html);
//			bpmFormViewQueryDao.update(formView);
		}
		System.out.println("转换表单成功");
		
	}

}
