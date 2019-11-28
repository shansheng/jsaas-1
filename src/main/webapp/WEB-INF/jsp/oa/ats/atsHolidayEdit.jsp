
<%-- 
    Document   : [考勤请假单]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤请假单]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsHoliday.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsHoliday.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤请假单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							
								<input name="userId" value="${atsHoliday.userId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>请假类型：</th>
						<td>
							
								<input name="holidayType" value="${atsHoliday.holidayType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							
								<input name="startTime" value="${atsHoliday.startTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							
								<input name="endTime" value="${atsHoliday.endTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>请假时间：</th>
						<td>
							
								<input name="holidayTime" value="${atsHoliday.holidayTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>时间长度：</th>
						<td>
							
								<input name="duration" value="${atsHoliday.duration}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							
								<input name="runId" value="${atsHoliday.runId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsHoliday"
		entityName="com.redxun.oa.ats.entity.AtsHoliday" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>