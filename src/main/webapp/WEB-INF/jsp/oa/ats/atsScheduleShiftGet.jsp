
<%-- 
    Document   : [排班列表]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[排班列表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[排班列表]基本信息</caption>
					<tr>
						<th>考勤用户ID：</th>
						<td>
							${atsScheduleShift.fileId}
						</td>
					</tr>
					<tr>
						<th>考勤日期：</th>
						<td>
							${atsScheduleShift.attenceTime}
						</td>
					</tr>
					<tr>
						<th>日期类型：</th>
						<td>
							${atsScheduleShift.dateType}
						</td>
					</tr>
					<tr>
						<th>班次ID：</th>
						<td>
							${atsScheduleShift.shiftId}
						</td>
					</tr>
					<tr>
						<th>标题：</th>
						<td>
							${atsScheduleShift.title}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsScheduleShift.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsScheduleShift.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsScheduleShift.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsScheduleShift.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsScheduleShift.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsScheduleShift" 
        entityName="com.redxun.oa.ats.entity.AtsScheduleShift"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsScheduleShift.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsScheduleShift/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>