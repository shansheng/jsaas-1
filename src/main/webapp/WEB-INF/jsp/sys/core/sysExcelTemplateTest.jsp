<%-- 
    Document   : [Excel模板]文件上传测试页
    Created on : 2018-11-28 21:18:33
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[Excel模板]文件上传测试</title>
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
				<caption>Excel模板测试</caption>
				<tr>
					<th>
						<span class="starBox"> 模式名称
							<span class="star">*</span>
						</span>
					</th>
					<td>
						${template.templateName}
					</td>
				</tr>
				<tr>
					<th>文件上传</th>
					<td>
						<input type="file" id="excelTemplateFile" name="excelTemplateFile" accept=".xls,.xlsx" /> 
						<a class="mini-button" id="btnUpload" onclick="doUpload">上传测试</a>
					</td>
				</tr>
			</table>
	</div>

	<script type="text/javascript">
		mini.parse();
		var alias="${template.templateNameAlias}";
		
		function doUpload(e) {
			var btn=e.sender;
			btn.setEnabled(false);
			var files=document.getElementById("excelTemplateFile").files;
			if(files.length==0){
				alert("请选择文件!")
				return ;
			}
			var formData = new FormData();
			formData.append("alias",alias);
			formData.append("myfile", files[0]);
			$.ajax({
				url :__rootPath + "/sys/core/sysExcelTemplate/uploadTest.do",
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
				            message: "上传测试成功:["+result.data+"]",
				            showModal: false
				        });
						
					}
					else{
						top._ShowErr({
		            		content:result.message,
		            		data:result.data
		            	})
		            	e.sender.setEnabled(true);
					}
					
				},
				error : function(returndata) {
					console.info(returndata);
					e.sender.setEnabled(true);
				}
			});
		};
		
	</script>
</body>
</html>

