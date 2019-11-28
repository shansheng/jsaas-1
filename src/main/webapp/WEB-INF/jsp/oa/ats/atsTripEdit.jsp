
<%-- 
    Document   : [考勤出差单]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤出差单]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsTrip.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsTrip.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤出差单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							
								<input name="userId" value="${atsTrip.userId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>出差类型：</th>
						<td>
							
								<input name="tripType" value="${atsTrip.tripType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							
								<input name="startTime" value="${atsTrip.startTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							
								<input name="endTime" value="${atsTrip.endTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>出差时间：</th>
						<td>
							
								<input name="tripTime" value="${atsTrip.tripTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							
								<input name="runId" value="${atsTrip.runId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsTrip"
		entityName="com.redxun.oa.ats.entity.AtsTrip" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>