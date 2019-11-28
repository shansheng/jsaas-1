<%-- 
    Document   : 公司文档目录列表页
    Created on : 2018年6月18日16:05:47
    Author     : 杨义
--%>
<%@page import="com.redxun.sys.org.controller.SysOrgMgrController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文档目录管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout"
		style="width: 100%; height: 100%;">
		<div title="center" region="center" bodyStyle="overflow:hidden;"
			style="border: 0;">
			<!--Splitter-->
			<div class="mini-splitter" style="width: 100%; height: 100%;"
				borderStyle="border:0;">
				<div size="270" maxSize="350" minSize="100"
					showCollapseButton="true" style="border-width: 1px;">
					<!--Tree-->

					<div id="panel1" class="mini-panel" title="公司文档"
						iconCls="" style="width: 440px; height: 100%;"
						showToolbar="true" showCollapseButton="true" showFooter="false"
						allowResize="true" collapseOnTitleClick="true">
						<!--toolbar-->
						
						<div property="toolbar"  class="toolbar-margin">
						<div id="treetoolbar">
						<a class="mini-button" iconCls="icon-down"
								onclick="mini.get('tree1').expandAll()">展开目录</a>
								 <a class="mini-button" iconCls="icon-up"
								onclick="mini.get('tree1').collapseAll()">收起目录</a>
								 <a class="mini-button" iconCls="icon-add"
								onclick="mini.get('tree1').collapseAll()">新建</a>
						</div>
						</div>
					
						<!--Tree-->
						<ul id="tree1" class="mini-tree"
							url="${ctxPath}/flie/tray/flieTrayBasic/listFile.do"
							style="width: 100%; padding: 5px; height: 100%;" showTreeIcon="true" 
							textField="fileTrayName" idField="id" value="base" expandOnLoad="true"
							resultAsTree="0" contextMenu="#treeMenu"
							onnodeselect="onNodeSelect">
						</ul>

					</div>

				</div>

				<div showCollapseButton="false" style="border: 0px;">
					<!--Tabs-->
					<div id="mainTabs" class="mini-tabs bg-toolbar" activeIndex="0"
						style="width: 100%; height: 100%;"
						onactivechanged="onTabsActiveChanged"></div>
				</div>
			</div>
		</div>
	</div>
	
<!-- 树右键菜单 -->
	<ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
		<li name="add" iconCls="icon-add" onclick="onAddAfter">新增同级文件夹</li>
		<li name="edit" iconCls="icon-edit" onclick="onEditNode">编辑文件夹</li>
		<li name="remove" iconCls="icon-remove" onclick="onRemoveNode">删除文件夹</li>
	</ul>



	<script type="text/javascript">
		mini.parse();
		var tree = mini.get("tree1");

		
		//在没有根目录的清空下建立新目录的按钮
		$(function(){
			if(tree.getChildNodes(tree.getRootNode()).length<1){
				$("#treetoolbar").hide();
			}else {
				$("#treeadd").hide();
			}
		});
		
		
		//建立根目录
		function addroot(){
			var iscompany = 0;//可用来判断是否公司
			var newNode = {};//新建空节点
			//tree.addNode(newNode, "add", node);
			var type = "COMPANY";
			_OpenWindow({
				url : '${ctxPath}/oa/doc/docFolder/edit.do?parent='
						+"0"+ "&path=" + iscompany
						+ "&type=" + type,
				title : "新建目录",
				width : 600,
				height : 400,
				onload : function() {
				},
				ondestroy : function(action) {
					if (action == 'ok'){
					tree.load();
					}
				}

			});
			
		}
		
		
		//增加同级节点
		function onAddAfter(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var newNode = {};
			var parent = node.parent;
			var pkId = node.folderId;//节点的唯一标识符
			var iscompany = 0;
			var type = "COMPANY";
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?folderId='+node.folderId+'&parent='+parent+'&path='+iscompany+"&type="+type,
				title : "新增同级节点",
				width : 600,
				height : 400,
				onload : function() {

				},
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();
				}

			});
		}
		
		


		//增加子节点
		function onAddNode(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var iscompany = 0;//可用来判断是否公司
			var newNode = {};//新建空节点
			var type = "COMPANY";
			_OpenWindow({
				url : '${ctxPath}/oa/doc/docFolder/edit.do?parent='
						+ node.folderId+ "&path=" + iscompany
						+ "&type=" + type,
				title : "新增子文件夹",
				width : 600,
				height : 400,
				onload : function() {
				},
				ondestroy : function(action) {
					if (action == 'ok'){
						tree.load();
					}
				}

			});
		}

		//编辑节点文本（URL）
		function onEditNode(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var pkId = node.id;
			var parent = node.parent;
			var path = node.path;
			var share = node.share;
			console.log(share);
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?pkId=' + pkId
						+ "&path=" + path + "&parent=" + parent,//
				title : "编辑文件",
				width : 600,
				height : 400,
				method : 'POST',
				onload : function() {

				},
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();

				}

			});

		}
		//删除节点
		function onRemoveNode(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var isLeaf = tree.isLeaf(node);
			var folderId = node.folderId;
			if (node) {
				if (confirm("确定删除选中节点?")) {
					$.ajax({
								type : "Post",
								url : '${ctxPath}/oa/doc/docFolder/delContain.do?folderId='
										+ folderId + '&type=' + node.type,
								data : {},
								beforeSend : function() {

								},
								success : function() {
								}
							});
					tree.removeNode(node);
				}
			}
		}

		//阻止浏览器默认右键菜单
		function onBeforeOpen(e) {
			var menu = e.sender;
			var tree = mini.get("tree1");

			var node = tree.getSelectedNode();
			if (!node) {
				e.cancel = true;
				return;
			}
			if (node && node.text == "Base") {
				e.cancel = true;
				e.htmlEvent.preventDefault();
				return;
			}
			////////////////////////////////////////////////////
			var editItem = mini.getByName("edit", menu);

				mini.getByName("add").show();
				mini.getByName("remove").show();

		}

		//显示节点页面
		function showTab(node) {
// 			var tabs = mini.get("mainTabs");
// 			var multi = document.getElementById("multi").checked;//是否选中子集的开关
// 			if (multi == false) {
// 				multi = "0";
// 			} else {
// 				multi = "1";
// 			}
// 			var id = node.folderId;
// 			var tab = tabs.getTab(id);

// 			if (!tabs.getTab(id)) {//如果id不为空的话
// 				tab = {};
// 				tab._nodeid = node.folderId;
// 				tab.name = id;
// 				tab.title = node.name;
// 				tab.showCloseButton = true;
// 				tab.url = __rootPath
// 						+ "/oa/doc/docFolder/index.do?folderId="
// 						+ node.folderId + "&multi=" + multi + "&type="
// 						+ "COMPANY";

// 				tabs.addTab(tab);
// 				tabs.removeAll(tab);//只显示当前
// 			}
// 			tabs.activeTab(tab);
		}
        //点击节点时
		function onNodeSelect(e) {
			var node = e.node;
			showTab(node);
		}

		function onTabsActiveChanged(e) {
			var tree = mini.get("tree1");
			var tabs = e.sender;
			var tab = tabs.getActiveTab();
			if (tab && tab._nodeid) {

				var node = tree.getNode(tab._nodeid);
				if (node && !tree.isSelectedNode(node)) {
					tree.selectNode(node);
				}
			}
		}
	</script>

</body>
</html>