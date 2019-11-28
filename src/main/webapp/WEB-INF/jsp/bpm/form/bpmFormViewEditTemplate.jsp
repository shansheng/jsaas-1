<%-- 
    Document   : [BpmFormTemplate]编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单模板编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/xml/xml.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/common/jquery.base64.js"></script>

<style>
	.CodeMirror{
		height: 600px;
	}
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
       		<a class="mini-button"  plain="true" onclick="saveData">保存</a>
       	 <a class="mini-button btn-red"  plain="true" onclick="onCancel">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container" >
				<form id="form1" method="post">
					<input id="pkId" name="id" class="mini-hidden"
						value="${bpmFormView.viewId}" />
					<table class="table-detail table-detail2" cellspacing="1" cellpadding="0">
						<caption>表单模版编辑</caption>
						<tr>
							<td>模版名称 ：</td>
							<td><input name="name" value="${bpmFormView.name}"
								class="mini-textbox" vtype="maxLength:50" enabled="false"/>

							</td>
						</tr>
						<tr>
							<td>模版 ：</td>
							<td style="max-width: 1024px;width: 93%;heigth:80%">
								<textarea id="template" name="template"></textarea>
							</td>
						</tr>
					</table>

				</form>
			<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView"
				entityName="com.redxun.bpm.form.entity.BpmFormView" />
		</div>
	</div>
	<script>
	var bpmFormView={};
	var editorMsg;
	$(function(){
		_SubmitJson({
			url:__rootPath+'/bpm/form/bpmFormView/getTemplate.do?viewId=${bpmFormView.viewId}',
			showMsg:false,
			success:function(result){
				var templateObj=$("#template")
				bpmFormView=result.data;
				templateObj.val(result.data.template);
				
				editorMsg= CodeMirror.fromTextArea(templateObj[0], {
				       lineNumbers: true,
				       matchBrackets: true,
				       lineWrapping:true,
				       mode: "text/xml"
			   	});
			}
		});	
	})
	
	function saveData(){
		var template=editorMsg.getValue();
		template=$.base64.btoa(template,true,'utf8');
		
        var config={
	        	url:__rootPath+"/bpm/form/bpmFormView/saveTemplate.do",
	        	method:'POST',
	        	data:{
	        		viewId:'${bpmFormView.viewId}',
	        		template:"<div>"+template+"</div>"
	        	},
	        	success:function(result){
        			CloseWindow('ok');	
	        	}
	        }
	        _SubmitJson(config);
	}
		
	
	</script>	
		
</body>
</html>