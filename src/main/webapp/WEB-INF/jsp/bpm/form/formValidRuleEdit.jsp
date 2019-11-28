<%-- 
    Document   : [FORM_VALID_RULE]编辑页
    Created on : 2018-11-27 22:58:37
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[FORM_VALID_RULE]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="formValidRule.id" />	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${formValidRule.id}" />
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>[FORM_VALID_RULE] 基本信息</caption>
					
					
			            <tr>
						<th>解决方案ID：</th>
						<td>
								<input name="solId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>表单KEY：</th>
						<td>
								<input name="formKey"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>流程定义ID：</th>
						<td>
								<input name="actDefId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>节点ID：</th>
						<td>
								<input name="nodeId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<th>表单定义：</th>
						<td>
								<input name="json"  class="mini-textbox" />
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${formValidRule.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/bpm/form/formValidRule/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
		});
	}
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		var config={
        	url:"${ctxPath}/bpm/form/formValidRule/save.do",
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