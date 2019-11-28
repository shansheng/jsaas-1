
<%-- 
    Document   : [office模板]编辑页
    Created on : 2018-01-28 11:11:47
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[office模板]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>

<rx:toolbar toolbarId="toolbar1" pkId="sysOfficeTemplate.id" />

<div class="mini-fit">
<div class="form-container">
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${sysOfficeTemplate.id}" />
				<table class="table-detail column-two" id="Mtable" cellspacing="1" cellpadding="0">
					<caption>[office模板]基本信息</caption>
					<tr>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${sysOfficeTemplate.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>类型：</td>
						<td>
							<input class="mini-combobox" name="type" 
											 emptyText="请选择..."
								   style="width: 90%;"
											 data="[{id:'normal',text:'普通模板'},{id:'red',text:'套红模板'}]"
											 value="${sysOfficeTemplate.type}"/>
								
						</td>
					</tr>
					
					<tr>
						<td>文件名：</td>
						<td>
							<input name="docId" textName="docName" 
								value="${sysOfficeTemplate.docId}"
								text="${sysOfficeTemplate.docName}"
							class="mini-buttonedit"   showClose="true"
							style="width: 90%;"
							oncloseclick="_ClearButtonEdit"
							 onbuttonclick="onButtonEdit" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td>
							
								<input name="description" value="${sysOfficeTemplate.description}"
							class="mini-textarea"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/core/sysOfficeTemplate"
		entityName="com.redxun.sys.core.entity.SysOfficeTemplate" />
</div>
</div>
	<script type="text/javascript">
	mini.parse();
	
	function onButtonEdit(e){
		var ctl=e.sender;
		_UploadDialogShowFile({
			from:'SELF',
			types:"Document",
			single:true,
			onlyOne:true,
			sizelimit:50,
			showMgr:false,
			callback:function(files){
				if(files && files.length>0){
					var file=files[0];
					ctl.setValue(file.fileId);
					ctl.setText(file.fileName);
				}
				
			}
		});
	}
	
	</script>
</body>
</html>