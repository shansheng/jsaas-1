<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>数据源列表管理</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false" height="45" showSplitIcon="false"  style="width:100%" bodyStyle="border:0">
			<div class="mini-toolbar dialog-footer" style="text-align:center;border:none;" >
			     <a class="mini-button"     onclick="onOk()">确定</a>
				    <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
			</div>	 
		 </div>
		 <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
		 	<ul id="tree1" class="mini-tree" url="${ctxPath}/sys/core/sysTree/listDicTree.do" style="width:100%;height:100%;" 
			    showTreeIcon="true"
			    <c:if test="${param.single!='true' }">
			    	showCheckBox="true"
			    </c:if> 
			     
			    textField="name" idField="pkId" parentField="parentId" resultAsTree="false" >        
			</ul>
		 </div>
	</div>
	
	<script type="text/javascript">
		var single=${param.single};
	
		mini.parse();
		
		var tree=mini.get("tree1");
		
		function getData(){
			var nodes=[];
			if(single){
				nodes.push( tree.getSelectedNode());
			}
			else{
				nodes=tree.getCheckedNodes(true);
			}
			return nodes;
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

