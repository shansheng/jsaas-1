<%-- 
    Document   : 附件移动归类
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>附件明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" onclick="moveFolder()" plain="true">确 定</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container" >
			<form id="fileForm">
				<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
					<c:if test="${not empty sysFile }">
					<caption>附件信息</caption>
					<tr>
						<td>附件名称</td>
						<td colspan="3"><a href="${ctxPath}/sys/core/file/previewFile.do?fileId=${sysFile.fileId}">${sysFile.fileName}</a></td>
					</tr>
					<tr>
						<td>上 传 人 </td>
						<td><rxc:userLabel userId="${sysFile.createBy}" /></td>
						<td>上传时间 </td>
						<td><fmt:formatDate value="${sysFile.createTime}" /> </td>
					</tr>
					<tr>
						<td>文件大小</td>
						<td colspan="3">${sysFile.sizeFormat}</td>
					</tr>
					</c:if>
					<tr>
						<td>
							<span class="starBox">
								移动目录<span class="star">*</span>
							</span>
						</td>
						<td colspan="3">
							 <input class="mini-hidden" name="fileId" value="${sysFile.fileId}"/>
							 <input class="mini-hidden" name="fileIds" value="${fileIds}"/>
							 <input
								id="folderTree"
								name="treeId"
								class="mini-treeselect"
								url="${ctxPath}/sys/core/sysTree/myFileFolder.do"
								multiSelect="false"
								valueFromSelect="false"
								textField="name"
								valueField="treeId"
								parentField="parentId"
								onbeforenodeselect="disableSelectRoot"
								expandOnLoad="true"
								required="true"
								allowInput="false"
								showRadioButton="true"
								showFolderCheckBox="false"
								style="width:300px;"
								popupHeight="150"
							/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function disableSelectRoot(e){
			if(e.node.treeId==0){
				e.cancel=true;
			}
		}
		
		//移动目录
		function moveFolder(){
			var form=new mini.Form('fileForm');
			form.validate();
			if(!form.isValid()) {
				return;
			}
			_SubmitJson({
				url:__rootPath+'/sys/core/sysFile/saveFolder.do',
				data:form.getData(),
				success:function(action){
					CloseWindow('ok');
				}
			});
		};
		addBody();
		
	</script>
	
</body>
</html>