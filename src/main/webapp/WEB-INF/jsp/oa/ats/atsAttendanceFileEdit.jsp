
<%-- 
    Document   : [考勤档案]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤档案]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttendanceFile.id" />
	<div class="mini-fit">
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttendanceFile.id}" />
				<table class="table-detail column_2" cellspacing="1" cellpadding="0">
					<caption>[考勤档案]基本信息</caption>
					<tr>
						<td>用户：</td>
						<td>
							<input id="userId" name="userId" class="mini-buttonedit icon-dep-button" value="${atsAttendanceFile.userId}" 
						text="${atsAttendanceFile.userName}" required="true" allowInput="false" onbuttonclick="onSelectUser"/>
						</td>
						<td>考勤卡号：</td>
						<td>
							
								<input name="cardNumber" value="${atsAttendanceFile.cardNumber}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>是否参与考勤：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="isAttendance"
							data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
							value="${atsAttendanceFile.isAttendance}"
							style="width: 90%"
						/>
						</td>
						<td>考勤制度：</td>
						<td>
							<input name="attencePolicy" class="mini-buttonedit icon-dep-button" value="${atsAttendanceFile.attencePolicy}" 
						text="${atsAttendanceFile.attencePolicyName}" required="true" allowInput="false" onbuttonclick="onSelAttencePolicy"/>
						</td>
					</tr>
					<tr>
						<td>假期制度：</td>
						<td>
							<input name="holidayPolicy" class="mini-buttonedit icon-dep-button" value="${atsAttendanceFile.holidayPolicy}" 
						text="${atsAttendanceFile.holidayPolicyName}" required="true" allowInput="false" onbuttonclick="onSelHolidayPolicy"/>
						</td>
						<td>默认班次：</td>
						<td>
							<input name="defaultShift" class="mini-buttonedit icon-dep-button" value="${atsAttendanceFile.defaultShift}" 
						text="${atsAttendanceFile.defaultShiftName}" required="true" allowInput="false" onbuttonclick="onSelShiftInfo"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsAttendanceFile"
		entityName="com.redxun.oa.ats.entity.AtsAttendanceFile" />
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	
	function onSelectUser(){
		_TenantUserDlg(tenantId,true,function(user){
			var userIdEdit=mini.get('userId');
			if(user){
				userIdEdit.setValue(user.userId);
				userIdEdit.setText(user.fullname);
			}
		});
	}
	

	</script>
</body>
</html>