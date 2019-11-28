<%-- 
    Document   : 附件明细
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>附件明细</title>
<%@include file="/commons/get.jsp"%>
<!-- <style>body{height:100%;}</style> -->
</head>
<body>
	<div class="fitTop"></div>
	<div class="mini-fit">
		<div id="form1" class="form-container">
			<div>
				<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
					<caption>附件信息</caption>
					<tr>
						<td style="width:15% !important;">附件名称</td>
						<td colspan="3"><a href="${ctxPath}/sys/core/file/previewFile.do?fileId=${sysFile.fileId}">${sysFile.fileName}</a></td>
					</tr>
					<tr>
						<td>上 传 人</td>
						<td><rxc:userLabel userId="${sysFile.createBy}" /></td>
						<td style="width:15% !important;">上传时间</td>
						<td><fmt:formatDate value="${sysFile.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					</tr>
					<tr>
						<td>文件大小</td>
						<td colspan="3">${sysFile.sizeFormat}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>