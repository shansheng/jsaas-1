<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>我的考勤结果</title>
<!-- 引入日历插件 -->
<%@include file="/commons/edit.jsp"%>
<link href='${ctxPath}/scripts/FullCalender/fullcalendar.css' rel='stylesheet' />
<link href='${ctxPath}/scripts/FullCalender/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='${ctxPath}/scripts/FullCalender/moment.min.js'></script>
<script src='${ctxPath}/scripts/FullCalender/fullcalendar.min.js'></script>
<script src='${ctxPath}/scripts/FullCalender/lang-all.js'></script>
<script src='${ctxPath}/scripts/ats/atsMyResult.js'></script>
<link href='${ctxPath}/scripts/ats/atsMyResult.css' rel='stylesheet' />
<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip-blue.css" />
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip.min.js"></script>
</head>
<body>
		<!-- 日历式排班 -->
		<div id="scheduleCalendar">
			<div class="col-md-3">
			  	<div  id="userlist" class="user-list"> </div>
			</div>
			 <div class="col-md-9">
			  	<div id ="calendarScheduleInfo" class="calendar-info">
		           <div id="calendar_info" ></div>
			 	</div>
		  	</div>
		</div>
</body>
</html>