package com.redxun.sys.core.controller;

import java.util.Date;
import java.util.List;

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

import com.redxun.bpm.core.entity.BpmSolTemplateRight;
import com.redxun.bpm.core.manager.BpmSolTemplateRightManager;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;

/**
 * 系统树管理
 * 
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 *            本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/core/sysTree/")
public class SysTreeFormController extends BaseFormController {

	@Resource
	private SysTreeManager sysTreeManager;
	@Resource
	BpmSolTemplateRightManager bpmSolTemplateRightManager;

	/**
	 * 处理表单
	 * 
	 * @param request
	 * @return
	 */
	@ModelAttribute("sysTree")
	public SysTree processForm(HttpServletRequest request) {
		String treeId = request.getParameter("treeId");

		SysTree sysTree = null;
		if (StringUtils.isNotEmpty(treeId)) {
			sysTree = sysTreeManager.get(treeId);
		} else {
			sysTree = new SysTree();
		}

		return sysTree;
	}

	/**
	 * 保存实体数据
	 * 
	 * @param request
	 * @param sysTree
	 * @param result
	 * @return
	 */

	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	@LogEnt(action = "save", module = "系统内核", submodule = "系统树")
	public JsonResult save(HttpServletRequest request, @ModelAttribute("sysTree") @Valid SysTree sysTree,
			BindingResult result) {
		String userRight = request.getParameter("userRight");
		String groupRight = request.getParameter("groupRight");
		String isAll = request.getParameter("isAll");
		if (result.hasFieldErrors()) {
			return new JsonResult(false, getErrorMsg(result));
		}
		String msg = null;
		if (StringUtils.isEmpty(sysTree.getTreeId())) {
			sysTree.setTreeId(this.idGenerator.getSID());
			if (!"0".equals(sysTree.getParentId())) {
				SysTree parentTree = (SysTree) this.sysTreeManager.get(sysTree.getParentId());
				if (parentTree != null) {
					this.sysTreeManager.create(parentTree);
					sysTree.setPath(parentTree.getPath() + sysTree.getTreeId() + ".");
					sysTree.setDepth(Integer.valueOf(parentTree.getDepth().intValue() + 1));
				} else {
					sysTree.setDepth(Integer.valueOf(1));
					sysTree.setPath("0." + sysTree.getTreeId() + ".");
				}
			}
			if ((StringUtils.isNotBlank(sysTree.getBindSolId())) && ((StringUtils.isNotBlank(isAll))
					|| (StringUtils.isNotBlank(groupRight)) || (StringUtils.isNotBlank(userRight)))) {
				BpmSolTemplateRight bpmSolTemplateRight;
				if (this.bpmSolTemplateRightManager.getByTreeId(sysTree.getTreeId()) != null) {
					bpmSolTemplateRight = this.bpmSolTemplateRightManager.getByTreeId(sysTree.getTreeId());
				} else {
					bpmSolTemplateRight = new BpmSolTemplateRight();
				}
				bpmSolTemplateRight.setRightId(this.idGenerator.getSID());
				bpmSolTemplateRight.setTreeId(sysTree.getTreeId());
				bpmSolTemplateRight.setUserIds(userRight);
				bpmSolTemplateRight.setIsAll(isAll);
				bpmSolTemplateRight.setGroupIds(groupRight);
				bpmSolTemplateRight.setCreateTime(new Date());
				this.bpmSolTemplateRightManager.create(bpmSolTemplateRight);
			}
			this.sysTreeManager.create(sysTree);
			msg = getMessage("sysTree.created", new Object[] { sysTree.getIdentifyLabel() }, "系统树节点成功创建!");
		} else {
			List<SysTree> sysTrees = this.sysTreeManager.getByParentId(sysTree.getTreeId());
			if ((StringUtils.isNotBlank(sysTree.getBindSolId())) && ((StringUtils.isNotBlank(isAll))
					|| (StringUtils.isNotBlank(groupRight)) || (StringUtils.isNotBlank(userRight)))) {
				BpmSolTemplateRight bpmSolTemplateRight;
				if (this.bpmSolTemplateRightManager.getByTreeId(sysTree.getTreeId()) != null) {
					bpmSolTemplateRight = this.bpmSolTemplateRightManager.getByTreeId(sysTree.getTreeId());
				} else {
					bpmSolTemplateRight = new BpmSolTemplateRight();
					bpmSolTemplateRight.setRightId(this.idGenerator.getSID());
				}
				bpmSolTemplateRight.setIsAll(isAll);
				bpmSolTemplateRight.setTreeId(sysTree.getTreeId());
				bpmSolTemplateRight.setUserIds(userRight);
				bpmSolTemplateRight.setGroupIds(groupRight);
				bpmSolTemplateRight.setCreateTime(new Date());
				this.bpmSolTemplateRightManager.update(bpmSolTemplateRight);
			}
			this.sysTreeManager.update(sysTree);
			msg = getMessage("sysTree.updated", new Object[] { sysTree.getIdentifyLabel() }, "系统树节点成功更新!");
		}
		return new JsonResult(true, msg);
	}
}
