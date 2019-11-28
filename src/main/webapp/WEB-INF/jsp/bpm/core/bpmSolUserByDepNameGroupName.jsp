<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<!DOCTYPE html>
<html>
<head>
<title>查找用户所在部门下的用户组的用户</title>
<%@include file="/commons/edit.jsp" %>
</head>
<body>
	<div class="topToolBar">
			<div class="mini-toolbar topBtn mini-toolbar-bottom">
							<a class="mini-button"  plain="true" onclick="ok">确定</a>
							<a class="mini-button btn-red" plain="true" onclick="CloseWindow()">关闭</a>
						
			</div>
		</div>
		
		<div  class="form-outer shadowBox90">
			<form id="vform">
				<table class="table-detail column_2" cellpadding="0" cellspacing="1" style="width:100%">
					<tbody>
						<tr>
							<td colspan="2">
								说明：查找某个部门下的用户组下的用户
							</td>
						</tr>
						<tr>
							<th width="150">部门值来自</th>
							<td>
								<div class="mini-radiobuttonlist" id="from" name="from" onvaluechanged="depChanged" required="true" data="[{id:'var',text:'变量'},{id:'def',text:'固定值'}]"/>
							</td>
						</tr>
						<tr id="depRow" style="display:none">
							<th>部门变量值</th>
							<td>
								<input id="depName1" class="mini-combobox" name="depName" 
									url="${ctxPath}/bpm/core/bpmSolVar/getBySolIdActDefId.do?solId=${param.solId}&actDefId=${param.actDefId}" 
									valueField="key" textField="name" style="width:80%" required="true"/>
							</td>
						</tr>
						<tr id="dep2Row" style="display:none">
							<th>部门名</th>
							<td>
								<input id="depName2" class="mini-textbox" name="depName" style="width:60%;"/>
							</td>
						</tr>
						<tr >
							<th width="150">组名</th>
							<td>
								<input id="groupName" class="mini-textbox" name="groupName" required="true" style="width:60%;" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var form=new mini.Form('vform');
		
		function depChanged(e){
			var s=mini.get('from');
			
			if(s.getValue()=='var'){
				$("#depRow").css('display','');
				$("#dep2Row").css('display','none');
			}else{
				$("#depRow").css('display','none');
				$("#dep2Row").css('display','');
			}
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
			
			depChanged();
			if(data.from=='var'){
				mini.get('depName1').setValue(data.depName);
			}else{
				mini.get('depName2').setValue(data.depName);
			}
			
		}

		function getConfigJson(){
			var from=mini.get('from').getValue();
			var dName=null;
			var depName=null;
			if(from=='var'){
				dName='变量['+mini.get('depName1').getText()+']';
				depName=mini.get('depName1').getValue();
			}else{
				dName=mini.get('depName2').getValue();
				depName=dName;
			}
			
			var groupName=mini.get('groupName').getValue();
			var configDescp='部门('+depName+')下的用户组['+groupName+']的用户';
			
			var formData=form.getData();
			formData.depName=depName;
			
			return{
				config:formData,
				configDescp:configDescp,
			};
		}
		
		
	</script>
</body>
</html>