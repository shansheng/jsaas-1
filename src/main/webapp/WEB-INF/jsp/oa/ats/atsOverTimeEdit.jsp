
<%-- 
    Document   : [考勤加班单]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤加班单]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsOverTime.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsOverTime.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤加班单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							
								<input name="userId" value="${atsOverTime.userId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>加班类型：</th>
						<td>
							
								<input name="otType" value="${atsOverTime.otType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							
								<input name="startTime" value="${atsOverTime.startTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							
								<input name="endTime" value="${atsOverTime.endTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>加班时间：</th>
						<td>
							
								<input name="otTime" value="${atsOverTime.otTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>加班补偿方式：</th>
						<td>
							
								<input name="otCompens" value="${atsOverTime.otCompens}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							
								<input name="runId" value="${atsOverTime.runId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsOverTime"
		entityName="com.redxun.oa.ats.entity.AtsOverTime" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>