
<%-- 
    Document   : [打卡记录]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[打卡记录]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[打卡记录]基本信息</caption>
					<tr>
						<th>考勤卡号：</th>
						<td>
							${atsCardRecord.cardNumber}
						</td>
					</tr>
					<tr>
						<th>打卡日期：</th>
						<td>
							${atsCardRecord.cardDate}
						</td>
					</tr>
					<tr>
						<th>打卡来源：</th>
						<td>
							${atsCardRecord.cardSource}
						</td>
					</tr>
					<tr>
						<th>打卡位置：</th>
						<td>
							${atsCardRecord.cardPlace}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsCardRecord.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsCardRecord.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsCardRecord.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsCardRecord.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsCardRecord.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsCardRecord" 
        entityName="com.redxun.oa.ats.entity.AtsCardRecord"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsCardRecord.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsCardRecord/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>