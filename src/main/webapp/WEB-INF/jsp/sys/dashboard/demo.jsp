<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>大屏管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
    <link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/jquery.gridster.min.css">
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.gridster.min.js"></script>
	
	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts-wordcloud.min.js"></script>
    <%@include file="/WEB-INF/jsp/sys/echarts/echartsTheme.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/layoutit/js/layoutitIndex.js"></script>
	<script src="${ctxPath}/scripts/sys/echarts/echartsFrontCustom.js?t=1.5.137" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/sys/echarts/dashboard.js?t=1.5.137" type="text/javascript"></script>
	
</head>
<body>
	<div class="personalPort" style="width:100%;height:100%;"></div>
<script type="text/javascript">


    $(function(){
    	var url = '${ctxPath}/sys/dashboard/singleDashboard/WWZL.do';
        $.post(url, function(data){
        	$(".personalPort").html(data.html);
			handData();
        });
    });

</script>
</body>
</html>