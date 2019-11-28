<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>流水号导入</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="doNext">下一步</a>
			<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<form id="zipForm" action="${ctxPath}/sys/core/sysDataSource/importDirect.do" method="post" enctype="multipart/form-data">
		<table cellpadding="0" cellspacing="0" class="table-detail column_2_m" style="padding:6px;">
			<caption>第一步：上传压缩文件</caption>
			<tr>
				<td>
					ZIP文件
				</td>
    			<td>
    				<input id="zipFile" type="file" name="zipFile"/>
    			</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		mini.parse();
		function doNext(){
			var file=document.getElementById("zipFile");
    		if(file.value==''){
    			alert('请上传业务列表的压缩文件！');
    			return;
    		}
    		$("#zipForm").submit();
		}
	</script>
</body>
</html>