<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>脚本验证</title>
	<%@include file="/commons/get.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
</head>
<body>
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<tr>
						<td colspan="2">
							<textarea id="script" name="script" style="width:100%;height:380px"></textarea>
						</td>
					</tr>
				</table>
	<div class="mini-toolbar" style="text-align: center;">
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button" onclick="CloseWindow()">关闭</a>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		
		function onOk() {
			CloseWindow("ok");
		}
		
		var scriptEditor = CodeMirror.fromTextArea(document.getElementById('script'),{
	        lineNumbers: true,
	        matchBrackets: true,
	        mode: "text/x-groovy"
		});
		
		function getData(){
			return scriptEditor.getValue();
		}
		
		function setData(script){
			scriptEditor.setValue(script);
		}
	</script>
</body>
</html>