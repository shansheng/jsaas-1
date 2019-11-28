
<%-- 
    Document   : [考勤加班单]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤加班单]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[考勤加班单]基本信息</caption>
					<tr>
						<th>用户ID：</th>
						<td>
							${atsOverTime.userId}
						</td>
					</tr>
					<tr>
						<th>加班类型：</th>
						<td>
							${atsOverTime.otType}
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							${atsOverTime.startTime}
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							${atsOverTime.endTime}
						</td>
					</tr>
					<tr>
						<th>加班时间：</th>
						<td>
							${atsOverTime.otTime}
						</td>
					</tr>
					<tr>
						<th>加班补偿方式：</th>
						<td>
							${atsOverTime.otCompens}
						</td>
					</tr>
					<tr>
						<th>流程运行ID：</th>
						<td>
							${atsOverTime.runId}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsOverTime.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsOverTime.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsOverTime.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsOverTime.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsOverTime.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsOverTime" 
        entityName="com.redxun.oa.ats.entity.AtsOverTime"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsOverTime.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsOverTime/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>