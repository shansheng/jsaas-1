
<%-- 
    Document   : [打卡记录]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[打卡记录]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsCardRecord.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsCardRecord.id}" />
				<input name="cardSource" class="mini-hidden" value="0" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[打卡记录]基本信息</caption>
					<tr>
						<td>考勤卡号：</td>
						<td>
							<input name="cardNumber" class="mini-buttonedit icon-dep-button" value="" 
						text="" required="true" allowInput="false" onbuttonclick="onSelAttendanceFile"/>
						</td>
					
						<td>打卡日期：</td>
						<td>
								<input name="cardDate" value=""
							class="mini-datepicker" showTime="true" valueType="String" format="yyyy-MM-dd HH:mm:ss"  />
						</td>
					</tr>
					<tr>
						<td>打卡位置：</td>
						<td colspan="3">
							
								<input name="cardPlace" value=""
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsCardRecord"
		entityName="com.redxun.oa.ats.entity.AtsCardRecord" />
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	
	function onOk(e){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		var config={
        	url:"${ctxPath}/oa/ats/atsCardRecord/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
	        
		_SubmitJson(config);
	}
	

	</script>
</body>
</html>