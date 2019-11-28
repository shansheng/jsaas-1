<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>红迅OA</title>
	<%@include file="/commons/dynamic.jspf" %>
	<script type="text/javascript" src="${ctxPath}/scripts/jquery-1.11.3.js"></script>
	<%--<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/css/indexMobile.css?t=10">--%>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/icon/iconfont.css?t=10">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/weixin/portal/css/index.css?t=3">
	<style type="text/css">
		body{
			background-color: #f4f4f4;
		}

	</style>
</head>
<body>
<div class="personalPort">
	<div class="contentHeaderBox">
		<div class="headerNav" style="margin-top:0;">
			<span class="headerIconLeft"><i class="iconfont icon-yonghu"></i></span>
			<span class="headerText">欢迎您：<span id="userSpan">${user.fullname}</span><input type="hidden" id="userId"/></span>
			<%--<span class="headerIconRight"><i class="iconfont icon-tixing1"></i><b></b></span>--%>
		</div>
	</div>
	<ul class="centerUl" id="centerUl">
		${html}
	</ul>
</div>

<script type="text/javascript" src="${ctxPath }/scripts/weixin/portal/js/indexMobile.js?t=1"></script>
</body>
</html>