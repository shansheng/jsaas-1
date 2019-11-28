
<%-- 
    Document   : [流程批量审批设置表]明细页
    Created on : 2018-06-27 15:19:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[流程批量审批设置表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[流程批量审批设置表]基本信息</caption>
					<tr>
						<td>流程方案ID：</td>
						<td>
							${bpmBatchApproval.solId}
						</td>
					</tr>
					<tr>
						<td>节点ID：</td>
						<td>
							${bpmBatchApproval.nodeId}
						</td>
					</tr>
					<tr>
						<td>实体表名称：</td>
						<td>
							${bpmBatchApproval.tableName}
						</td>
					</tr>
					<tr>
						<td>字段设置：</td>
						<td>
							${bpmBatchApproval.fieldJson}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${bpmBatchApproval.status}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="bpm/core/bpmBatchApproval" 
        entityName="com.redxun.bpm.core.entity.BpmBatchApproval"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${bpmBatchApproval.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/bpm/core/bpmBatchApproval/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>