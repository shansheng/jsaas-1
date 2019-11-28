<%-- 
    Document   : [用户类型]编辑页
    Created on : 2018-09-03 14:21:10
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[用户类型]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toptoolbar" pkId="osUserType.id" />
	<div class="mini-fit">
		<div id="p1" class="form-container">
			<form id="form1" method="post">
					<input id="pkId" name="id" class="mini-hidden" value="${osUserType.id}" />
					<table class="table-detail column-two" cellspacing="1" cellpadding="0">
						<caption>[用户类型] 基本信息</caption>
							<tr>
							<td>编码：</td>
							<td>
								<input name="code"  class="mini-textbox"  required="true" style="width: 90%" />
							</td>
							</tr>
							<tr>
							<td>名称：</td>
							<td>
								<input name="name"  class="mini-textbox"  required="true" style="width: 90%" />
							</td>
							</tr>
							<tr>
							<td>描述：</td>
							<td>
								<textarea name="descp"  class="mini-textarea"   style="width: 90%" ></textarea>
							</td>
							</tr>
					</table>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${osUserType.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/sys/org/osUserType/getJson.do";
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
        	url:"${ctxPath}/sys/org/osUserType/save.do",
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