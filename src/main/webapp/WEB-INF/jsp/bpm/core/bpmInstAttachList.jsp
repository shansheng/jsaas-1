<%-- 
    Document   : [BpmInstAttach]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[BpmInstAttach]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>

	<redxun:toolbar entityName="com.redxun.bpm.core.entity.BpmInstAttach" />

	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid"
			style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmInstAttach/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" pageSize="20"
			allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"
					 renderer="onActionRenderer"
					cellStyle="padding:0;">操作</div>
				<div field="instId" width="120" allowSort="true">${column.remarks}</div>
				<div field="fileId" width="120" allowSort="true">${column.remarks}</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
	                    + ' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
	                    + ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
	            return s;
	        }
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.bpm.core.entity.BpmInstAttach" winHeight="450"
		winWidth="700" entityTitle="[BpmInstAttach]"
		baseUrl="bpm/core/bpmInstAttach" />
</body>
</html>