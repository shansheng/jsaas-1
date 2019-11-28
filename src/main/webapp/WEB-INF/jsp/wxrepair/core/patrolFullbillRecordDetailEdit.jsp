<%-- 
    Document   : [巡检单填写详情]编辑页
    Created on : 2019-10-14 10:55:26
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[巡检单填写详情]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="patrolFullbillRecordDetail.id" />	
<div class="mini-fit">
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${patrolFullbillRecordDetail.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[巡检单填写详情] 基本信息</caption>
					
					
			            <tr>
						<td>题目ID：</td>
						<td>
								<input name="question"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>题目：</td>
						<td>
								<input name="questionName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>题型ID：</td>
						<td>
								<input name="questionType"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>题型：</td>
						<td>
								<input name="questionTypeName"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>回答：</td>
						<td>
								<input name="answer"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>外键：</td>
						<td>
								<input name="refId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>父ID：</td>
						<td>
								<input name="parentId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>流程实例ID：</td>
						<td>
								<input name="instId"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>状态：</td>
						<td>
								<input name="instStatus"  class="mini-textbox" />
						</td>
						</tr>
			            <tr>
						<td>组ID：</td>
						<td>
								<input name="groupId"  class="mini-textbox" />
						</td>
						</tr>
				</table>
		</form>
	
	
</div>	
</div>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${patrolFullbillRecordDetail.id}';
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/getJson.do";
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
        	url:"${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/save.do",
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