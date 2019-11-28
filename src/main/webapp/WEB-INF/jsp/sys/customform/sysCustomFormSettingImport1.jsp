<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>表单方案导入</title>
<%@include file="/commons/edit.jsp"%>
<style>
	#loading{text-indent:10px;line-height:30px;color:red;}

</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="doNext">下一步</a>
			<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
	<div class="form-container">
	<form id="zipForm" action="${ctxPath}/sys/customform/sysCustomFormSetting/importFormsJsonZip.do" method="post" enctype="multipart/form-data">
		<table cellpadding="0" cellspacing="0" class="table-detail column-two" >
			<caption>上传表单方案的压缩文件</caption>
			<tr>
				<td>
					表单方案的ZIP文件
				</td>
    			<td>
    				<input id="zipFile" type="file" name="zipFile"/>
    			</td>
			</tr>
		</table>
	</form>
	</div>

	<p id="loading"></p>
	</div>
	<script type="text/javascript">
		mini.parse();
		function doNext(){
			var file=document.getElementById("zipFile");
    		if(file.value==''){
    			alert('请上传表单方案的压缩文件！');
    			return;
    		}
    		$("#loading").text("数据正在导入中，请稍后...")
    		$("#zipForm").submit();
		}
	</script>
</body>
</html>