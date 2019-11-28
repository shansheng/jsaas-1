<%-- 
    Document   : [KdQuestion]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>问答分类列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
		<div region="west" showSplit="true" showHeader="false" width="200">
			<div class="treeToolBar">
				<a class="mini-button"   plain="true" onclick="addNewType" tooltip="新增一级分类">新增一级分类</a>
				<a class="mini-button"  plain="true" onclick="refresh" tooltip="刷新">刷新</a>
			</div>
			<div class="mini-fit" borderStyle="border:0px;">
				<div id="tree" class="mini-tree" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_KMS_KDQUE" style="width: 100%; height: 100%; padding: 5px;" showTreeIcon="true" textField="name" idField="treeId" parentField="parentId" resultAsTree="false"  expandOnNodeClick="false" expandOnLoad="0" contextMenu="#treeMenu" onnodeselect="onNodeSelect" ondrawnode="" onload="" ></div>
			</div>

			<ul id="treeMenu" class="mini-contextmenu" onbeforeopen="">
				<li name="brother"   onclick="addNewType">新增一级分类</li>
				<li name="children"   onclick="addNewSubType">新增子分类</li>
				<li name="edit"  onclick="editType">编辑分类</li>
				<li name="remove" class=" btn-red" onclick="delType">删除分类</li>
			</ul>
		</div>

		<div title="center" region="center" bodyStyle="overflow:hidden;" style="border: 0;margin-top: 2px">
			<div class="mini-fit">
				<div id="mainTabs" class="mini-tabs bg-toolbar" activeIndex="0" style="width: 100%; height: 100%;" onactivechanged="onTabsActiveChanged"></div>
			</div>
		</div>
	</div>

	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<script type="text/javascript">
		mini.parse();
		var tree=mini.get("tree");	
		
		function refresh(){
			tree.load();
		}
		
		function addNewType() {
			_OpenWindow({
				url : "${ctxPath}/sys/core/sysTree/editKmsType.do?nodetype=parent&catKey=CAT_KMS_KDQUE",
				title : "新增一级问题分类",
				height : 200,
				width : 800,
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();
				}
			});
		}
		
        function addNewSubType(){
        	var node = tree.getSelectedNode();
        	if(node==null){
        		alert("请选择一个分类！");
        		return;
        	}
        	if(node.depth>1){
        		alert("不能新增四级以上的分类！");
        		return;
        	}
			_OpenWindow({
				url : "${ctxPath}/sys/core/sysTree/editKmsType.do?nodetype=sub&catKey=CAT_KMS_KDQUE&parentId="+node.treeId,
				title : "新增子问题分类",
				height : 200,
				width : 800,
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();
				}
			});
        }
        
        function editType(){
        	var node = tree.getSelectedNode();
        	if(node==null){
        		alert("请选择一个分类！");
        		return;
        	}
			_OpenWindow({
				url : "${ctxPath}/sys/core/sysTree/editKmsType.do?treeId="+node.treeId,
				title : "问题分类编辑",
				height : 200,
				width : 800,
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();
				}
			});
        }
        
        function delType(){
        	var node = tree.getSelectedNode();
        	if(node==null){
        		alert("请选择一个分类！");
        		return;
        	}
        	
	       	if (!confirm("确定删除此分类（此分类下的子分类也会被删除！")) {return;}

            _SubmitJson({
            	url:"${ctxPath}/sys/core/sysTree/del.do",
            	data:{
            		ids:node.treeId
            	},
            	method:'POST',
            	success:function(){
            		tree.load();
            	}
            });
        }
        
		/*打开标签*/
		function showTab(node) {
			var tabs = mini.get("mainTabs");
			var id = "tab$" + node.treeId;
			var tab = tabs.getTab(id);
			if (!tab) {
				tab = {};
				tab._nodeid = node.treerId;
				tab.name = id;
				tab.title = "问题分类-" + node.name;
				tab.showCloseButton = true;

				tab.url = "${ctxPath}" + "/kms/core/kdQuestion/list.do?treeId="+node.treeId;
				tabs.addTab(tab);
				tabs.activeTab(tab);
			}
			else{
				tabs.activeTab(tab);
				tabs.reloadTab(tab);
			}
			
		}

		/*选择节点时触发*/
		function onNodeSelect(e) {
			var node = e.node;
			showTab(node);
		}

		/*激活tabs事件处理*/
		function onTabsActiveChanged(e) {
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