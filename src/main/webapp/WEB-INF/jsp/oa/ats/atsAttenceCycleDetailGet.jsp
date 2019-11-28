
<%-- 
    Document   : [考勤周期明细]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤周期明细]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[考勤周期明细]基本信息</caption>
					<tr>
						<th>考勤周期：</th>
						<td>
							${atsAttenceCycleDetail.cycleId}
						</td>
					</tr>
					<tr>
						<th>名称：</th>
						<td>
							${atsAttenceCycleDetail.name}
						</td>
					</tr>
					<tr>
						<th>开始时间：</th>
						<td>
							${atsAttenceCycleDetail.startTime}
						</td>
					</tr>
					<tr>
						<th>结束时间：</th>
						<td>
							${atsAttenceCycleDetail.endTime}
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							${atsAttenceCycleDetail.memo}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsAttenceCycleDetail.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsAttenceCycleDetail.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsAttenceCycleDetail.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsAttenceCycleDetail.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsAttenceCycleDetail.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsAttenceCycleDetail" 
        entityName="com.redxun.oa.ats.entity.AtsAttenceCycleDetail"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsAttenceCycleDetail.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttenceCycleDetail/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>