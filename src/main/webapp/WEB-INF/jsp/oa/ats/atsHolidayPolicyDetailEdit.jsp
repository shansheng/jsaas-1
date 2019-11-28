
<%-- 
    Document   : [假期制度明细]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[假期制度明细]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsHolidayPolicyDetail.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsHolidayPolicyDetail.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[假期制度明细]基本信息</caption>
					<tr>
						<th>假期制度ID：</th>
						<td>
							
								<input name="holidayId" value="${atsHolidayPolicyDetail.holidayId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>假期类型：</th>
						<td>
							
								<input name="holidayType" value="${atsHolidayPolicyDetail.holidayType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>假期单位：</th>
						<td>
							
								<input name="holidayUnit" value="${atsHolidayPolicyDetail.holidayUnit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>启动周期：</th>
						<td>
							
								<input name="enablePeriod" value="${atsHolidayPolicyDetail.enablePeriod}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>周期长度：</th>
						<td>
							
								<input name="periodLength" value="${atsHolidayPolicyDetail.periodLength}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>周期单位：</th>
						<td>
							
								<input name="periodUnit" value="${atsHolidayPolicyDetail.periodUnit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>控制单位额度：</th>
						<td>
							
								<input name="enableMinAmt" value="${atsHolidayPolicyDetail.enableMinAmt}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>单位额度：</th>
						<td>
							
								<input name="minAmt" value="${atsHolidayPolicyDetail.minAmt}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否允许补请假：</th>
						<td>
							
								<input name="isFillHoliday" value="${atsHolidayPolicyDetail.isFillHoliday}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>补请假期限：</th>
						<td>
							
								<input name="fillHoliday" value="${atsHolidayPolicyDetail.fillHoliday}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>补请假期限单位：</th>
						<td>
							
								<input name="fillHolidayUnit" value="${atsHolidayPolicyDetail.fillHolidayUnit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否允许销假：</th>
						<td>
							
								<input name="isCancelLeave" value="${atsHolidayPolicyDetail.isCancelLeave}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>销假期限：</th>
						<td>
							
								<input name="cancelLeave" value="${atsHolidayPolicyDetail.cancelLeave}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>销假期限单位：</th>
						<td>
							
								<input name="cancelLeaveUnit" value="${atsHolidayPolicyDetail.cancelLeaveUnit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否控制假期额度：</th>
						<td>
							
								<input name="isCtrlLimit" value="${atsHolidayPolicyDetail.isCtrlLimit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>假期额度规则：</th>
						<td>
							
								<input name="holidayRule" value="${atsHolidayPolicyDetail.holidayRule}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否允许超额请假：</th>
						<td>
							
								<input name="isOver" value="${atsHolidayPolicyDetail.isOver}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>超出额度下期扣减：</th>
						<td>
							
								<input name="isOverAutoSub" value="${atsHolidayPolicyDetail.isOverAutoSub}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>是否允许修改额度：</th>
						<td>
							
								<input name="isCanModifyLimit" value="${atsHolidayPolicyDetail.isCanModifyLimit}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>包括公休日：</th>
						<td>
							
								<input name="isIncludeRest" value="${atsHolidayPolicyDetail.isIncludeRest}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>包括法定假日：</th>
						<td>
							
								<input name="isIncludeLegal" value="${atsHolidayPolicyDetail.isIncludeLegal}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							
								<input name="memo" value="${atsHolidayPolicyDetail.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsHolidayPolicyDetail"
		entityName="com.redxun.oa.ats.entity.AtsHolidayPolicyDetail" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>