
<%-- 
    Document   : [巡检单填写记录]明细页
    Created on : 2019-10-21 11:32:36
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[巡检单填写记录]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <%--<div id="toptoolbarBg"></div>--%>
   <div class="form-container">
        <div id="form1" >
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[巡检单填写记录]基本信息</caption>
					<%--<tr>
						<td>填单人ID：</td>
						<td>
							${patrolFullbillRecord.staff}
						</td>
					</tr>--%>
					<tr>
						<td>填单人：</td>
						<td>
							${patrolFullbillRecord.staffName}
						</td>
					</tr>
					<tr>
						<td>巡检单ID：</td>
						<td>
							${patrolFullbillRecord.questionnaire}
						</td>
					</tr>
					<tr>
						<td>巡检单：</td>
						<td>
							${patrolFullbillRecord.questionnaireName}
						</td>
					</tr>
					<tr>
						<td>填单时间：</td>
						<td>
							<fmt:formatDate value="${patrolFullbillRecord.fulldate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<%--<tr>
						<td>状态ID：</td>
						<td>
							${patrolFullbillRecord.status}
						</td>
					</tr>--%>
					<tr>
						<td>状态：</td>
						<td>
							${patrolFullbillRecord.statusName}
						</td>
					</tr>
					<%--<tr>
						<td>外键：</td>
						<td>
							${patrolFullbillRecord.refId}
						</td>
					</tr>
					<tr>
						<td>父ID：</td>
						<td>
							${patrolFullbillRecord.parentId}
						</td>
					</tr>
					<tr>
						<td>流程实例ID：</td>
						<td>
							${patrolFullbillRecord.instId}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${patrolFullbillRecord.instStatus}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${patrolFullbillRecord.tenantId}
						</td>
					</tr>--%>
					<tr>
						<td>创建时间：</td>
						<td>
							<fmt:formatDate value="${patrolFullbillRecord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<%--<tr>
						<td>创建人ID：</td>
						<td>
							${patrolFullbillRecord.createBy}
						</td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>
							${patrolFullbillRecord.updateBy}
						</td>
					</tr>--%>
					<tr>
						<td>更新时间：</td>
						<td>
							<fmt:formatDate value="${patrolFullbillRecord.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<%--<tr>
						<td>组ID：</td>
						<td>
							${patrolFullbillRecord.groupId}
						</td>
					</tr>
					<tr>
						<td>门店ID：</td>
						<td>
							${patrolFullbillRecord.shop}
						</td>
					</tr>--%>
					<tr>
						<td>门店：</td>
						<td>
							${patrolFullbillRecord.shopName}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="wxrepair/core/patrolFullbillRecord" 
        entityName="com.airdrop.wxrepair.core.entity.PatrolFullbillRecord"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${patrolFullbillRecord.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/wxrepair/core/patrolFullbillRecord/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
	</div>
    </body>
</html>