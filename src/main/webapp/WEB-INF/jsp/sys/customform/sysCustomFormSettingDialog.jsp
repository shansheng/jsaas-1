<%-- 
    Document   :数据源对话框
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html >
<head>
<title>单据表单方案对话框</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="form-toolBox" id="form1">
			<span>名称：</span><input class="mini-textbox" style="width:150px;" id="name" name="Q_name_S_LK" onenter="onKeyEnter" /> 
			<span>标识键：</span> <input class="mini-textbox" style="width:150px;" id="alias" name="Q_alias_S_LK" onenter="onKeyEnter" /> 
			<input class="mini-hidden" style="width:150px;" id="boDefId" name="Q_bodefId_S_LK" value="" /> 
			<a class="mini-button"   onclick="search(this)">查询</a>
	</div>
	<div class="mini-fit">
		<div id="grid1" class="mini-datagrid" url="${ctxPath}/sys/customform/sysCustomFormSetting/listForDialog.do"
			style="width: 100%; height: 100%;" idField="id" allowResize="false"
			borderStyle="border-left:0;border-right:0;" multiSelect="false" allowAlternating="true"
			onrowdblclick="onRowDblClick">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div type="checkcolumn"></div>
				<div field="name" width="250" sortField="NAME_" headerAlign="center" allowSort="true">方案名称</div>
				<div field="alias" width="150" sortField="ALIAS_" headerAlign="center" allowSort="true">标识键</div>
				<div field="createTime" width="150" sortField="CREATE_TIME_" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">创建时间</div>
			</div>
		</div>
	</div>
	<div class="bottom-toolbar">
		<a   class="mini-button"  onclick="onOk()">确定</a>
		<a   class="mini-button" onclick="onCancel()">取消</a>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("grid1");
		grid.load();
		function getData() {
			var row = grid.getSelected();
			return row;
		}
		
		function search() {
			var name = mini.get("name").getValue();
			var alias= mini.get('alias').getValue();
			grid.load({
				Q_NAME__S_LK : name,
				Q_ALIAS__S_LK: alias
			});
		}
		
		function onKeyEnter(e) {
			search();
		}
		function onRowDblClick(e) {
			onOk();
		}
		function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
		function onOk() {
			CloseWindow("ok");
		}
		function onCancel() {
			CloseWindow("cancel");
		}
	</script>
</body>
</html>
