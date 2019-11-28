
<%-- 
    Document   : [考勤档案]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤档案]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[考勤档案]基本信息</caption>
					<tr>
						<td>用户：</td>
						<td>
							${atsAttendanceFile.userId}
						</td>
						<td>考勤卡号：</td>
						<td>
							${atsAttendanceFile.cardNumber}
						</td>
					</tr>
					<tr>
						<td>是否参与考勤：</td>
						<td>
							${atsAttendanceFile.isAttendance==1?'是':'否'}
						</td>
						<td>考勤制度：</td>
						<td>
							${atsAttendanceFile.attencePolicyName}
						</td>
					</tr>
					<tr>
						<td>假期制度：</td>
						<td>
							${atsAttendanceFile.holidayPolicyName}
						</td>
						<td>默认班次：</td>
						<td>
							${atsAttendanceFile.defaultShiftName}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsAttendanceFile" 
        entityName="com.redxun.oa.ats.entity.AtsAttendanceFile"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsAttendanceFile.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttendanceFile/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>