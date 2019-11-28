
<%-- 
    Document   : [排班列表]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[排班列表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsScheduleShift.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsScheduleShift.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[排班列表]基本信息</caption>
					<tr>
						<th>考勤用户ID：</th>
						<td>
							
								<input name="fileId" value="${atsScheduleShift.fileId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>考勤日期：</th>
						<td>
							
								<input name="attenceTime" value="${atsScheduleShift.attenceTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>日期类型：</th>
						<td>
							
								<input name="dateType" value="${atsScheduleShift.dateType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>班次ID：</th>
						<td>
							
								<input name="shiftId" value="${atsScheduleShift.shiftId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>标题：</th>
						<td>
							
								<input name="title" value="${atsScheduleShift.title}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsScheduleShift"
		entityName="com.redxun.oa.ats.entity.AtsScheduleShift" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>