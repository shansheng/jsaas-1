package com.redxun.ui.grid.column.render;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmOvertimeNodeManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.sys.core.enums.MiniGridColumnType;

/**
 * 表格列表中流程实例的列的展示
 * @author mansan
 *
 */
public class MiniGridColumnRenderOverTime implements MiniGridColumnRender{
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmOvertimeNodeManager bpmOvertimeNodeManager;
	
	@Override
	public String getRenderType() {
		return MiniGridColumnType.OVER_TIME.name();
	}

	@Override
	public String render(GridHeader gridHeader, Map<String,Object> rowData,Object val, boolean isExport) {
		String instId = (String) rowData.get("INST_ID_");
		List<BpmTask> list = bpmTaskManager.getByInstId(instId);
		if(BeanUtil.isNotEmpty(list)) {
			BpmTask task = list.get(0);
			Integer overtime = bpmOvertimeNodeManager.getOverTime(task.getSolId(),task.getProcDefId(),task.getTaskDefKey(),task.getCreateTime());
			if(overtime>0) {
				String tmp=DateUtil.getDisplayTime(overtime);
				return "<span style='color:red'>超时("+tmp+")</span>";
			}
		}
		return "<span style='color:green'>正常</span>";
	}
}
