
<%-- 
    Document   : [工作日历]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[工作日历]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsWorkCalendar.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsWorkCalendar.id}" />
				<table class="table-detail column_2" cellspacing="1" cellpadding="0">
					<caption>[工作日历]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsWorkCalendar.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsWorkCalendar.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>开始时间：</td>
						<td>
							
								<input name="startTime" value="${atsWorkCalendar.startTime}"
							class="mini-datepicker"  format="yyyy-MM-dd" />
						</td>
						<td>结束时间：</td>
						<td>
							
								<input name="endTime" value="${atsWorkCalendar.endTime}"
							class="mini-datepicker"   format="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td>日历模版：</td>
						<td>
						<input id="calendarTempl" name="calendarTempl" class="mini-buttonedit" 
						value="${atsWorkCalendar.calendarTempl}" text="${atsWorkCalendar.calendarTemplName}" 
						required="true" allowInput="false" onbuttonclick="onSelCalendarTempl"/>
						</td>
						<td>法定假期：</td>
						<td>
						<input id="legalHoliday" name="legalHoliday" class="mini-buttonedit" 
						value="${atsWorkCalendar.legalHoliday}" text="${atsWorkCalendar.legalHolidayName}" 
						required="true" allowInput="false" onbuttonclick="onSelLegalHoliday"/>
						</td>
					</tr>
					<tr>
						<td>是否默认：</td>
						<td>
							<input value="${atsWorkCalendar.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsWorkCalendar.isDefault}" />
						</td>
						<td>描述：</td>
						<td>
							
								<input name="memo" value="${atsWorkCalendar.memo}"
							class="mini-textbox"  trueValue="1" falseValue="0" style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsWorkCalendar"
		entityName="com.redxun.oa.ats.entity.AtsWorkCalendar" />
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	
	//设置是否默认
	function onIsDefaultvaluechanged(e){
		var is = mini.get("isDefault");
		is.setValue(this.getChecked()==true?1:0);
	}
	
	//显示对话框
	function onSelDialog(e,url,title){
		var btnEdit=e.sender;
		mini.open({
			url : url,
			title : title,
			width : 650,
			height : 380,
			ondestroy : function(action) {
				if (action == "ok") {
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						btnEdit.setValue(data.id);
						btnEdit.setText(data.name);
					}
				}
			}
		});
	}
	
	
	
	
	</script>
</body>
</html>