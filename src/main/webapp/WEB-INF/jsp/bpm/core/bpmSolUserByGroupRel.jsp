<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>通过用户关系查找用户</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
			<div class="mini-toolbar topBtn mini-toolbar-bottom">
						<a class="mini-button" plain="true" onclick="ok">确定</a>
						<a class="mini-button btn-red"  plain="true" onclick="CloseWindow()">关闭</a>
			</div>
	</div>
	<div class="form-outer shadowBox90">
		<form id="vform">
			<table class="table-detail column_2" cellpadding="0" cellspacing="1" style="width:100%">
				
				<tbody>
				
					<tr>
						<td colspan="2">
							说明：通过用户来计算其对应关系的用户作为审批人。
						</td>
					</tr>
					<tr>
						<td width="200">用户</td>
						<td>
							<input id="userId" class="mini-combobox" name="userId" url="${ctxPath}/bpm/core/bpmSolVar/getBySolIdActDefId.do?solId=${param.solId}&actDefId=${param.actDefId}" 
							valueField="key" textField="name" style="width:90%" required="true"/>
						</td>
					</tr>
					<tr>
						<td>用户关系类型</td>
						<td>
							<input id="relTypeKey" class="mini-combobox" name="relTypeKey" url="${ctxPath}/sys/org/osRelType/getGroupUserRelations.do" 
							style="width:90%" required="true" 
							valueField="key" textField="name"/>
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
		var userId=mini.get('userId');
		
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
			form.setData(mini.decode(config));
		}

		function getConfigJson(){
			var userIdText=userId.getSelected().name;
			var relTypeText=relTypeKey.getSelected().name;
			var configDescp='用户来自['+userIdText+']的用户组关系['+relTypeText+']';
			return{
				config:form.getData(),
				configDescp:configDescp
			};
		}
	</script>
</body>
</html>