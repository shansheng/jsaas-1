<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>批量审批</title>
	<%@include file="/commons/list.jsp"%>
	<style type="text/css">
		.mini-layout-border>#center{
	 		background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}
	</style>
</head>
<body>
	<div id="taskLayout" class="mini-layout" style="width:100%;height:100%;">
		    <div 
		    	title="审批节点定义" 
		    	region="west" 
		    	width="170"  
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
	    	>
		        <div class="mini-fit">
			         <ul 
			         	id="dimTree" 
			         	class="mini-tree" 
			         	url="${ctxPath}/bpm/core/bpmBatchApproval/jsonAll.do" 
			         	style="width:100%; height:100%;" 
						imgPath="${ctxPath}/upload/icons/"
						showTreeIcon="true" 
						textField="name" 
						idField="id" 
						resultAsTree="false"  
						parentField="parentId"
		                onnodeclick="onNodeClick" 
	                >        
		            </ul>
	            </div>
		    </div>
        
		    <div showHeader="false" showCollapseButton="false" region="center">
              	<div class="titleBar mini-toolbar" >
			         <ul>
						<li>
							<a class="mini-button"  onclick="onOk();">批量审批</a>
						</li>
						<li>
							<a class="mini-button"  plain="true" onclick="back()">返回</a>
						</li>
						<li class="clearfix"></li>
					</ul>
		     	</div>
		         <div class="mini-fit rx-grid-fit" >
		         	<div id="taskTab" class="mini-tabs" style="width:100%;height:100%;border:none"></div>
		        </div>
		    </div>		    
    </div>
	<script type="text/javascript">
		mini.parse();
		var taskTab = mini.get("#taskTab");
		//选中的表格
		var curGrid;
		
		function back(){
			history.back(-1);
		}
		
		function onOk(){
			if(!curGrid)return;
			var tasks = curGrid.getSelecteds();
			if(tasks.length==0){
				alert("请选择需要审批的任务!");
				return;
			}
			var aryIds = [];
			for(var i=0;i<tasks.length;i++){
				aryIds.push(tasks[i].ID_);
			}
			var taskIds=aryIds.join(",");
			_OpenWindow({
				title:"批量审批",
				height:450,
				width:700,
				url:"${ctxPath}/bpm/core/bpmBatchApproval/toApprove.do?taskId="+taskIds,
				ondestroy:function(action){
					curGrid.reload();
				}
			});
		}
		
		function onNodeClick(e){
			var node=e.node;
			var id = node.id;
			if(node.id==0 || node.parentId==0) return;
			var url=__rootPath+'/bpm/core/bpmBatchApproval/getColumns.do?pkId='+id;
			//动态加载查询列表
			$.get(url,function(result){
				if(result.columns.length==0){
					alert("没有定义审批列");
					return;
				}
				
				var tabs = taskTab.getTabs();
				for(var i=0;i<tabs.length;i++){
					var tab = tabs[i];
					//存在的情况。
					if(id==tab.name){
			        	var grid=mini.get('#taskGrid_'+id);
			        	grid.load();
			        	curGrid = grid;
			        	taskTab.activeTab(tab);
						return;
					}
				}
				//不存在的情况
				var tab=taskTab.addTab({
					title:node.name,
					name:node.id,
				});
				var el=taskTab.getTabBodyEl(tab);
				var grid=new mini.DataGrid();
				var url=__rootPath+'/bpm/core/bpmBatchApproval/getTasks.do?pkId='+id;
				grid.set({
					id:"taskGrid_"+id,
					style:"width:100%;height:100%;",
					showPager:false,
					idField:"ID_",
					url:url,
					multiSelect:true,
					allowAlternating:true,
					columns:result.columns
				});
				
				grid.load();
				grid.render(el);
				curGrid = grid;
				taskTab.activeTab(tab);
			});
		}
		
	</script>
</body>
</html>