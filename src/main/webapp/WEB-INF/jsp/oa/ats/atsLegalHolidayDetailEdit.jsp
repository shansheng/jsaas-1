
<%-- 
    Document   : [法定节假日明细]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[法定节假日明细]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsLegalHolidayDetail.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsLegalHolidayDetail.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[法定节假日明细]基本信息</caption>
					<tr>
						<th>法定假日：</th>
						<td>
							
								<input name="holidayId" value="${atsLegalHolidayDetail.holidayId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>假日名称：</th>
						<td>
							
								<input name="name" value="${atsLegalHolidayDetail.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							
								<input name="startTime" value="${atsLegalHolidayDetail.startTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							
								<input name="endTime" value="${atsLegalHolidayDetail.endTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							
								<input name="memo" value="${atsLegalHolidayDetail.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsLegalHolidayDetail"
		entityName="com.redxun.oa.ats.entity.AtsLegalHolidayDetail" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>