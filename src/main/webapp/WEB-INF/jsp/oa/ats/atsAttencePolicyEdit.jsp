
<%-- 
    Document   : [考勤制度]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤制度]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttencePolicy.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttencePolicy.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[考勤制度]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							<input name="code" value="${atsAttencePolicy.code}"
							class="mini-textbox"   style="width: 100%" />
						</td>
						<td>名称：</td>
						<td>
							<input name="name" value="${atsAttencePolicy.name}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>工作日历：</td>
						<td>
							<input name="workCalendar"
								   class="mini-buttonedit icon-dep-button"
								   style="width: 100%"
								   value="${atsAttencePolicy.workCalendar}"
								   text="${atsAttencePolicy.workCalendarName}"
								   required="true" allowInput="false"
								   onbuttonclick="onSelWorkCalendar"
							/>
						</td>
						<td>考勤周期：</td>
						<td>
							<input name="attenceCycle"
								   class="mini-buttonedit icon-dep-button"
								   value="${atsAttencePolicy.attenceCycle}"
								   style="width: 100%"
								   text="${atsAttencePolicy.attenceCycleName}" required="true" allowInput="false" onbuttonclick="onSelAttenceCycle"/>
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							<input name="orgId"
								   class="mini-buttonedit icon-dep-button"
								   value="${atsAttencePolicy.orgId}"
								   style="width: 100%"
								   text="${atsAttencePolicy.orgName}" required="true" allowInput="false" onbuttonclick="selectMainDep"/>
						</td>
						<td>是否默认：</td>
						<td>
							<input value="${atsAttencePolicy.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsAttencePolicy.isDefault}" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							
								<input name="memo" value="${atsAttencePolicy.memo}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>调休开始时间：</td>
						<td>
							<input class="mini-datepicker" name="offLaterTime" value="${atsAttencePolicy.offLaterTime}"
							showTime="true" format="HH:mm" timeFormat="HH:mm" valueType="String" style="width:100%;" minWidth="120" />
						</td>
						<td>次日上班时间：</td>
						<td>
							<input class="mini-datepicker" name="onLaterTime" value="${atsAttencePolicy.onLaterTime}"
							showTime="true" format="HH:mm" timeFormat="HH:mm" valueType="String" style="width:100%;" minWidth="120" />
						</td>
					</tr>
					<tr>
						<td>调休时间间隔(分钟)：</td>
						<td colspan="3">
							<input name="offLaterAllow" value="${atsAttencePolicy.offLaterAllow}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					
					<tr>
						<td>每周工作时数(小时)：</td>
						<td>
							
								<input name="weekHour" value="${atsAttencePolicy.weekHour}"
							class="mini-textbox"   style="width: 100%" />
						</td>
						<td>每天工作时数(小时)：</td>
						<td>
							
								<input name="daysHour" value="${atsAttencePolicy.daysHour}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>月标准工作天数(天)：</td>
						<td colspan="3">
							
								<input name="monthDay" value="${atsAttencePolicy.monthDay}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>每段早退允许值(分钟)：</td>
						<td>
							
								<input name="leaveAllow" value="${atsAttencePolicy.leaveAllow}"
							class="mini-textbox"   style="width: 100%" />
						</td>
						<td>每段迟到允许值(分钟)：</td>
						<td>
							
								<input name="lateAllow" value="${atsAttencePolicy.lateAllow}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>旷工起始值(分钟)：</td>
						<td>
							
								<input name="absentAllow" value="${atsAttencePolicy.absentAllow}"
							class="mini-textbox"   style="width: 100%" />
						</td>
						<td>加班起始值(分钟)：</td>
						<td>
							
								<input name="otStart" value="${atsAttencePolicy.otStart}"
							class="mini-textbox"   style="width: 100%" />
						</td>
					</tr>
					<tr>
						<td>班前无需加班单：</td>
						<td>
							<input value="${atsAttencePolicy.preNotBill}"
							class="mini-checkbox" onvaluechanged="onPreNotBillvaluechanged" />
							<input id="preNotBill" name="preNotBill" class="mini-hidden" value="${atsAttencePolicy.preNotBill}" />
						</td>
						<td>班后无需加班单：</td>
						<td>
							<input value="${atsAttencePolicy.afterNotBill}"
							class="mini-checkbox" onvaluechanged="onAfterNotBillvaluechanged" />
							<input id="afterNotBill" name="afterNotBill" class="mini-hidden" value="${atsAttencePolicy.afterNotBill}" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsAttencePolicy"
		entityName="com.redxun.oa.ats.entity.AtsAttencePolicy" />
		
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	
	function valuechanged(name,obj){
		var is = mini.get(name);
		is.setValue(obj.getChecked()==true?1:0);
	}
	
	//设置是否默认
	function onIsDefaultvaluechanged(e){
		valuechanged("isDefault",this);
	}
	//设置班前无需加班单
	function onPreNotBillvaluechanged(e){
		valuechanged("preNotBill",this);
	}
	//设置班后无需加班单
	function onAfterNotBillvaluechanged(e){
		valuechanged("afterNotBill",this);
	}
	
	</script>
</body>
</html>