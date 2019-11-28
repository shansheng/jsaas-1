
<%-- 
    Document   : [考勤请假单]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤请假单]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[考勤请假单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							${atsHoliday.userId}
						</td>
					</tr>
					<tr>
						<th>请假类型：</th>
						<td>
							${atsHoliday.holidayType}
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							${atsHoliday.startTime}
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							${atsHoliday.endTime}
						</td>
					</tr>
					<tr>
						<th>请假时间：</th>
						<td>
							${atsHoliday.holidayTime}
						</td>
					</tr>
					<tr>
						<th>时间长度：</th>
						<td>
							${atsHoliday.duration}
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							${atsHoliday.runId}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsHoliday.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsHoliday.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsHoliday.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsHoliday.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsHoliday.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsHoliday" 
        entityName="com.redxun.oa.ats.entity.AtsHoliday"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsHoliday.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsHoliday/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>