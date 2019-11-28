<%-- 
    Document   :数据源对话框
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>自定义对话框</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" id="form1">
		<div class="form-toolBox">
			<ul>
				<li>
					<span>名称：</span><input class="mini-textbox"  id="name" name="Q_name_S_LK" onenter="onKeyEnter" />
				</li>
				<li>
					<span>标识键：</span><input class="mini-textbox"  id="key" name="Q_key_S_LK" onenter="onKeyEnter" />
				</li>
				<li class="liBtn"><a class="mini-button" onclick="search()">查询</a></li>
			</ul>
		</div>
	</div>
	<div class="mini-fit">
		<div id="grid1" class="mini-datagrid" url="${ctxPath}/sys/core/sysBoList/listDialogJsons.do?select=true"
			style="width: 100%; height: 100%;" idField="id" allowResize="true"
			borderStyle="border-left:0;border-right:0;" multiSelect="false"
			onrowdblclick="onRowDblClick">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div type="checkcolumn"></div>
				<div field="name" width="150" headerAlign="center" allowSort="true">对话框名称</div>
				<div field="key" width="150" headerAlign="center" allowSort="true">标识键</div>
			</div>
		</div>
	</div>
	<div class="bottom-toolbar">
		<a class="mini-button"  onclick="onOk()">确定</a>
		<a class="mini-button" onclick="onCancel()">取消</a>
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
			var key= mini.get('key').getValue();
			grid.load({
				Q_NAME__S_LK : name,
				Q_KEY__S_LK: key
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
