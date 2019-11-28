
<%-- 
    Document   : [考勤出差单]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤出差单]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[考勤出差单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							${atsTrip.userId}
						</td>
					</tr>
					<tr>
						<th>出差类型：</th>
						<td>
							${atsTrip.tripType}
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							${atsTrip.startTime}
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							${atsTrip.endTime}
						</td>
					</tr>
					<tr>
						<th>出差时间：</th>
						<td>
							${atsTrip.tripTime}
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							${atsTrip.runId}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsTrip.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsTrip.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsTrip.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsTrip.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsTrip.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsTrip" 
        entityName="com.redxun.oa.ats.entity.AtsTrip"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsTrip.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsTrip/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>