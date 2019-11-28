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
	<div class="topToolBar" >
		<div>
	    	<a class="mini-button"  plain="true" onclick="saveForm()">保存</a>
		</div>
    </div>
	<div class="mini-fit">
	<div class="form-container" >
		<form id="form1" method="post" >
			<table class="table-detail column-four" cellspacing="1" cellpadding="0" border="2">
				<tr>
					<td>
						分　　类<span class="star">*</span>
					</td>
					<td colspan="3">
						<input id="pkId" name="viewId" class="mini-hidden" value="${bpmFormView.viewId}" />
						<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_FORM_VIEW" 
							   multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" value="${bpmFormView.treeId}"
							   showFolderCheckBox="false"
							   expandOnLoad="true" showClose="true"
							   oncloseclick="onClearTree" popupWidth="" style="width:245px"/>
					</td>
				</tr>
				<tr>
					<td>
						名　　称 <span class="star">*</span>
					</td>
					<td>
						<input name="name" value="${bpmFormView.name}" class="mini-textbox"
							   vtype="maxLength:255" style="width: 100%" required="true" emptyText="请输入名称" />
					</td>
				
					<td>
						标  识  键 <span class="star">*</span>
					</td>
					<td>
						<input name="key"
							   value="${bpmFormView.key}" class="mini-textbox"
							   vtype="key,maxLength:100"
							   style="width: 100%"
							   required="true"
							   emptyText="请输入标识键"
						/>
					</td>
				</tr>
				<tr>
					<td>
						表单地址<span class="star">*</span>
					</td>
					<td colspan="3">
						<input name="renderUrl"
							   value="${bpmFormView.renderUrl}"
							   class="mini-textbox" vtype="key,maxLength:100"
							   style="width: 100%"
							   required="true" emptyText="请输入表单URL" />
					</td>
				</tr>
				<tr>
					<td>视图说明 </td>
					<td colspan="3">
						<input name="isMain" class="mini-hidden"   value="YES" />
						<input name="version" class="mini-hidden"   value="1" />
						<input name="type" class="mini-hidden"   value="SEL-DEV" />
						<input name="status" class="mini-hidden"   value="DEPLOYED" />
						<textarea name="descp" class="mini-textarea"  style="width:100%;" >${bpmFormView.descp}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</div>
	
	<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView" entityName="com.redxun.bpm.form.entity.BpmFormView" />
	<script type="text/javascript">
		addBody();
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