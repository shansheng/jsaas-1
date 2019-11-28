
<%-- 
    Document   : [权限转移日志表]明细页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[权限转移日志表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[权限转移日志表]基本信息</caption>
					<tr>
						<th>操作描述：</th>
						<td>
							${sysTransferLog.opDescp}
						</td>
					</tr>
					<tr>
						<th>权限转移人：</th>
						<td>
							${sysTransferLog.authorPerson}
						</td>
					</tr>
					<tr>
						<th>目标转移人：</th>
						<td>
							${sysTransferLog.targetPerson}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysTransferLog.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysTransferLog.createTime}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysTransferLog.tenantId}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/translog/sysTransferLog" 
        entityName="com.redxun.sys.translog.entity.SysTransferLog"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysTransferLog.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/translog/sysTransferLog/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>