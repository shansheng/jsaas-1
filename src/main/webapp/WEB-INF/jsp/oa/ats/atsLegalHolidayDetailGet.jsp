
<%-- 
    Document   : [法定节假日明细]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[法定节假日明细]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[法定节假日明细]基本信息</caption>
					<tr>
						<th>法定假日：</th>
						<td>
							${atsLegalHolidayDetail.holidayId}
						</td>
					</tr>
					<tr>
						<th>假日名称：</th>
						<td>
							${atsLegalHolidayDetail.name}
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							${atsLegalHolidayDetail.startTime}
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							${atsLegalHolidayDetail.endTime}
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							${atsLegalHolidayDetail.memo}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsLegalHolidayDetail.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsLegalHolidayDetail.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsLegalHolidayDetail.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsLegalHolidayDetail.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsLegalHolidayDetail.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsLegalHolidayDetail" 
        entityName="com.redxun.oa.ats.entity.AtsLegalHolidayDetail"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsLegalHolidayDetail.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsLegalHolidayDetail/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>