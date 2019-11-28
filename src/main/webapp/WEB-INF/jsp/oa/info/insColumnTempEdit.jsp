<%-- 
    Document   : [栏目模板管理表]编辑页
    Created on : 2018-08-30 09:50:56
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[栏目模板管理表]编辑</title>
<%@include file="/commons/edit.jsp"%>

<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/xml/xml.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/mode/multiplex.js"></script>
</head>
<body>
	<div id="toptoolbar">
	<rx:toolbar toolbarId="toolbar1" pkId="insColumnTemp.id" />
	</div>
	<div id="toptoolbarBg"></div>
<div class="Mauto">	
	<div id="p1" class="form-outer shadowBox90">
		<form id="form1" method="post">
		
			<input id="pkId" name="id" class="mini-hidden" value="${insColumnTemp.id}" />
			<input name="isSys" class="mini-hidden" value="${insColumnDef.isSys==null?'0':insColumnDef.isSys}" />
			<table class="table-detail column_1_m" cellspacing="1" cellpadding="0">
				<caption>栏目模板管理表基本信息</caption>
				<tr>
					<th>名称</th>
					<td colspan="3">
						<input name="name" value="${insColumnTemp.name}" class="mini-textbox" required="true"  style="width: 90%" />
					</td>
				</tr>
				<tr>
					<th>标识键</th>
					<td colspan="3">
						<input name="key" value="${insColumnTemp.key}" class="mini-textbox"  required="true" style="width: 90%" />
					</td>
				</tr>
				<tr>
					<th>状态：</th>
					<td>
						<div id="status" name="status" class="mini-radiobuttonlist" value="${insColumnTemp.status}" required="true" repeatDirection="vertical"
						repeatLayout="table" data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]" textField="text" valueField="id" value="1"></div>
					</td>
				</tr>
				<tr>
					<th>HTML模板：</th>
					<td colspan="3">
						<textarea id="content" class="textarea" name="templet" style="width:100%;height:100%">${insColumnTemp.templet}</textarea>
					</td>
				</tr>
			</table>
		
		</form>
	</div>
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${insColumnTemp.id}';
	var flag = false;
	if(${insColumnTemp.isSys==1}){
		flag = true;
	}
	$(function(){
		initForm();
		form.setEnabled(!flag);
		mini.get("status").enable();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/oa/info/insColumnTemp/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
			editor.setValue(json.templet);
		});
	}
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    var temp = editor.getValue();
	    data.templet = temp;
		var config={
        	url:"${ctxPath}/oa/info/insColumnTemp/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}	
	
	CodeMirror.defineMode("mycode", function(config) {
		  return CodeMirror.multiplexingMode(
		    CodeMirror.getMode(config, "text/html"),
		    {open: "<<", close: ">>",
		     mode: CodeMirror.getMode(config, "text/plain"),
		     delimStyle: "delimit"}
		    // .. more multiplexed styles can follow here
		  );
	});
	var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
		  mode: "mycode",
		  lineNumbers: true,
		  lineWrapping: true
	});
	</script>
</body>
</html>