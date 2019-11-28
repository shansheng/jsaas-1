<%-- 
    Document   :通过数据源查询表名的对话框
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-layout" style="height:100%;width:100%">
		<div region="center">
				<div class="mini-toolbar">
					<label>数据源：</label>
					<input id="dsAlias" name="dsAlias"
						value="" 
						id="dsAlias"
						style="width: 180px;" 
						class="mini-buttonedit" 
						showClose="true"
						onbuttonclick="onDatasource" 
						oncloseclick="_ClearButtonEdit" />
					<label>表名：</label> <input id="tableName" class="mini-textbox"  style="width:150px;" onenter="onKeyEnter" /> 
					<a class="mini-button" onclick="search()"  >查询</a>
			</div>
			<div class="mini-fit">
				<div id="grid1" class="mini-datagrid"
					style="width: 100%; height: 100%;" 
					idField="id"
					showPager="false"
					allowResize="true"
					allowAlternating="true"
					onrowdblclick="onRowDblClick">
					<div property="columns">
						<div type="indexcolumn" width="10%">序号</div>
						<div field="tableName" width="40%" headerAlign="center">名称</div>
						<div field="comment" width="40%" headerAlign="center">注释</div>
						<div field="type" width="40%" headerAlign="center">对象</div>
					</div>
				</div>
			</div>
		</div>
		<div region="south" showHeader="false" bodyStyle="text-align:center;padding:5px;" height="40">
				<a   class="mini-button"  onclick="onOk()">确定</a>
				<a   class="mini-button" onclick="onCancel()">取消</a>
		</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("grid1");
		//动态设置URL
		var url="${ctxPath}/sys/db/sysDb/findTableList.do";
		//也可以动态设置列 grid.setColumns([]);
		function getData() {
			var row = grid.getSelected();
			return row;
		}
		
		function getDbAlias(){
			return mini.get('dsAlias').getValue();
		}
		
		function search() {
			var tableName = mini.get("tableName").getValue();
			grid.setUrl(url);
			grid.load({
				tableName : tableName,
				ds:mini.get('dsAlias').getValue()
			});
		}
		
		function onDatasource(e) {
			var btnEdit = this;
			var callBack = function(data) {
				btnEdit.setValue(data.alias);
				btnEdit.setText(data.name);
			}
			openDatasourceDialog(callBack);
		}
		
		function onKeyEnter(e) {
			search();
		}
		function onRowDblClick(e) {
			onOk();
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
