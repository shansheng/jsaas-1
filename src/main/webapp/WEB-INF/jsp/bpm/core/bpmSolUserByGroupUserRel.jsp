<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>通过用户关系查找用户</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div class="mini-toolbar topBtn mini-toolbar-bottom">
			<a class="mini-button"  plain="true" onclick="ok">确定</a>
			<a class="mini-button btn-red"  plain="true" onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<div class="form-outer shadowBox90">
		<form id="vform">
			<input id="groupText" name="groupText" class="mini-hidden" value="" />
			<table class="table-detail column_2" cellpadding="0" cellspacing="1" style="width:100%">
				<tbody>
					<tr>
						<td colspan="2">
							说明：用户组作为流程变量，可查找该组上的上级组与其对应关系的用户
						</td>
					</tr>
					<tr>
						<td width="200">用户组来自</td>
						<td>
							<div class="mini-radiobuttonlist" id="from" name="from" data="[{id:'var',text:'变量'},{id:'org',text:'用户组'},{id:'start-org',text:'发起人所在部门'},{id:'cur-org',text:'上一步审批人所在部门'}]" onvaluechanged="changeFrom" required="true"></div>
						</td>
					</tr>
					<tr id="tr_var" style="display:none">
						<td>变量</td>
						<td>
							<input id="groupVar" class="mini-combobox" name="groupVar" url="${ctxPath}/bpm/core/bpmSolVar/getBySolIdActDefId.do?solId=${param.solId}&actDefId=${param.actDefId}" 
								valueField="key" textField="name" style="width:90%" required="true"/>
						</td>
					</tr>
					<tr id="tr_org" style="display:none">
						<td>选择部门</td>
						<td>
							<input id="groupId" class="mini-buttonedit" allowinput="false" name="groupId" onbuttonclick="onButtonEdit" style="width:90%" required="true"/>
						</td>
					</tr>
					<tr>
						<td >上级部门</td>
						<td>
							<div  name="upperDep" class="mini-checkbox" checked="true" text="上级部门" ></div>	
						</td>
					</tr>
					<tr>
						<td>用户关系类型</td>
						<td>
							<input id="relTypeKey" class="mini-combobox" name="relTypeKey" url="${ctxPath}/sys/org/osRelType/getGroupUserRelations.do?dimId=1" 
							  required="true"  valueField="key" textField="name" style="width:60%;"/>
							<div id="chkUseRelation" name="useRelation" class="mini-checkbox" 
								checked="true" readOnly="false" text="使用关系" onvaluechanged="changeUserRelation"></div>
							
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var form=new mini.Form('vform');
		var relTypeKey=mini.get('relTypeKey');
		var party=mini.get('party');
		var from=mini.get('from');
		var groupId=mini.get('groupId');
		var groupVar=mini.get('groupVar');
		var useRelation=mini.get('chkUseRelation');
		
		
		//更改来源值
		function changeFrom(){
			var from=mini.get('from').getValue();
			if(from=='var'){
				$("#tr_var").css('display','');
				$("#tr_org").css('display','none');
			}else if(from=='org'){
				$("#tr_var").css('display','none');
				$("#tr_org").css('display','');
			}else{
				$("#tr_var").css('display','none');
				$("#tr_org").css('display','none');
			}
		}
		
		function changeUserRelation(e){
			relTypeKey.setRequired(e.sender.checked);
		}
		
		
		
		function ok(){
			form.validate();
			if(form.isValid()){
				CloseWindow('ok');
			}else{
				alert('请选择表单值!');
				return;
			}
		}

		function setData(config){
			if(!config){
				return;
			}
			var data=mini.decode(config);
			form.setData(data);
			changeFrom();
			groupId.setText(data.groupIdText);
			groupVar.setText(data.groupVarText);
		}

		function getConfigJson(){
			var groupIdText=groupId.getText();
			
			var configDescp='用户来自['+from.getSelected().text+']的用户组';
			if(useRelation.checked){
				var relTypeText=relTypeKey.getSelected().name;
				configDescp+=',关系名称['+relTypeText+']';	
			}
			
			var formData=form.getData();
			if(groupVar.getSelected()){
				formData.groupVarText=groupVar.getSelected().name;
			}
			formData.groupIdText=groupIdText;
			return{
				config:formData,
				configDescp:configDescp,
			};
		}
		
		function onButtonEdit(e){
			var btn=e.sender;
			var conf={single:true,showTenant:true,callback:function(data){
				btn.setText(data.name);
				btn.setValue(data.groupId);
				var tenantId=data.tenantId;
				var url=__rootPath + "/sys/org/osRelType/getGroupUserRelations.do?dimId=1&tenantId="+tenantId;
				relTypeKey.setUrl(url);
				
			}}
			_DepDialog(conf);
		}
	</script>
</body>
</html>