package com.redxun.ui.grid.column.render;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.enums.ProcessStatus;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.sys.core.enums.MiniGridColumnType;

/**
 * 表格列表中流程实例的列的展示
 * @author mansan
 *
 */
public class MiniGridColumnRenderCurAssignee implements MiniGridColumnRender{
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	UserService userService;

	@Override
	public String getRenderType() {
		return MiniGridColumnType.CUR_ASSIGNEE.name();
	}

	@Override
	public String render(GridHeader gridHeader, Map<String,Object> rowData,Object val, boolean isExport) {
		String instId = (String) rowData.get("INST_ID_");
		List<BpmTask> list = bpmTaskManager.getByInstId(instId);
		if(BeanUtil.isNotEmpty(list)) {
			IUser iUser=userService.getByUserId(list.get(0).getAssignee());
			if(iUser!=null){
				return iUser.getFullname();
			}
		}
		return "";
	}
}
