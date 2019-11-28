<%-- 
    Document   : 业务表单视图编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>业务表单视图编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<div  class="topToolBar" >
	<div>
		<a class="mini-button btn-red" plain="true" onclick="onCancel">关闭</a>
	</div>
</div>
<div class="mini-fit">
<div class="form-container">
	<form id="form1" method="post" class="form-outer">
		<table class="table-detail column-two" cellspacing="1" cellpadding="0" border="2">
			<tr>
				<td>分类 </td>
				<td>
					<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_FORM_VIEW" 
					 	multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" value="${bpmFormView.treeId}"
				        showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="onClearTree" popupWidth="300" style="width:300px"/>
				</td>
			</tr>
			<tr>
				<td>名称 <span class="star">*</span> </td>
				<td>
					${bpmFormView.name}
				</td>
			</tr>
			<tr>
				<td>标识键 <span class="star">*</span> </td>
				<td>
					${bpmFormView.key}
				</td>
			</tr>
			<tr>
				<td>表单地址 <span class="star">*</span> </td>
				<td>
					${bpmFormView.renderUrl}
				</td>
			</tr>
			<tr>
				<td>视图说明 </td>
				<td>
					${bpmFormView.descp}
				</td>
			</tr>
		</table>
	</form>
		
	
	<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView" entityName="com.redxun.bpm.form.entity.BpmFormView" />
</div>
</div>
	<script type="text/javascript">
		function saveForm(){
			var url=__rootPath+'/bpm/form/bpmFormView/saveUrlForm.do';
			_SaveJson("form1",url,function(data){
				if(data.success){
					CloseWindow("ok") ;
				}
			}) 
		}
		
	</script>
</body>
</html>