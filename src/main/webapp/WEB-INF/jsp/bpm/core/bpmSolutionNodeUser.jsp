<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>业务流程解决方案管理-某一节点人员配置</title>
	<%@include file="/commons/list.jsp"%>
	<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctxPath}/scripts/flow/form/userTypeSelect.js"></script>
	<style>
		.mini-panel-border .mini-grid-row:last-of-type .mini-grid-cell{
			border-bottom: none;
		}
		.mini-panel-border{
			border:0;
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
	<div class="topToolBar">
		<div style="text-align: left;">
	        <a class="mini-button"    onclick="addUser()" plain="true">添加</a>
		  	<input class="mini-hidden" id="nodeText" value=""/>
		</div>
	</div>
 	<div class="mini-fit" style="background: #fff;">
		<div 
			id="userGrid" 
			class="mini-datagrid" 
			oncellbeginedit="OnCellBeginEdit"
       		allowCellEdit="true" 
       		allowCellSelect="true" 
       		height="auto" 
       		oncellendedit="OnCellEndEdit"
       		oncellvalidation="onCellValidation" 
       		data-options="{nodeId:'${param['nodeId']}'}"
       		url="${ctxPath}/bpm/core/bpmSolUsergroup/getBySolNode.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId=${param.nodeId}&groupType=${param.groupType}"
			idField="id" 
			showPager="false" 
			style="width:100%;min-height:100px;"
			allowAlternating="true"
		>
			<div property="columns">
				<div type="indexcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="groupName" name="groupName"   width="80" headerAlign="center">组类型</div>
				<div field="sn" name="sn" width="50" headerAlign="center" >序号</div>
				<div field="userListString" name="userListString" width="50" headerAlign="center" >审批人员</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	addBody();
	mini.parse();
	var solId="${param['solId']}";
	var actDefId="${param.actDefId}";
	var nodeId="${param.nodeId}";
	var grid=mini.get('userGrid');
	grid.load();
	
	
	function addUser(){
		var url="${ctxPath}/bpm/core/bpmSolUser/edit.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId=${param.nodeId}&groupType=${param.groupType}";
		
		_OpenWindow({
			url:url,
			title:'添加用户组',
			width:780,
			height:480,
			ondestroy:function(action){
				if(action=="ok"){
					grid.load();
				}
			}
		});
	}
	
	//保存某个节点的人员配置
	function saveTaskUsers(nodeId){
		var nodeName = mini.get("nodeText").getValue();
		saveTaskUsers(nodeId,solId,actDefId,nodeName);
	}
	
	grid.on('drawcell',function(e){
		var recored=e.record;
		var field=e.field;
		var val=e.value;
		if(field=='calLogic'){
			if(val=='OR'){
				e.cellHtml='或';
			}else if(val=='AND'){
				e.cellHtml='与';
			}else{
				e.cellHtml='非';
			}
		}
	});
	
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
		        	url:"/saas_web/bpm/core/bpmSolUsergroup/del.do",
		        	method:'POST',
		        	data:{ids: pkId},
		        	 success: function(text) {
		                grid.load();
		            }
		         });
    		}
    	});
       
    }
	
	function onCellValidation(){
		
	}


</script>
</body>
</html>