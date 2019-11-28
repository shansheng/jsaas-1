
<%-- 
    Document   : [班次时间设置]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[班次时间设置]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsShiftTime.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsShiftTime.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[班次时间设置]基本信息</caption>
					<tr>
						<th>班次ID：</th>
						<td>
							
								<input name="shiftId" value="${atsShiftTime.shiftId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>段次：</th>
						<td>
							
								<input name="segment" value="${atsShiftTime.segment}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>出勤类型：</th>
						<td>
							
								<input name="attendanceType" value="${atsShiftTime.attendanceType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>上班时间：</th>
						<td>
							
								<input name="onTime" value="${atsShiftTime.onTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>上班是否打卡：</th>
						<td>
							
								<input name="onPunchCard" value="${atsShiftTime.onPunchCard}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>上班浮动调整值（分）：</th>
						<td>
							
								<input name="onFloatAdjust" value="${atsShiftTime.onFloatAdjust}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>段内休息时间：</th>
						<td>
							
								<input name="segmentRest" value="${atsShiftTime.segmentRest}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>下班时间：</th>
						<td>
							
								<input name="offTime" value="${atsShiftTime.offTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>下班是否打卡：</th>
						<td>
							
								<input name="offPunchCard" value="${atsShiftTime.offPunchCard}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>下班浮动调整值（分）：</th>
						<td>
							
								<input name="offFloatAdjust" value="${atsShiftTime.offFloatAdjust}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>上班类型：</th>
						<td>
							
								<input name="onType" value="${atsShiftTime.onType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>下班类型：</th>
						<td>
							
								<input name="offType" value="${atsShiftTime.offType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsShiftTime"
		entityName="com.redxun.oa.ats.entity.AtsShiftTime" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>