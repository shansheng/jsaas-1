<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>预览图片</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/commons/dynamic.jspf" %>
    <style type="text/css">
	    .mini-office .mini-panel-footer{
			word-break:break-all !important;
		}
		html,body{
			height: 100%;
			width: 100%;
		}
    </style>
</head>
<body> 
	<div style="width:100%;text-align:center;">
		<div style="margin:auto;">
			<img src="${ctxPath}/sys/core/file/previewImage.do?fileId=${param.fileId}"/>
		</div>
	</div>
</body>
</html>
