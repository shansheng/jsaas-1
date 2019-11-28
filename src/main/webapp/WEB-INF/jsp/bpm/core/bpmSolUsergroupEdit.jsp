<%-- 
    Document   : [BpmSolUsergroup]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户分组信息编辑</title>
<%@include file="/commons/edit.jsp"%>
<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctxPath}/scripts/flow/form/userTypeSelect.js?t=1"></script>
</head>
<body>
	<div id="toolbar1" class="topToolBar" >
		<div>
	    	<a class="mini-button"  plain="true" onclick="onOk">保存</a>
	     	<a class="mini-button btn-red"  plain="true" onclick="onCancel">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
		<form id="form1">	
			<input id="pkId" name="id" class="mini-hidden" value="${userGroup.id}" />
			<input id="solId" name="solId" class="mini-hidden" value="${userGroup.solId}" />
			<input id="actDefId" name="actDefId" class="mini-hidden" value="${userGroup.actDefId}" />
			<input id="nodeId" name="nodeId" class="mini-hidden" value="${userGroup.nodeId}" />
			<input id="sn" name="sn" class="mini-hidden" value="${userGroup.sn}" />
			<input id="groupType" name="groupType" class="mini-hidden" value="${userGroup.groupType}" />
			<table class="table-detail column-four" cellspacing="1" cellpadding="0">
				<caption>抄送配置</caption>
				<tr>
					<td width="140">名　　称</td>
					<td><input name="groupName" value="${userGroup.groupName}" class="mini-textbox" vtype="maxLength:50" required="true" style="width: 90%" />
					</td>
					<td width="140">通知类型</td>
					<td>
						<div name="notifyType" class="mini-checkboxlist"  value="${userGroup.notifyType}" required="true"
					        textField="text" valueField="name"  url="${ctxPath}/bpm/core/bpmConfig/getNoticeTypes.do" >
					    </div>
					</td>
				</tr>
				<tr>
					<td width="140">条件脚本</td>
					<td>
						<textarea id="config_${userGroup.nodeId}" onfocus="conditionOnFocus"  class="mini-textarea" name="setting" style="width:70%;height:60px;" ><c:out escapeXml="true" value="${userGroup.setting}"/></textarea>
			            <a class="mini-button"  plain="true" onclick="showExpressionEditor('${userGroup.solId}','${userGroup.actDefId}','${userGroup.nodeId}')">设计</a>
					</td>
					<td width="140">序　　号</td>
					<td>
						<input name="sn" value="${userGroup.sn}" class="mini-spinner" minValue="1" />
					</td>
				</tr>
			</table>			
			<div class="form-toolBox">
		         <a class="mini-button" id="addBtn"    onclick="addUserRow()" plain="true" enabled="true">添加</a>
		         <a class="mini-button btn-red" id="delBtn"  onclick="delUserRow()" plain="true" enabled="true">删除</a>
			</div>
	    	<div id="userGrid" class="mini-datagrid" oncellbeginedit="OnCellBeginEdit" style="width:100%;mini-height:300px;"
	         		allowCellEdit="true" allowCellSelect="true"  oncellendedit="OnCellEndEdit" height="auto"
	         		oncellvalidation="onCellValidation" 
	          		url="${ctxPath}/bpm/core/bpmSolUser/getUserByGroupId.do?groupId=${userGroup.id}&category=${userGroup.groupType}"
					idField="id" showPager="false" style="width:100%;min-height:100px;">
				<div property="columns">
					<div type="indexcolumn" width="20"></div>
					<div field="userType" name="userType" displayField="userTypeName" width="80" headerAlign="center">用户类型
						<input id="userTypeEditor" property="editor" class="mini-combobox" style="width:100%;" popupWidth="450" 
							textField="typeName" valueField="typeKey" url="${ctxPath}/bpm/core/bpmSolUser/getUserTypes.do"  
							required="true" allowInput="false"/>
					</div>
					<div field="config" name="config" displayField="configDescp" width="160" headerAlign="center" >用户值
						<input id="configEditor" property="editor" class="mini-buttonedit" style="width:100%" onbuttonclick="selConfig" 
							selectOnFocus="true" allowInput="false"/>
					</div>
					<div field="calLogic" name="calLogic" width="60" headerAlign="center" >计算逻辑
						<input id="logicEditor" property="editor" class="mini-combobox" style="width:100%" textField="text" valueField="id" 
  								data="[{id:'AND',text:'与'},{id:'OR',text:'或'},{id:'NOT',text:'非'}]" required="true" />  
					</div>
					<div type="checkboxcolumn" field="isCal" name="isCal" trueValue="YES" falseValue="NO" width="60" headerAlign="center">是否计算用户</div>
					<div field="sn" name="sn" width="50" headerAlign="center">序号
						<input id="snEditor" property="editor"  class="mini-spinner" minValue="1" maxValue="200" style="width:100%"/>
					</div>
					<div field="solId" name="solId" visible="false"></div>
				</div>
			</div>	
		</form>
	</div>
	</div>
	<script type="text/javascript">
	mini.parse();
	var grid=mini.get('userGrid');
	var solId="${param.solId}";
	var actDefId="${param.actDefId}";
	var groupId="${userGroup.id}";
	var nodeId="${userGroup.nodeId}";
	
	//当前的表格控件
	
	if(groupId){
		grid.load();
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
	
	//显示编辑器
	function showExpressionEditor(solId,actDefId,destNodeId){
		_OpenWindow({
			title:'公式设计器',
			iconCls:'icon-formula',
			url:__rootPath+'/bpm/core/bpmSolution/expEditor.do?solId='+solId+'&nodeId='+nodeId+'&actDefId='+actDefId,
			width:800,
			height:600,
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				var setting = mini.getByName("setting").getValue();
				win.addExp(setting);
			},
			ondestroy:function(action){
				if(action!='ok') return;
				var win=this.getIFrameEl().contentWindow;
				var content=win.getFormula();
				mini.get('config_'+destNodeId).setValue(content);
			}
		});
	}
	
	function handleFormData(formData){
		//表格检验
		grid.validate();
		if(!grid.isValid()){
	    	return;
	    }
		
		var result={isValid:true};
		var json={};
		for(var i=0;i<formData.length;i++){
			var obj=formData[i];
			json[obj.name]=obj.value;
		}
		
		json.userList=removeGirdData(grid.getData());
		result.formData=json;
		
		result.postJson=true;
		
		return result;
	}
	
	function removeGirdData(list){
		for(var i=0;i<list.length;i++){
			var obj=list[i];
			delete obj._id;
			delete obj._uid;
			delete obj.pkId;
		}
		return list;
	}


	</script>
	<rx:formScript formId="form1" baseUrl="bpm/core/bpmSolUsergroup"
		entityName="com.redxun.bpm.core.entity.BpmSolUsergroup" />
	
</body>
</html>