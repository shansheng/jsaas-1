
<%-- 
    Document   : [法定节假日]明细页
    Created on : 2018-03-22 16:48:35
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[法定节假日]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[法定节假日]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsLegalHoliday.code}
						</td>
						<td>名称：</td>
						<td>
							${atsLegalHoliday.name}
						</td>
					</tr>
					<tr>
						<td>年度：</td>
						<td>
							${atsLegalHoliday.year}
						</td>
						<td>描述：</td>
						<td>
							${atsLegalHoliday.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsLegalHoliday" 
        entityName="com.redxun.oa.ats.entity.AtsLegalHoliday"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var grid = mini.get("grid_ats_legal_holiday_detail");
		var form = new mini.Form("#form1");
		var pkId = '${atsLegalHoliday.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsLegalHoliday/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
					grid.setData(json.atsLegalHolidayDetails);
				}					
			});
		})
		</script>
    </body>
</html>