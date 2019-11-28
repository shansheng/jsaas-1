<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>业务流程解决方案管理-流程定义节点人员配置</title>
	<%@include file="/commons/list.jsp"%>
	<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctxPath}/scripts/flow/form/userTypeSelect.js"></script>
	<style type="text/css">
		body .mini-toolbar a.mini-button-disabled{
			background: #409EFF;
			padding: 0 6px;
		}
		body .mini-toolbar a.mini-button-disabled .mini-button-text{
			color: #fff;
		}
		body .mini-toolbar a.mini-button-disabled:hover .mini-button-text{
			color: #fff;
			cursor: not-allowed;
		}
	</style>
</head>
<body>
		<div style="display:none">
			<input 
				id="userTypeEditor" 
				class="mini-combobox" 
				style="width:100%" 
				textField="typeName" 
				valueField="typeKey" 
				popupWidth="450"
				url="${ctxPath}/bpm/core/bpmSolUser/getUserTypes.do"  
				required="true" 
				allowInput="false" 
			/>
			<input 
				id="configEditor" 
				class="mini-buttonedit" 
				style="width:100%" 
				onbuttonclick="selConfig" 
				selectOnFocus="true" 
				allowInput="false"
			/>
			<input 
				id="snEditor" 
				class="mini-spinner" 
				minValue="1" 
				maxValue="200" 
				style="width:100%"
			/>
			<input 
				id="logicEditor" 
				class="mini-combobox" 
				style="width:100%" 
				textField="text" 
				valueField="id" 
    			data="[{id:'AND',text:'与'},{id:'OR',text:'或'},{id:'NOT',text:'非'}]" 
    			required="true"  
   			/>  
		</div>
		<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;"> 
		    <div 
		    	title="流程任务节点" 
		    	region="west" 
		    	width="220"  
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
		    	iconCls="" 
	    	
	    	>
		        <div class="mini-fit">
		         <ul 
		         	id="bpmTaskNodeTree" 
		         	class="mini-tree Tree" 
		         	url="${ctxPath}/bpm/core/bpmNodeSet/getTaskNodes.do?actDefId=${bpmDef.actDefId}" 
		         	style="width:100%;height:100%;"
					parentField="parentActivitiId" 
					expandOnLoad="true" 
					style="overflow: auto;"
					showTreeIcon="true" 
					textField="name" 
					idField="activityId" 
					resultAsTree="false"  
	                onnodeclick="nodeClick">        
	            </ul>
	            </div>
		    </div>
		    <div 
		    	title="流程审批人员" 
		    	region="center" 
		    	showHeader="false" 
		    	showCollapseButton="false" 
		    	iconCls="icon-group"
		    	>
		    	<div class="mini-toolbar" >
					<div class="form-toolBox">
						<ul>
							<li><a class="mini-button" id="addBtn"  onclick="addGroup()"  enabled="false" >添加</a></li>
						</ul>
					</div>
		    	</div>
		    	<div class="mini-fit">
			    	<div id="userGrid" class="mini-datagrid" oncellbeginedit="OnCellBeginEdit" allowAlternating="true"
	            		allowCellEdit="true" allowCellSelect="true"  oncellendedit="OnCellEndEdit"
	            		oncellvalidation="onCellValidation" 
	             		url="${ctxPath}/bpm/core/bpmSolUsergroup/getBySolNode.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId=${param.nodeId}&groupType=task"
						idField="id" showPager="false" style="width:100%;height:100%;">
						<div property="columns">
							<div type="indexcolumn" width="20"></div>
							<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
							<div field="groupName" name="groupName"   width="80" headerAlign="center">组类型</div>
							<div field="sn" name="sn" width="50" headerAlign="center" >序号</div>
							<div field="userListString" name="userListString" width="50" headerAlign="center" >审批人员</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<script type="text/javascript">
		mini.parse();
		//当前的表格控件
		var grid=mini.get('userGrid');
		var solId="${param.solId}";
		var actDefId="${param.actDefId}";
		var nodeId='${param.nodeId}';
		var nodeName;
		var tree=mini.get('bpmTaskNodeTree');
		
		function nodeClick(e){
			mini.get('addBtn').setEnabled(true);
			nodeId=e.node.activityId;
			nodeName=e.node.name;
			multi=e.node.multiInstance?true:false;
			
			grid.setUrl("${ctxPath}/bpm/core/bpmSolUsergroup/getBySolNode.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId="+nodeId+"&groupType=task");
			grid.load();
		}
		
		function addGroup(){
			var url="${ctxPath}/bpm/core/bpmSolUser/edit.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId="+nodeId+"&groupType=task";
			
			_OpenWindow({
				url:url,
				title:'添加用户组',
				width:800,
				height:600,
				onload:function(){
					var win=this.getIFrameEl().contentWindow;
					win.setName(nodeName);
				},
				ondestroy:function(action){
					if(action=="ok"){
						grid.load();
					}
				}
			});
		}
		
		function onActionRenderer(e) {
	        var record = e.record;
	        var uid = record.pkId;
	    	var	s= ' <span  title="编辑" onclick="editRowOwn(\'' + uid +'\')">编辑</span>';
	            s+= ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
	        return s;
	    }
		
		//编辑行数据
	    function editRowOwn(pkId,fullWindow) {    
	    	var width=700;
	    	var height=500;
	    	if(fullWindow){
	    		width=getWindowSize().width;
	    		height=getWindowSize().height;
	    	}
	    
	    	if(isExitsFunction('_editRow')){
	    		_editRow(pkId);
	    		return;
	    	}
	        _OpenWindow({
	    		url: "${ctxPath}/bpm/core/bpmSolUser/edit.do?pkId="+pkId+"&actDefId=${param.actDefId}&solId=" + solId,
	            title: "编辑用户分组",
	            width: width, height: height,
	            ondestroy: function(action) {
	                if (action == 'ok') {
	                    grid.reload();
	                }
	            }
	    	});
	    }
		
	    function delRow(pkId) {
	        
	    	if(isExitsFunction('_delRow')){
	    		_delRow(pkId);
	    		return;
	    	}
	    	mini.confirm("确定删除选中记录？","确定？",function(action){
	    		if(action!='ok'){
	    			return;
	    		}else{
					 _SubmitJson({
			        	url:"${ctxPath}/bpm/core/bpmSolUsergroup/del.do",
			        	method:'POST',
			        	data:{ids: pkId},
			        	 success: function(text) {
			                grid.load();
			            }
			         });
	    		}
	    	});
	       
	    }
		
		

		/* //保存某个节点的人员配置
		function doSaveTaskUsers(){
			var nodeId=null;
			var nodeName=null;
			var node=tree.getSelectedNode();
			if(!node){
				nodeId='process';
			}else{
				nodeId=node.activityId;
				nodeName=node.name;
			}
			
			saveTaskUsers(nodeId,solId,"${bpmDef.actDefId}",nodeName);
		} */
		
	</script>
</body>
</html>