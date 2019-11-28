
<%-- 
    Document   : [巡检单填写详情]明细页
    Created on : 2019-10-14 10:55:26
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[巡检单填写详情]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <%--<div id="toptoolbarBg"></div>--%>
   <div class="form-container">
        <div id="form1" >
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[巡检单填写详情]基本信息</caption>
					<tr>
						<td>题目ID：</td>
						<td>
							${patrolFullbillRecordDetail.question}
						</td>
					</tr>
					<tr>
						<td>题目：</td>
						<td>
							${patrolFullbillRecordDetail.questionName}
						</td>
					</tr>
					<%--<tr>
						<td>题型ID：</td>
						<td>
							${patrolFullbillRecordDetail.questionType}
						</td>
					</tr>--%>
					<tr>
						<td>题型：</td>
						<td>
							${patrolFullbillRecordDetail.questionTypeName}
						</td>
					</tr>
					<tr>
						<td>回答：</td>
						<td>
							${patrolFullbillRecordDetail.answer}
						</td>
					</tr>
					<%--<tr>
						<td>外键：</td>
						<td>
							${patrolFullbillRecordDetail.refId}
						</td>
					</tr>--%>
					<%--<tr>
						<td>父ID：</td>
						<td>
							${patrolFullbillRecordDetail.parentId}
						</td>
					</tr>
					<tr>
						<td>流程实例ID：</td>
						<td>
							${patrolFullbillRecordDetail.instId}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${patrolFullbillRecordDetail.instStatus}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${patrolFullbillRecordDetail.tenantId}
						</td>
					</tr>--%>
					<tr>
						<td>创建时间：</td>
						<td>
							<fmt:formatDate value="${patrolFullbillRecordDetail.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<%--<tr>
						<td>创建人ID：</td>
						<td>
							${patrolFullbillRecordDetail.createBy}
						</td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>
							${patrolFullbillRecordDetail.updateBy}
						</td>
					</tr>--%>
					<tr>
						<td>更新时间：</td>
						<td>
							<fmt:formatDate value="${patrolFullbillRecordDetail.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<%--<tr>
						<td>组ID：</td>
						<td>
							${patrolFullbillRecordDetail.groupId}
						</td>
					</tr>--%>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="wxrepair/core/patrolFullbillRecordDetail" 
        entityName="com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${patrolFullbillRecordDetail.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/getJson.do",
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