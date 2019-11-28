
<%-- 
    Document   : [考勤组明细]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤组明细]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[考勤组明细]基本信息</caption>
					<tr>
						<th>考勤组：</th>
						<td>
							${atsAttenceGroupDetail.groupId}
						</td>
					</tr>
					<tr>
						<th>考勤档案：</th>
						<td>
							${atsAttenceGroupDetail.fileId}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsAttenceGroupDetail.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsAttenceGroupDetail.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsAttenceGroupDetail.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsAttenceGroupDetail.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsAttenceGroupDetail.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsAttenceGroupDetail" 
        entityName="com.redxun.oa.ats.entity.AtsAttenceGroupDetail"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsAttenceGroupDetail.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttenceGroupDetail/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>