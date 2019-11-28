<%-- 
    Document   : [CalSetting]编辑页
    Created on : 2017-1-7, 10:11:48
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>日历设定编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="${calSetting.settingId}" />

	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<input id="pkId" name="settingId" class="mini-hidden" value="${calSetting.settingId}" />
			<table class="table-detail column-two" cellspacing="1" cellpadding="0">
				<tr>
					<td>
						日历名称<span class="star">*</span>
					</td>
					<td><input name="calName" value="${calSetting.calName}" required="true" class="mini-textbox" vtype="maxLength:64" style="width: 90%" />

					</td>
				</tr>
				<tr>
					<td>
						是否默认<span class="star">*</span>
					</td>
					<td>
						<input class="mini-radiobuttonlist"
							   name="isCommon"
							   required="true"
							   value="${calSetting.isCommon}"
							   data="[{'id':'YES','text':'是'},{'id':'NO','text':'否'}]"
							   textField="text"
							   valueField="id"
							   style="width: 90%" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/calendar/calSetting" entityName="com.redxun.oa.calendar.entity.CalSetting" />
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>