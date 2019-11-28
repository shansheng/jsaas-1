<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>系统分类选择页</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
		<input id="key" class="mini-textbox" style="width: 150px;" onenter="onKeyEnter" emptyText="名称" /> <a class="mini-button" onclick="search()">查询</a>
		</div>
	</div>
	<div class="mini-fit" style="background: #fff">
	 	<ul id="tree1" class="mini-tree" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_KMS_KDQUE" style="width:100%;padding:5px;"  
	        showTreeIcon="true" resultAsTree="false" expandOnLoad="0" textField="name" idField="treeId" parentField="parentId" expandOnNodeClick="false">        
	    </ul>
	</div>
	<div class="bottom-toolbar">
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button btn-red"   onclick="onCancel()">取消</a>
	</div>
	<script type="text/javascript">
		mini.parse();
		var tree = mini.get("tree1");
		function GetData() {
			return tree.getSelectedNode();
		}
		
		function search() {
		var key = mini.get("key").getValue();
			tree.load({
				key : key
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function onRowDblClick(e) {
			onOk();
		}
		//////////////////////////////////
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