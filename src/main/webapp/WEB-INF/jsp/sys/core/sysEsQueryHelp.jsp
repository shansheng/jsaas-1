<%-- 
    Document   : [自定义查询]编辑页
    Created on : 2017-02-21 15:32:09
    Author     : cjx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]编辑</title>

<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/share/dialog.js"></script>


</head>
<body>
	<div class="heightBox"></div>
	<div class="shadowBox90" style="padding-top: 8px;">
		<input id="pkId" name="id" class="mini-hidden" value="${sysEsQuery.id}" />


		<table class="table-detail column_1" cellspacing="1" cellpadding="0">
	
			<tr>
				<th>js引用文件地址</th>
				<td>该方法文件定义在scripts/share.js中</td>
			</tr>
			<tr>
				<th>方法使用</th>
				<td id="tdMethod">
					
				</td>
			</tr>
			<tr>
				<th>备　　注</th>
				<td>
					<div>如果是in操作的参数的格式,如:{"fieldName":"value1,value2"},</div>
					<div>between操作的参数格式,如{"fieldName":"value1|value2"}</div>
				</td>
			</tr>
			
		</table>
	</div>
	
	<script type="text/html;" id="helperTemplate">
		<div>
			参数格式：var params = <span id="paramExample"><#=params#></span>;
				<div>
					doQuery('<#=alias#>', params,function(data){
						<div style="margin-left:30px">
							//data 返回数据格式 <div id="resultText" >[<#=rtn#>,...]</div>
						</div>
					});
				</div>
		</div>
	</script>

	<script type="text/javascript">
		//params,alias,rtn
		mini.parse();
		
		var id="${param.id}";
		$(function(){
			var url =__rootPath +"/sys/core/sysEsQuery/getHelper.do?id=" + id;
			$.get(url,function(data){
				var rtn=JSON.stringify(data.rtn);
				var params=JSON.stringify(data.params);
				var obj={alias:data.alias,rtn:rtn,params:params};
				var html=baiduTemplate('helperTemplate',obj);
				$("#tdMethod").html(html);
			})
		});
		
	</script>
</body>
</html>


