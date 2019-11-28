<%-- 
    Document   : 业务表单视图编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>业务表单视图编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.css" />
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.js"></script>
</head>
<body>
<div class="mini-fit">
	<div class="form-container">
		<form id="form1" method="post" >
			<table class="table-detail column-two" cellspacing="1" cellpadding="0" border="2">
				<tr>
					<td>服务接口 </td>
					<td>
						<div>
							接口地址:/restApi/sys/saveData
						</div>
						服务接口参数描述:
						<div style="margin-left: 20px">
							alias:服务名称
						</div>
						<div style="margin-left: 20px">
							data:表单数据
						</div>
					</td>
				</tr>
				<tr>
					<td>服务名称</td>
					<td>
						<div id="serviceName"></div>
					</td>
				</tr>
				<tr>
					<td>表单数据格式</td>
					<td  style="padding: 6px 14px">
						<div id="jsonview" style="height: 100%; width: 100%"></div>
					</td>
				</tr>

			</table>
		</form>
		<script type="text/javascript">
			var boDefId="${param.boDefId}";
			$(function(){
				var url=__rootPath +"/sys/bo/sysBoDef/getHelpJson?pkId="+boDefId;
				$.get(url,function(data){
					$("#serviceName").text(data.alias);
					$("#jsonview").jsonViewer(data.params);
				})
			})
		</script>

	</div>
</div>
	
</body>
</html>