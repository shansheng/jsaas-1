
<%-- 
    Document   : [考勤计算]编辑页
    Created on : 2018-03-28 15:47:59
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤计算]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttenceCalculate.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttenceCalculate.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤计算]基本信息</caption>
					<tr>
						<th>考勤档案：</th>
						<td>
							
								<input name="fileId" value="${atsAttenceCalculate.fileId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>考勤日期：</th>
						<td>
							
								<input name="attenceTime" value="${atsAttenceCalculate.attenceTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<th>是否排班：</th>
						<td>
							
								<input name="isScheduleShift" value="${atsAttenceCalculate.isScheduleShift}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>日期类型：</th>
						<td>
							
								<input name="dateType" value="${atsAttenceCalculate.dateType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>假期名称：</th>
						<td>
							
								<input name="holidayName" value="${atsAttenceCalculate.holidayName}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否有打卡记录：</th>
						<td>
							
								<input name="isCardRecord" value="${atsAttenceCalculate.isCardRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>考勤时间：</th>
						<td>
							
								<input name="shiftTime" value="${atsAttenceCalculate.shiftTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>应出勤时数：</th>
						<td>
							
								<input name="shouldAttenceHours" value="${atsAttenceCalculate.shouldAttenceHours}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>实际出勤时数：</th>
						<td>
							
								<input name="actualAttenceHours" value="${atsAttenceCalculate.actualAttenceHours}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>有效打卡记录：</th>
						<td>
							
								<input name="cardRecord" value="${atsAttenceCalculate.cardRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>旷工次数：</th>
						<td>
							
								<input name="absentNumber" value="${atsAttenceCalculate.absentNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>旷工小时数：</th>
						<td>
							
								<input name="absentTime" value="${atsAttenceCalculate.absentTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>旷工记录：</th>
						<td>
							
								<input name="absentRecord" value="${atsAttenceCalculate.absentRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>迟到次数：</th>
						<td>
							
								<input name="lateNumber" value="${atsAttenceCalculate.lateNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>迟到分钟数：</th>
						<td>
							
								<input name="lateTime" value="${atsAttenceCalculate.lateTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>迟到记录：</th>
						<td>
							
								<input name="lateRecord" value="${atsAttenceCalculate.lateRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>早退次数：</th>
						<td>
							
								<input name="leaveNumber" value="${atsAttenceCalculate.leaveNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>早退分钟数：</th>
						<td>
							
								<input name="leaveTime" value="${atsAttenceCalculate.leaveTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>早退记录：</th>
						<td>
							
								<input name="leaveRecord" value="${atsAttenceCalculate.leaveRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>加班次数：</th>
						<td>
							
								<input name="otNumber" value="${atsAttenceCalculate.otNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>加班分钟数：</th>
						<td>
							
								<input name="otTime" value="${atsAttenceCalculate.otTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>加班记录：</th>
						<td>
							
								<input name="otRecord" value="${atsAttenceCalculate.otRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>请假次数：</th>
						<td>
							
								<input name="holidayNumber" value="${atsAttenceCalculate.holidayNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>请假分钟数：</th>
						<td>
							
								<input name="holidayTime" value="${atsAttenceCalculate.holidayTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>请假时间单位：</th>
						<td>
							
								<input name="holidayUnit" value="${atsAttenceCalculate.holidayUnit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>请假记录：</th>
						<td>
							
								<input name="holidayRecord" value="${atsAttenceCalculate.holidayRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>出差次数：</th>
						<td>
							
								<input name="tripNumber" value="${atsAttenceCalculate.tripNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>出差分钟数：</th>
						<td>
							
								<input name="tripTime" value="${atsAttenceCalculate.tripTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>出差记录：</th>
						<td>
							
								<input name="tripRecord" value="${atsAttenceCalculate.tripRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>有效打卡记录：</th>
						<td>
							
								<input name="validCardRecord" value="${atsAttenceCalculate.validCardRecord}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>考勤类型：</th>
						<td>
							
								<input name="attenceType" value="${atsAttenceCalculate.attenceType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>班次：</th>
						<td>
							
								<input name="shiftId" value="${atsAttenceCalculate.shiftId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>ABNORMITY：</th>
						<td>
							
								<input name="abnormity" value="${atsAttenceCalculate.abnormity}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsAttenceCalculate"
		entityName="com.redxun.oa.ats.entity.AtsAttenceCalculate" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>