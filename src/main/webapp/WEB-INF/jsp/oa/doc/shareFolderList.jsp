<%-- 
    Document   : 共享文档目录列表页
    Created on : 2015-11-6, 16:11:48
    Author     : 陈茂昌
--%>
<%@page import="com.redxun.sys.org.controller.SysOrgMgrController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文档目录管理</title>
<%@include file="/commons/list.jsp"%>
<style>
	.mini-panel-toolbar{
		padding:6px 6px;
	}
</style>
</head>
<body>
<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
	<div
			title="共享文档"
			region="west"
			width="220"
			showCollapseButton="false"
	>
		<div class="treeToolBar"  >
			<a class="mini-button" onclick="mini.get('tree1').expandAll()" >展开目录</a>
			<a class="mini-button" onclick="mini.get('tree1').collapseAll()" >收起目录</a>
			<span><input type='checkbox' name='multi' id='multi' checked="true" style="vertical-align: -2px"/>含子目录</span>
		</div>
		<div class="mini-fit">
			<ul id="tree1" class="mini-tree"
							url="${ctxPath}/oa/doc/docFolder/listShare.do"
							style="width: 100%; padding: 5px;height: 100%;" showTreeIcon="true"
							textField="name" idField="folderId" value="base" expandOnLoad="true"
							parentField="parent" resultAsTree="false"
							contextMenu="#treeMenu" ondrawnode="onDrawNode" expand="onExpand"
							onnodeclick="onNodeSelect"></ul>
		</div>
	</div>
	<div title="center" region="center" bodyStyle="overflow:hidden;">
		<div class="mini-fit">
			<!--Tabs-->
					<div id="mainTabs" class="mini-tabs bg-toolbar" activeIndex="0"
						style="width: 100%; height: 100%;"
						onactivechanged="onTabsActiveChanged"></div>
		</div>
	</div>
</div>
	<ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
	<li>共享文件是只读的</li>
	</ul>



	<script type="text/javascript">
		mini.parse();
		var tree=mini.get("tree1");
		
		function getNodeNow(){
			var NowNode=mini.get("tree1").getSelectedNode();
			showTab(NowNode);
		}
		
		//设置节点图标以及文本等等
		function onDrawNode(e) {
	        var tree = e.sender;
	        var node = e.node;
	        	e.iconCls='icon-folder';
	        
	        	
	        	if(node.name.length>10){
	        		var shortnodeName=node.name.substring(0,9)+"…";
	        	e.nodeHtml= '<a title="' +node.name+ '">' +shortnodeName+ '</a>';
	        	}else{
	        		e.nodeHtml= '<a title="' +node.name+ '">' +node.name+ '</a>';
	        	}
	    }
		
		function onExpand(e){
			var tree = e.sender;
	        var node = e.node;
	        	e.iconCls='icon-folderopen';
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


		}
		
		
//显示节点页面
		function showTab(node) {
			var tabs = mini.get("mainTabs");
			var multi=document.getElementById("multi").checked;//是否选中子集的开关
			if(multi==false){
				multi="0";
			}else{
				multi="1";
			}
			var type=node.type;
			var id = node.folderId;
			var tab = tabs.getTab(id);
		
			if (!tabs.getTab(id)) {
				tab = {};
				tab._nodeid = node.folderId;
				tab.name = id;
				tab.title = node.name;
				tab.showCloseButton = true;
				tab.url = __rootPath+"/oa/doc/docFolder/shareIndex.do?folderId="+node.folderId+"&multi="+multi+"&type="+type+"&isShare="+"YES";
				
				tabs.addTab(tab);
				tabs.removeAll(tab);//只显示当前
			}
			tabs.activeTab(tab); 
		}

		function onNodeSelect(e) {
      	    var node = e.node;
				showTab(node);
		}
		

		function onTabsActiveChanged(e) {
			var tree =mini.get("tree1");
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