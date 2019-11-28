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
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false"
		 	height="46"
		 	showSplitIcon="false"  
		 	style="width:100%" 
		 	>
			 <div class="southBtn">
		 		<a    class="mini-button"  onclick="onOk()">确定</a>
				<a   class="mini-button btn-red" onclick="onCancel()">取消</a>
			 </div>
		 </div>
		 <div region="center" title="用户列表"   showHeader="false" showCollapseButton="false" style="mini-toolbar-bottom" >
			 <div class="form-toolBox" class="search-form">
				 <ul>
					 <li>
						 <span>&nbsp;表名：</span>
						 <input id="tableName" class="mini-textbox" onenter="onKeyEnter" />
					 </li>
					 <li><a class="mini-button" onclick="search()">查询</a></li>
				 </ul>
			 </div>
			<div class="mini-fit">
				<div id="grid1" class="mini-datagrid"
					style="width: 100%; height: 100%;" idField="id"
					showPager="false"
					 allowResize="false" allowAlternating="true"
					borderStyle="border-left:0;border-right:0;"
					onrowdblclick="onRowDblClick">
					<div property="columns">
						<div type="indexcolumn" width="50">序号</div>
						<div field="tableName" width="120" headerAlign="center">名称</div>
						<div field="comment" width="160" headerAlign="center">注释</div>
						<div field="type" width="80" headerAlign="center">对象</div>
					</div>
				</div>
			</div>
		 </div>
	</div>

	
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("grid1");
		//动态设置URL
		var url="${ctxPath}/sys/db/sysDb/findTableList.do";
		//也可以动态设置列 grid.setColumns([]);
		function GetData() {
			var row = grid.getSelected();
			return row;
		}
		function search() {
			var tableName = mini.get("tableName").getValue();
			grid.setUrl(url);
			grid.load({
				tableName : tableName,ds:"${ds}"
			});
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
