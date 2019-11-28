//package com.redxun.bpm.form.dao;
//
//import javax.annotation.Resource;
//
//import org.junit.Test;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.redxun.bpm.form.entity.BpmFormTemplate;
//import com.redxun.sys.core.util.JsaasUtil;
//import com.redxun.test.BaseTestCase;
//
///**
// * <pre>
// *  
// * 描述：BpmFormTemplate数据访问测试类
// * 构建组：miweb
// * 作者：keith
// * 邮箱: keith@redxun.cn
// * 日期:2014-2-1-上午12:52:41
// * 版权：广州红迅软件有限公司版权所有
// * </pre>
// */
//public class BpmFormTemplateDaoTest extends BaseTestCase {
//
//	@Resource
//	private BpmFormTemplateDao bpmFormTemplateDao;
//
//	@Transactional(readOnly = false)
//	@Test
//	public void crud() {
//		int amount=JsaasUtil.getUserAmount();
//		System.err.println(amount);
//	}
//}