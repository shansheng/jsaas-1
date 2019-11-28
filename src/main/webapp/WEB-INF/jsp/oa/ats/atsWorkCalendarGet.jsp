
<%-- 
    Document   : [工作日历]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>[工作日历]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[工作日历]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsWorkCalendar.code}
						</td>
						<td>名称：</td>
						<td>
							${atsWorkCalendar.name}
						</td>
					</tr>
					<tr>
						<td>开始时间：</td>
						<td>
							<fmt:formatDate value="${atsWorkCalendar.startTime}" pattern="yyyy-MM-dd"/>
						</td>
						<td>结束时间：</td>
						<td>
							<fmt:formatDate value="${atsWorkCalendar.endTime}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					<tr>
						<td>日历模版：</td>
						<td>
							${atsWorkCalendar.calendarTemplName}
						</td>
						<td>法定假期：</td>
						<td>
							${atsWorkCalendar.legalHolidayName}
						</td>
					</tr>
					<tr>
						<td>是否默认：</td>
						<td>
							${atsWorkCalendar.isDefault==1?'是':'否'}
						</td>
						<td>描述：</td>
						<td>
							${atsWorkCalendar.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsWorkCalendar" 
        entityName="com.redxun.oa.ats.entity.AtsWorkCalendar"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsWorkCalendar.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsWorkCalendar/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>