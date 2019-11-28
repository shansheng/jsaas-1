<%-- 
    Document   : [Excel模板]文件上传测试页
    Created on : 2018-11-28 21:18:33
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[Excel模板]文件上传</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar" >
		<div>
			<a class="mini-button" 
				plain="true"
				onclick="CloseWindow('ok')" 
				style="margin-right: 10; font-size: 20">关闭</a>
		</div>
		
	</div>
	<div id="p1" class="shadowBox form-outer"
		style="width: 100%; ">
			<input id="pkId" name="id" class="mini-hidden" value="${param.pkId}" /> 
			<table class="table-detail" cellspacing="1" cellpadding="0">
				<caption>Excel模板</caption>
				<tr>
					<td>
						<span class="starBox"> 模式名称
							<span class="star">*</span>
						</span>
					</td>
					<td>
						${template.templateName}
					</td>
				</tr>
				<tr>
					<td>文件上传</td>
					<td>
						<input type="file" id="excelTemplateFile" name="excelTemplateFile" accept=".xls,.xlsx" /> 
						<a class="mini-button" id="btnUpload" onclick="doUpload">上传</a>
					</td>
				</tr>
			</table>
	</div>

	<script type="text/javascript">
		mini.parse();
		var alias="${template.templateNameAlias}";
		
		function doUpload(e) {
			var files=document.getElementById("excelTemplateFile").files;
			if(files.length==0){
				alert("请选择文件!")
				return ;
			}
			var formData = new FormData();
			formData.append("alias",alias);
			formData.append("myfile", files[0]);
			$.ajax({
				url :__rootPath + "/sys/core/sysExcelTemplate/uploadExcel.do",
				type : 'POST',
		        contentType:false,
		        processData:false,
				data : formData,
				success : function(result) {
					if(result.success){
						mini.showMessageBox({
				            width: 250,
				            title: "提示信息",
				            buttons: ["ok"],
				            message: "上传成功:["+result.data+"]",
				            showModal: false
				        });
						
					}
					else{
						mini.showMessageBox({
							width: 250,
							title: "提示信息",
							buttons: ["ok"],
							message: "上传失败:["+result.data+"]",
							showModal: false
						});
					}
					
				},
				error : function(returndata) {
					mini.showMessageBox({
						width: 250,
						title: "提示信息",
						buttons: ["ok"],
						message: "上传失败:["+result.data+"]",
						showModal: false
					});
				}
			});
		};
		
	</script>
</body>
</html>

