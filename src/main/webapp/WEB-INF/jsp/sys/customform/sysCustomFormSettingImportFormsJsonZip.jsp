<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单方案导入</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
</head>
<body>
	<div class="mini-toolbar">
		<div class="form-toolBox">
			<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<table cellpadding="0" cellspacing="0" class="table-detail">
		<caption>导入结果</caption>
		<tr>
			<td>
				<c:choose>
					<c:when test="${empty rtnMsg }">
						成功!	
					</c:when>
					<c:otherwise>
						<ul>
						 <c:forEach items="${rtnMsg}" var="msg">
						 	<li>${msg}</li>
					     </c:forEach>
					    </ul>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	<div class="mini-fit" <c:if test="${empty differMsg }">visible="false"</c:if> >
		<a class="mini-button" onclick="exportScript();">导出差异脚本</a>
		<form id="differFrm" action="${ctxPath}/sys/customform/sysCustomFormSetting/exportDifferScript.do">
			<textarea id="differMsgs" name="differMsgs" style="width:100%;height:auto;"><c:forEach items="${differMsg}" var="msg">${msg}&#13;</c:forEach></textarea>
		</form>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		
		$(function(){
			var obj = document.getElementById("differMsgs");
			editor = CodeMirror.fromTextArea(obj, {
				matchBrackets : true,
				mode : "text/x-sql",
				lineNumbers: true
			});
			editor.setSize("100%","170");
		});
		
		function exportScript(){
			$("#differFrm").submit();
		}
	</script>
</body>
</html>