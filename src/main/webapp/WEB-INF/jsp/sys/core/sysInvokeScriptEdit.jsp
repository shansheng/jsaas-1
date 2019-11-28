<%-- 
    Document   : [执行脚本配置]编辑页
    Created on : 2018-10-18 11:06:29
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[执行脚本配置]编辑</title>
<%@include file="/commons/edit.jsp"%>

<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>

</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="sysInvokeScript.id" />
<div class="mini-fit">
<div id="p1" class="form-container">

	<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysInvokeScript.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>调用脚本配置</caption>
					    <tr>
							<td> 名称：</td>
							<td>
									<input name="name"  class="mini-textbox" required="required"/>
							</td>
							<td>别名：</td>
							<td>
									<input name="alias"  class="mini-textbox"  required="required" />
							</td>
						</tr>
			           
			            <tr>
							<td>脚本内容：</td>
							<td colspan="3">
								上下文参数为params,可以在脚本中 直接编写 return params查看返回都值。
								<%--<textarea name="content" width="90%" height="400" class="mini-textarea" emptyText="请输入脚本"></textarea>--%>
								<textarea name="content" id="sqlDiy" width="90%" height="400"  emptyText="请输入脚本">
						        </textarea>
							</td>
						</tr>
				</table>
		</form>
</div>
</div>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysInvokeScript.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/sys/core/sysInvokeScript/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
			insertVal(editor,json.content);
		});
	}

	var editor = null;
	function initCodeMirror() {
		var obj = document.getElementById("sqlDiy");
		editor = CodeMirror.fromTextArea(obj, {
			matchBrackets : true,
			mode : "text/x-groovy"
		});
	}
	initCodeMirror();


	function insertVal(editor, val) {
		var doc = editor.getDoc();
		var cursor = doc.getCursor(); // gets the line number in the cursor position
		doc.replaceRange(val, cursor); // adds a new line
	}

	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    data.content=editor.getValue();
		var config={
        	url:"${ctxPath}/sys/core/sysInvokeScript/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}	
	</script>
</body>
</html>