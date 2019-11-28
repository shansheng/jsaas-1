<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
							说明：通过用户往上查找对应的符合等级的部门及其下
						
						</td>
					</tr>
					<tr>
						<td>审批人来源</td>
						<td>
							<input id="userType" name="userType" class="mini-radiobuttonlist" value="start" data="[{id:'start',text:'发起人'},{id:'cur',text:'上一步审批人'}]" 
								showNullItem="true" nullItemText="请选择..." required="true"
								textField="text" valueField="id" />
						</td>
					</tr>
					<tr>
						<td>用户组等级</td>
						<td>
							<input id="rankLevel" name="rankLevel" class="mini-combobox" url="${ctxPath}/sys/org/osRankType/listByDimId.do?dimId=1" 
							showNullItem="true" nullItemText="请选择..." required="true"
							textField="name" valueField="level" />
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
		var rankLevel=mini.get('rankLevel');
		var userType=mini.get('userType');
		
		
		
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
			var type=userType.getSelected().text;
			var rankType=rankLevel.getSelected().name;
			var relTypeText=relTypeKey.getSelected().name;
			var configDescp='用户来自['+ type +']往上查找符合等级('+rankType+')的用户组的关系['+relTypeText+']用户';
			return{
				config:form.getData(),
				configDescp:configDescp,
			};
		}
	</script>
</body>
</html>