<%-- 
    Document   : [BPM_REG_LIB]编辑页
    Created on : 2018-12-25 15:49:05
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>规则编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="bpmRegLib.id" />	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="regId" class="mini-hidden" value="${bpmRegLib.regId}" />
				<input name="userId"  class="mini-hidden" value="0" />
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>正则表达式配置</caption>
			            <tr>
						<td>名称：</td>
						<td>
								<input name="name"  class="mini-textbox" required="true" width="90%"/>
						</td>
						<td>别名：</td>
						<td>
								<input name="key"  class="mini-textbox" required="true" width="90%" />
						</td>
						</tr>
			            <tr>
						<td>类型：</td>
						<td colspan="3">
								<input class="mini-combobox" name="type" 
									data="[{id:'0',text:'校验规则'},{id:'1',text:'脱敏规则'}]"
									required="true" width="50%"
								>
								<span style="color:red">校验规则:配置正则公式；脱敏规则：配置正则公式和替换公式</span>
						</td>
						</tr>
						<tr>
						<td>正则公式：</td>
						<td>
								<input name="regText"  class="mini-textarea"
								required="true" width="90%" height="300px"
								 />
						</td>
						<td>替换公式：</td>
						<td>
								<input name="mentText"  class="mini-textarea"
								 width="90%" height="300px"
								 />
						</td>
						</tr>
						
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${bpmRegLib.regId}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/bpm/core/bpmRegLib/getJson.do";
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
        	url:"${ctxPath}/bpm/core/bpmRegLib/save.do",
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