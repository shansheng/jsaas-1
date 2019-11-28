<%-- 
    Document   : [BpmOpinionLib]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程审批意见列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>

	<redxun:toolbar entityName="com.redxun.bpm.core.entity.BpmOpinionLib" excludeButtons="fieldSearch,export,importData,"/>

	<div class="mini-fit" style="height: 100%;">
		<div 
			id="datagrid1" 
			class="mini-datagrid"	
			style="width: 100%; height: 100%;" 
			allowResize="false"
			url="${ctxPath}/bpm/core/bpmOpinionLib/getUserText.do" 
			idField="opId"	
			multiSelect="true" 
			showColumnsMenu="true"
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20" 
			allowAlternating="true" 
			pagerButtons="#pagerButtons"n
		>
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="60" 	headerAlign="" align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="opText" width="120" headerAlign=""	allowSort="true">意见正文</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span class="" title="明细" onclick="detailRow(\''+ pkId	+ '\')">明细</span>'
					+ ' <span class="" title="编辑" onclick="editRow(\''	+ pkId	+ '\')">编辑</span>'
					+ ' <span class="" title="删除" onclick="delRow(\''	+ pkId + '\')">删除</span>';
			return s;
		}
		
		
	</script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"	entityName="com.redxun.bpm.core.entity.BpmOpinionLib" winHeight="450"
		winWidth="700" entityTitle="常用审批意见"	baseUrl="bpm/core/bpmOpinionLib" />
</body>
</html>