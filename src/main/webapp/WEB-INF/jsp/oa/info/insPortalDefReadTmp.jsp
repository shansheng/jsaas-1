<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@include file="/commons/dynamic.jspf" %>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的门户[预览]</title>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/icons.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/layoutitIndex.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/layout.css">

	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts-wordcloud.min.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/mini/miniui/miniui.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/share.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/layoutit/js/layoutitIndex.js"></script>
	
	<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=FB14a133b9bf40fec90d36c84fb4dd13"></script>
	
	<link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/jquery.gridster.min.css">
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.gridster.min.js"></script>
	
	<script src="${ctxPath}/scripts/mini/miniui/miniui.js" type="text/javascript" ></script>
	<link href="${ctxPath}/scripts/mini/miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />
	<script src="${ctxPath}/scripts/common/baiduTemplate.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/customer/mini-custom.js" type="text/javascript"></script>
	<%@include file="/WEB-INF/jsp/sys/echarts/echartsTheme.jsp"%>
	<link  href="${ctxPath}/styles/commons.css" rel="stylesheet" type="text/css" />
	<script src="${ctxPath}/scripts/sys/echarts/echartsFrontCustom.js?t=1.5.137" type="text/javascript"></script>
	<style>
		.etable-cond-f-span{display:inline-block;font-size:14px;min-width:80px;
				text-align:right;box-sizing:border-box;vertical-align:middle;color:#999;}
	</style>
</head>
<body>
	<div class="personalPort">${html}</div>
	<script type="text/javascript">
		$(function(){
			handData();
		})
	</script>
</body>
</html>
