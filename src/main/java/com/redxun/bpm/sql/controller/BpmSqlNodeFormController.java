package com.redxun.bpm.sql.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.bpm.sql.entity.BpmSqlNode;
import com.redxun.bpm.sql.manager.BpmSqlNodeManager;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;


/**
 * sql管理
 * 
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/sql/bpmSqlNode/")
public class BpmSqlNodeFormController extends BaseFormController {
	
	@Resource
	private BpmSqlNodeManager bpmSqlNodeManager;

	/**
	 * 处理表单
	 * 
	 * @param request
	 * @return
	 */
	@ModelAttribute("bpmSqlNode")
	public BpmSqlNode processForm(HttpServletRequest request) {
		String bpmSqlNodeId = request.getParameter("bpmSqlNodeId");
		BpmSqlNode bpmSqlNode = null;
		if (StringUtils.isNotEmpty(bpmSqlNodeId)) {
			bpmSqlNode = bpmSqlNodeManager.get(bpmSqlNodeId);
		} else {
			bpmSqlNode = new BpmSqlNode();
		}
		return bpmSqlNode;
	}

	/**
	 * 保存实体数据
	 * 
	 * @param request
	 * @param bpmSqlNode
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	@LogEnt(action = "save", module = "流程", submodule = "BPM_SQL_NODE中间表")
	public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmSqlNode") @Valid BpmSqlNode bpmSqlNode, BindingResult result) {
		String ds = bpmSqlNode.getDsId();
//		if(StringUtil.isNotBlank(ds)){
//			String dsName = sysDatasourceManager.get(ds.trim()).getName();
//			bpmSqlNode.setDsName(dsName);
//		}
		
		if (result.hasFieldErrors()) {
			return new JsonResult(false, getErrorMsg(result));
		}
		String msg = null;
		if (StringUtils.isEmpty(bpmSqlNode.getBpmSqlNodeId())) {
			bpmSqlNode.setBpmSqlNodeId(idGenerator.getSID());
			bpmSqlNodeManager.create(bpmSqlNode);
			msg = getMessage("bpmSqlNode.created", new Object[] { bpmSqlNode.getIdentifyLabel() }, "sql成功创建!");
		} else {
			bpmSqlNodeManager.update(bpmSqlNode);
			msg = getMessage("bpmSqlNode.updated", new Object[] { bpmSqlNode.getIdentifyLabel() }, "sql成功更新!");
		}
		return new JsonResult(true, msg);
	}
}
