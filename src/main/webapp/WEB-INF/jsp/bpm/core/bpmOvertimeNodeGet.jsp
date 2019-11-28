
<%-- 
    Document   : [流程超时节点表]明细页
    Created on : 2019-03-27 18:50:23
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[流程超时节点表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[流程超时节点表]基本信息</caption>
					<tr>
						<th>解决方案ID：</th>
						<td>
							${bpmOvertimeNode.solId}
						</td>
					</tr>
					<tr>
						<th>流程实例ID：</th>
						<td>
							${bpmOvertimeNode.instId}
						</td>
					</tr>
					<tr>
						<th>流程节点ID：</th>
						<td>
							${bpmOvertimeNode.nodeId}
						</td>
					</tr>
					<tr>
						<th>操作类型：</th>
						<td>
							${bpmOvertimeNode.opType}
						</td>
					</tr>
					<tr>
						<th>操作内容：</th>
						<td>
							${bpmOvertimeNode.opContent}
						</td>
					</tr>
					<tr>
						<th>超时时间：</th>
						<td>
							${bpmOvertimeNode.OVERTIME}
						</td>
					</tr>
					<tr>
						<th>节点状态：</th>
						<td>
							${bpmOvertimeNode.status}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${bpmOvertimeNode.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${bpmOvertimeNode.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${bpmOvertimeNode.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${bpmOvertimeNode.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${bpmOvertimeNode.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="bpm/core/bpmOvertimeNode" 
        entityName="com.redxun.bpm.core.entity.BpmOvertimeNode"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${bpmOvertimeNode.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/bpm/core/bpmOvertimeNode/getJson.do",
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